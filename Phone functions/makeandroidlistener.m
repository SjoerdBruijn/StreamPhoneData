function androidlistener = makeandroidlistener(target)
% androidlistener=makeandroidlistener()
% function that generates a UDP phone listener object to listen to android
% phones. Use getandroiddata subsequently.
% input:
%  target= target IP adress (adress of the computer. First three digits may
%  be enough.
% output: 
% androidlistener : UDP object that listens to incoming signals on port
% 5000.


%% find IP adress using some Java, and display it to user
IPaddress   = [];
iterNetwork = java.net.NetworkInterface.getNetworkInterfaces();
while (iterNetwork.hasMoreElements())
    network = iterNetwork.nextElement();
    iterAddress = network.getInetAddresses();
    while (iterAddress.hasMoreElements())
        address = iterAddress.nextElement();
        tmpIPaddress = char(address.getHostAddress());
        if  strcmp(tmpIPaddress(1:length(target)),target)
            IPaddress = tmpIPaddress;
        end
    end
end
if isempty(IPaddress)
    error('you are not connected to the right network')
end
disp(['IP adress is: ', IPaddress,' Port: 50000'])

%% Creating UDP object and opening connection
androidlistener     = udp(IPaddress,'LocalPort',50000);
fopen(androidlistener); % Opening UDP communication
