%
%
%   **my_label_denoise�t��k**
%
%   �N�G�ȼv���� label ��Alabel�ӼƤp�� T �����]���I��
%
%   �Ѽƻ���
%	pic_input       �G�Ȥƹ�
%   T               ���n���e��
%
%

function [ result ] = my_label_denoise( pic_input ,T)

    %���o label �����M �̤jlabel�ơA(8�s�q)
    [label,label_max] = bwlabel(pic_input,8);
    [row,col] = size( label );
    result    = zeros(row,col);
    
%     %��C��label���Τ@���C��N��A����ܥX��
%     RGB_label = label2rgb(label, @flag, 'c', 'shuffle');
%     imshow(RGB_label,'InitialMagnification','fit')
% %     imwrite(RGB_label,['../label/' num2str(n) '_label' '.bmp']);
    
    %���n�p�� T ��label�j��]��0 (�I��)
    for k = 1:label_max
        label_area(k) = length( find(label==k) ); % ��Ulabel���n
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
    
    % �p�G label != 0�A�N�⵲�G�ϳ]��1 (�e��)
    % �p�G label == 0�A�N�⵲�G�ϳ]��0 (�I��)
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

% ���ɴ���
% clc;
% clear;
%     
% for n = 6:6
%     
%     % �p�G�ɮצs�b�~���� 
%     if(exist(['../11_resegment/gamma/correlation/Otsu/' num2str(n) '_gamma=1_win=5_k=0.5_L' '.bmp'],'file')~=0)
%     pic_input  = imread(['../11_resegment/gamma/correlation/Otsu/' num2str(n) '_gamma=1_win=5_k=0.5_L' '.bmp']);
%     
%     T = 15000;
%     
%     %���o label �����M label �̤j�Ʀr
%     [label,label_max] = bwlabel(pic_input,8);
%     [row,col] = size( label );
%     result    = zeros(row,col);
%     
%     %��C��label���Τ@���C��N��A����ܥX��
%     RGB_label = label2rgb(label, @flag, 'c', 'shuffle');
% %     imshow(RGB_label,'InitialMagnification','fit')
% %     imwrite(RGB_label,['../label/' num2str(n) '_label' '.bmp']);
%     
%     %���n�p�� T ��label�j��]��0 (�I��)
%     for k = 1:label_max
%         label_area(k) = length( find(label==k) ); % ��Ulabel���n
%         label_area_total(n-1,k) = label_area(k); % �������label���n�O���_��(�[�� T �Ѽƥ�)
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
%     % �p�G label != 0�A�N�⵲�G�ϳ]��1 (�e��)
%     % �p�G label == 0�A�N�⵲�G�ϳ]��0 (�I��)
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
