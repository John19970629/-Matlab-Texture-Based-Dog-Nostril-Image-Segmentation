function  result  = my_area_contrast( pic )

[row,lengths] = size(pic);

g = pic;
a = zeros(255,0);
b = zeros(255,0);
d = zeros(255,0);
c = zeros(0,255);
e = zeros(255,0);

for k=1:255               %pixel
    c(k) = 1;                 %個數從1開始
    for i=1:row
        for j=1:lengths
            if g(i,j)~=255     %這好像可以去掉 因為下面有判斷
                if g(i,j) ==k-1;    %從pixel = 0 開始
                    a(k,c(k)) =i;    % a矩陣存i座標
                    b(k,c(k)) =j;    % b矩陣存j座標
                    c(k) = c(k)+1;  %看pixel = k-1 有多少個
                end
            end
        end
    end
    c(k) = c(k)-1;           %因為c(k)初始?為1 所以要減回去
end

all=0;
for k=1:255
    all = c(k)+all;         %計算總面積
end

avg = fix(all/255);      %每個pixel該有多少個數
f=1;
x1=c(1);

for k=1:255
    for z=1:avg            %填滿個數
        x2=0;
        while x2==0       %預防座標為0
            if x1 ~=0          %原pixel=0個數不等於0
                d(k,z)=a(f,x1); %d矩陣紀錄pixel=0 i座標
                e(k,z)=b(f,x1); %e矩陣紀錄pixel=0 j座標
                x1=x1-1;         %假如x1=2.下一次記錄x1=1直到x1=0;跳出
                x2 = d(k,z);     %為了讓x2不等於0去讓z+1
            end
            if x1==0          %原pixel=0個數等於0 跳下一個pixel
                f=f+1;
                if f~=256
                    x1=c(f);        %x1=(pixel=1個數)
                end
            end
        end
    end
end

for i=1:row
    for j=1:lengths
        s(i,j) = 255;       %為新矩陣
    end
end

for k=1:255
    for z=1:avg
        s(d(k,z),e(k,z)) =k-1;      %分配新矩陣
    end
end

result = uint8(s);
% imwrite(result,'test.bmp');
%imhist(result);

end

