clear;
%% Importing Video File
% Video plays at 24FPS 
obj = VideoReader('Time-Lapse- Watch Flowers Bloom Before Your Eyes - Short Film Showcase (1).mp4');
%% Get the frames
% at time = 25 sec
fa1 = read(obj, 600);
fa2 = read(obj, 601);
% at time = 38 sec
fb1 = read(obj, 912);
fb2 = read(obj, 913);
% at time = 50 seconds
fc1 = read(obj, 1200);
fc2 = read(obj, 1201);
av1=(fa1+fa2)./2;
av2=(fb1+fb2)./2;
av3=(fc1+fc2)./2;


%% Plotting the Snapshots
 FigHandle = figure;
  set(FigHandle, 'Position', [100, 100, 1000, 400]);
subplot(3,4,1); imshow(fa1); title('First frame');
subplot(3,4,2); imshow(fa2); title('Second frame');
subplot(3,4,3); imshow(fa1-fa2); title('Difference at t=25 sec');
subplot(3,4,4); imshow(av1);title('Interpolation between the frames'); 
subplot(3,4,5); imshow(fb1); 
subplot(3,4,6);imshow(fb2);
subplot(3,4,7); imshow(fb1-fb2); title('t=38 sec');
subplot(3,4,8); imshow(av2);title('Interpolation between the frames'); 
subplot(3,4,9); imshow(fc1);
subplot(3,4,10); imshow(fc2);
subplot(3,4,11); imshow(fc1-fc2); title('t=50 sec');
subplot(3,4,12); imshow(av3);title('Interpolation between the frames'); 
