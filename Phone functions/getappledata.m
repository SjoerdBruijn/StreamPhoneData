function [t_acc,acc,om,t_om]=getappledata(phonelistener)
% [t_acc,acc,om,t_om]=getappledata(phonelistener)
% function to get data from an Apple phone via wifi. First, a
% phonelistener object should have been generated, via makeapplelistener.
% input:
%   phonelistener :TCP objetc that listens to phone
% output:
%   t_acc   : time belonging to current acceleration sample
%   acc     : acceleration [1x3]
%   om      : angular velocity [1x3]
%   t_om    : time belonging to current angular velocity sample
% if a sample cannot be read, nan's willl be returned
% function can easily be adjusted to read more sensor data.
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

t_acc   = nan;
acc     = nan(1,3);
t_om    = nan(1);
om      = nan(1,3);


formatSpec  = '%s%f%s%f%f%f%f%f%f%f%f%[^\n\r]';
delimiter   = ',';

data = fgetl(phonelistener); % read each line with fgetl()
try
    dataArray   = textscan(data, formatSpec, 'Delimiter', delimiter);
    
    t_acc       = [dataArray{4}];
    acc         = [dataArray{5:7}];
    t_om        = [dataArray{8}];
    om          = [dataArray{9:11}];
catch
    disp('no data received')
end
