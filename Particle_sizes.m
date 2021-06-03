


function [Length,Ni_nos,YSZ_nos,L_micro,Ni_size,YSZ_size,B_Ni,B_YSZ,B_Pore,B_Lines] = Particle_sizes(B,kn,P,Im_side)

NI = 150; % Ni Green
YSZ = 76; % YSZ Red

[~,V_YSZ,V_Ni] = Volume_fraction(B);

Ni_nos = 0;
YSZ_nos = 0; 
Length = 0; % The total length of the lines

B_Lines = B; % Temporary image with the generated lines plotted for visualisation


% Logical values used for colors Black and Whilte in this section as bwopen changes figure into logical
% values
WHITE = 1;
BLACK = 0;

% eliminate YSZ from image making it black

B_Ni = B;
B_Ni(B_Ni == YSZ) = BLACK;

% Convert the image to binary black and white 

B_Ni(B_Ni == NI) = WHITE;

% Remove particles less than P pixels from images so that the particle
% counting is not affected by these

B_Ni = bwareaopen(B_Ni,P);
B_Ni = imcomplement(B_Ni);
B_Ni = bwareaopen(B_Ni,P);
B_Ni = imcomplement(B_Ni);

% eliminate Ni from image making it black

B_YSZ = B;
B_YSZ(B_YSZ == NI) = BLACK;

% Convert the image to binary black and white 

B_YSZ(B_YSZ == YSZ) = WHITE;

% Remove particles less than P pixels from images so that the particle
% counting is not affected by these

B_YSZ = bwareaopen(B_YSZ,P);
B_YSZ = imcomplement(B_YSZ);
B_YSZ = bwareaopen(B_YSZ,P);
B_YSZ = imcomplement(B_YSZ);


% eliminate YSZ and Ni from image making it black and pore white

B_Pore = B;
B_Pore(B_Pore == BLACK) = WHITE;
B_Pore(B_Pore ~= WHITE) = BLACK;


% Remove particles less than P pixels from images so that the particle
% counting is not affected by these

B_Pore = bwareaopen(B_Pore,P);
B_Pore = imcomplement(B_Pore);
B_Pore = bwareaopen(B_Pore,P);
B_Pore = imcomplement(B_Pore);


% % % % Lines starting from left edge
for k = 1:kn


Angle_low = 1; % in degrees
Angle_high = 359; % in degrees
 
y_low = 1; 
y_high = size(B,1);


% Random seed for the angles 

Angle = Angle_low  +  (Angle_high - Angle_low) * rand;


% Random seed for the starting points along the left edge of image (row
% index to be randomly generated)


y = y_low  +  (y_high - y_low) * rand;

x = 1;

x1 = x;
y1 = y;

% Initialising end point of the lines


x2_ini = size(B,2)+50;
y2_ini = tand(Angle) * (x2_ini - x1) + y1;


% Calculation of the end points based on intersection with image edges

if (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) <= size(B,2) && (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) >= 1

 x2 = (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 );
 y2 = 1;
 
elseif ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) <= size(B,2) && ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) >= 1
     
    
 x2 = ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 );
 y2 = size(B,1);
 

 elseif ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) >= 1 && ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) <= size(B,1) 

 x2 = size(B,2);
 y2 = ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ); 
     
end

     
xn = abs(x2-x1);
yn = abs(y2-y1);

% interpolate against axis with greater distance between points;
% this guarantees statement in the under the first point.

if (xn > yn)
    xc = x1 : sign(x2-x1) : x2;
    yc = round( interp1([x1 x2], [y1 y2], xc, 'linear') );
else
    yc = y1 : sign(y2-y1) : y2;
    xc = round( interp1([y1 y2], [x1 x2], yc, 'linear') );
end


xc = round(xc);
yc = round(yc);


% Convert coordinates into matrix indices
% 

Rows = size(B,1) - yc+1;
Cols = xc;

idx = sub2ind(size(B),Rows,Cols);

B_Lines(idx) = 255; % This image will display the lines


% Calculating the length of the lines

Length = Length + sqrt((x2 - x1)^2 + (y2-y1)^2);


% Counting the number of particles

    if (B_Ni(idx(1)) == WHITE)
    
Ni_nos = Ni_nos + 1;

    end

    if (B_YSZ(idx(1)) == WHITE)
    
YSZ_nos = YSZ_nos + 1;

    end
    

for i = 1:size(idx,2)-1
    
    
    if (B_Ni(idx(i)) == BLACK) && (B_Ni(idx(i+1)) == WHITE )


Ni_nos = Ni_nos + 1;

    end
    
    if (B_YSZ(idx(i)) == BLACK) && (B_YSZ(idx(i+1)) == WHITE) 


YSZ_nos = YSZ_nos + 1;

    end

end

clear xc yc idx

end


% Lines starting from bottom edge
for k = 1:kn

Angle_low = 1; % in degrees
Angle_high = 359; % in degrees
 
x_low = 1; 
x_high = size(B,2);


% Random seed for the angles 

Angle = Angle_low  +  (Angle_high - Angle_low) * rand;


% Random seed for the starting points along the left edge of image (row
% index to be randomly generated)


x = x_low  +  (x_high - x_low) * rand;

y = 1;

x1 = x;
y1 = y;


% Initialising end point of the lines

y2_ini = size(B,1)+50;
x2_ini = (1/tand(Angle)) * (y2_ini - y1) + x1;


% Calculation of the end points based on intersection with image edges

if ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) <= size(B,1) && ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) >= 1

 x2 = 1;
 y2 = ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 );
 
 
elseif ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) <= size(B,2) && ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) >= 1

 x2 = ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 );
 y2 = size(B,1);
 

 elseif ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) <= size(B,1) && ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) >= 1 

 x2 = size(B,2);
 y2 = ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ); 
     
end


xn = abs(x2-x1);
yn = abs(y2-y1);

% interpolate against axis with greater distance between points;
% this guarantees statement in the under the first point!
if (xn > yn)
    xc = x1 : sign(x2-x1) : x2;
    yc = round( interp1([x1 x2], [y1 y2], xc, 'linear') );
else
    yc = y1 : sign(y2-y1) : y2;
    xc = round( interp1([y1 y2], [x1 x2], yc, 'linear') );
end


xc = round(xc);
yc = round(yc);


% Convert coordinates into matrix indices
% 

Rows = size(B,1) - yc+1;
Cols = xc;

idx = sub2ind(size(B),Rows,Cols);

B_Lines(idx) = 255; % This image will display the lines


% Calculating the length of the lines

Length = Length + sqrt((x2 - x1)^2 + (y2-y1)^2);


% Counting the number of particles

    if (B_Ni(idx(1)) == WHITE)
    
Ni_nos = Ni_nos + 1;

    end

    if (B_YSZ(idx(1)) == WHITE)
    
YSZ_nos = YSZ_nos + 1;

    end
    

for i = 1:size(idx,2)-1
    
    
    if (B_Ni(idx(i)) == BLACK) && (B_Ni(idx(i+1)) == WHITE )


Ni_nos = Ni_nos + 1;

    end
    
    if (B_YSZ(idx(i)) == BLACK) && (B_YSZ(idx(i+1)) == WHITE) 


YSZ_nos = YSZ_nos + 1;

    end

end


clear xc yc idx

end


 
% % Lines starting from top edge
for k = 1:kn


Angle_low = 1; % in degrees
Angle_high = 359; % in degrees
 
x_low = 1; 
x_high = size(B,2);


% Random seed for the angles 

Angle = Angle_low  +  (Angle_high - Angle_low) * rand;


% Random seed for the starting points along the left edge of image (row
% index to be randomly generated)


x = x_low  +  (x_high - x_low) * rand;

y = size(B,1);

x1 = x;
y1 = y;


% Initialising end point of the lines

y2_ini = -50;
x2_ini = (1/tand(Angle)) * (y2_ini - y1) + x1;


% Calculation of the end points based on intersection with image edges


if ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) <= size(B,1) && ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) >= 1

 x2 = 1;
 y2 = ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 );
 

elseif (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) <= size(B,2) && (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) >= 1

 x2 = (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 );
 y2 = 1;

 elseif ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) <= size(B,1) && ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) >= 1 

 x2 = size(B,2);
 y2 = ((size(B,2)-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ); 


end



xn = abs(x2-x1);
yn = abs(y2-y1);

% interpolate against axis with greater distance between points;
% this guarantees statement in the under the first point!
if (xn > yn)
    xc = x1 : sign(x2-x1) : x2;
    yc = round( interp1([x1 x2], [y1 y2], xc, 'linear') );
else
    yc = y1 : sign(y2-y1) : y2;
    xc = round( interp1([y1 y2], [x1 x2], yc, 'linear') );
end




xc = round(xc);
yc = round(yc);


% Convert coordinates into matrix indices
% 

Rows = size(B,1) - yc+1;
Cols = xc;

idx = sub2ind(size(B),Rows,Cols);

B_Lines(idx) = 255; % This image will display the lines


% Calculating the length of the lines

Length = Length + sqrt((x2 - x1)^2 + (y2-y1)^2);


% Counting the number of particles

    if (B_Ni(idx(1)) == WHITE)
    
Ni_nos = Ni_nos + 1;

    end

    if (B_YSZ(idx(1)) == WHITE)
    
YSZ_nos = YSZ_nos + 1;

    end
    

for i = 1:size(idx,2)-1
    
    
    if (B_Ni(idx(i)) == BLACK) && (B_Ni(idx(i+1)) == WHITE )


Ni_nos = Ni_nos + 1;

    end
    
    if (B_YSZ(idx(i)) == BLACK) && (B_YSZ(idx(i+1)) == WHITE) 


YSZ_nos = YSZ_nos + 1;

    end

end


clear xc yc idx

end


%%% Lines starting from the right edge

for k = 1:kn


Angle_low = 1; % in degrees
Angle_high = 359; % in degrees
 
y_low = 1; 
y_high = size(B,1);


% Random seed for the angles 

Angle = Angle_low  +  (Angle_high - Angle_low) * rand;


% Random seed for the starting points along the left edge of image (row
% index to be randomly generated)


y = y_low  +  (y_high - y_low) * rand;

x = size(B,2);

x1 = x;
y1 = y;


% Initialising end point of the lines


x2_ini = -50;
y2_ini = tand(Angle) * (x2_ini - x1) + y1;


% Calculation of the end points based on intersection with image edges

if (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) <= size(B,2) && (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) >= 1

 x2 = (-y1 * ((x2_ini-x1)/(y2_ini-y1))+ x1 );
 y2 = 1;
 
elseif ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) <= size(B,2) && ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 ) >= 1
     
    
 x2 = ((size(B,1)-y1) * ((x2_ini-x1)/(y2_ini-y1))+ x1 );
 y2 = size(B,1);

elseif ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) <= size(B,1) && ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 ) >= 1

 x2 = 1;
 y2 = ((-x1) * ((y2_ini-y1)/(x2_ini-x1))+ y1 );
 
end
 
  
xn = abs(x2-x1);
yn = abs(y2-y1);

% interpolate against axis with greater distance between points;
% this guarantees statement in the under the first point!
if (xn > yn)
    xc = x1 : sign(x2-x1) : x2;
    yc = round( interp1([x1 x2], [y1 y2], xc, 'linear') );
else
    yc = y1 : sign(y2-y1) : y2;
    xc = round( interp1([y1 y2], [x1 x2], yc, 'linear') );
end


xc = round(xc);
yc = round(yc);


% Convert coordinates into matrix indices
% 

Rows = size(B,1) - yc+1;
Cols = xc;

idx = sub2ind(size(B),Rows,Cols);

B_Lines(idx) = 255; % This image will display the lines


% Calculating the length of the lines

Length = Length + sqrt((x2 - x1)^2 + (y2-y1)^2);


% Counting the number of particles

    if (B_Ni(idx(1)) == WHITE)
    
Ni_nos = Ni_nos + 1;

    end

    if (B_YSZ(idx(1)) == WHITE)
    
YSZ_nos = YSZ_nos + 1;

    end
    

for i = 1:size(idx,2)-1
    
    
    if (B_Ni(idx(i)) == BLACK) && (B_Ni(idx(i+1)) == WHITE )


Ni_nos = Ni_nos + 1;

    end
    
    if (B_YSZ(idx(i)) == BLACK) && (B_YSZ(idx(i+1)) == WHITE) 


YSZ_nos = YSZ_nos + 1;

    end

end

clear xc yc idx

end


L_micro = Length * (Im_side/size(B,1));  %Total line length in micrometers


Ni_size =  1.5 * L_micro * V_Ni / Ni_nos ;       % in micometers
YSZ_size = 1.5 *  L_micro * V_YSZ / YSZ_nos;     % in micometers