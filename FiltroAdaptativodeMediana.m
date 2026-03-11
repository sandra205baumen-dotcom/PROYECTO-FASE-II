% Filtro adaptativo de mediana

clc;
clear;
close all;

I = imread('IMAGENES\caballo.bmp');

if size(I,3)==3
    I = rgb2gray(I);
end

densidad_ruido = 0.08;  % 8% ruido
Iruido = imnoise(I,'salt & pepper',densidad_ruido);

Smax = 7;   % Tamaño máximo de ventana 

Ifiltrada = filtro_mediana_adaptativo(Iruido, Smax);

figure('Name','Filtro Adaptativo de mediana','NumberTitle','off')

subplot(1,3,1)
imshow(I)
title('Imagen original')

subplot(1,3,2)
imshow(Iruido)
title('Imagen con ruido')

subplot(1,3,3)
imshow(Ifiltrada)
title('Imagen filtrada')