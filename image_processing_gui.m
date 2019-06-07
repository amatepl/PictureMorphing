function varargout = image_processing_gui(varargin)
% IMAGE_PROCESSING_GUI MATLAB code for image_processing_gui.fig
%      IMAGE_PROCESSING_GUI, by itself, creates a new IMAGE_PROCESSING_GUI or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING_GUI returns the handle to a new IMAGE_PROCESSING_GUI or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING_GUI.M with the given input arguments.
%
%      IMAGE_PROCESSING_GUI('Property','Value',...) creates a new IMAGE_PROCESSING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_processing_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_processing_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image_processing_gui

% Last Modified by GUIDE v2.5 07-Jun-2019 09:45:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_processing_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @image_processing_gui_OutputFcn, ...
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

% --- Executes just before image_processing_gui is made visible.
function image_processing_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image_processing_gui (see VARARGIN)

% Choose default command line output for image_processing_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image_processing_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = image_processing_gui_OutputFcn(hObject, eventdata, handles) 
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
fileVec = fopen('vector1.txt','w');
fprintf(fileVec,'%s','');
fclose(fileVec);
image = uigetfile({'*.tif; *.jpg; *.jpeg','Image (*.tif, *.jpg, *.jpeg)'},'Select an image');
fileImage = fopen('image1.txt','w');
fprintf(fileImage,'%s',image);
fclose(fileImage);
axes(handles.axes1);
imageHandle1 = imshow(image);
impixelinfo;
hold on;
set(imageHandle1,'ButtonDownFcn',@ImageClickCallback1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileVec = fopen('vector2.txt','w');
fprintf(fileVec,'%s','');
fclose(fileVec);
image = uigetfile({'*.tif; *.jpg; *.jpeg','Image (*.tif, *.jpg, *.jpeg)'},'Select an image');
fileImage = fopen('image2.txt','w');
fprintf(fileImage,'%s',image);
fclose(fileImage);
axes(handles.axes3);
imageHandle2 = imshow(image);
impixelinfo;
set(imageHandle2,'ButtonDownFcn',@ImageClickCallback2);

function ImageClickCallback1 ( hObject , eventData, handles)
   axesHandle  = get(hObject,'Parent');
   coordinates = get(axesHandle,'CurrentPoint'); 
   coordinates = round(coordinates(1,1:2));
   h1 = findobj('Tag','edit1');
   set(h1,'String',num2str(coordinates(1)));
   h2 = findobj('Tag','edit2');
   set(h2,'String',num2str(coordinates(2)));
   % Creation of a feature vector on the source image
   vec = imline;
   pos = wait(vec);
   % Write the data of the vectors inside a file
   fileVec = fopen('vector1.txt','a');
   fprintf(fileVec,'%i %i %i %i \n',round(pos));
   fclose(fileVec);
   hold on;

function ImageClickCallback2 ( hObject , eventData, handles)
   axesHandle  = get(hObject,'Parent');
   coordinates = get(axesHandle,'CurrentPoint'); 
   coordinates = round(coordinates(1,1:2));
   h1 = findobj('Tag','edit1');
   set(h1,'String',num2str(coordinates(1)));
   h2 = findobj('Tag','edit2');
   set(h2,'String',num2str(coordinates(2)));
   % Creation of a feature vector on the destination image
   vec = imline;
   pos = wait(vec);
   % Write the data of the vectors inside a file
   fileVec = fopen('vector2.txt','a');
   fprintf(fileVec,'%i %i %i %i \n',round(pos));
   fclose(fileVec);
   hold on;
   
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%set(H,'string','Hallo');

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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    vecFile1 = fopen('vector1.txt','r');
    vec1 = fscanf(vecFile1, '%i %i %i %i');
    vec1 = reshape(vec1,4,length(vec1)/4).';
    fclose(vecFile1);
    vecFile2 = fopen('vector2.txt','r');
    vec2 = fscanf(vecFile2, '%i %i %i %i');
    vec2 = reshape(vec2,4,length(vec2)/4).';
    fclose(vecFile2);
    nbVec1 = size(vec1,1);
    nbVec2 = size(vec2,1);
    if nbVec1 ~= nbVec2 
        c = 'The number of feature vectors are not the same in source and the destination image...';
        set(handles.issueText,'String',c);
    else
        c = 'No issue';
        set(handles.issueText,'String',c);
        % Read the file image to know what is the images studied
        fileImage1 = fopen('image1.txt','r');
        image1 = fscanf(fileImage1,'%s');
        fclose(fileImage1);
        fileImage2 = fopen('image2.txt','r');
        image2 = fscanf(fileImage2,'%s');
        fclose(fileImage2);
        if (image1 == "" || image2 == "")
            c = 'Missing image to make morrphing...';
            set(handles.issueText,'String',c);
        else
            % Logan code
            img1=imread(image1);
            img2=imread(image2); 
            [newRowSize, newColSize]=size(img1);
            newColSize = newColSize/3;
            newSize=[ newRowSize ; newColSize ];

            l1=vec1;
            l2=vec2;

            destIm = multiLineMorph(image1, l1, l2, nbVec1, newSize);
            axes(handles.axes2);
            imageHandle1 = imshow(destIm);
            impixelinfo;
        end
        fileVec = fopen('vector1.txt','w');
        fprintf(fileVec,'%s','');
        fclose(fileVec);  
        fileVec = fopen('vector2.txt','w');
        fprintf(fileVec,'%s','');
        fclose(fileVec);
        fileImage = fopen('image1.txt','w');
        fprintf(fileImage,'%s','');
        fclose(fileImage);
        fileImage = fopen('image2.txt','w');
        fprintf(fileImage,'%s','');
        fclose(fileImage);
%         % This lines are used when the algorith is totally clear        
%         P = zeros(2,nbVec1)
%         Q = P;
%         P = [vec1(:,1) vec1(:,3)].';
%         Q = [vec1(:,2) vec1(:,4)].';
    end
