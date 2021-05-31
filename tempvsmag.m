dataall=xlsread('2021              5             13             11             35         10.634VzVxmonitor - 副本.xlsx');
subplot(4,1,1)
scatter(dataall(:,1),dataall(:,2))
title('Vz')
subplot(4,1,2)
scatter(dataall(:,1),dataall(:,3))
title('Vx')

[temmon,timedata]=xlsread('EFG213000987_20210513142415.xls','Sheet1','A2:C169');
time=(datenum(timedata)-datenum(timedata(1)))*3600*24;
subplot(4,1,3)
scatter(time,temmon(:,1))
title('Temperature')
subplot(4,1,4)
scatter(time,temmon(:,2))
title('Moisture')
xlabel('time(s)')