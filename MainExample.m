% main example file for using matlab to stream phone data. Note that this
% file only readse out accelerometer data. For full list of sensors that
% can be read out, see getandroiddata and getappledata
%% Copyright
%     COPYRIGHT (c) 2017 Sjoerd Bruijn, VU University Amsterdam
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%% version history; march 2017, Sjoerd Bruijn (SMB) updated from older versions by SMB, to make suitable
% for general use (i.e. proper commenting, cleanup of code, etc)

%% Resetting MATLAB environment
instrreset; clear ; close all; clc
addpath('Phone functions');

%% general setting
N_sample        = 1000; % how many samples to collect

%% create phone listener object: Android
IpAdress      = '192'; % in case of android, this is the IP adress of the computer, or the first
% three digits of it. 
phonelistener   = makeandroidlistener(IpAdress);

%% create phone listener object: Apple
% IpAdress      = '192.168.1.67'; % in case of apple, this is the IP adress
% of the phone!!
% Port          = 57100;
% phonelistener = makeapplelistener(IpAdress,Port);
%% Initialise empty figure and empty variables
figure
h_plot  = plot(NaN,[NaN NaN NaN]);
t       = NaN*ones(N_sample,1);
acc     = NaN*ones(N_sample,3);

%% Loop to start data collection
for i_time = 1:N_sample
    
    %% Apple: sensorlog
    %    [t(i_time,:), acc(i_time,:)]   = getappledata(phonelistener);
    
    %% Android: IMU+GPS Stream
    [t(i_time,:), acc(i_time,:)]        = getandroiddata(phonelistener);
    
    %% plot here
    set(h_plot(1),'Xdata',t(~isnan(acc(:,1))),'Ydata',acc(~isnan(acc(:,1)),1))
    set(h_plot(2),'Xdata',t(~isnan(acc(:,1))),'Ydata',acc(~isnan(acc(:,1)),2))
    set(h_plot(3),'Xdata',t(~isnan(acc(:,1))),'Ydata',acc(~isnan(acc(:,1)),3))
    pause(0.001)
    
    drawnow
end
%% Closing and deleting connections (keep these in your program!)
fclose(phonelistener);%Closing UDP communication
delete(phonelistener);%Deleting UDP communication

