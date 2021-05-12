I = imread('lena512.bmp');
SaltPepperI = imnoise(I,'salt & pepper',0.01);

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
% 
% for k = 1:Nit
%     F = sparse(1:N-1, 1:N-1, abs(Dx)/lam) + DDT;   
%     x = y - D'*(F\Dy);                               
%     Dx = D*x;
%     cost(k) = 0.5*sum(abs(x-y).^2) + lam*sum(abs(Dx));
% end


% X = reshape(x, rows, columns);
% 
% RES = uint8(255 * mat2gray(X));
% figure,imshow(SaltPepperI)
% hold
% figure,imshow(RES)

% count = 0;
% nq = N - 1;
% Q = DDT;
% q = [Dx Dy]';
% x0 = ones(2 * nq, 1);
% eps = 0.0001;
% eigenvalues = eig(Q);
% L = max(eigenvalues);
% alpha = 1 / L;
% grad = Q * xg + q;
% deltax = x0;
% iter_g = 0;
nim = y;
u = y;
[height, width]=size(SaltPepperI); 
[ux, uy]=imgradientxy(y, 'IntermediateDifference');
lambda = 0.1;
 E=sum(sqrt(ux(:).^2 + uy(:).^2)) + lambda*sum(abs(u(:) - nim(:)));
 Res = gradient(E);

% while (norm(deltax) > eps)
%     xg_next = xg - alpha * grad;
%     xg_next(nq + 1 : end) = max(xg_next(nq + 1 : end), 0);
%     deltax = xg - xg_next;
%     xg = xg_next;
%     grad = Q * xg + q;
%     iter_g = iter_g + 1;
%     count = count + 1;
%     if count > 100
%         break;
%     end
% end
% zet_gradient = xg(nq + 1 : end);