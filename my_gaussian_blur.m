%
%
%   **my_gaussian_blur�t��k**
% 
%   ����蹳�B�z�������ҽk
%
%   �Ѽƻ���
%	pic     �Ƕ��v��
%   WinSize �B�z window ���j�p
%   sigma   �зǮt�Ѽ�
%
%

function result = my_gaussian_blur (pic,WinSize,sigma)

w = (WinSize-1)/2;

[row col] = size(pic);
result = zeros(row,col);
pic_sym = padarray(pic,[w w],'symmetric');

filter = fspecial('gaussian',[WinSize WinSize],sigma);
pic_gaussian_blur = imfilter(pic_sym,filter);

for i = 1:row
    for j = 1:col
        result(i,j) = pic_gaussian_blur(i+w,j+w);
    end
end

result = uint8(result);

end

% clc;
% clear;
% 
% w = 12;
% 
% pic_correlation_L = imread(['../11_resegment/gamma/correlation/64/' num2str(98) '_correlation_64_L' '.bmp']);
% [row col] = size(pic_correlation_L);
% result = zeros(row,col);
% pic_sym = padarray(pic_correlation_L,[w w],'symmetric');
% 
% 
% filter = fspecial('gaussian',[25 25],10);
% pic_gaussian_blur_L = imfilter(pic_sym,filter);
% 
% for i = 1:row
%     for j = 1:col
%         result(i,j) = pic_gaussian_blur_L(i+w,j+w);
%     end
% end
% 
% imshow(uint8(result));