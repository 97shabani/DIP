% Copyright (c) 2017 Majid Shabani
% 97shabani@gmail.com
%DIP_HW10_MajidShabani

close all; 
clear all;

img = imread('Fig0526.tif'); 
[m,n] = size(img);

% Compute the meshgrid arrays
[v,u] = meshgrid(1:n, 1:m);

%   a           linear motion rate in the x-direction
%   b           linear motion rates in the y-direction
%   T           duration of the exposure
T = 1; a = 0.1; b = 0.1;

%Following two steps are very critical
%trans the (m/2, n/2) to the origin(0,0)
U = u-floor(m/2);
V = v-floor(n/2);

%Construct the degradation function.
H = T./(pi*( U*a + V*b +eps)).* sin( pi*(U*a + V*b +eps)).* exp(-1j*(pi*( U*a + V*b +eps)));

%Create a motion blurred image.
F_img = fft2(img);
F_Blur = F_img.*ifftshift(H);
img_blur = real(ifft2(F_Blur));

%Display Motion Blured Image
f=figure;
subplot(1, 2, 1);imshow(img);title('Orginal Image');
subplot(1, 2, 2);imshow(img_blur, []);title('Motion Blured Image');
savefig(f,'MotionBlured.fig');