function applelistener=makeapplelistener(IpAdress,Port)
% applelistener=makeapplelistener(IpAdress,Port)
% function that generates a TCP phone listener object to retrieve data from APPLE
% phones. Use getappledata subsequently.
% input:
%   IpAdress : the Ipadress of the phone you want to retrieve data from
%   (string)
%   Port     : the Port where the phone specifies the data can be get
%   (number)
% output:
% applelistener : TCP object that retrieves data from the phone at
% IpAdress:Port





%% Creating TCPIP object and opening connection
if verLessThan('matlab','9.12')
    applelistener=tcpip(IpAdress,Port,'NetworkRole','client'); % create TCPIP client object
else
    applelistener=tcpclient(IpAdress,Port);
end
fopen(applelistener);
