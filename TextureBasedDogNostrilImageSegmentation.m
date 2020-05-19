function varargout = TextureBasedDogNostrilImageSegmentation(varargin)
% TextureBasedDogNostrilImageSegmentation MATLAB code for TextureBasedDogNostrilImageSegmentation.fig
%      TextureBasedDogNostrilImageSegmentation, by itself, creates a new TextureBasedDogNostrilImageSegmentation or raises the existing
%      singleton*.
%
%      H = TextureBasedDogNostrilImageSegmentation returns the handle to a new TextureBasedDogNostrilImageSegmentation or the handle to
%      the existing singleton*.
%
%      TextureBasedDogNostrilImageSegmentation('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TextureBasedDogNostrilImageSegmentation.M with the given input arguments.
%
%      TextureBasedDogNostrilImageSegmentation('Property','Value',...) creates a new TextureBasedDogNostrilImageSegmentation or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TextureBasedDogNostrilImageSegmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TextureBasedDogNostrilImageSegmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TextureBasedDogNostrilImageSegmentation

% Last Modified by GUIDE v2.5 25-Apr-2018 19:30:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TextureBasedDogNostrilImageSegmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @TextureBasedDogNostrilImageSegmentation_OutputFcn, ...
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


% --- Executes just before TextureBasedDogNostrilImageSegmentation is made visible.
function TextureBasedDogNostrilImageSegmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TextureBasedDogNostrilImageSegmentation (see VARARGIN)


% Choose default command line output for TextureBasedDogNostrilImageSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TextureBasedDogNostrilImageSegmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TextureBasedDogNostrilImageSegmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

CompleteSegmentation1


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
AcorrdingToSteps
