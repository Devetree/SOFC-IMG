
function [T1,T2,V_pore1,V_YSZ1,V_Ni1,V_pore2,V_YSZ2,V_Ni2,B] = Threshold_adjust(I,V_pore_ori,Err_tol)

% Multilevel image thresholds using Otsu�s method

thresh = multithresh(I,2);
L = imquantize(I,thresh);
B = label2rgb(L,[0 0 0;1 0 0;0 1 0]);
B = rgb2gray(B);

% % Volume fraction calculation


[V_pore1,V_YSZ1,V_Ni1] = Volume_fraction(B);


T1 = thresh(1);
T2 = thresh(2);

T1 = double(T1);
T2 = double(T2);

% Error in the volume fractions

E_V_pore = V_pore_ori  - V_pore1;

E_V_pore1 = E_V_pore;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inc = 1;

    Lam = 1;
   V_pore2_pre = 0;
    
   
    while (abs(E_V_pore) > Err_tol ) && inc > 0.001 && Lam ~= 0
        

               if sign(E_V_pore1) ~= sign(E_V_pore)
                   
                   inc = inc/2;
                   
               end
        
       E_V_pore1 = E_V_pore;
       
       
    if E_V_pore > 0 
        
     T1 = T1 + inc;
     
          
        elseif E_V_pore < 0 
    
     T1 = T1 - inc;

    end
    
        
      
L = imquantize(I,[T1 T2]);
B = label2rgb(L,[0 0 0;1 0 0;0 1 0]);
B = rgb2gray(B);

% % Volume fraction calculation


[V_pore2,~,~] = Volume_fraction(B);


% Error in the volume fractions

E_V_pore = V_pore_ori  - V_pore2;


Lam = V_pore2 - V_pore2_pre;

V_pore2_pre = V_pore2;


    end

if (abs(E_V_pore) > Err_tol )
    
errordlg('The specified error tolerance could not be achieved','Warning!');
%     message = sprintf('Warning! /n The specified error tolerance could not be achieved');
%     msgbox(message);

end

[V_pore2,V_YSZ2,V_Ni2] = Volume_fraction(B);

B = label2rgb(L,[0 0 0;1 0 0;0 1 0]);
B = rgb2gray(B);


