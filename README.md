# hardware
## The introduction of the slow magnetic field compensation 
还考虑做一个慢反馈，就是每10秒读取一个数据，然后反馈给highfiness电流源，这个可以通过串口通讯来进行，不需要PID电路，但是现在直接用highfiness所带的USB进行串口通讯发现是不稳定的，所以继续用RJ45端口和单片机进行通讯，这样也可以更快

In order to componsate the magnetic field of permanent magnet caused by the temperature fluctuation

![image](https://user-images.githubusercontent.com/39110126/120443858-a3d5dc80-c3b9-11eb-8983-6170d977d114.png)

I will first sample the relationship between the magnetic field and the current in compensating coil in front of the permanent magnet where the compensating coil current is varied from -1Amp to +1Amp with 0.1A step.

And then compensate the magnetic field every 10 seconds by control the compensating coil current with highfiness power supply.

** The use of magnetic field compensation **

1. first load the arduino harware code to Arduino board [DAC set](https://github.com/liyuan-qiu/hardware/blob/magnetic-field-compensation/setDAC20/setDAC20.ino)

2. then turn on the matlab UI app [magnetic field slow compensate UI](https://github.com/liyuan-qiu/hardware/blob/magnetic-field-compensation/currentvsVzVxUI.m)

3. Find the COM port of the Arduino hardware [Connect Instrument](https://github.com/liyuan-qiu/hardware/blob/magnetic-field-compensation/connectinstrument.m)

4. Turn on the sampling procedure to 

