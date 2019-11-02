function y = NRZI(ibs,rb)

% ibs = [0,1,0,0,1,1,1,0];
% rb = 1e6;

t = 0:1/(rb*1000):length(ibs)/rb;
y = []; %Dynamic memory allocation is very dangerous, do not do this

%% This assumes that we are using NRZM implemented into NRZI. If needed to adapt as
%% NRZ-S, then change the flow control for ibs(i)

prev = 0;
for i = 1:length(ibs)
    if ibs(i) == 0
        for j = 1:length(t)/(length(ibs))
            y = [y,prev];
        end
    else
        for j = 1:length(t)/(2*length(ibs))
            y = [y,prev];
        end
        prev = bitxor(1,prev);
        for j = 1:length(t)/(2*length(ibs))
            y = [y,prev];
        end
    end
end