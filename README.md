
# StreamPhoneData

feel free to cite this code using the doi;
[![DOI](https://zenodo.org/badge/90114835.svg)](https://zenodo.org/badge/latestdoi/90114835)

Some matlab scripts to stream the data from the sensors (accelerometers, gyroscopes, GPS, and whatever more your phone may have) in your smartphone (Android or Iphone) to Matlab

## Requirements

MathWorks Products(<www.mathworks.com>)

- MATLAB®
- Instrument Control Toolbox™ ([udpport](https://www.mathworks.com/help/instrument/udpport.html) build-in function）

## How to get started

To use this software:

1. Download the measurement software; for android, download ‘IMU+GPS-Stream’; for Iphone/Ipad, download ‘Sensorlog’ (by Bernd Thomas).
2. If you have an Iphone/Ipad, open your Sensorlog, click the settings icon. In the settings, in the “log data to” select “socket”. In the lower tab, make sure that only “accelerator” (ACC) and “gyroscope” (GYR) are switched on. Also, fully at the bottom, make sure that “fill missing data with previous sample” is switched on. (see screenshots in screenshots apple folder)
3. Connect with both your phone and laptop to the same Wifi network.
4. Open the MainExample file. Since this program is written for different devices, you should now uncomment the appropriate lines (see comments in the script). You have to do this BOTH at the beginning of the script, and in the middle somewhere.
5. For android: You can now run this script. This Matlab script will open up a connection, and display an IP address on which it can be reached. This IP address (the address on which your computer can be reached) should start with 192. If you are at a network that does not use the 192. addresses, change the IpAdress in the script. Input the Ip adress in your phone, as well as the port (50000). Also, to avoid problems, make sure to check the "run in background". As soon as you switch the stream to on, you should see your accelerometer data in Matlab
6. FOR IPHONE in the block of code you just uncommented, it also says:
IpAdress='192.168.1.72';
Port=61904;
Change these values to the values you see in the main screen of the sensorlog app, bottom right (it reads as 192.168.1.72: 61904) on your phone. Next, you can click the “play” button in the lower left of the screen. Now you can run the Matlab script. You should see the accelerometer from your phone in a Matlab graph.

- If no data do appear in the figure, there is probably a problem with your connection. Press Ctrl+C to break the program, turn of any virus scanning or security software and turn off the built in firewall of your operating system (for windows: <https://support.microsoft.com/en-us/help/17228/windows-protect-my-pc-from-viruses>), (for mac: <http://www.wikihow.com/Turn-off-Mac-Firewall>), and try again.
