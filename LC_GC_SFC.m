function varargout = LC_GC_SFC(varargin)
% LC_GC_SFC MATLAB code for LC_GC_SFC.fig
%      LC_GC_SFC, by itself, creates a new LC_GC_SFC or raises the existing
%      singleton*.
%
%      H = LC_GC_SFC returns the handle to a new LC_GC_SFC or the handle to
%      the existing singleton*.
%
%      LC_GC_SFC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LC_GC_SFC.M with the given input arguments.
%
%      LC_GC_SFC('Property','Value',...) creates a new LC_GC_SFC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LC_GC_SFC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LC_GC_SFC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% EXPLANATION OF THE GUI
%
% 1. USE OF THE APPLICATION
%
% The this tool can be used for calculating the optimal flow rate
% for chromatographic systems (LC, GC and SFC).
%
% 2. SELECTING SYSTEM AND PARAMETERS
%
% The system for which the calculations have to be performed can be
% selected from the pop-up menu located on top of the GUI. Per system
% one can choose to perform calculations for open columns as well as
% packed columns. After choosing the right system, the parameters 
% under which the calculations have to be performed must be set. In 
% case of packed columns, one can choose for normal parameters 
%(Van Deemter's equation) and reduced parameters (reduced Van Deemter's 
% equation or Knox' equation). For open columns, one can choose between
% normal parameters (Golay's equation) or reduced parameters (reduced
% Golay equation).
%
% 3. INPUT ARGUMENTS
%
% Input arguments should be given according to the guiding text next
% to the input field. As an aid common values can be found by clicking
% on the push buttons. Calculations can be executed by clicking the
% Calculate button
%
% 4. OUTPUT
%
% The output consists of: 
%                           - Optimal flow rate in mL/min
%                           - Optimal linear flow velocity in m/s
%                           - Minimal plate height in um (here u === mu)
%
% Additionally, a plot will be generated in which the minimal plate
% height is plotted against the linear flow velocity.
%
% 5. FURTHER INFORMATION
%
% A brief tutorial with supporting images can be downloaded from:
% https://github.com/jorismeurs/LC_GC_SFC_optimization
%
% For contact: j.meurs@student.vu.nl
%
% 6. LICENSE
%
% This file is covered by a MIT-licences
% The MIT License (MIT)
% Copyright (c) 2016, Joris Meurs
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 02-Jun-2016 15:29:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LC_GC_SFC_OpeningFcn, ...
                   'gui_OutputFcn',  @LC_GC_SFC_OutputFcn, ...
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


% --- Executes just before LC_GC_SFC is made visible.
function LC_GC_SFC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LC_GC_SFC (see VARARGIN)


% Choose default command line output for LC_GC_SFC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LC_GC_SFC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LC_GC_SFC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in chrom.
function chrom_Callback(hObject, eventdata, handles)
% hObject    handle to chrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chrom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chrom

v = get(handles.chrom,'Value');
if v == 1;
end

if v == 2; %LC open column
   set(handles.title,'String','Liquid Chromatography');
   set(handles.uipanel1,'Visible','on');
   set(handles.uipanel2,'Visible','on');
   set(handles.title,'Visible','on');
   
   set(handles.text1,'String','Film thickness (um)');
   set(handles.text2,'String','Column diameter (um)');
   set(handles.text3,'String','Diffusion coefficient (mobile phase) (1e-9 m2/s)');
   set(handles.text4,'String','Diffusion coefficient (film) (1e-11 m2/s)');
   set(handles.text5,'String','Expected retention factor');
   set(handles.text4,'Visible','on');
   set(handles.edit4,'Visible','on');
   set(handles.text5,'Visible','on');
   set(handles.edit5,'Visible','on');
   set(handles.text6,'Visible','off');
   set(handles.edit6,'Visible','off');
   set(handles.text7,'Visible','off');
   set(handles.edit7,'Visible','off');
   set(handles.parameters,'Visible','off');
   set(handles.abc,'Visible','off');
   
   set(handles.text8,'String','Optimal linear velocity (um/s)');
   set(handles.text9,'String','Minimal plate height (um)');
   set(handles.text10,'Visible','off');
   set(handles.edit10,'Visible','off');
   
   set(handles.parameters,'Visible','off');
   set(handles.parameters2,'Visible','on');
end

if v == 3; %LC packed column
   set(handles.title,'String','Liquid Chromatography');
   set(handles.uipanel1,'Visible','on');
   set(handles.uipanel2,'Visible','on');
   set(handles.title,'Visible','on');
   
   set(handles.text1,'String','Particle size (um)');
   set(handles.text2,'String','Column diameter (mm)');
   set(handles.text3,'String','Diffusion coefficient (1e-9 m2/s)');
   set(handles.text4,'String','Volume fraction');
   set(handles.edit3,'Visible','on');
   set(handles.text3,'Visible','on');
   set(handles.edit4,'Visible','on');
   set(handles.text4,'Visible','on');
   set(handles.edit5,'Visible','on');
   set(handles.text5,'Visible','on');
   set(handles.text5,'String','A-term');
   set(handles.text6,'Visible','on');
   set(handles.text6,'String','B-term');
   set(handles.edit6,'Visible','on');
   set(handles.text7,'Visible','on');
   set(handles.text7,'String','C-term');
   set(handles.edit7,'Visible','on');
   set(handles.parameters,'Visible','on');
   set(handles.abc,'Visible','on');
   
   set(handles.parameters,'Visible','on');
   set(handles.parameters2,'Visible','off');
   
   set(handles.text8,'String','Optimal linear velocity (m/s)');
   set(handles.text9,'String','Minimal plate height (um)');
   set(handles.text10,'String','Optimal flow rate (mL/min)');
   set(handles.text10,'Visible','on');
   set(handles.edit10,'Visible','on');
   
end

if v == 4; %GC open column
   set(handles.title,'String','Gas Chromatography');
   set(handles.uipanel1,'Visible','on');
   set(handles.uipanel2,'Visible','on');
   set(handles.title,'Visible','on');
   
   set(handles.text1,'String','Film thickness (um)');
   set(handles.text2,'String','Column diameter (mm)');
   set(handles.text3,'String','Diffusion coefficient (carrier gas) (1e-6 m2/s)');
   set(handles.text4,'String','Diffusion coefficient (film) (1e-11 m2/s)');
   set(handles.text5,'String','Expected retention factor');
   set(handles.text4,'Visible','on');
   set(handles.edit4,'Visible','on');
   set(handles.text5,'Visible','on');
   set(handles.edit5,'Visible','on');
   set(handles.text6,'Visible','off');
   set(handles.edit6,'Visible','off');
   set(handles.text7,'Visible','off');
   set(handles.edit7,'Visible','off');
   set(handles.parameters,'Visible','off');
   set(handles.abc,'Visible','off');
   
   set(handles.text8,'String','Optimal linear velocity (m/s)');
   set(handles.text9,'String','Minimal plate height (mm)');
   set(handles.text10,'Visible','off');
   set(handles.edit10,'Visible','off');
   
   set(handles.parameters,'Visible','off');
   set(handles.parameters2,'Visible','on');
   
end

if v == 5; %GC packed column
   set(handles.title,'String','Gas Chromatography');
   set(handles.uipanel1,'Visible','on');
   set(handles.uipanel2,'Visible','on');
   set(handles.title,'Visible','on');
   
   set(handles.text1,'String','Particle size (um)');
   %set(handles.text2,'String','Column diameter (mm)');
   set(handles.text2,'String','Diffusion coefficient (1e-6 m2/s)');
   set(handles.edit3,'Visible','on');
   set(handles.text3,'Visible','on');
   set(handles.edit4,'Visible','on');
   set(handles.text4,'Visible','on');
   set(handles.edit5,'Visible','on');
   set(handles.text5,'Visible','on');
   set(handles.text3,'String','A-term');
   set(handles.text4,'String','B-term');
   set(handles.text5,'String','C-term');
   set(handles.text6,'Visible','off');
   set(handles.edit6,'Visible','off');
   set(handles.text7,'Visible','off');
   set(handles.edit7,'Visible','off');
   set(handles.parameters,'Visible','on');
   set(handles.abc,'Visible','on');
   
   set(handles.parameters,'Visible','on');
   set(handles.parameters2,'Visible','off');
   
   set(handles.text8,'String','Optimal linear velocity (m/s)');
   set(handles.text9,'String','Minimal plate height (mm)');
   set(handles.text10,'Visible','off');
   set(handles.edit10,'Visible','off');
   
end

if v == 6; %SFC open column
   set(handles.title,'String','Supercritical Fluid Chromatography'); 
   set(handles.uipanel1,'Visible','on');
   set(handles.uipanel2,'Visible','on');
   set(handles.title,'Visible','on');
   
   set(handles.text1,'String','Film thickness (um)');
   set(handles.text2,'String','Column diameter (um)');
   set(handles.text3,'String','Diffusion coefficient (mobile phase) (1e-8 m2/s)');
   set(handles.text4,'String','Diffusion coefficient (film) (1e-11 m2/s)');
   set(handles.text5,'String','Expected retention factor');
   set(handles.text4,'Visible','on');
   set(handles.edit4,'Visible','on');
   set(handles.text5,'Visible','on');
   set(handles.edit5,'Visible','on');
   set(handles.text6,'Visible','off');
   set(handles.edit6,'Visible','off');
   set(handles.text7,'Visible','off');
   set(handles.edit7,'Visible','off');
   set(handles.parameters,'Visible','off');
   set(handles.abc,'Visible','off');
   
   set(handles.text8,'String','Optimal linear velocity (mm/s)');
   set(handles.text9,'String','Minimal plate height (mm)');
   set(handles.text10,'Visible','off');
   set(handles.edit10,'Visible','off');
   
   set(handles.parameters,'Visible','off');
   set(handles.parameters2,'Visible','on');
end

if v == 7; %SFC packed column
   set(handles.title,'String','Supercritical Fluid Chromatography');
   set(handles.uipanel1,'Visible','on');
   set(handles.uipanel2,'Visible','on');
   set(handles.title,'Visible','on');
   
   set(handles.text1,'String','Particle size (um)');
   %set(handles.text2,'String','Column diameter (mm)');
   set(handles.text2,'String','Diffusion coefficient (SF)(1e-8 m2/s)');
   set(handles.edit3,'Visible','on');
   set(handles.text3,'Visible','on');
   set(handles.edit4,'Visible','on');
   set(handles.text4,'Visible','on');
   %set(handles.text4,'String','Volume fraction');
   set(handles.text3,'String','A-term');
   set(handles.text5,'Visible','on');
   set(handles.text4,'String','B-term');
   set(handles.edit5,'Visible','on');
   set(handles.text6,'Visible','off');
   set(handles.text5,'String','C-term');
   set(handles.edit6,'Visible','off');
   set(handles.edit7,'Visible','off');
   set(handles.text7,'Visible','off');
   set(handles.parameters,'Visible','on');
   set(handles.abc,'Visible','on');
   
   set(handles.parameters,'Visible','on');
   set(handles.parameters2,'Visible','off');
   
   set(handles.text10,'Visible','off');
   set(handles.edit10,'Visible','off');
   
end

% --- Executes during object creation, after setting all properties.
function chrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close LC_GC_SFC
run LC_GC_SFC

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vv = get(handles.chrom,'Value');

if vv == 2; % LC open column
    
    pp = get(handles.parameters2,'Value');
    
    if pp == 2 % Normal Golay
    
    % Obtain values
    a = get(handles.edit1,'String');
    b = get(handles.edit2,'String');
    c = get(handles.edit3,'String');
    d = get(handles.edit4,'String');
    e = get(handles.edit5,'String');
    
    % Convert to numbers
    df = str2double(a);
    dc = str2double(b);
    D_m = str2double(c);
    D_f = str2double(d);
    k = str2double(e);
    
    % Limitations
    if df<=0, error('Irregular value');end
    if D_f<=0, error('Irregular value');end
    if dc<=0, error('Irregular value');end
    if D_m<=0, error('Irregular value');end
    if k<=0, error('Irregular value');end
    if k == 1, error('Irregular value');end
    
    % Convert to right units
    df_ = df.*1e-6; 
    dc_ = dc.*1e-6;
    D_f_ = D_f.*1e-11;
    D_m_ = D_m.*1e-9;
    
    % Calculations
    N = 100000;% number of data points
    u_m = linspace(0.001e-3,1e-4,N)';% m/s
    fk = (11*(k^2)+(6*k)+1)/(96*((1+k)^2));
    gk = (2*k)/(3*((1-k)^2));
    H = ((2.*D_m_)./u_m)+(fk.*((dc_^2.*u_m)./D_m_))+(gk.*((df_^2.*u_m)./D_f_));
    H_min = min(H);
    L = [u_m H];
    r = find(L(:,2) == H_min);
    u_opt = L(r,1);
    
    % Output
    u_opt_ = u_opt.*1e6;
    H_min_ = H_min*1e3;
    u_ = num2str(u_opt_); % m/s
    H_ = num2str(H_min_); %mm
    set(handles.edit8,'String',u_);
    set(handles.edit9,'String',H_);
    
    figure;
    plot(u_m.*1e6,H.*1e3,'-');
    xlabel('Linear flow velocity (um/s)');
    ylabel('Theoretical plate height (mm)');
    axis([0 100 0 H_min_+2]);
    end
    
    if pp == 3 % Reduced Golay
        
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        
        % Convert to numbers
        df = str2double(a);
        k = str2double(b);
        
        % Limitations
        if df <=0, error('Irregular value');end
        if k <=0, error('Irregular value');end
        if k == 1, error('Irregular value');end
        
        % Calculations
        N = 1000;
        v = linspace(0.001,10,N)';
        f = ((11*k^2)+(6*k)+1)/(96*((1+k)^2));
        g = (2*k)/(3*((1+k)^2));
        h = (2./v)+(f.*v)+(g.*df^2.*v);
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = L(r,1);
        
        % Output
        h_ = num2str(h_min);
        v_ = num2str(v_opt);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 10 0 (h_min+10)]);
    end
        
end

if vv == 3; % LC packed column
    
    qq = get(handles.parameters,'Value');
    
    % Obtain values
    a = get(handles.edit1,'String');
    b = get(handles.edit2,'String');
    c = get(handles.edit3,'String');
    d = get(handles.edit4,'String');
    e = get(handles.edit5,'String');
    f = get(handles.edit6,'String');
    g = get(handles.edit7,'String');
        
    if qq == 2 % Normal Van Deemter
        
        % Convert strings to numbers
        dp_ = str2double(a);
        dc_ = str2double(b);
        D_ = str2double(c);
        E = str2double(d);
        A = str2double(e);
        B = str2double(f);
        C = str2double(g);
        
        % Convert values to right units
        dp = dp_/1e6;
        dc = dc_/1e3;
        D = D_/1e9;
        
        % Limitations
        if dp<=0, error('Irregular value');end
        if D<=0, error('Irregular value');end
        if dc<=0, error('Irregular value');end
        if A<0, error('Irregular value');end
        if B<0, error('Irregular value');end
        if C<0, error('Irregular value');end
        if E<=0, error('Irregular value');
        elseif E>0.99, error('Irregular value');end
        
        % Calculations
        N = 100000;% number of data points
        u_m = linspace(0.001,0.1,N)';% m/s
        H_m = (A.*dp)+((B.*D)./u_m)+(C.*((dp.^2).*u_m)./D);% plate height in meters
        H_min = min(H_m);% plate height in meters
        L = [u_m H_m];
        r = find(L(:,2) == H_min);
        u_opt = L(r,1);
        F_opt = (u_opt*0.25*pi*E*(dc^2));
        F_mLmin = F_opt*(60e6);
                
        % Output values
        u_ = num2str(u_opt);
        H_ = num2str(H_min*1e6);
        F_ = num2str(F_mLmin);
        set(handles.edit8,'String',F_);
        set(handles.edit10,'String',H_);
        set(handles.edit9,'String',u_);
        
        figure;
        plot(u_m,H_m.*1e6,'-');
        xlabel('Linear flow velocity (m/s)');
        ylabel('Theoretical plate height ( \mu m)');
        axis([0 0.1 0 20]);
                
    end
    
    if qq == 3 % Reduced Van Deemter
        
        % Convert strings to numbers
        A = str2double(a);
        B = str2double(b);
        C = str2double(c);
        
        % Calculations
        v = linspace(0.001,20,100000)';
        h = A + (B./v) + (C.*v);
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = (L(r,1));
        
        % Output
        v_ = num2str(v_opt);
        h_ = num2str(h_min);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 20 0 (h_min+10)]);
    end
    
    if qq == 4 % Knox
        
        % Convert strings to numbers
        A = str2double(a);
        B = str2double(b);
        C = str2double(c);
        
        % Calculations
        v = linspace(0.001,10,100000)';
        h = A.*v.^(1/3) + B./v + C.*v;
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = (L(r,1));
        
        % Output
        v_ = num2str(v_opt);
        h_ = num2str(h_min);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 10 0 (h_min+10)]);
    end
    
end

if vv == 4; % GC open column
    
    pp = get(handles.parameters2,'Value');
    
    if pp == 2 % Normal Golay
    
    % Obtain values
    a = get(handles.edit1,'String');
    b = get(handles.edit2,'String');
    c = get(handles.edit3,'String');
    d = get(handles.edit4,'String');
    e = get(handles.edit5,'String');
    
    % Convert to numbers
    df = str2double(a);
    dc = str2double(b);
    D_m = str2double(c);
    D_f = str2double(d);
    k = str2double(e);
    
    % Limitations
    if df<=0, error('Irregular value');end
    if D_f<=0, error('Irregular value');end
    if dc<=0, error('Irregular value');end
    if D_m<=0, error('Irregular value');end
    if k<=0, error('Irregular value');end
    if k == 1, error('Irregular value');end
    
    % Convert to right units
    df_ = df.*1e-6; 
    dc_ = dc.*1e-3;
    D_f_ = D_f.*1e-11;
    D_m_ = D_m.*1e-4;
    
    % Calculations
    N = 100000;% number of data points
    u_m = linspace(0.001,0.9,N)';% m/s
    fk = (11*(k^2)+(6*k)+1)/(96*((1+k)^2));
    gk = (2*k)/(3*((1-k)^2));
    H = ((2.*D_m_)./u_m)+(fk.*((dc_^2.*u_m)./D_m_))+(gk.*((df_^2.*u_m)./D_f_));
    H_min = min(H);
    L = [u_m H];
    r = find(L(:,2) == H_min);
    u_opt = L(r,1);
    
    % Output
    u_opt_ = u_opt;
    H_min_ = H_min.*1e3;
    u_ = num2str(u_opt_); % m/s
    H_ = num2str(H_min_); %mm
    set(handles.edit8,'String',u_);
    set(handles.edit9,'String',H_);
    
    figure;
    plot(u_m,H.*1e3,'-');
    xlabel('Linear flow velocity (m/s)');
    ylabel('Theoretical plate height (mm)');
    axis([0 0.9 0 10]);
    end
    
    if pp == 3 % Reduced Golay
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        
        % Convert to numbers
        df = str2double(a);
        k = str2double(b);
        
        % Limitations
        if df <=0, error('Irregular value');end
        if k <=0, error('Irregular value');end
        if k == 1, error('Irregular value');end
        
        % Calculations
        N = 1000;
        v = linspace(0.001,10,N)';
        f = ((11*k^2)+(6*k)+1)/(96*((1+k)^2));
        g = (2*k)/(3*((1+k)^2));
        h = (2./v)+(f.*v)+(g.*df^2.*v);
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = L(r,1);
        
        % Output
        h_ = num2str(h_min);
        v_ = num2str(v_opt);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 10 0 (h_min+10)]);
    end
    
end

if vv == 5; % GC packed column
    
    qq = get(handles.parameters,'Value');
    
    if qq == 2 % Normal Van Deemter
        
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        c = get(handles.edit3,'String');
        d = get(handles.edit4,'String');
        e = get(handles.edit5,'String');
        
        % Convert strings to numbers
        dp_ = str2double(a);
        D_ = str2double(b);
        A = str2double(c);
        B = str2double(d);
        C = str2double(e);
        
        % Convert values to right units
        dp = dp_/1e6;
        D = D_/1e6;
        
        % Limitations
        if dp<=0, error('Irregular value');end
        if D<=0, error('Irregular value');end
        if A<0, error('Irregular value');end
        if B<0, error('Irregular value');end
        if C<0, error('Irregular value');end
                
        % Calculations
        N = 100000;% number of data points
        u_m = linspace(0.01,1,N)';% m/s
        H_m = (A.*dp)+((B.*D)./u_m)+(C.*((dp.^2).*u_m)./D);
        H_min = min(H_m);% plate height in meters
        L = [u_m H_m];
        r = find(L(:,2) == H_min);
        u_opt = L(r,1);
                
        % Output
        u_ = num2str(u_opt);
        H_ = num2str(H_min.*1e3);
        set(handles.edit8,'String',u_);
        set(handles.edit9,'String',H_);
        
        figure;
        plot(u_m.*1e2,H_m.*1e3,'-');
        xlabel('Linear flow velocity (cm/s)');
        ylabel('Theoretical plate height (mm)');
        axis([0 100 0 10]);
    end
    
    if qq == 3 % Reduced Van Deemter
        
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        c = get(handles.edit3,'String');
        
        % Convert strings to numbers
        A = str2double(a);
        B = str2double(b);
        C = str2double(c);
        
        % Limitations
        if A < 0, error('Irregular value');end
        if B < 0, error('Irregular value');end
        if C < 0, error('Irregular value');end
        
        % Calculations
        v = linspace(0.001,20,100000)';
        h = A + B./v + C.*v;
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = (L(r,1));
        
        % Output
        v_ = num2str(v_opt);
        h_ = num2str(h_min);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 20 0 (h_min+10)]);
    end
    
    if qq == 4 % Knox
        
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        c = get(handles.edit3,'String');
        
        % Convert strings to numbers
        A = str2double(a);
        B = str2double(b);
        C = str2double(c);
        
        % Limitations
        if A < 0, error('Irregular value');end
        if B < 0, error('Irregular value');end
        if C < 0, error('Irregular value');end
        
        % Calculations
        v = linspace(0.001,10,100000)';
        h = A.*v.^(1/3) + B./v + C.*v;
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = (L(r,1));
        
        % Output
        v_ = num2str(v_opt);
        h_ = num2str(h_min);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 10 0 (h_min+10)]);
    end
end

if vv == 6; % SFC open column
    
    pp = get(handles.parameters2,'Value');
    
    if pp == 2 % Normal Golay
    
    % Obtain values
    a = get(handles.edit1,'String');
    b = get(handles.edit2,'String');
    c = get(handles.edit3,'String');
    d = get(handles.edit4,'String');
    e = get(handles.edit5,'String');
    
    % Convert to numbers
    df = str2double(a);
    dc = str2double(b);
    D_m = str2double(c);
    D_f = str2double(d);
    k = str2double(e);
    
    % Limitations
    if df<=0, error('Irregular value');end
    if D_f<=0, error('Irregular value');end
    if dc<=0, error('Irregular value');end
    if D_m<=0, error('Irregular value');end
    if k<=0, error('Irregular value');end
    if k == 1, error('Irregular value');end
    
    % Convert to right units
    df_ = df*1e-6; 
    dc_ = dc*1e-6;
    D_f_ = D_f*1e-11;
    D_m_ = D_m*1e-8;
    
    % Calculations
    N = 100000;% number of data points
    u_m = linspace(1e-5,5e-3,N)';% m/s
    fk = (11*(k^2)+(6*k)+1)/(96*((1+k)^2));
    gk = (2*k)/(3*((1-k)^2));
    H = ((2.*D_m_)./u_m)+(fk.*((dc_^2.*u_m)./D_m_))+(gk.*((df_^2.*u_m)./D_f_));
    H_min = min(H);
    L = [u_m H];
    r = find(L(:,2) == H_min);
    u_opt = L(r,1);
    
    % Output
    u_opt_ = u_opt*1e3;
    H_min_ = H_min*1e3;
    u_ = num2str(u_opt_); % m/s
    H_ = num2str(H_min_); %um
    set(handles.edit8,'String',u_);
    set(handles.edit9,'String',H_);
    
    figure;
    plot(u_m.*1e3,H.*1e3,'-');
    xlabel('Linear flow velocity (mm/s)');
    ylabel('Theoretical plate height (mm)');
    %axis([0 10 0 10]);
    end
    
    if pp == 3 % Reduced Golay
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        
        % Convert to numbers
        df = str2double(a);
        k = str2double(b);
        
        % Limitations
        if df <=0, error('Irregular value');end
        if k <=0, error('Irregular value');end
        if k == 1, error('Irregular value');end
        
        % Calculations
        N = 1000;
        v = linspace(0.001,10,N)';
        f = ((11*k^2)+(6*k)+1)/(96*((1+k)^2));
        g = (2*k)/(3*((1+k)^2));
        h = (2./v)+(f.*v)+(g.*df^2.*v);
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = L(r,1);
        
        % Output
        h_ = num2str(h_min);
        v_ = num2str(v_opt);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 10 0 (h_min+10)]);
    end
end

if vv == 7; % SFC packed column
    
    qq = get(handles.parameters,'Value');
    
    if qq == 2 % Normal Van Deemter
    
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        c = get(handles.edit3,'String');
        d = get(handles.edit4,'String');
        e = get(handles.edit5,'String');
            
        % Convert strings to numbers
        dp_ = str2double(a);
        D_ = str2double(b);
        A = str2double(c);
        B = str2double(d);
        C = str2double(e);
        
        % Convert values to right units
        dp = dp_/1e6;
        D = D_/1e8;
        
        % Limitations
        if dp<=0, error('Irregular value');end
        if D<=0, error('Irregular value');end
        if A<0, error('Irregular value');end
        if B<0, error('Irregular value');end
        if C<0, error('Irregular value');end
                
        % Calculations
        N = 100000;% number of data points
        u_m = linspace(0.001,0.1,N)';% m/s
        H_m = (A.*dp)+((B.*D)./u_m)+(C.*((dp.^2).*u_m)./D);% plate height in meters
        H_min = min(H_m);% plate height in meters
        u_opt = (-B.*D)./(C.*(dp.^2)+ A.*dp-H_min); %m/s
                        
        % Output values
        u_ = num2str(u_opt);
        H_ = num2str(H_min*1e6);
        set(handles.edit9,'String',H_);
        set(handles.edit8,'String',u_);
        
        figure;
        plot(u_m,H_m.*1e6,'-');
        xlabel('Linear flow velocity (m/s)');
        ylabel('Theoretical plate height ( \mu m)');
        axis([0 0.1 0 10]);
    end
    
    if qq == 3 % Reduced Van Deemter
        
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        c = get(handles.edit3,'String');
        
        % Convert strings to numbers
        A = str2double(a);
        B = str2double(b);
        C = str2double(c);
        
        % Limitations
        if A < 0, error('Irregular value');end
        if B < 0, error('Irregular value');end
        if C < 0, error('Irregular value');end
        
        % Calculations
        v = linspace(0.001,20,100000)';
        h = A + B./v + C.*v;
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = (L(r,1));
        
        % Output
        v_ = num2str(v_opt);
        h_ = num2str(h_min);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 20 0 (h_min+10)]);
    end
    
    if qq == 4 % Knox
        
        % Obtain values
        a = get(handles.edit1,'String');
        b = get(handles.edit2,'String');
        c = get(handles.edit3,'String');
        
        % Convert strings to numbers
        A = str2double(a);
        B = str2double(b);
        C = str2double(c);
        
        % Limitations
        if A < 0, error('Irregular value');end
        if B < 0, error('Irregular value');end
        if C < 0, error('Irregular value');end
        
        % Calculations
        v = linspace(0.001,10,100000)';
        h = A.*v.^(1/3) + B./v + C.*v;
        h_min = min(h);
        L = [v h];
        r = find(L(:,2) == h_min);
        v_opt = (L(r,1));
        
        % Output
        v_ = num2str(v_opt);
        h_ = num2str(h_min);
        set(handles.edit8,'String',v_);
        set(handles.edit9,'String',h_);
        
        figure;
        plot(v,h,'-');
        xlabel('Reduced velocity');
        ylabel('Reduced plate height');
        axis([0 10 0 (h_min+10)]);
    end
  
end
    
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in parameters.
function parameters_Callback(hObject, eventdata, handles)
% hObject    handle to parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns parameters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from parameters

m = get(handles.chrom,'Value');
q = get(handles.parameters,'Value');
   if q == 1; 
   end
   
   if m == 3 % LC Packed column
   
        if q == 2;% Normal Van Deemter
        set(handles.text1,'String','Particle size (um)');
        set(handles.text2,'String','Column diameter (mm)');
        set(handles.text3,'String','Diffusion coefficient (1e-9 m2/s)');
        set(handles.text4,'String','Volume fraction');
        set(handles.text5,'String','A-term');
        set(handles.text6,'String','B-term');
        set(handles.text7,'String','C-term');
        
        set(handles.text4,'Visible','on');
        set(handles.text5,'Visible','on');
        set(handles.text6,'Visible','on');
        set(handles.text7,'Visible','on');
        set(handles.edit4,'Visible','on');
        set(handles.edit5,'Visible','on');
        set(handles.edit6,'Visible','on');
        set(handles.edit7,'Visible','on');
        
        set(handles.text8,'String','Optimal flow rate (mL/min)');
        set(handles.text9,'String','Optimal linear velocity (m/s)');
        set(handles.text10,'Visible','on');
        set(handles.text10,'String','Minimal plate height (um)');
        set(handles.edit10,'Visible','on');
        
        set(handles.dm,'Visible','on');
        set(handles.abc,'Visible','on');
        end
   end
   
   if m == 5 % GC Packed column
       if q == 2;% Normal Van Deemter
        set(handles.text1,'String','Particle size (um)');
        set(handles.text2,'String','Diffusion coefficient (1e-6 m2/s)');
        set(handles.text3,'String','A-term');
        set(handles.text4,'String','B-term');
        set(handles.text5,'String','C-term');
        
        set(handles.text4,'Visible','on');
        set(handles.text5,'Visible','on');
        set(handles.text6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit4,'Visible','on');
        set(handles.edit5,'Visible','on');
        set(handles.edit6,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.text8,'String','Optimal linear velocity (m/s)');
        set(handles.text10,'Visible','off');
        set(handles.text9,'String','Minimal plate height (mm)');
        set(handles.edit10,'Visible','off');
        
        set(handles.dm,'Visible','on');
        set(handles.abc,'Visible','on');
        end
   end
   
   if m == 7 % SFC Packed column
       
       if q == 2;% Normal Van Deemter
        set(handles.text1,'String','Particle size (um)');
        set(handles.text2,'String','Diffusion coefficient (1e-8 m2/s)');
        set(handles.text3,'String','A-term');
        set(handles.text4,'String','B-term');
        set(handles.text5,'String','C-term');
        
        set(handles.text4,'Visible','on');
        set(handles.text5,'Visible','on');
        set(handles.text6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit4,'Visible','on');
        set(handles.edit5,'Visible','on');
        set(handles.edit6,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.text8,'String','Optimal linear velocity (m/s)');
        set(handles.text10,'Visible','off');
        set(handles.text9,'String','Minimal plate height (um)');
        set(handles.edit10,'Visible','off');
        
        set(handles.dm,'Visible','on');
        set(handles.abc,'Visible','on');
       end
   end   
        if q == 3; % Reduced Van Deemter
        
        set(handles.text1,'String','A-term');
        set(handles.text2,'String','B-term');
        set(handles.text3,'String','C-term');
        set(handles.text4,'Visible','off');
        set(handles.text5,'Visible','off');
        set(handles.text6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit4,'Visible','off');
        set(handles.edit5,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.edit7,'Visible','off');
       
        set(handles.text8,'String','Reduced velocity');
        set(handles.text9,'String','Reduced plate height');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
        
        set(handles.dm,'Visible','off');
        set(handles.abc,'Visible','on');
        end
   
        if q == 4; % Reduced Knox
       
        set(handles.text1,'String','A-term');
        set(handles.text2,'String','B-term');
        set(handles.text3,'String','C-term');
        set(handles.text4,'Visible','off');
        set(handles.text5,'Visible','off');
        set(handles.text6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit4,'Visible','off');
        set(handles.edit5,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.edit7,'Visible','off');
       
        set(handles.text8,'String','Reduced velocity');
        set(handles.text9,'String','Reduced plate height');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
        
        set(handles.dm,'Visible','off');
        set(handles.abc,'Visible','on');
        end

% --- Executes during object creation, after setting all properties.
function parameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in abc.
function abc_Callback(hObject, eventdata, handles)
% hObject    handle to abc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

zz = get(handles.chrom,'Value');

if zz == 3, h = msgbox({'A = 2' 'B = 1' 'C = 0.01-0.3'},'Values for A, B and C','help');end

if zz == 5, msgbox({'A ~ 2*particle size ' 'B ~ 2*(Diffusion coefficient analyte in gas phase)' 'C ~ 0.81*(k/(1+k))'}, 'Values for A, B and C','help');end

if zz == 7, msgbox({'A ~ 2*particle size ' 'B ~ 2*(Diffusion coefficient analyte in gas phase)' 'C ~ 0.81*(k/(1+k))'}, 'Values for A, B and C','help');end

% --- Executes on selection change in parameters2.
function parameters2_Callback(hObject, eventdata, handles)
% hObject    handle to parameters2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns parameters2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from parameters2

l = get(handles.chrom,'Value');
p = get(handles.parameters2,'Value');

if l == 2
    if p == 1
    end

    if p == 2 % Golay equation
        set(handles.text1,'String','Film thickness (um)');
        set(handles.text2,'String','Column diameter (um)');
        set(handles.text3,'String','Diffusion coefficient (mobile phase) (1e-9 m2/s)');
        set(handles.text4,'String','Diffusion coefficient (film) (1e-11 m2/s)');
        set(handles.text5,'String','Expected retention factor');
        set(handles.text3,'Visible','on');
        set(handles.edit3,'Visible','on');
        set(handles.text4,'Visible','on');
        set(handles.edit4,'Visible','on');
        set(handles.text5,'Visible','on');
        set(handles.edit5,'Visible','on');
        set(handles.text6,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.parameters,'Visible','off');
        set(handles.abc,'Visible','off');
        set(handles.dm,'Visible','on');
   
        set(handles.text8,'String','Optimal linear velocity (um/s)');
        set(handles.text9,'String','Minimal plate height (um)');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
    end


    if p == 3 % Reduced Golay
        set(handles.text1,'String','Reduced film thickness');
        set(handles.text2,'String','Expected retention factor');
        
        set(handles.text3,'Visible','off');
        set(handles.edit3,'Visible','off');
        set(handles.text4,'Visible','off');
        set(handles.edit4,'Visible','off');
        set(handles.text5,'Visible','off');
        set(handles.edit5,'Visible','off');
        set(handles.text6,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.parameters,'Visible','off');
        set(handles.abc,'Visible','off');
        set(handles.dm,'Visible','off');
        
        set(handles.text8,'String','Optimal reduced velocity');
        set(handles.text9,'String','Reduced plate height');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
        
    end

end

if l == 4 % Open column GC
    if p == 1
    end
    
    if p == 2 % Golay equation
        set(handles.text1,'String','Film thickness (um)');
        set(handles.text2,'String','Column diameter (mm)');
        set(handles.text3,'String','Diffusion coefficient (mobile phase) (1e-6 m2/s)');
        set(handles.text4,'String','Diffusion coefficient (film) (1e-11 m2/s)');
        set(handles.text5,'String','Expected retention factor');
        set(handles.text3,'Visible','on');
        set(handles.edit3,'Visible','on');
        set(handles.text4,'Visible','on');
        set(handles.edit4,'Visible','on');
        set(handles.text5,'Visible','on');
        set(handles.edit5,'Visible','on');
        set(handles.text6,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.dm,'Visible','on');
        set(handles.parameters,'Visible','off');
        set(handles.abc,'Visible','off');
   
        set(handles.text8,'String','Optimal linear velocity (m/s)');
        set(handles.text9,'String','Minimal plate height (mm)');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
    end
    
    if p == 3 % Reduced Golay
        set(handles.text1,'String','Reduced film thickness');
        set(handles.text2,'String','Expected retention factor');
        
        set(handles.text3,'Visible','off');
        set(handles.edit3,'Visible','off');
        set(handles.text4,'Visible','off');
        set(handles.edit4,'Visible','off');
        set(handles.text5,'Visible','off');
        set(handles.edit5,'Visible','off');
        set(handles.text6,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.parameters,'Visible','off');
        set(handles.abc,'Visible','off');
        set(handles.dm,'Visible','off');
        
        set(handles.text8,'String','Optimal reduced velocity');
        set(handles.text9,'String','Reduced plate height');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
    end
end

if l == 6 % Open column SFC
    
    if p == 2 % Golay equation
        set(handles.text1,'String','Film thickness (um)');
        set(handles.text2,'String','Column diameter (um)');
        set(handles.text3,'String','Diffusion coefficient (mobile phase) (1e-8 m2/s)');
        set(handles.text4,'String','Diffusion coefficient (film) (1e-11 m2/s)');
        set(handles.text5,'String','Expected retention factor');
        set(handles.text3,'Visible','on');
        set(handles.edit3,'Visible','on');
        set(handles.text4,'Visible','on');
        set(handles.edit4,'Visible','on');
        set(handles.text5,'Visible','on');
        set(handles.edit5,'Visible','on');
        set(handles.text6,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit7,'Visible','off');
        set(handles.parameters,'Visible','off');
        set(handles.abc,'Visible','off');
        set(handles.dm,'Visible','on');
   
        set(handles.text8,'String','Optimal linear velocity (mm/s)');
        set(handles.text9,'String','Minimal plate height (mm)');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
    end
    
    if p == 1 
    end
    
    if p == 3 % Reduced Golay
        set(handles.text1,'String','Reduced film thickness');
        set(handles.text2,'String','Expected retention factor');
        
        set(handles.text3,'Visible','off');
        set(handles.edit3,'Visible','off');
        set(handles.text4,'Visible','off');
        set(handles.edit4,'Visible','off');
        set(handles.text5,'Visible','off');
        set(handles.edit5,'Visible','off');
        set(handles.text6,'Visible','off');
        set(handles.edit6,'Visible','off');
        set(handles.text7,'Visible','off');
        set(handles.edit7,'Visible','off');
        
        set(handles.parameters,'Visible','off');
        set(handles.abc,'Visible','off');
        set(handles.dm,'Visible','off');
        
        set(handles.text8,'String','Optimal reduced velocity');
        set(handles.text9,'String','Reduced plate height');
        set(handles.text10,'Visible','off');
        set(handles.edit10,'Visible','off');
    end
end

% --- Executes during object creation, after setting all properties.
function parameters2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameters2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dm.
function dm_Callback(hObject, eventdata, handles)
% hObject    handle to dm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = get(handles.chrom,'Value');

if s == 2 || s == 3
   msgbox({'MeOH: 2.369e-9 m2/s' 'ACN: 1.64e-9 m2/s'},'Diffusion coefficients','help');
end

if s == 4 || s == 5
   msgbox('Diffusion coeffcients are of the order of 1e-6 m2/s','Diffusion coefficients','help');
end

if s == 6 || s == 7
   msgbox({'CO2: 2.28035e-8 m2/s'},'Diffusion coefficients','help');
end
