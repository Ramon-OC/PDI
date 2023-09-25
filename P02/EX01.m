% Imagen original (1024 x 1024) en escala de grises
originalImage = im2gray(imread('CarlosIV1024.jpg'));
newDimentions = 64; % (512, 256, 128 o 64)
newImage = reduce(originalImage,newDimentions);
imshow(newImage); 

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