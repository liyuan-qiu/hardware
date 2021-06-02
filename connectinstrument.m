clear
global obj_Vx;
global obj_Vz;
global UnoDAC;

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
set(obj_Vx, 'Timeout', 2);
set(obj_Vx,'Terminator','CR/LF')
'connect obj_Vx'
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
set(obj_Vz, 'Timeout', 2);
set(obj_Vz,'Terminator','CR/LF')

'connect obj_Vy'
% =======================================
% Find a serial port object.
UnoDAC = instrfind('Type', 'serial', 'Port', 'COM14', 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(UnoDAC)
    UnoDAC = serial('COM14');
else
    fclose(UnoDAC);
    UnoDAC = UnoDAC(1);
end
% Connect to instrument object, obj1.
fopen(UnoDAC);
set(UnoDAC, 'Timeout', 2);
set(UnoDAC,'Terminator','CR/LF')

'connect UnoDAC'