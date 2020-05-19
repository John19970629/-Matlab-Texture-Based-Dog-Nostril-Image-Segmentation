function  pic_mark  =my_mark (pic,pic_mark)
for a = 2:64
%pic= imread(['C:\Users\xcupc\Desktop\ª¯»ó¯¾\circle\' num2str(a) '.bmp']);
%pic_mark=imread(['C:\Users\xcupc\Desktop\ª¯»ó¯¾\1_nose_seg\' num2str(a) '.bmp']);
   
    adsf=0;
    level =16;
    window_size=2;
    pic1=uint8(pic);
    
    [row,col] = size(pic);
    
  for i = 1:row
       for j = 1:col
             if pic(i,j)==1
                 pic_mark(i,j)=255;
       
             
              end
              
       end
      
  end
    
    %  imwrite(pic_mark,['C:\Users\xcupc\Desktop\ª¯»ó¯¾\reslut\' num2str(a) '.bmp']);
end
