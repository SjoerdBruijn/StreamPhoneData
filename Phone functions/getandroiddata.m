function [t, acc, om, mag, gps, or,lin_acc,grav,press]=getandroiddata(phonelistener)
% [t, acc, om, mag, gps, or,lin_acc,grav,press]=getandroiddata(phonelistener)
% function to get data from an Android phone via wifi. First, a
% phonelistener object should have been generated, via makeandroidlistener.
% input:
%   phonelistener :UDP objetc that listens to phone
% output:
%   t       : time
%   acc     : acceleration [1x3]
%   om      : angular velocity [1x3]
%   mag     : magnetic field [1x3]
%   gps     : gps coordinates [unknown, doesnt work yet]
%   or      : orientation as estimated by the phone (euler angles?) [1x3]
%   lin_acc : linear accelerations, excluding gravity [1x3] (as calculated by phone)
%   grav    : direction of gravitational vector  [1x3] (as calculated by phone)
%   press   : pressure.
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
%% TODO: 
% include proper GPS extraction
% battery temperature readout? 


%% create empty outputs
t       = nan;
acc     = nan(1,3);
om      = nan(1,3);
mag     = nan(1,3);
gps     = nan(1,3);
or      = nan(1,3);
lin_acc = nan(1,3);
grav    = nan(1,3);
press   = nan;

%% read a line of data. 
data = fscanf(phonelistener);

%% indices of the different data fields
sepp        = [strfind(data,',') length(data)];
ind_acc     = strfind(data,', 3,');
ind_om      = strfind(data,', 4,');
ind_mag     = strfind(data,', 5,');
ind_gps     = strfind(data,'onbekend'); % should still check this.
ind_or      = strfind(data,', 81,');
ind_linacc  = strfind(data,', 82,');
ind_grav    = strfind(data,', 83,');
ind_press   = strfind(data,', 85,');

%% extract all data: time
t       = str2double(data(1:sepp(1)));
if t<1000 || size(sepp,2)==1 % some stupid hack to avoid errors. 
    t = nan;
    return
end
%% extract all data: acceleration
if ~isempty(ind_acc) && length(find(sepp>ind_acc))>=4
    ind_acc = find(sepp>ind_acc,1,'first');
    acc     = [str2double(data(sepp(ind_acc)+1:sepp(ind_acc+1)-1)) str2double(data(sepp(ind_acc+1)+1:sepp(ind_acc+2)-1)) str2double(data(sepp(ind_acc+2)+1:sepp(ind_acc+3)-1))   ]  ;
end
%% extract all data: angular velocity
if ~isempty(ind_om) && length(find(sepp>ind_om))>=4
    ind_om = find(sepp>ind_om,1,'first');
    om     = [str2double(data(sepp(ind_om)+1:sepp(ind_om+1)-1)) str2double(data(sepp(ind_om+1)+1:sepp(ind_om+2)-1)) str2double(data(sepp(ind_om+2)+1:sepp(ind_om+3)-1))   ]  ;
end
%% extract all data: magnetos
if ~isempty(ind_mag)&& length(find(sepp>ind_mag))>=4
    ind_mag = find(sepp>ind_mag,1,'first');
    mag     = [str2double(data(sepp(ind_mag)+1:sepp(ind_mag+1)-1)) str2double(data(sepp(ind_mag+1)+1:sepp(ind_mag+2)-1)) str2double(data(sepp(ind_mag+2)+1:sepp(ind_mag+3)-1))   ]  ;
end
%% extract all data: GPS
if ~isempty(ind_gps)&& length(find(sepp>ind_gps))>=4
    ind_gps = find(sepp>ind_gps,1,'first');
    gps     = [str2double(data(sepp(ind_gps)+1:sepp(ind_gps+1)-1)) str2double(data(sepp(ind_gps+1)+1:sepp(ind_gps+2)-1)) str2double(data(sepp(ind_gps+2)+1:sepp(ind_gps+3)-1))   ]  ;
end
%% extract all data: orientation
if ~isempty(ind_or)&& length(find(sepp>ind_or))>=4
    ind_or = find(sepp>ind_or,1,'first');
    or     = [str2double(data(sepp(ind_or)+1:sepp(ind_or+1)-1)) str2double(data(sepp(ind_or+1)+1:sepp(ind_or+2)-1)) str2double(data(sepp(ind_or+2)+1:sepp(ind_or+3)-1))   ]  ;
end
%% extract all data: linear accelerations
if ~isempty(ind_linacc)&& length(find(sepp>ind_linacc))>=4
    ind_linacc = find(sepp>ind_linacc,1,'first');
    lin_acc     = [str2double(data(sepp(ind_linacc)+1:sepp(ind_linacc+1)-1)) str2double(data(sepp(ind_linacc+1)+1:sepp(ind_linacc+2)-1)) str2double(data(sepp(ind_linacc+2)+1:sepp(ind_linacc+3)-1))   ]  ;
end
%% extract all data: gravity vector
if ~isempty(ind_grav)&& length(find(sepp>ind_grav))>=4
    ind_grav = find(sepp>ind_grav,1,'first');
    grav     = [str2double(data(sepp(ind_grav)+1:sepp(ind_grav+1)-1)) str2double(data(sepp(ind_grav+1)+1:sepp(ind_grav+2)-1)) str2double(data(sepp(ind_grav+2)+1:sepp(ind_grav+3)-1))   ]  ;
end
%% extract all data: pressure
if ~isempty(ind_press)&& length(find(sepp>ind_press))>=1
    ind_press = find(sepp>ind_press,1,'first');
    press     = str2double(data(sepp(ind_press)+1:sepp(ind_press+1)-1))   ;
end