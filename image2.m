function varargout = image2(varargin)
% IMAGE2 MATLAB code for image2.fig
%      IMAGE2, by itself, creates a new IMAGE2 or raises the existing
%      singleton*.
%
%      H = IMAGE2 returns the handle to a new IMAGE2 or the handle to
%      the existing singleton*.
%
%      IMAGE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE2.M with the given input arguments.
%
%      IMAGE2('Property','Value',...) creates a new IMAGE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image2

% Last Modified by GUIDE v2.5 26-Apr-2018 21:34:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image2_OpeningFcn, ...
                   'gui_OutputFcn',  @image2_OutputFcn, ...
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


% --- Executes just before image2 is made visible.
function image2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image2 (see VARARGIN)

% Choose default command line output for image2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = image2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
