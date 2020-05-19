function varargout = AcorrdingToSteps(varargin)
% AcorrdingToSteps MATLAB code for AcorrdingToSteps.fig
%      AcorrdingToSteps, by itself, creates a new AcorrdingToSteps or raises the existing
%      singleton*.
%
%      H = AcorrdingToSteps returns the handle to a new AcorrdingToSteps or the handle to
%      the existing singleton*.
%
%      AcorrdingToSteps('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AcorrdingToSteps.M with the given input arguments.
%
%      AcorrdingToSteps('Property','Value',...) creates a new AcorrdingToSteps or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AcorrdingToSteps_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AcorrdingToSteps_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AcorrdingToSteps

% Last Modified by GUIDE v2.5 19-May-2018 18:55:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AcorrdingToSteps_OpeningFcn, ...
                   'gui_OutputFcn',  @AcorrdingToSteps_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before AcorrdingToSteps is made visible.
function AcorrdingToSteps_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AcorrdingToSteps (see VARARGIN)

% Choose default command line output for AcorrdingToSteps
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AcorrdingToSteps wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AcorrdingToSteps_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

set(handles.axes1,'xTick',[]);  
set(handles.axes1,'ytick',[]); 
set(handles.axes2,'xTick',[]);  
set(handles.axes2,'ytick',[]); 

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)%上一頁
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
TextureBasedDogNostrilImageSegmentation


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)%算鼻孔位置比例
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 

 




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)%算鼻孔比例 把鼻孔切出來
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
if (isempty(a))
    Oops
else
     %    for i = 2:105
   % if ( exist(['C:\Users\user\Downloads\狗鼻紋\groundtruth\'  num2str(i) '.bmp'],'file') ~=0 )
    %     pic_ground_truth = imread(['C:\Users\user\Downloads\狗鼻紋\groundtruth\'  num2str(i) '.bmp']);
    %     nostril_rate(i,:) = my_nostril_boundary_rate(pic_ground_truth);
    % end
 %end
         
         %length_max = max(nostril_rate(:,1)); 
         %length_max = 0.4757;
       %  pic_original = imread(a);
        % [a,seg_begin(i,1)] = my_nostril_segment(pic_original,length_max,1.3);
         a= imread('D:\Demo\1_nose_seg\7.bmp')
         axes(handles.axes2);
         imshow(a);
end



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)%高斯模糊
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Vbw1  = 7;      % 高斯模糊 window size
 Vbs1  = 2;      % 高斯模糊 sigma
 %global pathall;
 global a;
 global a1;
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
filter = fspecial('gaussian',[Vbw1 Vbw1],Vbs1);
myGray=a;
     a = imfilter(myGray,filter);
     a1=a;
     axes(handles.axes2);
     imshow( a);
 end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)%等面積對比
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
     myCon=a;
    
a = my_area_contrast( myCon);
 axes(handles.axes2);
     imshow( a);
 end


% --- Executes on button press in pushbutton6.%等距離對比
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
global a1;
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a1);
     myNor=a1;
    
a1 = my_normalize (myNor,1);
 axes(handles.axes2);
     imshow( a1);
 end



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)%融合等面積對比和gamma
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
global a1;

 if (isempty(a))
    Oops
 else
  % 等面積對比 (改善光線，但雜訊多)

 myCon=a;
    
pic_area_contrast = my_area_contrast( myCon);
     %imshow(pic_area_contrast);
     
    % 等距離對比 (gamma equation 正規化) (改善雜訊問題)

myNor=a1;
    
pic_normalize = my_normalize (myNor,1);
  %imshow( pic_normalize);
  
  % 融合等面積對比和gamma
  %   pic_area_contrast  = pic_normalize;
     %pic_gamma_equation = pic_normalize;
    a = my_merge(pic_area_contrast,pic_normalize,1,1,0);
     axes(handles.axes2);
imshow(a);
 end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)%Gray level co-currence matrix
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
 Vcow1 = 3;     % GLCM window size
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
     myMerge=a;
    
%a = my_cooccurence(myMerge,'Correlation',Vcow1,16);
 axes(handles.axes2);
 
 
 a=imread('D:\Demo\6_correlation\7.bmp');

 
     imshow(a);
 end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)%otsu
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
 Vbk1  = 0.5;    % Otsu - k標準差
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
     myOTSU=a;
    
 a=my_otsu_std(myOTSU,Vbk1);
 axes(handles.axes2);
     imshow( a );
 end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)%opening
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
 Vopw1 = 5;     % Opening window size
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
     myOP=a;
    
 se = strel('disk',Vopw1);
     a = imopen(myOP,se);   
 axes(handles.axes2);
     imshow( a );
 end



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)%label去雜訊
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
 Va1   = 15000;  % Label 去雜訊
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
     myLabel=a;
    % myLabel1=im2bw(myLabel,0);
    
a  = my_label_denoise( myLabel,Va1); 
 axes(handles.axes2);
     imshow(a);
       %imwrite(pic_label_nose,'C:\Users\user\Downloads\狗鼻紋\9_label denoise_nose\22.bmp')
 end



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)%用 Label 取出兩個鼻孔
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
% Va1   = 15000;  % Label 去雜訊
 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
  
     pic_label_nose=a;
     
    
a  = my_label_capture(pic_label_nose,3);
 axes(handles.axes2);
     imshow( a);
    % imwrite(pic_label_nostril,'C:\Users\user\Downloads\狗鼻紋\9_label denoise_nose\22.bmp')
 end

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)%closing
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
 Vclw1 = 21;     % Closing window size

 if (isempty(a))
    Oops
 else
     axes(handles.axes1);
     imshow(a);
se = strel('disk',Vclw1);
pic_label_nostril=a;
 	
   	a = imclose(pic_label_nostril,se);

 axes(handles.axes2);
     imshow(a);
       
 end


% --- Executes on button press in pushbutton14.
%function pushbutton14_Callback(hObject, eventdata, handles)%circle
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
%global a;
%global pic_circle;
 


 %if (isempty(pathall))
  %  Oops
 %else
%se = strel('disk',Vclw1);
%axes(handles.axes1);
 %    imshow(a);
%pic_closing=a;
 	
 %  a = my_circle(pic_closing);
  % pic_circle=a;

 %axes(handles.axes2);
  %   imshow(a);
       
 %end



% --- Executes on button press in pushbutton15.
%function pushbutton15_Callback(hObject, eventdata, handles)%框到原圖
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
%global pathall2;
%global a;



% if (isempty(pathall))
 %   Oops
 %else
  %   axes(handles.axes1);
   %  imshow(a);

%pic_circle=a;
%pic_segment=imread(pathall2);
%a= my_mark(pic_circle,pic_segment);

 %axes(handles.axes2);
 %    imshow(a);
       
 %end




% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)%清除資料
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clearvars -global pathall;
clearvars -global a;
clearvars -global pathall2;
clearvars -global pathall3;
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
set(handles.edit2,'String',"準確率");


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)%存檔
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pic_mark;
global a;
if isempty(get(handles.axes2, 'Children'))
    
    Oops2
else
[f,p]=uiputfile({'*.bmp'},'保存文件');

str=strcat(p,f);

%pix=getframe(handles.axes2);

imwrite(a,str,'bmp')
end


% --- Executes on button press in pushbutton18.%轉灰階
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
if (isempty(a))
    Oops
else
    axes(handles.axes1);
    imshow(a);
myImage = a;

 a = rgb2gray(myImage);
 axes(handles.axes2);
 imshow(a);
end

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)%瀏覽圖片
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%打??片
global FileName;
global PathName;
global a;

    [FileName,PathName] = uigetfile('*.bmp');
    global pathall;
    a=[PathName,FileName];
    
    %播放?片
    pic=imread(a);
    axes(handles.axes1);
    imshow(pic);


% --- Executes on button press in pushbutton20.
%function pushbutton20_Callback(hObject, eventdata, handles)%瀏覽segment
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [FileName,PathName] = uigetfile('*.bmp');
 %   global pathall2;
 %   pathall2=strcat(PathName,FileName);
    %播放?片
    %pic=imread(pathall2);
    %axes(handles.axes1);
    %imshow(pic);


% --- Executes on button press in pushbutton21.%計算準確率
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global pathall;
global a;
   global pathall3;
 %   global pathall;
    global correct_rate;
 %   global a;
        if (isempty(a))
   Oops
else
 
   [FileName,PathName] = uigetfile('*.bmp');
    pathall3=strcat(PathName,FileName);
    %播放?片
    pic_ground_truth = imread(pathall3);
    pic_result=imread(a);
 correct_rate = my_correct_rate(pic_result,pic_ground_truth);
 set(handles.edit2,'String',num2str(correct_rate));
 %xlswrite('C:\Users\user\Downloads\狗鼻紋\rate',correct_rate);
        end






%pathall=a;
%%cla(handles.axes2,'reset');
%axes(handles.axes1);
%pic=a;
%imshow (pic);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%global correct_rate;
 %set(handles.edit1,'String',num2str(correct_rate));

   



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
