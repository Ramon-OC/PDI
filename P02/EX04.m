originalImage = im2gray(imread('CarlosIV1024.jpg'));
newIntensity = 2; % Valores sugeridos: 128, 64, 32, 16, 8, 4 y 2.
modifiedImage = modifyIntensity(originalImage,newIntensity);

imshow(modifiedImage);
%getElements(modifiedImage)

% Dada una imagen y un entero con la nueva intensidad, se reduce el rango
% dinámico de nuestra matriz
function modifiedImage = modifyIntensity(originalImage,newIntensity)
    modifiedImage = zeros(1024,1024,'uint8');
    newIntesity = 255/(newIntensity-1);
    disp(newIntesity);
    for i = 1:length(originalImage)
        for j = 1:length(originalImage)
            newValue = floor(originalImage(i, j)/newIntesity) * newIntesity;
            modifiedImage(i, j) = newValue;
        end
    end
end

% Imprime la cantidad y el conjunto de elementos que están contenidos en la matriz
function getElements(image)
    uniqueElements = unique(image);
    fprintf(' - La imagen tiene %d elementos diferentes\n', length(uniqueElements));
    disp(' - Elementos únicos en la matriz:');
    disp(uniqueElements);
end
