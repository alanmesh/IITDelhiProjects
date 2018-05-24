function [b] = HistogramPlotter(I)
%% The function gives the histogram data for image I

%% Code begins
b=zeros(1,16); % Initialize with zeroes (for 16 level image only)
[row,col]=size(I); % Read the size of the the given Image

for x=1:1:row  % Iterate for all the rows
    for y=1:1:col % Iterate for all the comumns
        if I(x,y)<1 
            continue; % Don't do anything if intensisity values are less than 1
        else
            t=I(x,y); % store otherwise
        end
        b(t)=b(t)+1;  
    end
end
end

