%
%
%   **my_correct_rate 演算法**
%
%   result 交集 ground_truth / result 聯集 ground_truth
%
%   參數說明
%	result          切割結果
%   ground_truth    手動切割影像
%
%

function rate = my_correct_rate (result,ground_truth)
% ground_truth = my_high_light( ground_truth , 1 );
[row,col] = size(result);
intersection = 0;
joint = 0;

% 交集 Intersection
for i=1:row
    for j=1:col
        
        if ( ground_truth(i,j) ==255 && result(i,j)==255 )
            intersection = intersection + 1;
        end
        
    end
end

% 聯集 Joint
for i=1:row
    for j=1:col
        
        if ( ground_truth(i,j) ==255 || result(i,j)==255 )
            joint = joint + 1;
        end
        
    end
end

rate = (intersection/joint);

end

% 單檔測試
% clc;
% clear;
%
% for n=2:2
%     ground_truth = imread(['../ground truth/' num2str(n) '.bmp']);
%     result = imread(['../13_result/' num2str(n) '.bmp']);
%
%     ground_truth = my_high_light( ground_truth , 1 );
%     [row,col] = size(result);
%     intersection = 0;
%     joint = 0;
%
%     % 交集 Intersection
%     for i=1:row
%         for j=1:col
%
%             if ( ground_truth(i,j) ==255 && result(i,j)==255 )
%                 intersection = intersection + 1;
%             end
%
%         end
%     end
%
%     % 聯集 Joint
%     for i=1:row
%         for j=1:col
%
%             if ( ground_truth(i,j) ==255 || result(i,j)==255 )
%                 joint = joint + 1;
%             end
%
%         end
%     end
%
%     rate = intersection/joint;
% end
