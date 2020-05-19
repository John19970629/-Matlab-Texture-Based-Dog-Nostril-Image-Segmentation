%
%
%   **nostril_segment**
%
%   參數說明
%	pic                 彩圖
%   length_rate         要切割鼻孔的row比例
%   false_rate          容錯率
%
%   備註
%   round       四捨五入
%   ceil        無條件進位
%
%

function [result,seg_begin] = my_nostril_segment (pic,length_rate,false_rate)
    
    [row,col,dim] = size(pic);
    center = [round(row/2),round(col/2)];
    
    length  = ceil(length_rate*row*false_rate);
    seg_begin = ceil(center(1)-(length/2));
    seg_end = ceil(center(1)+(length/2));
    
    for i=seg_begin:seg_end
        for j=1:col
            result(i-seg_begin+1,j,:) = pic(i,j,:);
        end
    end
    
end

% %單檔測試
% clc;
% clear;
% 
% length_rate = 0.4757;    
% weight_rate = 0.9216;
% 
% false_rate = 1.3;
% 
% for n=88:88
%     pic = imread(['../ground truth/' num2str(n) '.bmp']);
%     
%     [row,col,dim] = size(pic);
%     center = [round(row/2),round(col/2)];
%     
%     length  = ceil(length_rate*row*false_rate);
%     seg_begin = ceil(center(1)-(length/2));
%     seg_end = ceil(center(1)+(length/2));
%     
%     for i=seg_begin:seg_end
%         for j=1:col
%             result(i-seg_begin+1,j,:) = pic(i,j,:);
%         end
%     end
%     imshow(result);
% end
