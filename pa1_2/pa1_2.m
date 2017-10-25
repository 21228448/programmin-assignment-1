

I0 = im2double(imread('ims/ocean_sunset.jpg'));
I1 = im2double(imread('ims/storm.jpg'));

IR = colorTransfer(I0,I1);


figure,imshow(I0);
figure,imshow(I1);

% imwrite(IR,'ocsunset-storm.jpg');
figure,imshow(IR);
