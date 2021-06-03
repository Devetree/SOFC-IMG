

function [V_pore,V_YSZ,V_Ni,B] = Sweep_fill(B,jump,Del)
  
 
NI = 150; % Ni Green
YSZ = 76; % YSZ Red
PORE = 0; % Pore Black

Lamda = 1;
V_Ni_1 = 0;
 
 
while abs(Lamda) > Del
        

% Sweep fill left to right

Temp = zeros(1,jump);

for i = 1:size(B,1)
  
    for j = 2:size(B,2)
        
if B(i,j) == YSZ && B(i,j-1) == NI && j < size(B,2)-jump+1 
    
    k = 1;
    for x = j: j+jump-1
        
        Temp(1,k) = B(i,x);
        k = k+1;
    end
    
    if sum(Temp(:,:)== PORE) >= 1 || sum(Temp(:,:)== NI) >= 1
        
        B(i,j) = NI;
        
    end
      
end

    end
end


% Sweep fill right to left
    
Temp = zeros(1,jump);

for i = size(B,1):-1:1
  
    for j = size(B,2)-1:-1:1
        
if B(i,j) == YSZ && B(i,j+1) == NI && j > jump 
    
    k = 1;
    for x = j:-1:j-jump+1
        
        Temp(1,k) = B(i,x);
        k = k+1;
    end
    
    if sum(Temp(:,:)== PORE) >= 1 || sum(Temp(:,:)== NI) >= 1
        
        B(i,j) = NI;
        
    end
    
end

    end
end


% Sweep fill top to bottom
    
Temp = zeros(1,jump);

for j = 1:size(B,2)
  
    for i = 2:size(B,1)
        
if B(i,j) == YSZ && B(i-1,j) == NI && i < size(B,1)-jump+1 
    
    k = 1;
    for x = i: i+jump-1
        
        Temp(1,k) = B(x,j);
        k = k+1;
    end
    
    if sum(Temp(:,:)== PORE) >= 1 || sum(Temp(:,:)== NI) >= 1
        
        B(i,j) = NI;
        
    end
    
end

    end
end


% Sweep fill bottom to top

Temp = zeros(1,jump);

for j = size(B,2):-1:1
  
    for i = size(B,1)-1:-1:1
        
if B(i,j) == YSZ && B(i+1,j) == NI && i > jump 
    
    k = 1;
    for x = i:-1:i-jump+1
        
        Temp(1,k) = B(x,j);
        k = k+1;
    end
    
    if sum(Temp(:,:)== PORE) >= 1 || sum(Temp(:,:)== NI) >= 1
        
        B(i,j) = NI;
        
    end
    
end

    end
end


% % Volume fraction calculation
% 

[~,~,V_Ni] = Volume_fraction(B);


Lamda = V_Ni - V_Ni_1;

V_Ni_1 = V_Ni;


end


[V_pore,V_YSZ,V_Ni] = Volume_fraction(B);