function [t_acc,acc,om,t_om]=getappledata(phonelistener)
% [t_acc,acc,om,t_om]=getappledata(phonelistener)
% function to get data from an android phone via wifi. First, a
% phonelistener object should have been generated, via makeapplelistener.
% input:
%   phonelistener :UDP objetc that listens to phone
% output:
%   t_acc   : time belonging to current acceleration sample
%   acc     : acceleration [1x3]
%   om      : angular velocity [1x3]
%   t_om    : time belonging to current angular velocity sample
% if a sample cannot be read, nan's willl be returned
% function can easily be adjusted to read more sensor data.
% nov 2015 SMB.

t_acc       = nan;
acc         = nan(1,3);
t_om        = nan;
om          = nan(1,3);


formatSpec = '%s%f%f%f%f%f%f%f%f%f%f%[^\n\r]'; % you get this when you make Matlab import a .cvs file
delimiter = ','; % you get this when you make Matlab import a .cvs file

data = fgetl(phonelistener); % read each line with fgetl()
try
    dataArray = textscan(data, formatSpec, 'Delimiter', delimiter); % you get this when you make Matlab import a .cvs file
    
    t_acc=[dataArray{3}];
    acc=[dataArray{4:6}];
    t_om=[dataArray{7}];
    om=[dataArray{8:10}];
catch
    disp('no data received')
end
