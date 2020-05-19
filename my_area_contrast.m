function  result  = my_area_contrast( pic )

[row,lengths] = size(pic);

g = pic;
a = zeros(255,0);
b = zeros(255,0);
d = zeros(255,0);
c = zeros(0,255);
e = zeros(255,0);

for k=1:255               %pixel
    c(k) = 1;                 %�ӼƱq1�}�l
    for i=1:row
        for j=1:lengths
            if g(i,j)~=255     %�o�n���i�H�h�� �]���U�����P�_
                if g(i,j) ==k-1;    %�qpixel = 0 �}�l
                    a(k,c(k)) =i;    % a�x�}�si�y��
                    b(k,c(k)) =j;    % b�x�}�sj�y��
                    c(k) = c(k)+1;  %��pixel = k-1 ���h�֭�
                end
            end
        end
    end
    c(k) = c(k)-1;           %�]��c(k)��l?��1 �ҥH�n��^�h
end

all=0;
for k=1:255
    all = c(k)+all;         %�p���`���n
end

avg = fix(all/255);      %�C��pixel�Ӧ��h�֭Ӽ�
f=1;
x1=c(1);

for k=1:255
    for z=1:avg            %�񺡭Ӽ�
        x2=0;
        while x2==0       %�w���y�Ь�0
            if x1 ~=0          %��pixel=0�ӼƤ�����0
                d(k,z)=a(f,x1); %d�x�}����pixel=0 i�y��
                e(k,z)=b(f,x1); %e�x�}����pixel=0 j�y��
                x1=x1-1;         %���px1=2.�U�@���O��x1=1����x1=0;���X
                x2 = d(k,z);     %���F��x2������0�h��z+1
            end
            if x1==0          %��pixel=0�ӼƵ���0 ���U�@��pixel
                f=f+1;
                if f~=256
                    x1=c(f);        %x1=(pixel=1�Ӽ�)
                end
            end
        end
    end
end

for i=1:row
    for j=1:lengths
        s(i,j) = 255;       %���s�x�}
    end
end

for k=1:255
    for z=1:avg
        s(d(k,z),e(k,z)) =k-1;      %���t�s�x�}
    end
end

result = uint8(s);
% imwrite(result,'test.bmp');
%imhist(result);

end

