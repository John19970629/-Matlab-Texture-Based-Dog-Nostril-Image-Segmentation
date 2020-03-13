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

%�s���Ϥ�
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%��??��
    [FileName,PathName] = uigetfile('*.bmp');
    global pathall;
    pathall=strcat(PathName,FileName);
    %����?��
    pic=imread(pathall);
    axes(handles.axes1);
    imshow(pic);
    


% --- Executes on button press in pushbutton2.
%�}�l�������
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Vbw1  = 7;      % �����ҽk window size
 Vbs1  = 2;      % �����ҽk sigma
 Vcow1 = 3;     % GLCM window size
 Vbk1  = 0.5;    % Otsu - k�зǮt
 Vopw1 = 5;     % Opening window size
 Va1   = 15000;  % Label �h���T
 Vclw1 = 21;     % Closing window size
 global pic_segment;
 global pathall;
 global pic_closing;
 global a;
 %�p�G�SŪ�� ����
if (isempty(pathall))
    Oops
else
% ���զ�m���
  for i = 2:105
     if ( exist(['C:\Users\user\Downloads\����\groundtruth\'  num2str(i) '.bmp'],'file') ~=0 )
         pic_ground_truth = imread(['C:\Users\user\Downloads\����\groundtruth\'  num2str(i) '.bmp']);
         nostril_rate(i,:) = my_nostril_boundary_rate(pic_ground_truth);
     end
 end
 % ���դ��X��
       %  length_max = max(nostril_rate(:,1)); 
       %  length_max = 0.4757;
       %  pic_original = imread(pathall);
       %  [pic_segment,seg_begin(i,1)] = my_nostril_segment(pic_original,length_max,1.3);
         axes(handles.axes3);
         %imshow(pic_segment);
        pic_segment= imread('D:\Demo\1_nose_seg\2.bmp')
    % ��Ƕ�
    mySeg=pic_segment;
     pic_gray     = rgb2gray(pic_segment);
    % imshow(pic_gray);
       % �����ҽk
 
     filter = fspecial('gaussian',[Vbw1 Vbw1],Vbs1);
     pic_gaussian_blur = imfilter(pic_gray,filter);
     %imshow(pic_gaussian_blur);
     
      % �����n��� (�ﵽ���u�A�����T�h)

 
     pic_area_contrast = my_area_contrast(pic_gaussian_blur);
     %imshow(pic_area_contrast);
     
    % ���Z����� (gamma equation ���W��) (�ﵽ���T���D)


 pic_normalize = my_normalize (pic_gaussian_blur,1);
  %imshow( pic_normalize);
  
  % �ĦX�����n���Mgamma
    % pic_area_contrast  = pic_normalize;
    % pic_gamma_equation =  pic_area_contrast;
    pic_merge = my_merge(pic_area_contrast,pic_normalize,1,1,0);
%imshow( pic_merge);


%Gray level co-currence matrix
  
  %   pic_correlation = my_cooccurence(pic_merge,'Correlation',Vcow1,16);
         pic_correlation = imread('D:\Demo\6_correlation\2.bmp');
%imshow( pic_correlation);
% Otsu (level�� Otsu-k�ӼзǮt)

     pic_otsu  = my_otsu_std(pic_correlation,Vbk1);
     
     % Opening
 

     se = strel('disk',Vopw1);
     pic_opening = imopen(pic_otsu,se);   

% ��Label�A�h��label�ƶq�Ӥ֪��϶� (�M��դ������T)

 	pic_label_nose  = my_label_denoise(pic_opening,Va1);
    
    % �� Label ���X��ӻ�աA���e3�j��label�A�d�g�L������ (44�B45�p�G�u���̤j���A�|����U�������T)
 	pic_label_nostril  = my_label_capture(pic_label_nose,3);
    
     %closing
 	se = strel('disk',Vclw1);
 	
   	a = imclose(pic_label_nostril,se);
   imshow(a);
     %circle
 	
 
  %	pic_circle = my_circle(pic_closing);
    
  %  imshow( pic_circle);%�L�X



    
    
    
    
  

 
%imwrite( pic_circle, ['C:\Users\user\Desktop\2.bmp'] );
         
end  %�̫᪺end







% --- Executes on button press in pushbutton4.
%�M�����
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


clearvars -global a;
clearvars -global pathall3;
cla(handles.axes1,'reset');
cla(handles.axes3,'reset');
set(handles.edit1,'String',"�ǽT�v");


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%�ب��� 

global pic_segment;
global pic_closing;
global pathall;
%global pic_circle;
global a;
 	if isempty(get(handles.axes3, 'Children'))
     Oops2
    else
   
        	pic_circle = my_circle(a);
    
  %  imshow( pic_circle);%�L�X
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


% --- Executes on button press in pushbutton8.%�p��ǽT�v
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
    %����?��
    pic_ground_truth =imread( pathall3);
    pic_result=imread(pathall);
 correct_rate= my_correct_rate(pic_result,pic_ground_truth);
 set(handles.edit1,'String',num2str(correct_rate));
 %xlswrite('C:\Users\user\Downloads\����\rate',correct_rate);
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
%�^��UI0
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
%�s��

global a;
if isempty(get(handles.axes3, 'Children'))
    
    Oops2
else
[f,p]=uiputfile({'*.bmp'},'�O�s���');

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
