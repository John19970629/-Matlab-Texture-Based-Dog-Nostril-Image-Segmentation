%
%
%   **my_high_light演算法**
%
%   將圖片反白
%
%   參數說明
%	pic       灰階或是二值影像
%   mode      處理黑白影像或是灰階影像，0：黑白，1：灰階
%
%

function [ result ] = my_high_light(pic,mode)
    [row,col] = size( pic );
    result = pic;
    
    if(mode==0)
        for i = 1:row
            for j = 1:col
                result(i,j) = ~pic(i,j);
            end
        end
    end
    
    if(mode==1)
        for i = 1:row
            for j = 1:col
                result(i,j) = 255-pic(i,j);
            end
        end
    end

end

% 單檔測試
% clc;
% clear;
% 
% for n = 2:2
%     pic = imread(['../6_correlation/' num2str(n) '.bmp']);
%     
%     mode = 0;
%     [row,col] = size( pic );
%     result = pic;
%     
%     if(mode==0)
%         for i = 1:row
%             for j = 1:col
%                 result(i,j) = ~pic(i,j);
%             end
%         end
%     end
%     
%     if(mode==1)
%         for i = 1:row
%             for j = 1:col
%                 result(i,j) = 255-pic(i,j);
%             end
%         end
%     end
%     
%     imshow(result);
%     
% end