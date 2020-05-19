%
%
%   **Co-occurence演算法**
%   參數說明
%	pic1        要做cooccurence的灰階圖
%	type        哪一種特徵 (Homogeneity,Contrast,Correlation,Energy,Entropy,Dis,Idm)       
%	window_size	window的大小
%
%
function result = my_cooccurence (pic1,type,window_size,level)
    [row,lengths] = size(pic1);
    tmp_result = [row,lengths];
    result = [row,lengths];
    result = uint8(result);
    for i = 1:row
        for j = 1:lengths
            lowH = i-window_size;
            highH = i+window_size;
            lowW = j-window_size;
            highW = j+window_size;
            if lowH<1
                lowH = 1;
            end
            if highH>row
                highH = row;
            end
            if lowW<1
                lowW = 1;
            end
            if highW>lengths
                highW = lengths;
            end
            tempBlock = pic1(lowH:highH,lowW:highW);
            glcm = graycomatrix(tempBlock,'NumLevels',level);
            %type不同
            if (strcmp(type,'Homogeneity'))
                stats = graycoprops(glcm,'Homogeneity');
                tmp_result(i,j)=stats.Homogeneity;
            end
            
            if (strcmp(type,'Contrast'))
                stats = graycoprops(glcm,'Contrast');
                tmp_result(i,j)=stats.Contrast;
            end
            
            if (strcmp(type,'Correlation'))
                stats = graycoprops(glcm,'Correlation');
                tmp_result(i,j)=stats.Correlation;
            end
            
            if (strcmp(type,'Energy'))
                stats = graycoprops(glcm,'Energy');
                tmp_result(i,j)=stats.Energy;
            end
            
            if (strcmp(type,'Entropy'))
                tmp_result(i,j)=entropy(glcm);
            end
            
            if (strcmp(type,'Dis'))
                tmp_sum=sum(sum(glcm));
                dis_value=0;
                for p=1:8
                    for q=1:8
                        dis_value = dis_value + double(double(glcm(p,q)/tmp_sum) * abs(p-q));
                    end
                end
                tmp_result(i,j)=dis_value;
            end
            
            if (strcmp(type,'Idm'))
                tmp_sum=sum(sum(glcm));
                idm_value=0;
                for p=1:8
                    for q=1:8
                        idm_value = idm_value + double((double(glcm(p,q)/tmp_sum)) / (1+ (double(p-q))^2));
                    end
                end
                tmp_result(i,j)=idm_value;
            end
        end
    end
    % 正規化
    tmp_Max=max(max(tmp_result));
    tmp_min=min(min(tmp_result));
    for i=1:row 
        for j=1:lengths
            result(i,j)=uint8( (double(tmp_result(i,j)-tmp_min)/double(tmp_Max-tmp_min))*255);
        end
   end
end