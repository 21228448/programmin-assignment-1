
q = 100;
I =  imread('1.png');

I_q = round(I./q )*q ;
figure,imshow(I_q);
% imwrite(I_q,'q100-quan.png');

D = FloydSteinberg(I,q);
figure,imshow(D);
% imwrite(D,'q100-floyd.png');