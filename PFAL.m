% Filtro adaptativo: Reducción del ruido local 

close all;
imtool close all;

Img1 = imread('Entorno\Forestal\1578_jpg.rf.2f7b487fb2b09544903880837d15cacd.jpg');

if size(Img1, 3) > 1
    Img1 = rgb2gray(Img1);
end
Img1 = double(Img1);
[M, N] = size(Img1);

var_noise = 1000; 
J = imnoise(uint8(Img1), 'gaussian', 0, 0.001);
J = double(J);

% Varianza global
L = 256;
ri = (0:L-1)';
[counts, ~] = imhist(uint8(J));
p_ri = counts / sum(counts); 
m_global = sum(ri .* p_ri); % Media global 
sigma2_global = sum(((ri - m_global).^2) .* p_ri); % Varianza global 

% 3. Imagen aumentada para vecindad de 3x3
Img1A = padarray(J, [1 1], 'replicate');
ImgR1 = zeros(M, N); % Imagen restaurada

% 4. Proceso de filtrado adaptativo
for x = 2:M+1
    for y = 2:N+1
        pixVel = Img1A(x-1:x+1, y-1:y+1);
        
        local_counts = histcounts(pixVel, 0:L);
        p_Sxy = local_counts / sum(local_counts);
        
        m_Sxy = sum(ri .* p_Sxy');
        
        var_Sxy = sum(((ri - m_Sxy).^2) .* p_Sxy');
        
        % 
        g_xy = J(x-1, y-1);
        
        % Condición técnica: si la varianza del ruido es mayor a la local, 
        % el ratio se ajusta a 1.0 para evitar resultados sin sentido 
        ratio = var_noise / var_Sxy;
        if var_noise > var_Sxy
            ratio = 1.0;
        end
        
        % f_hat = g(x,y) - [sigma_eta^2 / sigma_Sxy^2] * [g(x,y) - m_Sxy]
        ImgR1(x-1, y-1) = g_xy - ratio * (g_xy - m_Sxy);
    end
end

% 5. Mostrar resultados
figure('Name','Reducción de ruido local - Filtro adaptativo','NumberTitle','off')

subplot(1,3,1)
imshow(mat2gray(Img1))
title('Imagen original')

subplot(1,3,2)
imshow(mat2gray(J))
title('Imagen con ruido')

subplot(1,3,3)
imshow(mat2gray(ImgR1))
title('Imagen restaurada')

fprintf('Estadísticas globales de la imagen ruidosa:\n');
fprintf('Media: %.2f | Varianza: %.2f\n', m_global, sigma2_global);