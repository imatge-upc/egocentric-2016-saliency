function score = reading_gazedata(file,name)
file = xlsread(file); %Gaze data file
% This file has 6 columns (duration,width,height,RecordingTimestamp, Gaze_coordinateX, Gaze_coordinateY):
%Position of the columns:
duration_column = 1; %duration is in milliseconds
width_column = 2; %in pixels
height_column = 3; %in pixels
Tmp_column = 4; %in milliseconds
GazeX_column = 5; %in pixels
GazeY_column = 6; %in pixels

milli = 1000; % 1 second = 1000 milliseconds
duration = (round(file(1,duration_column)/milli))*milli; %extraction of the duration of the video without the last milliseconds

score = zeros(1,(duration/milli));

for rate_frames = milli:milli:duration %from the 1st second to the last one (in milliseconds)
    second_position = find(file(:,Tmp_column)==rate_frames); 
    second_before_position = find(file(:,Tmp_column)==rate_frames-milli);

    matrix = zeros(file(1,height_column),file(1,width_column));
    control = 0;
    for c = (second_before_position+1):second_position
        cord_x = file(c,GazeX_column);
        cord_y = file(c,GazeY_column);
        if isnan(cord_x)==0 % if the gaze point is lost, the matrix is not filled.
            matrix(cord_x+1,cord_y+1) = 1; %completing the binary matrix for each millisecond that forms each second.
            control = control+1;
        end
    end
    
    if control<=15 %That is a control. If in each second exists a notable number of looses (more than the half part) of gazepoints, the NSS is not calculed
        score(1,(rate_frames/milli)) = 0;
    else
        if (rate_frames/milli)<=9
            im = imread(strcat(name,'_0000',num2str((rate_frames/milli)),'.png'));
        elseif and((rate_frames/milli)>=10,(rate_frames/milli)<=99)
            im = imread(strcat(name,'_000',num2str((rate_frames/milli)),'.png'));
        elseif and((rate_frames/milli)>=100,(rate_frames/milli)<=999)
            im = imread(strcat(name,'_00',num2str((rate_frames/milli)),'.png'));
        else
            im = imread(strcat(name,'_0',num2str((rate_frames/milli)),'.png'));
        end
        
        score(1,(rate_frames/milli)) = NSS(im,matrix);
    end
end

