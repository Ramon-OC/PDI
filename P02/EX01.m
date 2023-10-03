 % Imagen original (1024 x 1024) en escala de grises
originalImage = im2gray(imread('CarlosIV1024.jpg'));

% El tamaño de la imagen debe ser 1024 x 1024
is1024x1024 = size(originalImage, 1) == 1024 && size(originalImage, 2) == 1024;

% La extension debe ser .jpg
[~, ~, extension] = fileparts('CarlosIV1024.jpg');
isJpg = strcmpi(extension, '.jpg');


if is1024x1024 && isJpg
    newDimentions = 128; % Valores sugeridos (512, 256, 128 o 64)
    newImage = reduce(originalImage,newDimentions);
    imshow(newImage); 
end 

% La función recibe como parámetros la imagen original y la dimensión a la 
% que se busca reducir 
function newImage = reduce(oldImage,newScale)
    aux = length(oldImage)/newScale;
    newImage = zeros(newScale,newScale,'uint8');
    for i = 1:newScale
        for j = 1:newScale
        newImage(i, j) = oldImage(aux * i, aux * j);
        end
    end
end