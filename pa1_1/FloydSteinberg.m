function output = FloydSteinberg(input_im,q)

% Input: input_im = a grayscale image
% q = quantization parameter
% Output: output = dithered image of input_im's

for x=1:1:size(input_im,1)
    for y=1:1:size(input_im,2)
        oldpixel(x,y) = input_im(x,y);
        
        newpixel(x,y) = round(oldpixel(x,y)./q)*q;
        input_im(x,y) = newpixel(x,y);
        quant_error = oldpixel(x,y)-newpixel(x,y);
        
        if x == 1
            if y == size(input_im,2)
                input_im(x + 1,y) = input_im(x + 1,y) + quant_error * 5 / 8;
                input_im(x + 1,y - 1) = input_im(x + 1,y - 1) + quant_error * 3 / 8;
            elseif y == 1
                input_im(x + 1,y) = input_im(x + 1,y) + quant_error * 5 / 13;
                input_im(x,y + 1) = input_im(x,y + 1) + quant_error * 7 / 13;
                input_im(x + 1,y + 1) = input_im(x + 1,y + 1) + quant_error * 1 / 13;
            else
                input_im(x + 1,y) = input_im(x + 1,y) + quant_error * 5 / 16;
                input_im(x,y + 1) = input_im(x,y + 1) + quant_error * 7 / 16;
                input_im(x + 1,y - 1) = input_im(x + 1,y - 1) + quant_error * 3 / 16;
                input_im(x + 1,y + 1) = input_im(x + 1,y + 1) + quant_error * 1 / 16;         
            end
        elseif x == size(input_im,1) 
            if y < size(input_im,2)
                input_im(x,y + 1) = input_im(x,y + 1) + quant_error * 7 / 7;
            end
        else
            if y == 1
                 input_im(x,y + 1) = input_im(x,y + 1) + quant_error * 7 / 13;
                 input_im(x + 1,y + 1) = input_im(x + 1,y + 1) + quant_error * 1 / 13;
                 input_im(x + 1,y) = input_im(x + 1,y) + quant_error * 5 / 13;
            elseif y == size(input_im,2)
                 input_im(x + 1,y - 1) = input_im(x + 1,y - 1) + quant_error * 3 / 8;
                 input_im(x + 1,y) = input_im(x + 1,y) + quant_error * 5 / 8;
            else
                input_im(x + 1,y) = input_im(x + 1,y) + quant_error * 5 / 16;
                input_im(x + 1,y - 1) = input_im(x + 1,y - 1) + quant_error * 3 / 16;
                input_im(x,y + 1) = input_im(x,y + 1) + quant_error * 7 / 16;
                input_im(x + 1,y + 1) = input_im(x + 1,y + 1) + quant_error * 1 / 16;
            end
        end
    end 
end

output=uint8(input_im);
end
