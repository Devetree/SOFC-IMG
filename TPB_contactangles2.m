
function [I_TPB,Angle_mat,Theta_YSZ_avg,Theta_NI_avg,Theta_PORE_avg,TPB,TPB_points] = TPB_contactangles2(B,Im_side)

NI = 150; % Ni Green
YSZ = 76; % YSZ Red
PORE = 0; % Pore Black

%%%%%%%%%%%%%%%%%%% Initial TPB calculation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



TPB_points = 0;
I_TPB = B;



% converting angles to 0 to 360 degree scale


for j = 1:size(B,2)-1
    
for i = 1:size(B,1)-1
    
str_el = B(i:i+1,j:j+1);

if length(str_el(str_el == PORE)) >= 1 && length(str_el(str_el == YSZ)) >= 1 && length(str_el(str_el == NI)) >= 1
    
I_TPB(i:i+1,j:j+1) = 255;

TPB_points = TPB_points + 1;

end

end

end


% Calculation of the contact angles



Angle_mat = zeros(TPB_points,3);

Theta_YSZ = 0; 
Theta_NI = 0;
Theta_PORE = 0;
TPB_points1 = 0; % updated number of TPB points


for p = 1:size(B,1)-4

for q = 1:size(B,2)-4
    
% Searching around the TPB points to identify phase interfaces and calculate angles


   if I_TPB(p:p+1,q:q+1)== 255
       
       clear xyz xyz1 abcd uvw
       
       xyz = [];
       xyz1 = [];
       abcd = [];
       uvw = [];
       
       % Searching around the 0th layer
    
i = p;
j = q;

m = 0;
     

      j = j+1;       
 
   if i > 0 && j > 1 && B(i,j) ~= B(i,j-1)
       
       
        m = m+1;
       
       
       xyz(m,1) = i;
       xyz(m,2) = j;
       xyz(m,3) = B(i,j);           


   end
   


         

     i = i+1;     
       
      if i > 1 && j > 0 && B(i,j) ~= B(i-1,j)
       
              m = m+1;
  
       xyz(m,1) = i;
       xyz(m,2) = j;
       xyz(m,3) = B(i,j);
       

       end
   


      
       
         j = j-1;
   if i > 0 && j > 0 && j~= size(B,2) &&   B(i,j) ~= B(i,j+1)
       
       m = m+1;
        
       xyz(m,1) = i;
       xyz(m,2) = j;
       xyz(m,3) = B(i,j);
                  

   end
    

      
      

         i = i-1;
       
       if i > 0 && j > 0  && i~= size(B,1) && B(i,j) ~= B(i+1,j)
         
       m = m+1;
       
       xyz(m,1) = i;
       xyz(m,2) = j;
       xyz(m,3) = B(i,j); 
                  
       end
   
           
 
     
 % Sweep through the 3rd layer
 
 
    
i = p-3;
j = q-3;


m = 0;
     
for k = 1:7 
       
      j = j+1;       
 
   if i > 0 && j > 1 && B(i,j) ~= B(i,j-1)
       
       
        m = m+1;
      
  
       xyz1(m,1) = i;
       xyz1(m,2) = j;
       xyz1(m,3) = B(i,j);           


   end
   

end
   
         
      for k = 1:7
     i = i+1;     
       
      if i > 1 && j > 0 && B(i,j) ~= B(i-1,j)
       
              m = m+1;

                 
 
       xyz1(m,1) = i;
       xyz1(m,2) = j;
       xyz1(m,3) = B(i,j);
       

       end
   

      end
      
      
      for k = 1:7
       
         j = j-1;
   if i > 0 && j > 0 && j~= size(B,2) &&   B(i,j) ~= B(i,j+1)
       
                     m = m+1;
       
 
       xyz1(m,1) = i;
       xyz1(m,2) = j;
       xyz1(m,3) = B(i,j);
                  

   end
    
      end
      
      
            for k = 1:7
         i = i-1;
       
       if i > 0 && j > 0  && i~= size(B,1) && B(i,j) ~= B(i+1,j)
  
       
       m = m+1;
       
       xyz1(m,1) = i;
       xyz1(m,2) = j;
       xyz1(m,3) = B(i,j); 
                  
       end
   
            end
          

            % ---------------------------------------------------------
            % Calculation of the angles
            
         m = 0;     
  if  size(xyz,1) == 3 &&  size(xyz1,1) == 3
    
       
      for pp = 1:3
          for qq = 1:3
             
              if xyz(pp,3) == xyz1(qq,3)
                  
                  m = m + 1;
                  
                  x1 = xyz(pp,2);
                  y1 = size(B,1) - xyz(pp,1) + 1;
                  
                  x2 = xyz1(qq,2);
                  y2 = size(B,1) - xyz1(qq,1) + 1;
                  
                  
                  Ang = atan2d(y2-y1,x2-x1);
  
          
          if Ang <0
              
              Ang = 360 + Ang;
              
          end
          
          
          uvw(m,1) = Ang;
          uvw(m,2) = xyz(pp,3);
          
            
              end
          end
      end
            
  end         
                     
            
            
 if  size(uvw,1) == 3

    Th_YSZ = NaN;
    Th_NI = NaN;
    Th_PORE = NaN;
    abcd = uvw(:,1);

        
        Alph1 = min(abcd);
        Alph2 = min(abcd(abcd > min(abcd)));
        Alph3 = max(abcd);
        

       
      for k = 1:3
        
        if uvw(k,1) == Alph1 && uvw(k,2) == YSZ
            
            Theta_YSZ = Theta_YSZ + (360-Alph3+Alph1);
            
            Th_YSZ = (360-Alph3+Alph1);
            
        elseif uvw(k,1) == Alph1 && uvw(k,2) == NI 
            
            Theta_NI = Theta_NI + (360-Alph3+Alph1);
            
            Th_NI = (360-Alph3+Alph1);
            
            elseif uvw(k,1) == Alph1 && uvw(k,2) == PORE
            
            Theta_PORE = Theta_PORE + (360-Alph3+Alph1);
            
                 Th_PORE = (360-Alph3+Alph1);     
            
        elseif uvw(k,1) == Alph2 && uvw(k,2) == YSZ
            
            Theta_YSZ = Theta_YSZ + (Alph2-Alph1);
            
            Th_YSZ = (Alph2-Alph1);
            
        elseif uvw(k,1) == Alph2 && uvw(k,2) == NI
            
            Theta_NI = Theta_NI + (Alph2-Alph1);
            
            Th_NI = (Alph2-Alph1);
            
            elseif uvw(k,1) == Alph2 && uvw(k,2) == PORE
            
            Theta_PORE = Theta_PORE + (Alph2-Alph1);
            
            Th_PORE = (Alph2-Alph1);
            
            elseif uvw(k,1) == Alph3 && uvw(k,2) == YSZ
            
            Theta_YSZ = Theta_YSZ + (Alph3-Alph2);
            
             Th_YSZ = (Alph3-Alph2);
            
            elseif uvw(k,1) == Alph3 && uvw(k,2) == NI
            
            Theta_NI = Theta_NI + (Alph3-Alph2);
            
            Th_NI = (Alph3-Alph2);
    
            elseif uvw(k,1) == Alph3 && uvw(k,2) == PORE
            
            Theta_PORE = Theta_PORE + (Alph3-Alph2);
            
            Th_PORE = (Alph3-Alph2);
                                         
         end
            
       end
        
     TPB_points1=TPB_points1+1;
      
      
     Angle_mat(TPB_points1,1) = Th_YSZ;
     Angle_mat(TPB_points1,2) = Th_NI;
     Angle_mat(TPB_points1,3) = Th_PORE;
     
 
 end


 
   end
   
end
end



Theta_YSZ_avg = Theta_YSZ/TPB_points1;
Theta_NI_avg = Theta_NI/TPB_points1;
Theta_PORE_avg = Theta_PORE/TPB_points1;


TPB = 2 * TPB_points / (Im_side * Im_side);   % TPB initial