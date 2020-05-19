function  BW3  =my_circle (pic)
for i = 2:64
 	%pic= imread(['C:\Users\xcupc\Desktop\ª¯»ó¯¾\11_closing\' num2str(i) '.bmp']);
   
    adsf=0;
    level =16;
    window_size=2;
    [row,col] = size(pic);
    t=graythresh(pic);
    BW=im2bw(pic,t);  
    
    BW1= bwperim(BW,8);
   
    result= imfill(BW1,'holes');
   SE = ones(3);F2 = imdilate(result,SE,'same');
   BW3 = bwperim(F2);
   
  %  imwrite(BW3,['C:\Users\xcupc\Desktop\ª¯»ó¯¾\circle\' num2str(i) '.bmp']);
end
end