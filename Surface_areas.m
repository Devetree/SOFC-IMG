

function [S_Ni,S_YSZ,S_Pore,S_Ni_YSZ,S_Ni_Pore,S_YSZ_Pore,B_Ni_peri,B_YSZ_peri,B_Pore_peri] = Surface_areas(B_Ni,B_YSZ,B_Pore,Im_side)

B_Ni_peri = bwperim(B_Ni);
Ni_peri = sum(B_Ni_peri(:));


B_YSZ_peri = bwperim(B_YSZ);
YSZ_peri = sum(B_YSZ_peri(:));


B_Pore_peri = bwperim(B_Pore);
Pore_Peri = sum(B_Pore_peri(:));


% convert from pixels to micrometers

Ni_peri = Ni_peri * (Im_side/size(B_Ni,1));
YSZ_peri = YSZ_peri * (Im_side/size(B_YSZ,1));
Pore_Peri = Pore_Peri * (Im_side/size(B_Pore,1));


% Calculate individual surface areas

S_Ni = (4/pi)*(Ni_peri/(Im_side * Im_side));
S_YSZ = (4/pi)*(YSZ_peri/(Im_side * Im_side));
S_Pore = (4/pi)*(Pore_Peri/(Im_side * Im_side));

S_Ni_YSZ = (S_Ni+S_YSZ-S_Pore)/2;
S_Ni_Pore = (S_Ni-S_YSZ+S_Pore)/2;
S_YSZ_Pore = (S_YSZ+S_Pore-S_Ni)/2;
