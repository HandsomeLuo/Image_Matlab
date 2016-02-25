
function varargout = MainGUI(varargin)
% MAINGUI MATLAB code for MainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainGUI

% Last Modified by GUIDE v2.5 23-Feb-2016 16:33:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MainGUI_OutputFcn, ...
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


% --- Executes just before MainGUI is made visible.
function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainGUI (see VARARGIN)

% Choose default command line output for MainGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.axes1,'visible','off')
set(handles.axes2,'visible','off')
axes(handles.axes1);
imshow('使用流程.jpg');


setappdata(handles.figure1,'image',0);
setappdata(handles.figure1,'SegPath',0);
setappdata(handles.figure1,'SigPath',0);
setappdata(handles.figure1,'ImagePath',0);
setappdata(handles.figure1,'net',0);

% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function BPnetwork_Callback(hObject, eventdata, handles)
% hObject    handle to BPnetwork (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function svm_Callback(hObject, eventdata, handles)
% hObject    handle to svm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------



% --------------------------------------------------------------------
function SVMtrain_Callback(hObject, eventdata, handles)
% hObject    handle to SVMtrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function SVMtest_Callback(hObject, eventdata, handles)
% hObject    handle to SVMtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function BPtrain_Callback(hObject, eventdata, handles)
% hObject    handle to BPtrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function BPtest_Callback(hObject, eventdata, handles)
% hObject    handle to BPtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function openfile_Callback(hObject, eventdata, handles)
% hObject    handle to openfile (see GCBO)
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

axes(handles.axes1);
src = strcat(pathname,filename);
Ori = imread(src);
setappdata(handles.figure1,'image',Ori);
imshow(Ori);

% --------------------------------------------------------------------
function savefile_Callback(hObject, eventdata, handles)
% hObject    handle to savefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImagePath = getappdata(handles.figure1,'ImagePath');
SegPath = getappdata(handles.figure1,'SegPath');
SigPatn = getappdata(handles.figure1,'SigPatn');
try
    GateData(ImagePath,SegPath,SigPatn);
    FeatureExt(0);
catch
    msgbox('提取失败');
    return;
end
msgbox('提取完毕','提示');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('trainsetMat\P.mat');
    load('trainsetMat\T.mat');
%     TrainsetC = load('trainsetMat\Train_colorhist.mat');
%     % TestsetC = load('Test_colorhist.mat');
% 
%     TrainsetT = load('trainsetMat\Train_texture.mat');
%     % TestsetT = load('Test_texture.mat');
% 
%     train1 = cat(2,TrainsetC.color1,TrainsetT.texture1);
%     train2 = cat(2,TrainsetC.color2,TrainsetT.texture2);
%     train3 = cat(2,TrainsetC.color3,TrainsetT.texture3);
%     train4 = cat(2,TrainsetC.color4,TrainsetT.texture4);
%     trainset = cat(1,train1,train2,train3,train4);
%     %trainset = cat(1,TrainsetC.water_color,TrainsetC.bear_color,TrainsetC.grass_color,TrainsetC.land_color);
% 
%     % water_test = cat(2,TestsetC.water_color,TestsetT.water_texture);
%     % bear_test = cat(2,TestsetC.bear_color,TestsetT.bear_texture);
%     % grass_test = cat(2,TestsetC.grass_color,TestsetT.grass_texture);
%     % land_test = cat(2,TestsetC.land_color,TestsetT.land_texture);
%     % testset = cat(1,water_test,bear_test,grass_test,land_test);
%     % %testset = cat(1,TestsetC.water_color,TestsetC.bear_color,TestsetC.grass_color,TestsetC.land_color);
% 
%     %P=mapminmax(trainset');%初始训练值
%     P = trainset';
%     % T 为目标矢量 
%     %T1=ones(1,size(water_train,1)); 
%     T1 = repmat([0,0],size(train1,1),1);
%     %T2=2*ones(1,size(bear_train,1));
%     T2 = repmat([0,1],size(train2,1),1);
%     %T3=3*ones(1,size(grass_train,1));
%     T3 = repmat([1,0],size(train3,1),1);
%     %T4=4*ones(1,size(land_train,1));
%     T4 = repmat([1,1],size(train4,1),1);
%     T = cat(1,T1,T2,T3,T4)';
catch
    msgbox('数据加载失败');
    return;
end

nntool;

%setappdata(handles.figure1,'net',net);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ImagePath = uigetdir('e:\', '选择图片路径' );
if isequal(ImagePath,0)
    return
end
set(handles.text1,'String',ImagePath);
setappdata(handles.figure1,'ImagePath',ImagePath);
try
    axes(handles.axes1);
    Images = dir(fullfile(ImagePath,'*.jpeg'));
    Ori = imread(strcat(ImagePath,'\',Images(1).name));
    imshow(Ori);
catch
    msgbox('找不到图片');
    return;
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SegPath = uigetdir('e:\', '选择分割图像路径' );
if isequal(SegPath,0)
    return;
end
set(handles.text2,'String',SegPath);
setappdata(handles.figure1,'SegPath',SegPath);
try
    axes(handles.axes2);
    Segments = dir(fullfile(SegPath,'*.jpg'));
    Seg = imread(strcat(SegPath,'\',Segments(1).name));
    imshow(Seg);
catch
    msgbox('找不到图片');
    return;
end
    
    
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SigPatn = uigetdir('e:\', '选择标记图像路径' );
if isequal(SigPatn,0)
    return
end
set(handles.text3,'String',SigPatn);
setappdata(handles.figure1,'SigPatn',SigPatn);


% --------------------------------------------------------------------
function feature_Callback(hObject, eventdata, handles)
% hObject    handle to feature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function colortexture_Callback(hObject, eventdata, handles)
% hObject    handle to colortexture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sift_Callback(hObject, eventdata, handles)
% hObject    handle to sift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    save('net',net);
catch
    msgbox('保存失败');
    return;
end
msgbox('保存成功');
