function varargout = ShowGUI(varargin)
% SHOWGUI MATLAB code for ShowGUI.fig
%      SHOWGUI, by itself, creates a new SHOWGUI or raises the existing
%      singleton*.
%
%      H = SHOWGUI returns the handle to a new SHOWGUI or the handle to
%      the existing singleton*.
%
%      SHOWGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOWGUI.M with the given input arguments.
%
%      SHOWGUI('Property','Value',...) creates a new SHOWGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShowGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShowGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ShowGUI

% Last Modified by GUIDE v2.5 25-Feb-2016 10:55:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ShowGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ShowGUI_OutputFcn, ...
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


% --- Executes just before ShowGUI is made visible.
function ShowGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShowGUI (see VARARGIN)

% Choose default command line output for ShowGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ShowGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
setappdata(handles.figure1,'Net',0);
setappdata(handles.figure1,'Ori',0);
setappdata(handles.figure1,'Seg',0);
setappdata(handles.figure1,'Sig',0);

% --- Outputs from this function are returned to the command line.
function varargout = ShowGUI_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile( ...
    {'*.mat','All Image Files';...
    '*.*','All Files' },...
    '请选择神经网络', ...
    'MultiSelect', 'on');
src = strcat(pathname,filename);

try
    Net = load(src);
    set(handles.text3,'String','Done');
catch
    msgbox('无法加载网络');
end

setappdata(handles.figure1,'Net',Net);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Net = getappdata(handles.figure1,'Net');

Ori = getappdata(handles.figure1,'Ori');

FeatureExt(1,Ori);
load('testMat\P.mat');
p = P.P;
A = sim(Net,p);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.jpg;*.jpeg;*tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择原始图片', ...
    'MultiSelect', 'on');
if isequal(filename,0) || isequal(pathname,0)
    return;
end

src = strcat(pathname,filename);
Ori = imread(src);

try
    axes(handles.axes1);
    imshow(Ori);
    setappdata(handles.figure1,'Ori',Ori);
    set(handles.text4,'String','Done');
catch
    msgbox('找不到图片');
    return;
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.jpg;*.jpeg;*tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择分割图片', ...
    'MultiSelect', 'on');
if isequal(filename,0) || isequal(pathname,0)
    return;
end

src = strcat(pathname,filename);
Seg = imread(src);
setappdata(handles.figure1,'Seg',Seg);
 set(handles.text5,'String','Done');


    
    
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.jpg;*.jpeg;*tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择标记信息', ...
    'MultiSelect', 'on');
if isequal(filename,0) || isequal(pathname,0)
    return;
end

src = strcat(pathname,filename);
Sig = load(src);
setappdata(handles.figure1,'Sig',Sig);
 set(handles.text6,'String','Done');
