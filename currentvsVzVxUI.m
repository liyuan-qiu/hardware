function [Vxp1,Vxp2,Vxset]=currentvsVzVx(app)
global obj_Vx;
global obj_Vz;
global UnoDAC;
for count=1:20
    count
    current(count)=count*100-1000;
    fprintf(UnoDAC,['SET mA ',num2str(current(count))])
    for count2=1:1
    data1 = query(obj_Vx, ':MEASure:VOLTage?');
    data2 = query(obj_Vz, ':MEASure:VOLTage?');
    datavoltage1(count2)=str2num(data1);
    datavoltage2(count2)=str2num(data2);
    
    end
    Vx(count)=mean(datavoltage1);
    Vxfluc(count)=std(datavoltage1);
    Vz(count)=mean(datavoltage2);
    Vzfluc(count)=std(datavoltage2);
    pause(5)
end
fprintf(UnoDAC,'SET mA 0')
[current;Vx;Vz]
% figure
% subplot(2,1,1)
scatter(app.UIAxes,Vx,current)
fitVx=fit(Vx',current','poly1')
hold on
plot(app.UIAxes,fitVx)
ylabel('current(mA)')
xlabel('Vx(V)')
Vxp1=fitVx.p1
Vxp2=fitVx.p2
Vxset=-Vxp2/Vxp1;
legend('',[num2str(fitVx.p1),'*Vz+',num2str(fitVx.p2)])
% subplot(2,1,2)
scatter(app.UIAxes2,Vz,current)
fitVz=fit(Vz',current','poly1')
hold on
plot(app.UIAxes2,fitVz)
ylabel('current(mA)')
xlabel('Vz(V)')
legend('',[num2str(fitVz.p1),'*Vx+',num2str(fitVz.p2)])
end