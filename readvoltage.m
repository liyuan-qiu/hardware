clear
% Find a serial port object.
obj_Vx = instrfind('Type', 'serial', 'Port', 'COM9', 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(obj_Vx)
    obj_Vx = serial('COM9');
else
    fclose(obj_Vx);
    obj_Vx = obj_Vx(1);
end

% Connect to instrument object, obj1.
fopen(obj_Vx);
set(obj_Vx, 'Timeout', 1);
%===============================
% Find a serial port object.
obj_Vz = instrfind('Type', 'serial', 'Port', 'COM10', 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(obj_Vz)
    obj_Vz = serial('COM10');
else
    fclose(obj_Vz);
    obj_Vz = obj_Vz(1);
end

% Connect to instrument object, obj1.
fopen(obj_Vz);
set(obj_Vz, 'Timeout', 1);
%% Instrument Configuration and Control
%%%=======================
%% Instrument Connection


% Communicating with instrument object, obj1.
time1=clock
excelname=[num2str(time1),'VzVxmonitor.xlsx']
tic
for count1=1:10000    
    count1
    data1 = query(obj_Vx, ':MEASure:VOLTage?');
    data2 = query(obj_Vz, ':MEASure:VOLTage?');
    timerecord=toc;
    datavoltage1=str2num(data1);
    datavoltage2=str2num(data2);
    datasave=[timerecord,datavoltage1,datavoltage2];
    xlswrite(excelname,datasave,'Sheet1',['A',num2str(count1)])

    pause(3)
    
end

dataall=xlsread(excelname);
subplot(2,1,1)
scatter(dataall(:,1),dataall(:,2))
subplot(2,1,2)
scatter(dataall(:,1),dataall(:,3))
