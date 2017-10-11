

I0 = im2double(imread('ims/scotland_house.jpg'));
I1 = im2double(imread('ims/scotland_plain.jpg'));

IR = colorTransfer(I0,I1);


