imagen = imread('Prometeo.jpg');

% El tamaño de la imagen debe ser 64 x 64
is64x64 = size(imagen, 1) == 64 && size(imagen, 2) == 64;

% La extension debe ser .jpg
[~, ~, extension] = fileparts('Prometeo.jpg');
isJpg = strcmpi(extension, '.jpg');

if is64x64 && isJpg
    coordinates = cell(5, 1); 
    
    % Se generan cinco coordenadas de forma aleatoria
    for i = 1:5
        x = randi([1, 64]); 
        y = randi([1, 64]); 
        coordinates{i} = [x, y];
    end
    
    % Prueba para el peor de los casos
    % coordinates = {[1,1];[64,64];[64,1];[1,64]};
    
    % Prueba para las coordenadas del reporte
    % coordinates = {[18,49]; [13,19]; [6,37]; [44,35]; [28,42]};
    
    imshow(imagen);
    
    for i = 1:size(coordinates, 1)
        calculateAdjacencies(coordinates{i})
    end
end

% Nos devuelve las cuatro adyacencias de una coordenada
function adjacencies4 = getAdjacencies4(adjacencies4, coordinate)
    x = coordinate(1);
    y = coordinate(2);

    if y - 1 >= 1 % up
        adjacencies4{1} = [x, y-1];
    end

    if y + 1 <= 64 % down
        adjacencies4{2} = [x, y+1];
    end

    if x - 1 >= 1 % left 
        adjacencies4{3} = [x-1, y];
    end

    if x + 1 <= 64 % right
        adjacencies4{4} = [x+1, y];
    end
end

% Nos devuelve las ocho adyacencias de una coordenada
function adjacencies8 = getAdjacencies8(adjacencies8, coordinate)
    x = coordinate(1);
    y = coordinate(2);

    if x + 1 <= 64 && y + 1 <= 64 % down right
        adjacencies8{1} = [x+1, y+1];
    end

    if x - 1 >= 1 && y - 1 >= 1 % up left
        adjacencies8{2} = [x-1, y-1];
    end

    if x + 1 <= 64 && y - 1 >= 1 % up right
        adjacencies8{3} = [x+1, y-1];
    end

    if x - 1 >= 1 && y + 1 <= 64 % down left
        adjacencies8{4} = [x-1, y+1];
    end
end

% Dado un conjunto de coordenadas y un caracter para el color, se dibuja un
% recuadro sobre el pixel
function drawAdjacencies(adjacencies, color)
    hold on;
    for i = 1:size(adjacencies, 1)
        x = adjacencies{i}(1);
        y = adjacencies{i}(2);
        if x ~= 0 && y ~= 0
            rectangle('Position', [x-0.5, y-0.5, 1, 1], 'EdgeColor', color, 'LineWidth', 2);
        end
    end
    hold off;
end

% Dada una coordenada dibuja un circulo 
function drawCircle(coordinate, color)
    hold on;
    x = coordinate(1);
    y = coordinate(2);
    rectangle('Position', [x-0.5, y-0.5, 1, 1], 'Curvature', [1, 1], 'EdgeColor', color, 'LineWidth', 2); 
    hold off;
end

% Muestra las adyacencias y las dibuja
function calculateAdjacencies(coordinate)
    adjacencies4 = cell(4, 1);
    adjacencies8 = cell(4, 1);

    % Inicializamos en cero las adyacencias
    for i = 1:4
        adjacencies4{i} = [0, 0];
        adjacencies8{i} = [0, 0];
    end

    % Calcula las adyacencias
    adjacencies4 = getAdjacencies4(adjacencies4,coordinate);
    adjacencies8 = getAdjacencies8(adjacencies8,coordinate);
    
    fprintf('Vecinos 4-adyacentes de [%d,%d]:\n',coordinate)
    fprintf(' - Vecino superior  [x, y-1]: [%d,%d]\n', adjacencies4{1});
    fprintf(' - Vecino inferior  [x, y+1]: [%d,%d]\n', adjacencies4{2});
    fprintf(' - Vecino izquierdo [x-1, y]: [%d,%d]\n', adjacencies4{3});
    fprintf(' - Vecino derecho   [x+1, y]: [%d,%d]\n', adjacencies4{4});

    fprintf('Vecinos 8-adyacentes de [%d,%d]:\n',coordinate)
    fprintf(' - Vecino inferior derecho    [x+1, y+1]: [%d,%d]\n', adjacencies8{1});
    fprintf(' - Vecino superior izquierdo  [x-1, y-1]: [%d,%d]\n', adjacencies8{2});
    fprintf(' - Vecino superior derecho    [x+1, y-1]: [%d,%d]\n', adjacencies8{3});
    fprintf(' - Vecino inferior izquierdo  [x-1, y+1]: [%d,%d]\n\n', adjacencies8{4});

    % Dibuja las adyacencias
    drawCircle(coordinate,'g')
    drawAdjacencies(adjacencies4, 'b')
    drawAdjacencies(adjacencies8, 'r')
end