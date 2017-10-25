function output = colorTransfer(source,target)

a = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1288 0.8444];
b = [1/sqrt(3) 0 0;0 1/sqrt(6) 0;0 0 1/sqrt(2)];
c = [1 1 1;1 1 -2;1 -1 0];
%1..............................................................................................................
imgSource = reshape(im2double(source),[],3);
imgSource = max(imgSource,1/255);
LMS = a*imgSource';


imgTarget = reshape(im2double(target),[],3);
imgTarget = max(imgTarget,1/255);
LMS_tar = a*imgTarget';

%2...............................................................................................................
LMS = log10(LMS);
LMS_tar = log10(LMS_tar);

%3...............................................................................................................

lab = b*c*LMS;
lab = reshape(lab', size(source));

lab_tar = b*c*LMS_tar;
lab_tar=reshape(lab_tar', size(target));

s_l=lab(:,:,1);      %divide images l,a,b channels
s_a=lab(:,:,2);
s_b=lab(:,:,3);
t_l=lab_tar(:,:,1);
t_a=lab_tar(:,:,2);
t_b=lab_tar(:,:,3);

%4..............................................................................................................
s_l_mean=mean(s_l(:));  %compute l,a,b channel's means
s_a_mean=mean(s_a(:));
s_b_mean=mean(s_b(:));
t_l_mean=mean(t_l(:));
t_a_mean=mean(t_a(:));
t_b_mean=mean(t_b(:));

s_l_std=std(s_l(:));   %compute l,a,b channel's standard deviations
s_a_std=std(s_a(:));
s_b_std=std(s_b(:));
t_l_std=std(t_l(:));
t_a_std=std(t_a(:));
t_b_std=std(t_b(:));

%5...............................................................................................................
l=s_l - s_l_mean;      %subtract means from the data
a=s_a - s_a_mean;
b=s_b - s_b_mean;

%6...............................................................................................................
l_new=l.*(t_l_std./s_l_std);   %scale new data points according to the relative std of target and source images
a_new=a.*(t_a_std./s_a_std);
b_new=b.*(t_b_std./s_b_std);

%7.................................................................................................................
l_final=l_new+t_l_mean;   %add the averages computed for the source to scaled data point
a_final=a_new+t_a_mean;
b_final=b_new+t_b_mean;

%8...............................................................................................................
trg(:,:,1)=l_final;
trg(:,:,2)=a_final;
trg(:,:,3)=b_final;

res_lab = reshape(trg,[],3);

b2 = [sqrt(3)/3 0 0;0 sqrt(6)/6 0;0 0 sqrt(2)/2];
c2 = [1 1 1;1 1 -1;1 -2 0];

LMS_res=c2*b2*res_lab';

%9...............................................................................................................
for ch = 1:3
    LMS_res(ch,:) = 10.^LMS_res(ch,:);
end
%10..............................................................................................................
est_im = ([4.4679 -3.5873 0.1193;-1.2186 2.3809 -0.1624;0.0497 -0.2439 1.2045]*LMS_res)';
output = reshape(est_im,size(lab)); % reshape the image

end