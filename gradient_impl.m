I = imread('lena512.bmp');
SaltPepperI = imnoise(I,'salt & pepper',0.02);
imwrite(SaltPepperI,'flower_salt_pepper.jpg');

GaussianI = imnoise(I,'gaussian',0.02);
PoisonI = imnoise(I,'poisson');
SpeckleI = imnoise(I,'speckle');

[rows, columns, numberOfColorChannels] = size(SaltPepperI);
y = double(SaltPepperI);
y = y(:); 

u0 = y';
tau=0.1;
lambda=2;
u=u0;
for k=1:20
    [ux,uy]=gradient(u);
    u=u-tau*(u-u0-lambda*divergence(ux,uy));
    u=(u-min(min(u)))/(max(max(u))-min(min(u)));
end

X = u;
RES = uint8(255 * mat2gray(X));
figure,imshow(SaltPepperI)
hold
figure,imshow(RES)