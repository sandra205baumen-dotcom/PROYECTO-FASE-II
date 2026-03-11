function Iout = filtro_mediana_adaptativo(I, Smax)
% Filtro adaptativo de mediana
% I     : Imagen en escala de grises
% Smax  : Tamaño máximo de ventana (impar)

I = double(I);
[M, N] = size(I);
Iout = zeros(M,N);

Sinit = 3;  % Tamaño inicial

for i = 1:M
    for j = 1:N
        
        S = Sinit;
        terminado = false;
        
        while ~terminado
            
            k = floor(S/2);
            
            % Límites de la ventana
            rmin = max(i-k,1);
            rmax = min(i+k,M);
            cmin = max(j-k,1);
            cmax = min(j+k,N);
            
            ventana = I(rmin:rmax, cmin:cmax);
            
            Zmin = min(ventana(:));
            Zmax = max(ventana(:));
            Zmed = median(ventana(:));
            Zxy  = I(i,j);
            
            % Etapa A
          
            A1 = Zmed - Zmin;
            A2 = Zmed - Zmax;
            
            if (A1 > 0) && (A2 < 0)

                % Etapa B
                
                B1 = Zxy - Zmin;
                B2 = Zxy - Zmax;
                
                if (B1 > 0) && (B2 < 0)
                    Iout(i,j) = Zxy;
                else
                    Iout(i,j) = Zmed;
                end
                
                terminado = true;
                
            else
                S = S + 2;   % Aumentar tamaño de ventana
                
                if S > Smax
                    Iout(i,j) = Zmed;
                    terminado = true;
                end
            end
            
        end
        
    end
end

Iout = uint8(Iout);

end