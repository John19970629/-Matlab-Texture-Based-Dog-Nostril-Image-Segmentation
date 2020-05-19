%
%
%   **my_high_light�t��k**
%
%   �N�Ϥ��ϥ�
%
%   �Ѽƻ���
%	pic       �Ƕ��άO�G�ȼv��
%   mode      �B�z�¥ռv���άO�Ƕ��v���A0�G�¥աA1�G�Ƕ�
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

% ���ɴ���
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