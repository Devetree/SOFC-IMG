function varargout = SOFC_Image2(varargin)
% SOFC_IMAGE2 MATLAB code for SOFC_Image2.fig
%      SOFC_IMAGE2, by itself, creates a new SOFC_IMAGE2 or raises the existing
%      singleton*.
%
%      H = SOFC_IMAGE2 returns the handle to a new SOFC_IMAGE2 or the handle to
%      the existing singleton*.
%
%      SOFC_IMAGE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOFC_IMAGE2.M with the given input arguments.
%
%      SOFC_IMAGE2('Property','Value',...) creates a new SOFC_IMAGE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SOFC_Image2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SOFC_Image2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SOFC_Image2

% Last Modified by GUIDE v2.5 12-Jun-2019 18:10:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SOFC_Image2_OpeningFcn, ...
                   'gui_OutputFcn',  @SOFC_Image2_OutputFcn, ...
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


% --- Executes just before SOFC_Image2 is made visible.
function SOFC_Image2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SOFC_Image2 (see VARARGIN)

panel_handles = findobj(handles.figure1,'type','uipanel');
set( panel_handles, 'parent', handles.figure1);

% Choose default command line output for SOFC_Image2
handles.output = hObject;

set(handles.uipanel1,'visible','off');
set(handles.uipanel2,'visible','off');
zoom(handles.figure1)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SOFC_Image2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SOFC_Image2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

clearvars handles.I handles.B handles.Im_side handles.B_Ni handles.B_YSZ handles.B_Pore;

% Get the gray scale image file
[filename,pathname] = uigetfile('*.png');

set(handles.edit4, 'String', filename);

handles.I = imread(fullfile(pathname,filename));

if size(handles.I, 3) == 3
    handles.I = rgb2gray(handles.I);
end

handles.axes1 = imshow(handles.I);
title('Original Image');

figure;
imshow(handles.I)
title('Original Image');

    % Update handles structure
guidata(hObject, handles);




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles = guidata(hObject);

Thd1 = get(handles.slider1, 'Value');

set(handles.edit11, 'String', Thd1);


    % Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = guidata(hObject);

Thd2 = get(handles.slider2, 'Value');

set(handles.edit12, 'String', Thd2);

    % Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

Thd1 = get(handles.slider1, 'Value');
Thd2 = get(handles.slider2, 'Value');

if Thd1 >= Thd2 
    message = sprintf('T1 should be less than T2');
msgbox(message,'Threshold Error');
end
    

L = imquantize(handles.I,[Thd1 Thd2]);
B = label2rgb(L,[0 0 0;1 0 0;0 1 0]);
handles.B = rgb2gray(B);

[V_pore,V_YSZ,V_Ni] = Volume_fraction(handles.B);

handles.axes1 = imshow(handles.B);
title('Image after manual threshold adjustment');

fileID = fopen('SOFC_img_results.txt','a');

fprintf(fileID,'\r\n Volume fractions after the manual threshold adjustment \r\n');
fprintf(fileID,'V_pore = %d \r\n',V_pore);
fprintf(fileID,'V_YSZ = %d \r\n',V_YSZ);
fprintf(fileID,'V_Ni = %d \r\n',V_Ni);


figure;
imshow(handles.B)
title('Image after manual threshold adjustment');

message = sprintf('Volume fractions after the manual threshold adjustment \n V_pore = %d \n V_YSZ = %d \n V_Ni = %d ',V_pore,V_YSZ,V_Ni);
msgbox(message);



    % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

V_pore_ori = str2double(get(handles.edit1,'String'));
Err_tol = str2double(get(handles.edit5,'String'));


[T1,T2,V_pore1,V_YSZ1,V_Ni1,V_pore2,V_YSZ2,V_Ni2,handles.B] = Threshold_adjust(handles.I,V_pore_ori,Err_tol);

set(handles.slider1, 'Value', T1);
set(handles.slider2, 'Value', T2);

handles.axes1 = imshow(handles.B);
title('Image after auto threshold adjustment');
% Volume fractions after Otsu,s method

fileID = fopen('SOFC_img_results.txt','a');

fprintf(fileID,'\r\nVolume fractions after Otsu,s method \r\n');
fprintf(fileID,'V_pore = %d \r\n',V_pore1);
fprintf(fileID,'V_YSZ = %d \r\n',V_YSZ1);
fprintf(fileID,'V_Ni = %d \r\n',V_Ni1);

% Volume fractions after the threshold adjustment

fprintf(fileID,'\r\nVolume fractions after the auto threshold adjustment \r\n');
fprintf(fileID,'V_pore = %d \r\n',V_pore2);
fprintf(fileID,'V_YSZ = %d \r\n',V_YSZ2);
fprintf(fileID,'V_Ni = %d \r\n',V_Ni2);

figure;
imshow(handles.B)
title('Image after auto threshold adjustment');

message = sprintf('Volume fractions after Otsu,s method \n V_pore = %d \n V_YSZ = %d \n V_Ni = %d \n Volume fractions after the auto threshold adjustment \n V_pore = %d \n V_YSZ = %d \n V_Ni = %d',V_pore1,V_YSZ1,V_Ni1,V_pore2,V_YSZ2,V_Ni2);
msgbox(message);

Thd1 = get(handles.slider1, 'Value');
Thd2 = get(handles.slider2, 'Value');

set(handles.edit11, 'String', Thd1);
set(handles.edit12, 'String', Thd2);

    % Update handles structure
guidata(hObject, handles);


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

jump = str2double(get(handles.edit6,'String'));
Del = str2double(get(handles.edit7,'String'));


[V_pore,V_YSZ,V_Ni,handles.B] = Sweep_fill(handles.B,jump,Del);

handles.axes1 = imshow(handles.B);
title('Image after sweep filling');

fileID = fopen('SOFC_img_results.txt','a');

fprintf(fileID,'\r\nVolume fractions after the sweep fill operation \r\n');
fprintf(fileID,'V_pore = %d \r\n',V_pore);
fprintf(fileID,'V_YSZ = %d \r\n',V_YSZ);
fprintf(fileID,'V_Ni = %d \r\n',V_Ni);


figure;
imshow(handles.B)
title('Image after sweep filling');


message = sprintf('Volume fractions after the sweep fill operation \n V_pore = %d \n V_YSZ = %d \n V_Ni = %d ',V_pore,V_YSZ,V_Ni);
msgbox(message);

    % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

r = str2double(get(handles.edit13,'String'));
[V_pore,V_YSZ,V_Ni,handles.B] = Eros_dilate(handles.B,r);

handles.axes1 = imshow(handles.B);
title('Image after erosion and dilation');

% Volume fractions after erosion and dilation

fileID = fopen('SOFC_img_results.txt','a');

fprintf(fileID,'\r\nVolume fractions after erosion and dilation \r\n');
fprintf(fileID,'V_pore = %d \r\n',V_pore);
fprintf(fileID,'V_YSZ = %d \r\n',V_YSZ);
fprintf(fileID,'V_Ni = %d \r\n',V_Ni);

figure;
imshow(handles.B)
title('Image after erosion and dilation');

message = sprintf('Volume fractions after erosion and dilation \n V_pore = %d \n V_YSZ = %d \n V_Ni = %d ',V_pore,V_YSZ,V_Ni);
msgbox(message);


    % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

set(handles.uipanel1,'visible','off');
set(handles.uipanel2,'visible','off');


% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles = guidata(hObject);

set(handles.uipanel1,'visible','on');
set(handles.uipanel2,'visible','off');


% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

set(handles.uipanel1,'visible','off');
set(handles.uipanel2,'visible','on');


% Update handles structure
guidata(hObject, handles);

function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);


kn = str2double(get(handles.edit10,'String'));
P = str2double(get(handles.edit9,'String'));
handles.Im_side = str2double(get(handles.edit8,'String'));

[Length,Ni_nos,YSZ_nos,L_micro,Ni_size,YSZ_size,handles.B_Ni,handles.B_YSZ,handles.B_Pore,B_Lines] = Particle_sizes(handles.B,kn,P,handles.Im_side);


handles.axes1 = imshow(B_Lines);
title('Image showing the lines');


fileID = fopen('SOFC_img_results.txt','a');

fprintf(fileID,'\r\nSOFC Image properties \r\n');
fprintf(fileID,'Total line length in pixels = %d \r\n',Length);
fprintf(fileID,'Total line length in micrometers = %d \r\n',L_micro);
fprintf(fileID,'Ni particle numbers = %d \r\n',Ni_nos);
fprintf(fileID,'YSZ particle numbers = %d \r\n',YSZ_nos);
fprintf(fileID,'Ni particle size = %d \r\n',Ni_size);
fprintf(fileID,'YSZ particle size = %d \r\n',YSZ_size);


figure;
imshow(handles.B_Ni)
title('Binary image of Ni');

figure;
imshow(handles.B_YSZ)
title('Binary image of YSZ');

figure;
imshow(handles.B_Pore)
title('Binary image of Pore');

figure;
imshow(B_Lines)
title('Image showing the lines');


message = sprintf('Total line length in pixels = %d \n Ni particle numbers = %d \n YSZ particle numbers = %d \n Total line length in micrometers = %d \n Ni particle size = %d \n YSZ particle size = %d',Length,Ni_nos,YSZ_nos,L_micro,Ni_size,YSZ_size);
msgbox(message);

    % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

handles.Im_side = str2double(get(handles.edit8,'String'));
[S_Ni,S_YSZ,S_Pore,S_Ni_YSZ,S_Ni_Pore,S_YSZ_Pore,B_Ni_peri,B_YSZ_peri,B_Pore_peri] = Surface_areas(handles.B_Ni,handles.B_YSZ,handles.B_Pore,handles.Im_side);

handles.axes1 = imshow(B_Ni_peri);
title('Ni Perimeter');

fileID = fopen('SOFC_img_results.txt','a');

fprintf(fileID,'\r\nSurface area of Ni = %d \r\n',S_Ni);
fprintf(fileID,'Surface area of YSZ = %d \r\n',S_YSZ);
fprintf(fileID,'Surface area of Pore = %d \r\n',S_Pore);

fprintf(fileID,'\r\nSurface area of Ni-YSZ interface in micrometers square = %d \r\n',S_Ni_YSZ);
fprintf(fileID,'Surface area of Ni-Pore interface in micrometers square = %d \r\n',S_Ni_Pore);
fprintf(fileID,'Surface area of YSZ-Pore interface in micrometers square = %d \r\n',S_YSZ_Pore);

figure;
imshow(B_Ni_peri)
title('Ni Perimeter');

figure;
imshow(B_YSZ_peri)
title('YSZ Perimeter');

figure;
imshow(B_Pore_peri)
title('Pore Perimeter');

message = sprintf('Surface area of Ni = %d \n ,Surface area of YSZ = %d \n Surface area of Pore = %d \n Surface area of Ni-YSZ interface in micrometers square = %d  \n Surface area of Ni-Pore interface in micrometers square = %d \n Surface area of YSZ-Pore interface in micrometers square = %d',S_Ni,S_YSZ,S_Pore,S_Ni_YSZ,S_Ni_Pore,S_YSZ_Pore);
msgbox(message);



    % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

handles.Im_side = str2double(get(handles.edit8,'String'));
[I_TPB,Angle_mat,Theta_YSZ_avg,Theta_NI_avg,Theta_PORE_avg,TPB,TPB_points] = TPB_contactangles2(handles.B,handles.Im_side);


handles.axes1 = imshow(I_TPB);
title('TPB points');


figure;
imshow(I_TPB)
title('TPB points');

figure;
h1 = histogram(Angle_mat(:,1));
xlabel('Angles in degrees')
ylabel('Frequency')
title('YSZ angles')

figure;
h2 = histogram(Angle_mat(:,2));
xlabel('Angles in degrees')
ylabel('Frequency')
title('Ni angles')

figure;
h3 = histogram(Angle_mat(:,3));
xlabel('Angles in degrees')
ylabel('Frequency')
title('Pore angles')


fileID = fopen('SOFC_img_results.txt','a');


fprintf(fileID,'\r\n TPB points = %d \r\n',TPB_points);

fprintf(fileID,'TPB density in micrometers^-2 = %d \r\n',TPB);


fprintf(fileID,'\r\nAverage YSZ contact angle in degrees = %d \r\n',Theta_YSZ_avg);
fprintf(fileID,'Average Ni contact angle in degrees = %d \r\n',Theta_NI_avg);
fprintf(fileID,'Average Pore contact angle in degrees = %d \r\n',Theta_PORE_avg);



message = sprintf('TPB points = %d \n TPB density in micrometers^-2 = %d  \n  Average YSZ contact angle in degrees = %d \n Average Ni contact angle in degrees = %d \n Average Pore contact angle in degrees = %d',TPB_points,TPB,Theta_YSZ_avg,Theta_NI_avg,Theta_PORE_avg);
msgbox(message);

    % Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function text16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);

figure;
imhist(handles.I)

    % Update handles structure
guidata(hObject, handles);



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
