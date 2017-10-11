
q = 255;
I =  (imread('1.png'));

I_q = round(I./q )*q ;
imwrite(I_q,'quan.png')
figure,imshow(I_q);

D = Floyd_Steinberg_Dithering((I),q);
imwrite(D,'fs.png')

% I_q = round(D./q )*q ;
figure,imshow(D);