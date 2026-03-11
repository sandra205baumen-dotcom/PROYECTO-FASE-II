% Gradiente Laplaciano

clc;
clear;
close all;

imagen_cargada = false;

while true
    
    disp(' ')
    disp('===== MENU PRINCIPAL =====')
    disp('1 - Seleccionar imagen')
    disp('2 - Aplicar Gradiente-Laplaciano')
    disp('3 - Seleccionar otra imagen')
    disp('4 - Salir')
    
    opcion = input('Seleccione una opción: ');
    
    switch opcion
        
        case 1
            
            [fname, path] = uigetfile({'*.jpg;*.png;*.bmp','Imagenes (*.jpg,*.png,*.bmp)'}, ...
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
                
                disp('Imagen cargada correctamente')
                
                figure('Name','Imagen Original')
                imshow(I)
                title('Imagen original')
                
            end
            
        case 2
            
            if ~imagen_cargada
                disp('Primero debe seleccionar una imagen')
                continue
            end
            
            disp(' ')
            disp('Seleccione máscara Laplaciana')
            disp('1 - Laplaciano 4 vecinos')
            disp('2 - Laplaciano 8 vecinos (centro -8)')
            disp('3 - Laplaciano 8 vecinos (centro 8)')
            
            op = input('Opción: ');
            
            switch op
                
                case 1
                    L = [0 -1 0; -1 4 -1; 0 -1 0];
                    c = 1;
                    
                case 2
                    L = [1 1 1; 1 -8 1; 1 1 1];
                    c = -1;
                    
                case 3
                    L = [-1 -1 -1; -1 8 -1; -1 -1 -1];
                    c = 1;
                    
                otherwise
                    disp('Opción inválida')
                    continue
            end
            
            % Laplaciano
            Lap = imfilter(I,L,'replicate');
            R = I + c*Lap;
            
            % Gradiente
            Gx = fspecial('sobel')';
            Gy = fspecial('sobel');
            
            Ix = imfilter(I,Gx,'replicate');
            Iy = imfilter(I,Gy,'replicate');
            
            Grad = sqrt(Ix.^2 + Iy.^2);
            
            % Suavizado
            H = fspecial('average',[3 3]);
            Grad_suav = imfilter(Grad,H,'replicate');
            
            % Mascara
            Mask = R .* Grad_suav;
            g = I + Mask;
            
            % Gamma
            gamma = 0.5;
            g = imadjust(mat2gray(g),[],[],gamma);
            
            figure('Name','Resultado Gradiente-Laplaciano')
            imshow(g)
            title('Imagen realzada')
            
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