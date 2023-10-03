coordinates = cell(5, 1);

% Se generan cinco coordenadas de forma aleatoria
for i = 1:5
    x = randi([1, 64]); 
    y = randi([1, 64]); 
    coordinates{i} = [x, y];
end

% Prueba para las coordenadas del reporte
% cordinates = {[18,49]; [13,19]; [6,37]; [44,35]; [28,42]};

calculateDistances(coordinates)

% Función que recibe como parametros dos coordenadas para calcular la
% distancia City Block
function cityBlockDistance = cityBlock(coordsOne, coordsTwo)
    cityBlockDistance = abs(coordsOne(1)-coordsTwo(1)) + abs(coordsOne(2)-coordsTwo(2));
end

% Función que recibe como parametros dos coordenadas para calcular la
% distancia Chessboard
function chessboardDistance = chessboard(coordsOne, coordsTwo)
    chessboardDistance = max(abs(coordsOne(1)- coordsTwo(1)), abs(coordsOne(2)-coordsTwo(2)));
end

function calculateDistances(coordinates)
    for i = 2:length(coordinates)
        cityBlockDistance = cityBlock(coordinates{1},coordinates{i});
        chessBoardDistance = chessboard(coordinates{1},coordinates{i});
        fprintf(' - Distancia CityBlock entre  [%d,%d] y [%d,%d]: %d.\n', coordinates{1}, coordinates{i}, cityBlockDistance);
        fprintf(' - Distancia Chessboard entre [%d,%d] y [%d,%d]: %d.\n', coordinates{1}, coordinates{i}, chessBoardDistance);
    end
end