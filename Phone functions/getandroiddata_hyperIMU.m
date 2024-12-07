function [t, acc, om, mag]=getandroiddata_hyperIMU(phonelistener)
if verLessThan('matlab','9.12')
    data = fscanf(phonelistener);
else

    data=read(phonelistener,1,'string');
    try
        data=data.Data{:};
    catch
        data=[];
    end
end


t       = nan;
acc     = nan(1,3);
om      = nan(1,3);
mag     = nan(1,3);
try
    data    = str2num(data);
    n=size(data,2);
    if mod(n,3)==1
        t=data(1);
        if n>1
            acc=data(2:4);
        end
        if n>4
            om=data(5:7);
        end
        if n>7
            mag=data(8:10);
        end
    else
        if n>1
            acc=data(1:3);
        end
        if n>3
            om=data(4:6);
        end
        if n>6
            mag=data(7:10);
        end
    end
catch
    disp('could not fetch data')
end
