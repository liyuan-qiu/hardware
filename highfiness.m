% Find a serial port object.
highfiness = instrfind('Type', 'serial', 'Port', 'COM13', 'Tag', '','BaudRate', 115200,'Timeout', 15);
% Configure instrument object, obj1.
% set(highfiness, 'BaudRate', 115200);
% set(highfiness, 'Timeout', 15);
% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(highfiness)
    highfiness = serial('COM13');
else
    fclose(highfiness);
    highfiness = highfiness(1);
end

% Connect to instrument object, obj1.
fclose(highfiness);
fopen(highfiness);

%% Instrument Configuration and Control

% Communicating with instrument object, obj1.
data1 = query(highfiness, '*IDN？')

for count1=1:1
    count1
    query(highfiness, ['CUR ',num2str(count1*10),'uA'])
%     query(highfiness, 'CUR?')
    pause(1)
end
