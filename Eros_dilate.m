


function [V_pore,V_YSZ,V_Ni,B] = Eros_dilate(B,r)


se = strel('disk',r); % Structuring element

% B =imclose(B,se);

% imclose gives the same result as first dilating and then eroding the
% image with the structuring element


B = imdilate(B,se);
B = imerode(B,se);



% % Volume fraction calculation
% 

[V_pore,V_YSZ,V_Ni] = Volume_fraction(B);