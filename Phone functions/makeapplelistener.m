function applelistener=makeapplelistener(IpAdress,Port)
% applelistener=makeapplelistener(IpAdress,Port)
% function that generates a TCP phone listener object to retrieve data from APPLE
% phones. Use getappledata subsequently. 
% input: 
%   IpAdress        : the Ipadress of the phone you want to retrieve data from (string)
%   Port            : the Port where the phone specifies the data can be get(number)
% output: 
%   applelistener   : TCP object that retrieves data from the phone at IpAdress:Port
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

%% Creating TCPIP object and opening connection
applelistener = tcpip(IpAdress,Port,'NetworkRole','client'); % create TCPIP client object 
fopen(applelistener); 
