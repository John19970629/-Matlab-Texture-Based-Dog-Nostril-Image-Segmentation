%
%
%   **nostril_boundary**
%   �Ѽƻ���
%	pic       �G�Ȥƹ�(�I���զ�A��ն¦�)
%   
%   ���G
%   �^�ǻ����ɻP��l�Ϫ���� rate=[rate_length,rate_weight];
%
%

function rate = my_nostril_boundary_rate (pic)
    pic = my_high_light(pic,1);
    [row col] = size(pic);
    
    % �W��
    for i=row:-1:1
        for j=col:-1:1
            if(pic(i,j)==0)
                upper = i;
                break;
            end
        end
    end
    
    % �U��
    for i=1:row
        for j=1:col
            if(pic(i,j)==0)
                down = i;
                break;
            end
        end
    end
    
    % ����
    for i=col:-1:1
        for j=row:-1:1
            if(pic(j,i)==0)
                left = i;
                break;
            end
        end
    end
        
    % �k��
    for i=1:col
        for j=1:row
            if(pic(j,i)==0)
                right = i;
                break;
            end
        end
    end
    
    length = down-upper;
    weight = right-left;
    
    rate_length  = length/row;
    rate_weight = weight/col;
    
    rate=[rate_length,rate_weight];
    
end

%       %���ɴ��ե�
% clc;
% clear;
% k=53;
% for n=k:k
%     pic_ground_truth = imread(['../ground truth/' num2str(n) '.bmp']);
%     [row col] = size(pic_ground_truth);
%     
%     % �W��
%     for i=row:-1:1
%         for j=col:-1:1
%             if(pic_ground_truth(i,j)==0)
%                 upper = i;
%                 break;
%             end
%         end
%     end
%     
%     % �U��
%     for i=1:row
%         for j=1:col
%             if(pic_ground_truth(i,j)==0)
%                 down = i;
%                 break;
%             end
%         end
%     end
%     
%     % ����
%     for i=col:-1:1
%         for j=row:-1:1
%             if(pic_ground_truth(j,i)==0)
%                 left = i;
%                 break;
%             end
%         end
%     end
%         
%     % �k��
%     for i=1:col
%         for j=1:row
%             if(pic_ground_truth(j,i)==0)
%                 right = i;
%                 break;
%             end
%         end
%     end
%     
%     length = down-upper;
%     weight = right-left;
%     
%     rate_length  = length/row;
%     rate_weight = weight/col;
%     
%     rate=[rate_length,rate_weight];
%   
% end
