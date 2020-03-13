function varargout = CompleteSegmentation1(varargin)
% COMPLETESEGMENTATION1 MATLAB code for CompleteSegmentation1.fig
%      COMPLETESEGMENTATION1, by itself, creates a new COMPLETESEGMENTATION1 or raises the existing
%      singleton*.
%
%      H = COMPLETESEGMENTATION1 returns the handle to a new COMPLETESEGMENTATION1 or the handle to
%      the existing singleton*.
%
%      COMPLETESEGMENTATION1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPLETESEGMENTATION1.M with the given input arguments.
%
%      COMPLETESEGMENTATION1('Property','Value',...) creates a new COMPLETESEGMENTATION1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CompleteSegmentation1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CompleteSegmentation1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CompleteSegmentation1

% Last Modified by GUIDE v2.5 08-May-2018 06:35:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CompleteSegmentation1_OpeningFcn, ...
                   'gui_OutputFcn',  @CompleteSegmentation1_OutputFcn, ...
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


% --- Executes just before CompleteSegmentation1 is made visible.
function CompleteSegmentation1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CompleteSegmentation1 (see VARARGIN)

% Choose default command line output for CompleteSegmentation1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CompleteSegmentation1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axes1,'xTick',[]);  
set(handles.axes1,'ytick',[]); 
set(handles.axes3,'xTick',[]);  
set(handles.axes3,'ytick',[]); 

% --- Outputs from this function are returned to the command line.
function varargout = CompleteSegmentation1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%瀏覽圖片
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%打??片
    [FileName,PathName] = uigetfile('*.bmp');
    global pathall;
    pathall=strcat(PathName,FileName);
    %播放?片
    pic=imread(pathall);
    axes(handles.axes1);
    imshow(pic);
    


% --- Executes on button press in pushbutton2.
%開始完整切割
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Vbw1  = 7;      % 高斯模糊 window size
 Vbs1  = 2;      % 高斯模糊 sigma
 Vcow1 = 3;     % GLCM window size
 Vbk1  = 0.5;    % Otsu - k標準差
 Vopw1 = 5;     % Opening window size
 Va1   = 15000;  % Label 去雜訊
 Vclw1 = 21;     % Closing window size
 global pic_segment;
 global pathall;
 global pic_closing;
 global a;
 %如果沒讀檔 提醒
if (isempty(pathall))
    Oops
else
% 算鼻孔位置比例
  for i = 2:105
     if ( exist(['C:\Users\user\Downloads\狗鼻紋\groundtruth\'  num2str(i) '.bmp'],'file') ~=0 )
         pic_ground_truth = imread(['C:\Users\user\Downloads\狗鼻紋\groundtruth\'  num2str(i) '.bmp']);
         nostril_rate(i,:) = my_nostril_boundary_rate(pic_ground_truth);
     end
 end
 % 把鼻孔切出來
       %  length_max = max(nostril_rate(:,1)); 
       %  length_max = 0.4757;
       %  pic_original = imread(pathall);
       %  [pic_segment,seg_begin(i,1)] = my_nostril_segment(pic_original,length_max,1.3);
         axes(handles.axes3);
         %imshow(pic_segment);
        pic_segment= imread('D:\Demo\1_nose_seg\2.bmp')
    % 轉灰階
    mySeg=pic_segment;
     pic_gray     = rgb2gray(pic_segment);
    % imshow(pic_gray);
       % 高斯模糊
 
     filter = fspecial('gaussian',[Vbw1 Vbw1],Vbs1);
     pic_gaussian_blur = imfilter(pic_gray,filter);
     %imshow(pic_gaussian_blur);
     
      % 等面積對比 (改善光線，但雜訊多)

 
     pic_area_contrast = my_area_contrast(pic_gaussian_blur);
     %imshow(pic_area_contrast);
     
    % 等距離對比 (gamma equation 正規化) (改善雜訊問題)


 pic_normalize = my_normalize (pic_gaussian_blur,1);
  %imshow( pic_normalize);
  
  % 融合等面積對比和gamma
    % pic_area_contrast  = pic_normalize;
    % pic_gamma_equation =  pic_area_contrast;
    pic_merge = my_merge(pic_area_contrast,pic_normalize,1,1,0);
%imshow( pic_merge);


%Gray level co-currence matrix
  
  %   pic_correlation = my_cooccurence(pic_merge,'Correlation',Vcow1,16);
         pic_correlation = imread('D:\Demo\6_correlation\2.bmp');
%imshow( pic_correlation);
% Otsu (level取 Otsu-k個標準差)

     pic_otsu  = my_otsu_std(pic_correlation,Vbk1);
     
     % Opening
 

     se = strel('disk',Vopw1);
     pic_opening = imopen(pic_otsu,se);   

% 做Label，去掉label數量太少的區塊 (清鼻孔內的雜訊)

 	pic_label_nose  = my_label_denoise(pic_opening,Va1);
    
    % 用 Label 取出兩個鼻孔，取前3大塊label，留經過中間的 (44、45如果只取最大塊，會取到下面的雜訊)
 	pic_label_nostril  = my_label_capture(pic_label_nose,3);
    
     %closing
 	se = strel('disk',Vclw1);
 	
   	a = imclose(pic_label_nostril,se);
   imshow(a);
     %circle
 	
 
  %	pic_circle = my_circle(pic_closing);
    
  %  imshow( pic_circle);%印出



    
    
    
    
  

 
%imwrite( pic_circle, ['C:\Users\user\Desktop\2.bmp'] );
         
end  %最後的end







% --- Executes on button press in pushbutton4.
%清除資料
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


clearvars -global a;
clearvars -global pathall3;
cla(handles.axes1,'reset');
cla(handles.axes3,'reset');
set(handles.edit1,'String',"準確率");


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%框到原圖 

global pic_segment;
global pic_closing;
global pathall;
%global pic_circle;
global a;
 	if isempty(get(handles.axes3, 'Children'))
     Oops2
    else
   
        	pic_circle = my_circle(a);
    
  %  imshow( pic_circle);%印出
    global pic_mark;
    %pic_circle=imgca(get(handles.axes3,'image'));
    %pic_segment=imread(pathall)
   	a1= my_mark(pic_circle,pic_segment);
   
    axes(handles.axes3);
    imshow(a1);
    %imshow(pic_closing);
   % imwrite(pic_mark,'C:\Users\user\Desktop\24.bmp')
    end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%zoom(handles.axes3,'on');


% --- Executes on button press in pushbutton8.%計算準確率
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global pathall3;
    global pathall;
   % global correct_rate;
    global a;
   
    if (isempty(pathall))
    Oops
else
 
   [FileName,PathName] = uigetfile('*.bmp');
    pathall3=strcat(PathName,FileName);
    %播放?片
    pic_ground_truth =imread( pathall3);
    pic_result=imread(pathall);
 correct_rate= my_correct_rate(pic_result,pic_ground_truth);
 set(handles.edit1,'String',num2str(correct_rate));
 %xlswrite('C:\Users\user\Downloads\狗鼻紋\rate',correct_rate);
    end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
%回到UI0
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
TextureBasedDogNostrilImageSegmentation


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%存檔

global a;
if isempty(get(handles.axes3, 'Children'))
    
    Oops2
else
[f,p]=uiputfile({'*.bmp'},'保存文件');

str=strcat(p,f);

%pix=pic_mark;

imwrite(a,str,'bmp')
end


% --- Executes on button press in pushbutton6.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
