%
%
%   **my_label_denoise演算法**
%
%   將二值影像做 label 後，label個數小於 T 的都設成背景
%
%   參數說明
%	pic_input       二值化圖
%   T               面積門檻值
%
%

function [ result ] = my_label_denoise( pic_input ,T)

    %取得 label 的表格和 最大label數，(8連通)
    [label,label_max] = bwlabel(pic_input,8);
    [row,col] = size( label );
    result    = zeros(row,col);
    
%     %把每個label都用一個顏色代表，並顯示出來
%     RGB_label = label2rgb(label, @flag, 'c', 'shuffle');
%     imshow(RGB_label,'InitialMagnification','fit')
% %     imwrite(RGB_label,['../label/' num2str(n) '_label' '.bmp']);
    
    %面積小於 T 的label強制設成0 (背景)
    for k = 1:label_max
        label_area(k) = length( find(label==k) ); % 找各label面積
        if (label_area(k) < T)
            for i=1:row
                for j=1:col
                    if (label(i,j)==k)
                        label(i,j)=0;   
                    end
                end
            end
        end
    end
    
    % 如果 label != 0，就把結果圖設成1 (前景)
    % 如果 label == 0，就把結果圖設成0 (背景)
    for i = 1:row
        for j = 1:col
            if( label(i,j)>0 )
               result(i,j) = 1;
            else
                result(i,j) = 0; 
            end
        end
    end
    
end

% 單檔測試
% clc;
% clear;
%     
% for n = 6:6
%     
%     % 如果檔案存在才執行 
%     if(exist(['../11_resegment/gamma/correlation/Otsu/' num2str(n) '_gamma=1_win=5_k=0.5_L' '.bmp'],'file')~=0)
%     pic_input  = imread(['../11_resegment/gamma/correlation/Otsu/' num2str(n) '_gamma=1_win=5_k=0.5_L' '.bmp']);
%     
%     T = 15000;
%     
%     %取得 label 的表格和 label 最大數字
%     [label,label_max] = bwlabel(pic_input,8);
%     [row,col] = size( label );
%     result    = zeros(row,col);
%     
%     %把每個label都用一個顏色代表，並顯示出來
%     RGB_label = label2rgb(label, @flag, 'c', 'shuffle');
% %     imshow(RGB_label,'InitialMagnification','fit')
% %     imwrite(RGB_label,['../label/' num2str(n) '_label' '.bmp']);
%     
%     %面積小於 T 的label強制設成0 (背景)
%     for k = 1:label_max
%         label_area(k) = length( find(label==k) ); % 找各label面積
%         label_area_total(n-1,k) = label_area(k); % 把全部的label面積記錄起來(觀察 T 參數用)
%         if (label_area(k) < T)
%             for i=1:row
%                 for j=1:col
%                     if (label(i,j)==k)
%                         label(i,j)=0;   
%                     end
%                 end
%             end
%         end
%     end
%     
%     % 如果 label != 0，就把結果圖設成1 (前景)
%     % 如果 label == 0，就把結果圖設成0 (背景)
%     for i = 1:row
%         for j = 1:col
%             if( label(i,j)>0 )
%                result(i,j) = 1;
%             else
%                 result(i,j) = 0; 
%             end
%         end
%     end
%     
% %     imshow(result);
%     end
% end
