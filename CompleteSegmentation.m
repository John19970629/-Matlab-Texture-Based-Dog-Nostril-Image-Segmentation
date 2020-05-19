function varargout = CompleteSegmentation(varargin)
% CompleteSegmentation MATLAB code for CompleteSegmentation.fig
%      CompleteSegmentation, by itself, creates a new CompleteSegmentation or raises the existing
%      singleton*.
%
%      H = CompleteSegmentation returns the handle to a new CompleteSegmentation or the handle to
%      the existing singleton*.
%
%      CompleteSegmentation('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CompleteSegmentation.M with the given input arguments.
%
%      CompleteSegmentation('Property','Value',...) creates a new CompleteSegmentation or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CompleteSegmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CompleteSegmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CompleteSegmentation

% Last Modified by GUIDE v2.5 26-Apr-2018 21:31:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CompleteSegmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @CompleteSegmentation_OutputFcn, ...
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


% --- Executes just before CompleteSegmentation is made visible.
function CompleteSegmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CompleteSegmentation (see VARARGIN)

% Choose default command line output for CompleteSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




   


% --- Outputs from this function are returned to the command line.
function varargout = CompleteSegmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
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
 Vcow1 = 5;     % GLCM window size
 Vbk1  = 0.5;    % Otsu - k標準差
 Vopw1 = 5;     % Opening window size
 Va1   = 15000;  % Label 去雜訊
 Vclw1 = 21;     % Closing window size
 global pic_circle;
 global pic_segment;
 global pathall;
 %如果沒讀檔 提醒
if (isempty(pathall))
    Oops
else
% 算鼻孔位置比例
  for i = 2:15
     if ( exist(['C:\Users\user\Downloads\狗鼻紋\groundtruth\'  num2str(i) '.bmp'],'file') ~=0 )
         pic_ground_truth = imread(['C:\Users\user\Downloads\狗鼻紋\groundtruth\'  num2str(i) '.bmp']);
         nostril_rate(i,:) = my_nostril_boundary_rate(pic_ground_truth);
     end
 end
 % 把鼻孔切出來
         length_max = max(nostril_rate(:,1)); 
        % imshow(length_max,'value');
         length_max = 0.4757;
         pic_original = imread(pathall);
         [pic_segment,seg_begin(i,1)] = my_nostril_segment(pic_original,length_max,1.3);
         axes(handles.axes3);
         imshow(pic_segment);

    
    
  

 
%imwrite( pic_circle, ['C:\Users\user\Desktop\2.bmp'] );
         
end  %最後的end







% --- Executes on button press in pushbutton4.
%清除資料
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


clearvars -global pathall;
cla(handles.axes1,'reset');
cla(handles.axes3,'reset');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%框到原圖 
global pic_circle;
global pic_segment;
 	if isempty(get(handles.axes3, 'Children'))
     Oops2
    else
    global pic_mark;
    pic_circle=imread('C:\Users\user\Desktop\2.bmp');
    pic_segment=imread('C:\Users\user\Downloads\狗鼻紋\1_nose_seg\2.bmp')
   	pic_mark= my_mark(pic_circle,pic_segment);
   
    axes(handles.axes3);
    imshow(pic_mark);
   % imwrite(pic_mark,'C:\Users\user\Desktop\24.bmp')
    end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

zoom(handles.axes3,'on');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=zoom;
set(h,handles.axes3,'Enable','out')


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
function pushbutton12_Callback(hObject, eventdata, handles)%存檔
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pic_mark;
if isempty(get(handles.axes3, 'Children'))
    
    Oops2
else
[f,p]=uiputfile({'*.bmp'},'保存文件');

str=strcat(p,f);

%pix=pic_mark;

imwrite(pic_mark,str,'bmp')
end



