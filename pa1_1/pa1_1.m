
q = 255;
I =  imread('1.png');

I_q = round(I./q )*q ;
figure,imshow(I_q);

D = FloydSteinberg(I,q);
