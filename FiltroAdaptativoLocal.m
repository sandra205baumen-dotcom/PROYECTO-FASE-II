clc;
clear;
close all;

imagen_cargada = false;

while true
    
    disp(' ')
    disp('===== FILTRO ADAPTATIVO LOCAL =====')
    disp('1 - Seleccionar imagen')
    disp('2 - Aplicar filtro adaptativo local')
    disp('3 - Seleccionar otra imagen')
    disp('4 - Salir')
    
    opcion = input('Seleccione una opción: ');
    
    switch opcion
        
        case 1
            
            [fname, path] = uigetfile({'*.jpg;*.png;*.bmp'}, ...
                'Seleccione una imagen');
            
            if isequal(fname,0)
                disp('No se seleccionó imagen')
            else
                
                ruta = fullfile(path,fname);
                I = imread(ruta);
                
                if size(I,3)==3
                    I = rgb2gray(I);
                end
                
                I = im2double(I);
                
                imagen_cargada = true;
                
                figure('Name','Imagen Original')
                imshow(I)
                title('Imagen original')
                
            end
            
        % Filtro
        
        case 2
            
            if ~imagen_cargada
                disp('Primero debe seleccionar una imagen')
                continue
            end
            
            ventana = input('Tamaño de ventana (3 o 5): ');
            ruido = input('Varianza del ruido (ejemplo 0.005): ');
            
            pad = floor(ventana/2);
            Ip = padarray(I,[pad pad],'replicate');
            
            [filas, cols] = size(I);
            g = zeros(filas,cols);
            
            for i = 1:filas
                for j = 1:cols
                    
                    region = Ip(i:i+ventana-1 , j:j+ventana-1);
                    
                    media_local = mean(region(:));
                    var_local = var(region(:));
                    
                    if var_local == 0
                        g(i,j) = I(i,j);
                    else
                        
                        ratio = ruido / var_local;
                        
                        if ratio > 1
                            ratio = 1;
                        end
                        
                        g(i,j) = I(i,j) - ratio*(I(i,j)-media_local);
                        
                    end
                    
                end
            end
            
            g = mat2gray(g);
            
            figure('Name','Filtro adaptativo local')
            imshow(g)
            title('Imagen filtrada')

        case 3
            
            imagen_cargada = false;
            disp('Seleccione una nueva imagen')
        
        case 4
            
            disp('Programa finalizado')
            break
            
        otherwise
            
            disp('Opción inválida')
            
    end
    
end