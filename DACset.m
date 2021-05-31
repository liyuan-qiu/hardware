clear
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
set(UnoDAC, 'Timeout', 1);
fprintf(UnoDAC,'SET mA 1000')