orden = 2;
fc = [15,30,80];

imagenOriginal = imread('imagenes/IMG02.tif');
imagenRuidosa = imnoise(imagenOriginal,'salt & pepper');

% Paso altas y paso bajas de una imagen sin ruido
[resultados, filtros] = butterworth(imagenOriginal, orden, fc);
mostrarResultados(resultados,filtros,fc);

% Paso altas y paso bajas de una imagen con ruido
[resultados, filtros] = butterworth(imagenRuidosa, orden, fc);
mostrarResultados(resultados,filtros,fc);

function [resultados, filtros] = butterworth(image, orden, fc)
    sizeFC = length(fc);

    resultados = cell(2, 1);
    filtros = cell(2, 1);

    [m, n] = size(image);
    cx = round(m/2);
    cy = round(n/2);
    [x, y] = meshgrid(1:n, 1:m);

    d = (x - cx).^2 + (y - cy).^2;

    imf = fftshift(fft2(image));


    for i = 1:sizeFC
        filtroPasoAltas = 1 - (1 ./ (1 + ((d / fc(i) / fc(i)).^(2 * orden))));
        filtroPasoBajas = 1 ./ (1 + ((d / fc(i) / fc(i)).^(2 * orden)));
            
        convPA = imf.*filtroPasoAltas;
        convPB = imf.*filtroPasoBajas;

        pasoAltasResultado = abs(ifft2(convPA));
        pasoBajasResultado = abs(ifft2(convPB));

        filtros{1,i} = filtroPasoAltas;
        filtros{2,i} = filtroPasoBajas;

        resultados{1,i} = pasoAltasResultado;
        resultados{2,i} = pasoBajasResultado;
    end

end

function mostrarResultados(resultados, filtros, fc)
    [~, N] = size(resultados);  
    figure;
    for i = 1:N
        subplot(4,N,i);
        imshow(filtros{1,i});
        title(['Filtro Paso Altas ', num2str(fc(i))]);
        
        subplot(4,N,i+N);
        imshow(uint8(resultados{1,i}));
        title(['Butterworth Paso Altas ', num2str(fc(i))]);
        
        subplot(4,N,i+2*N);
        imshow(filtros{2,i});
        title(['Filtro Paso Bajas ', num2str(fc(i))]);
        
        subplot(4,N,i+3*N);
        imshow(uint8(resultados{2,i}));
        title(['Butterworth Paso Bajas ', num2str(fc(i))]);
    end
end