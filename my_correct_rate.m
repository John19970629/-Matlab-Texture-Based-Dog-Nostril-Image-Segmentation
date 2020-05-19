%
%
%   **my_correct_rate �t��k**
%
%   result �涰 ground_truth / result �p�� ground_truth
%
%   �Ѽƻ���
%	result          ���ε��G
%   ground_truth    ��ʤ��μv��
%
%

function rate = my_correct_rate (result,ground_truth)
% ground_truth = my_high_light( ground_truth , 1 );
[row,col] = size(result);
intersection = 0;
joint = 0;

% �涰 Intersection
for i=1:row
    for j=1:col
        
        if ( ground_truth(i,j) ==255 && result(i,j)==255 )
            intersection = intersection + 1;
        end
        
    end
end

% �p�� Joint
for i=1:row
    for j=1:col
        
        if ( ground_truth(i,j) ==255 || result(i,j)==255 )
            joint = joint + 1;
        end
        
    end
end

rate = (intersection/joint);

end

% ���ɴ���
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
%     % �涰 Intersection
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
%     % �p�� Joint
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
