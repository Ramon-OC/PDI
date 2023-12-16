imagenOriginal = imread('imagenes/fourier_bw512.bmp');

resultadosSinCorrimiento = transformadaFourier(imagenOriginal);
showImages(resultadosSinCorrimiento);

resultadosConCorrimiento = transformadaFourierConCorrimiento(imagenOriginal);

function resultados = transformadaFourier(imagenOriginal)
    resultados = cell(1, 6);
    resultados{1,1} = imagenOriginal;   
    % Transformada discreta de fourier
    transformadaDiscreta = fft2(imagenOriginal);

    magnitud = abs(transformadaDiscreta);
    resultados{1,2} = magnitud;

    fase = angle(transformadaDiscreta);
    resultados{1,3} = fase;

    inversaAmplitud = real(ifft2(magnitud)); 
    resultados{1,4} = inversaAmplitud;

    inversaFase = real(ifft2(exp(1i*fase)));
    resultados{1,5} = inversaFase;

    inversa = real(ifft2(magnitud.*exp(1i*fase)));
    resultados{1,6} = inversa;

end

% Cuando se solicita la magnitud y fase con corrimiento. Se muestra una
% figura adicional. 
function resultados = transformadaFourierConCorrimiento(imagenOriginal)
    resultados = cell(1, 3);
    resultados{1,1} = imagenOriginal;   

    transformadaDiscreta = fft2(imagenOriginal);
    transformadaDiscreta = fftshift(transformadaDiscreta); % Corrimiento de la imagen
    
    magnitud = abs(transformadaDiscreta);
    resultados{1,2} = magnitud;

    fase = angle(transformadaDiscreta);
    resultados{1,3} = fase;

    figure;
    subplot(1, 3, 1), imshow(resultados{1,1}), title('Imagen original');
    subplot(1, 3, 2), imshow(log(1 + resultados{1,2}), []), title('Magnitud');
    subplot(1, 3, 3), imshow(resultados{1,3}, []), title('Fase');

end

function showImages(resultados)
    figure;
    subplot(2, 3, 1), imshow(resultados{1,1}), title('Imagen original');
    subplot(2, 3, 2), imshow(log(1 + resultados{1,2}), []), title('Magnitud');
    subplot(2, 3, 3), imshow(resultados{1,3}, []), title('Fase');
    subplot(2, 3, 4), imshow(uint8(resultados{1,4}), []), title('Inversa con amplitud');
    subplot(2, 3, 5), imshow(resultados{1,5}, []), title('Inversa con fase');
    subplot(2, 3, 6), imshow(uint8(resultados{1,6}), []), title('Reconstrucción');
end