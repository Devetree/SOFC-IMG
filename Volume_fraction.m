

function [V_pore,V_YSZ,V_Ni] = Volume_fraction(B)


NI = 150; % Ni Green
YSZ = 76; % YSZ Red
PORE = 0; % Pore Black

p_pore = 0;
p_YSZ = 0;
p_Ni = 0;


for i = 1:size(B,1)
    
    for j = 1:size(B,2)
        
        if (B(i,j) == PORE)
        
        p_pore = p_pore + 1;
        
        elseif (B(i,j) == YSZ)
            
             p_YSZ = p_YSZ + 1;
        
        elseif (B(i,j) == NI)
            
        p_Ni = p_Ni + 1;
        
        end
    end
end

V_pore = p_pore/(p_pore+p_YSZ+p_Ni);
V_YSZ = p_YSZ/(p_pore+p_YSZ+p_Ni);
V_Ni = p_Ni/(p_pore+p_YSZ+p_Ni);