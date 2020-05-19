%
%
%   **my_label_capture演算法**
%
%   將二值影像做 label 後，左、右各找 N 大塊 label，看哪塊經過兩條中線的 pixel 最多，就留下那塊label
%
% ┌─────────── ┐
% │    │    │    │    │
% │    │    │    │    │
% │──● ──┼──●──│
% │    │    │    │    │
% │    │    │    │    │
% └─────────── ┘
%
%   參數說明
%	pic       二值影像
%   N         找出幾大塊label
%
%   備註
%   round       四捨五入
%   ceil        無條件進位
%

function [ result ] = my_label_capture(pic ,N)
    [row,col] = size(pic);
    result = zeros(row,col);

    % 反白，把鼻孔變成前景，鼻子變背景
    pic = my_high_light(pic,0);

    % 把影像分成兩張 (從中間分開)
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

    % 取得 label 的表格和 最大label數　(8連通)
    [label_L,label_L_max] = bwlabel(pic_L,8);
    [row_L,col_L] = size( label_L );
    result_L = zeros(row_L,col_L);

    [label_R,label_R_max] = bwlabel(pic_R,8);
    [row_R,col_R] = size( label_R );
    result_R = zeros(row_R,col_R);
    label_L_area = zeros(1,label_R_max);

    % Label數量不到N的處理，左右鼻孔因為Label數可能不同，所以分開計算
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

    % 把兩邊label的面積由大到小排列
    for k = 1:label_L_max
        label_L_area(k) = length( find(label_L==k) ); % 找各label面積
    end

    for k = 1:label_R_max
        label_R_area(k) = length( find(label_R==k) ); % 找各label面積
    end

    % 如果兩邊沒有任何 Label，面積給0，不然就由大到小做排序
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

    % 找出 N 大塊的label號碼
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

    % 只留下有經過長、寬中垂線的區塊
    center_L_row = ceil(row/2);
    center_L_col = ceil(col_L/2);

    center_R_row = ceil(row/2);
    center_R_col = ceil(col_R/2);

    count_L = zeros(1,NL);
    count_R = zeros(1,NR);

    % 計算經過左邊中心Label的面積
    for i = 1:row_L
        for j = 1:col_L
            for k = 1:NL
                if ((label_L(i,j)==max_label_L(k)) && (i==center_L_row || j==center_L_col))
                    count_L(k) = count_L(k)+1;
                end
            end
        end
    end

    % 計算經過右邊中心Label的面積
    for i = 1:row_R
        for j = 1:col_R
            for k = 1:NR
                if ((label_R(i,j)==max_label_R(k)) && (i==center_R_row || j==center_R_col))
                    count_R(k) = count_R(k)+1;
                end
            end
        end
    end

    % 找出左邊經過中心、面積又最大的 Label 編號
    for k = 1:NL
        if (count_L(k) == max(count_L))
            final_label_L = max_label_L(k);
        end
    end

    % 找出右邊經過中心、面積又最大的 Label 編號
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

    % 把左右結果合併
    for i = 1:row
        for j = 1:col_L
            result(i,j) = result_L(i,j);
        end
        for j = col_L+1:col
            result(i,j) = result_R(i,j-col_L);
        end
    end

end

% 單檔測試
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
%     % 反白，把鼻孔變成前景，鼻子變背景
%     pic = my_high_light(pic,0);
%     
%     % 把影像分成兩張 (從中間分開)
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
%     % 取得 label 的表格和 最大label數　(8連通)
%     [label_L,label_L_max] = bwlabel(pic_L,8);
%     [row_L,col_L] = size( label_L );
%     result_L = zeros(row_L,col_L);
%     
%     [label_R,label_R_max] = bwlabel(pic_R,8);
%     [row_R,col_R] = size( label_R );
%     result_R = zeros(row_R,col_R);
%     label_L_area = zeros(1,label_R_max);
%     
%     % 把每個label都用一個顏色代表，並顯示出來
%     [label,label_max] = bwlabel(pic,8);
%     label_area = zeros(1,label_max);
%     RGB_label = label2rgb(label, 'spring', 'c', 'shuffle');
% %     imshow(RGB_label,'InitialMagnification','fit');
% %     imwrite(RGB_label,['../' num2str(i) '.bmp']);
%     
%     % Label數量不到N的處理，左右鼻孔因為Label數可能不同，所以分開計算
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
%     % 把兩邊label的面積由大到小排列
% 	for k = 1:label_L_max
%     	label_L_area(k) = length( find(label_L==k) ); % 找各label面積
%     end
%     
%     for k = 1:label_R_max
%     	label_R_area(k) = length( find(label_R==k) ); % 找各label面積
%     end
%     
%     % 如果兩邊沒有任何 Label，面積給0，不然就由大到小做排序
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
%     % 找出 N 大塊的label號碼
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
%     % 只留下有經過長、寬中垂線的區塊
%     center_L_row = ceil(row/2);
%     center_L_col = ceil(col_L/2);
%     
%     center_R_row = ceil(row/2);
%     center_R_col = ceil(col_R/2);
%      
%     count_L = zeros(1,NL);
%     count_R = zeros(1,NR);
%     
%     % 計算經過左邊中心Label的面積
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
%     % 計算經過右邊中心Label的面積
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
%     % 找出左邊經過中心、面積又最大的 Label 編號
%     for k = 1:NL
%         if (count_L(k) == max(count_L))
%             final_label_L = max_label_L(k);
%         end
%     end
%     
%     % 找出右邊經過中心、面積又最大的 Label 編號
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
%     % 把左右結果合併
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
