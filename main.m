Vbw1  = 7;      % �����ҽk window size
 Vbs1  = 2;      % �����ҽk sigma
 Vcow1 = 3;     % GLCM window size
 Vbk1  = 0.5;    % Otsu - k�зǮt
 Vopw1 = 5;     % Opening window size
 Va1   = 15000;  % Label �h���T
 Vclw1 = 21;     % Closing window size


 

% ���զ�m���
% for i = 2:105
%     if ( exist(['../ground truth/' num2str(i) '.bmp'],'file') ~=0 )
%         pic_ground_truth = imread(['../ground truth_old/' num2str(i) '.bmp']);
%         nostril_rate(i,:) = my_nostril_boundary_rate(pic_ground_truth);
%     end
% end

% ���դ��X��
 %for i = 2:77
 %        length_max = max(nostril_rate(:,1)); 
 %         length_max = 0.4757;
 %        pic_original = imread(['../0_nose/' num2str(i) '.png']);
 %        [pic_segment,seg_begin(i,1)] = my_nostril_segment(pic_original,length_max,1.3);
 %        imwrite(pic_segment, ['../1_nose_seg/' num2str(i) '.bmp'] );
 %end

% ��Ƕ�
 %for i = 2:77
 %    pic_original = imread(['C:\Users\user\Downloads\����\1_nose_seg\'  num2str(i) '.bmp']);
 %    pic_gray     = rgb2gray(pic_original);
 %    imwrite(pic_gray, ['C:\Users\user\Downloads\����\2_gary\'  num2str(i) '.bmp']);
%end
% �����ҽk
 %for i = 2:77
 %    pic_gray = imread(['C:\Users\user\Downloads\����\2_gary\'  num2str(i) '.bmp']);
 %    filter = fspecial('gaussian',[Vbw1 Vbw1],Vbs1);
 %    pic_gaussian_blur = imfilter(pic_gray,filter);
 %    imwrite(pic_gaussian_blur, ['C:\Users\user\Downloads\����\3_gosu\' num2str(i) '.bmp']);
% end
 % �����n��� (�ﵽ���u�A�����T�h)
 %for i = 2:77
 %    pic_gaussian_blur = imread(['C:\Users\user\Downloads\����\3_gosu\' num2str(i) '.bmp']);
 %    pic_area_contrast = my_area_contrast(pic_gaussian_blur);
 %    imwrite(pic_area_contrast, ['C:\Users\user\Downloads\����\4_area contrast\' num2str(i) '.bmp']);
% end
 % ���Z����� (gamma equation ���W��) (�ﵽ���T���D)
 %for i = 2:77
 %pic_gaussian_blur = imread(['C:\Users\user\Downloads\����\3_gosu\' num2str(i) '.bmp']);
 % pic_normalize = my_normalize (pic_gaussian_blur,1);
 %    imwrite(pic_normalize, ['C:\Users\user\Downloads\����\4_normalize\' num2str(i) '.bmp']);
 %end

% �ĦX�����n���Mgamma
%for i = 2:77
%     pic_area_contrast  = imread(['C:\Users\user\Downloads\����\4_normalize\' num2str(i) '.bmp']);
%     pic_gamma_equation = imread( ['C:\Users\user\Downloads\����\4_area contrast\' num2str(i) '.bmp']);
%     pic_merge = my_merge(pic_area_contrast,pic_gamma_equation,1,1,0);
%     imwrite(pic_merge,['C:\Users\user\Downloads\����\5_merge_area_gamma\' num2str(i) '.bmp']);
% end
%Gray level co-currence matrix
%for i = 2:5
%   pic_merge = imread(['C:\Users\user\Downloads\����\5_merge_area_gamma\' num2str(i) '.bmp']);
%     pic_correlation = my_cooccurence(pic_merge,'Correlation',Vcow1,16);
%   imwrite(pic_correlation,['C:\Users\user\Downloads\����\6_correlation\' num2str(i) '.bmp']);
%end

% Otsu (level�� Otsu-k�ӼзǮt)
% for i = 2:15
%     pic_correlation = imread(['C:\Users\user\Downloads\����\6_correlation\' num2str(i) '.bmp']);
%     pic_otsu  = my_otsu_std(pic_correlation,Vbk1);
%     imwrite(pic_otsu,['C:\Users\user\Downloads\����\7_OTSU\' num2str(i) '.bmp']);
% end

% Opening
 %for i = 2:15
 %    pic_otsu = imread(['C:\Users\user\Downloads\����\7_OTSU\' num2str(i) '.bmp']); 
 %    se = strel('disk',Vopw1);
 %    pic_opening = imopen(pic_otsu,se);   
  %   imwrite(pic_opening,['C:\Users\user\Downloads\����\8_opening\' num2str(i) '.bmp']);
 %end

% ��Label�A�h��label�ƶq�Ӥ֪��϶� (�M��դ������T)
% for i = 2:15
% 	pic_opening  = imread(['C:\Users\user\Downloads\����\8_opening\' num2str(i) '.bmp']);
% 	pic_label_nose  = my_label_denoise(pic_opening,Va1);
%  	imwrite(pic_label_nose,['C:\Users\user\Downloads\����\9_label denoise_nose\' num2str(i) '.bmp']);
% end

% �� Label ���X��ӻ�աA���e3�j��label�A�d�g�L������ (44�B45�p�G�u���̤j���A�|����U�������T)
% for i = 2:15
% 	pic_label_nose  = imread(['C:\Users\user\Downloads\����\9_label denoise_nose\' num2str(i) '.bmp']);
% 	pic_label_nostril  = my_label_capture(pic_label_nose,3);
%  	imwrite(pic_label_nostril,['C:\Users\user\Downloads\����\10_label  denoise_nostril\' num2str(i) '.bmp']);
% end

 %closing
%for i = 2:15
% 	se = strel('disk',Vclw1);
% 	pic_otsu  = imread(['C:\Users\user\Downloads\����\10_label  denoise_nostril\' num2str(i) '.bmp']);
%   	pic_closing = imclose(pic_otsu,se);
%  	imwrite(pic_closing,['C:\Users\user\Downloads\����\11_closing\' num2str(i) '.bmp']);
% end
 
 %circle
   %for i = 2:15
 	
 	%pic_closing= imread(['C:\Users\user\Downloads\����\11_closing\' num2str(i) '.bmp']);
  	%pic_circle = my_circle(pic_closing);
  	%imwrite(pic_circle,['C:\Users\user\Downloads\����\12_circle\' num2str(i) '.bmp']);
% end

%�ب���  
%for i = 2:15
 	
% 	pic_og= imread(['C:\Users\user\Downloads\����\1_nose_seg\' num2str(i) '.bmp']);
%    pic_circle=imread(['C:\Users\user\Downloads\����\12_circle\' num2str(i) '.bmp']);
%   	pic_circle = my_mark(pic_circle,pic_og);
%  	imwrite(pic_circle,['C:\Users\user\Downloads\����\13_result\' num2str(i) '.bmp']);
%end
 
  for i = 8
       
     pic_ground_truth = imread(['C:\Users\user\Downloads\����\groundtruth_seg\' num2str(i) '.bmp']);
     pic_result = imread(['C:\Users\user\Downloads\����\���q\8\closing.bmp']);
 
     correct_rate(i,1) = my_correct_rate(pic_result,pic_ground_truth);
 xlswrite('C:\Users\user\Downloads\����\rate',correct_rate);
 end


