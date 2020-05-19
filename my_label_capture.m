%
%
%   **my_label_capture�t��k**
%
%   �N�G�ȼv���� label ��A���B�k�U�� N �j�� label�A�ݭ����g�L������u�� pixel �̦h�A�N�d�U����label
%
% �z�w�w�w�w�w�w�w�w�w�w�w �{
% �x    �x    �x    �x    �x
% �x    �x    �x    �x    �x
% �x�w�w�� �w�w�q�w�w���w�w�x
% �x    �x    �x    �x    �x
% �x    �x    �x    �x    �x
% �|�w�w�w�w�w�w�w�w�w�w�w �}
%
%   �Ѽƻ���
%	pic       �G�ȼv��
%   N         ��X�X�j��label
%
%   �Ƶ�
%   round       �|�ˤ��J
%   ceil        �L����i��
%

function [ result ] = my_label_capture(pic ,N)
    [row,col] = size(pic);
    result = zeros(row,col);

    % �ϥաA�����ܦ��e���A��l�ܭI��
    pic = my_high_light(pic,0);

    % ��v��������i (�q�������})
    col_L = ceil(col/2);
    col_R = col-col_L;

    pic_L = zeros(row,col_L);
    pic_R = zeros(row,col_R);

    for i=1:row
        for j=1:col_L
            pic_L(i,j) = pic(i,j);
        end
    end

    for i=1:row
        for j=1:col_R
            pic_R(i,j) = pic(i,col_R+j);
        end
    end

    % ���o label �����M �̤jlabel�ơ@(8�s�q)
    [label_L,label_L_max] = bwlabel(pic_L,8);
    [row_L,col_L] = size( label_L );
    result_L = zeros(row_L,col_L);

    [label_R,label_R_max] = bwlabel(pic_R,8);
    [row_R,col_R] = size( label_R );
    result_R = zeros(row_R,col_R);
    label_L_area = zeros(1,label_R_max);

    % Label�ƶq����N���B�z�A���k��զ]��Label�ƥi�ण�P�A�ҥH���}�p��
    if (N>label_L_max)
        NL = label_L_max;
        max_label_L = 0;
        final_label_L = 1;
    else
        NL = N;
    end
    if (N>label_R_max)
        NR = label_R_max;
        max_label_R = 0;
        final_label_R = 1;
    else
        NR = N;
    end

    % �����label�����n�Ѥj��p�ƦC
    for k = 1:label_L_max
        label_L_area(k) = length( find(label_L==k) ); % ��Ulabel���n
    end

    for k = 1:label_R_max
        label_R_area(k) = length( find(label_R==k) ); % ��Ulabel���n
    end

    % �p�G����S������ Label�A���n��0�A���M�N�Ѥj��p���Ƨ�
    if ( label_L_max==0 )
        label_L_area = 0;
    else
        label_L_area = sort(label_L_area,'descend');
    end

    if ( label_R_max==0 )
        label_R_area = 0;
    else
        label_R_area = sort(label_R_area,'descend');
    end

    % ��X N �j����label���X
    for i = 1:NL
        for k = 1:label_L_max
            if (label_L_area(i) == length( find(label_L==k)))
                max_label_L(i) = k;
            end
        end
    end

    for i = 1:NR
        for k = 1:label_R_max
            if (label_R_area(i) == length( find(label_R==k)))
                max_label_R(i) = k;
            end
        end
    end

    % �u�d�U���g�L���B�e�����u���϶�
    center_L_row = ceil(row/2);
    center_L_col = ceil(col_L/2);

    center_R_row = ceil(row/2);
    center_R_col = ceil(col_R/2);

    count_L = zeros(1,NL);
    count_R = zeros(1,NR);

    % �p��g�L���䤤��Label�����n
    for i = 1:row_L
        for j = 1:col_L
            for k = 1:NL
                if ((label_L(i,j)==max_label_L(k)) && (i==center_L_row || j==center_L_col))
                    count_L(k) = count_L(k)+1;
                end
            end
        end
    end

    % �p��g�L�k�䤤��Label�����n
    for i = 1:row_R
        for j = 1:col_R
            for k = 1:NR
                if ((label_R(i,j)==max_label_R(k)) && (i==center_R_row || j==center_R_col))
                    count_R(k) = count_R(k)+1;
                end
            end
        end
    end

    % ��X����g�L���ߡB���n�S�̤j�� Label �s��
    for k = 1:NL
        if (count_L(k) == max(count_L))
            final_label_L = max_label_L(k);
        end
    end

    % ��X�k��g�L���ߡB���n�S�̤j�� Label �s��
    for k = 1:NR
        if (count_R(k) == max(count_R))
            final_label_R = max_label_R(k);
        end
    end

    for i = 1:row_L
        for j = 1:col_L
            if (label_L(i,j) == final_label_L)
                result_L(i,j) = 1;
            else
                result_L(i,j) = 0;
            end
        end
    end

    for i = 1:row_R
        for j = 1:col_R
            if (label_R(i,j) == final_label_R)
                result_R(i,j) = 1;
            else
                result_R(i,j) = 0;
            end
        end
    end

    % �⥪�k���G�X��
    for i = 1:row
        for j = 1:col_L
            result(i,j) = result_L(i,j);
        end
        for j = col_L+1:col
            result(i,j) = result_R(i,j-col_L);
        end
    end

end

% ���ɴ���
% clc;
% clear;
%     
% for n = 44:44
%     
%     N = 1;
%     pic = imread(['../9_label denoise_nose/' num2str(n) '.bmp']);
%     
%     [row,col] = size(pic);
%     result = zeros(row,col);
%     
%     % �ϥաA�����ܦ��e���A��l�ܭI��
%     pic = my_high_light(pic,0);
%     
%     % ��v��������i (�q�������})
%     col_L = ceil(col/2);
%     col_R = col-col_L;
%     
%     pic_L = zeros(row,col_L);
%     pic_R = zeros(row,col_R);
%     
%     for i=1:row
%         for j=1:col_L
%             pic_L(i,j) = pic(i,j);
%         end
%     end
%     
%     for i=1:row
%         for j=1:col_R
%             pic_R(i,j) = pic(i,col_R+j);
%         end
%     end
%     
%     % ���o label �����M �̤jlabel�ơ@(8�s�q)
%     [label_L,label_L_max] = bwlabel(pic_L,8);
%     [row_L,col_L] = size( label_L );
%     result_L = zeros(row_L,col_L);
%     
%     [label_R,label_R_max] = bwlabel(pic_R,8);
%     [row_R,col_R] = size( label_R );
%     result_R = zeros(row_R,col_R);
%     label_L_area = zeros(1,label_R_max);
%     
%     % ��C��label���Τ@���C��N��A����ܥX��
%     [label,label_max] = bwlabel(pic,8);
%     label_area = zeros(1,label_max);
%     RGB_label = label2rgb(label, 'spring', 'c', 'shuffle');
% %     imshow(RGB_label,'InitialMagnification','fit');
% %     imwrite(RGB_label,['../' num2str(i) '.bmp']);
%     
%     % Label�ƶq����N���B�z�A���k��զ]��Label�ƥi�ण�P�A�ҥH���}�p��
%     if (N>label_L_max)
%         NL = label_L_max;
%         max_label_L = 0;
%         final_label_L = 1;
%     else
%         NL = N;
%     end
%     if (N>label_R_max)
%         NR = label_R_max;
%         max_label_R = 0;
%         final_label_R = 1;
%     else
%         NR = N;
%     end
%     
%     % �����label�����n�Ѥj��p�ƦC
% 	for k = 1:label_L_max
%     	label_L_area(k) = length( find(label_L==k) ); % ��Ulabel���n
%     end
%     
%     for k = 1:label_R_max
%     	label_R_area(k) = length( find(label_R==k) ); % ��Ulabel���n
%     end
%     
%     % �p�G����S������ Label�A���n��0�A���M�N�Ѥj��p���Ƨ�
%     if ( label_L_max==0 )
%         label_L_area = 0;
%     else
%         label_L_area = sort(label_L_area,'descend');
%     end
%     
%     if ( label_R_max==0 )
%         label_R_area = 0;
%     else
%        label_R_area = sort(label_R_area,'descend'); 
%     end
%     
%     % ��X N �j����label���X
%     for i = 1:NL
%         for k = 1:label_L_max
%             if (label_L_area(i) == length( find(label_L==k)))
%                 max_label_L(i) = k;
%             end
%         end
%     end
%     
%     for i = 1:NR
%         for k = 1:label_R_max
%             if (label_R_area(i) == length( find(label_R==k)))
%                 max_label_R(i) = k;
%             end
%         end
%     end
% 
%     % �u�d�U���g�L���B�e�����u���϶�
%     center_L_row = ceil(row/2);
%     center_L_col = ceil(col_L/2);
%     
%     center_R_row = ceil(row/2);
%     center_R_col = ceil(col_R/2);
%      
%     count_L = zeros(1,NL);
%     count_R = zeros(1,NR);
%     
%     % �p��g�L���䤤��Label�����n
%     for i = 1:row_L
%         for j = 1:col_L
%         	for k = 1:NL
%                 if ((label_L(i,j)==max_label_L(k)) && (i==center_L_row || j==center_L_col))
%                     count_L(k) = count_L(k)+1;
%                 end
%             end
%         end        
%     end    
%     
%     % �p��g�L�k�䤤��Label�����n
%     for i = 1:row_R
%         for j = 1:col_R
%             for k = 1:NR
%                 if ((label_R(i,j)==max_label_R(k)) && (i==center_R_row || j==center_R_col))
%                     count_R(k) = count_R(k)+1;
%                 end
%             end
%         end        
%     end
%     
%     % ��X����g�L���ߡB���n�S�̤j�� Label �s��
%     for k = 1:NL
%         if (count_L(k) == max(count_L))
%             final_label_L = max_label_L(k);
%         end
%     end
%     
%     % ��X�k��g�L���ߡB���n�S�̤j�� Label �s��
%     for k = 1:NR
%         if (count_R(k) == max(count_R))
%             final_label_R = max_label_R(k);
%         end
%     end
%     
%     for i = 1:row_L
%         for j = 1:col_L
%             if (label_L(i,j) == final_label_L)
%                 result_L(i,j) = 1;
%             else
%                 result_L(i,j) = 0;
%             end
%         end
%     end
%     
%     for i = 1:row_R
%         for j = 1:col_R
%             if (label_R(i,j) == final_label_R)
%                 result_R(i,j) = 1;
%             else
%                 result_R(i,j) = 0;
%             end
%         end
%     end
%     
%     % �⥪�k���G�X��
%     for i = 1:row
%         for j = 1:col_L
%             result(i,j) = result_L(i,j);
%         end
%         for j = col_L+1:col
%             result(i,j) = result_R(i,j-col_L);
%         end
%     end 
%     
% %     imwrite(result,['../' num2str(i) '.bmp']);
% %     imshow(result);
%     
% end
