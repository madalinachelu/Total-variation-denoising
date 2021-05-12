I = imread('lena512.bmp');
SaltPepperI = imnoise(I,'salt & pepper',0.01);
imwrite(SaltPepperI,'flower_salt_pepper.jpg');

GaussianI = imnoise(I,'gaussian',0.01);
PoisonI = imnoise(I,'poisson');
SpeckleI = imnoise(I,'speckle');

[rows, columns, numberOfColorChannels] = size(SaltPepperI);

y = double(SaltPepperI);

lam = 70;                        
Nit = 50;                         
y = y(:);                                             
cost = zeros(1, Nit);                                 
N = length(y);


I = speye(N);
D = I(2:N, :) - I(1:N-1, :);
DDT = D * D';

x = y;

% Initialization
Dx = D*x;
Dy = D*y;

for k = 1:Nit
    F = sparse(1:N-1, 1:N-1, abs(Dx)/lam) + DDT;       
    x = y - D'*(F\Dy);                                 
    Dx = D*x;
    cost(k) = 0.5*sum(abs(x-y).^2) + lam*sum(abs(Dx));
end

X = reshape(x, rows, columns);

RES = uint8(255 * mat2gray(X));
figure,imshow(SaltPepperI)
hold
figure,imshow(RES)
 
