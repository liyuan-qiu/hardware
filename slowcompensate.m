function slowcompensate(Vxp1,Vxp2,Vxset)
global obj_Vx;
global obj_Vz;
global UnoDAC;
global excelname;

% [Vxp1,Vxp2,Vxset]=currentvsVzVx;
count1=0
time1=clock
excelname=[num2str(time1),'VzVxmonitor.xlsx']
cleanupObj =onCleanup(@cleanMeUp);

tic
while(1)

    count1=count1+1

    data1 = query(obj_Vx, ':MEASure:VOLTage?');
    data2 = query(obj_Vz, ':MEASure:VOLTage?');
    datavoltage1=str2num(data1);
    datavoltage2=str2num(data2);

%     error=floor((datavoltage1-setpoint)*1000);%用mV作为单位
    compensate_current=-Vxp1*(datavoltage1-Vxset)*0.5
    %计算出所�?要的电流，mA为单位，或�?�可以查表，�?要测试一下，在看看是否是线�?�还是需要查�?
    if abs(compensate_current)<1000%只有当电流小�?1A的时候才能去给变化，否则就设定为+-1000mA
        fprintf(UnoDAC,['SET mA ',num2str(compensate_current)])
    else
        if compensate_current>0
            fprintf(UnoDAC,'SET mA 1000')
        else
            fprintf(UnoDAC,'SET mA -1000')
        end
    end
    timerecord=toc;
    datasave=[timerecord,datavoltage1,datavoltage2,compensate_current];
    xlswrite(excelname,datasave,'Sheet1',['A',num2str(count1)])
    pause(2)

end
end
function cleanMeUp()
'hello'

global UnoDAC;
global excelname;
%     figure
    fprintf(UnoDAC,'SET mA 0')
    dataall=xlsread(excelname);
    subplot(4,1,1)
    scatter(dataall(:,1),dataall(:,2))
    title('Vz')
    subplot(4,1,2)
    scatter(dataall(:,1),dataall(:,3))
    title('Vx')
    'end'
end