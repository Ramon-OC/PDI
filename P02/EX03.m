image1024 = im2gray(imread('CarlosIV1024.jpg'));

% Tamaño de la imagen original
originalSize = 64; %  512, 256, 128 y 64.
originalImage = reduce(image1024,originalSize);

% Relación con el nuevo tamaño a una imagen de 1024 x 1024
ratio = 1024/length(originalImage);

% Obtener las posiciones interpoladas
interpolated = zeros(1, 1024);
for i = 1:1024
    interpolated(i) = ceil(i / ratio);
end

% Definimos variable donde se guarda 
newImage = zeros(1024, 1024, 'uint8');
auxiliarMatrix= zeros(1024, 1024, 'uint8');

for i=1:length(originalImage)
	for j=1:1024
		index = interpolated(j);
		newImage(i,j) = originalImage(i,index);
	end
end

for i=1:1024
	for j=1:1024
		auxiliarMatrix(i,j) = newImage(interpolated(i),j);
	end
end

newImage = auxiliarMatrix;
imshow(newImage)

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