%%
clc,clear,close all


angle = 130

filePath = pwd + "\missilePictures\" + string(angle) + ".png";
filePath = char(filePath)
[imagem,~,transparency] = imread(filePath);
%%
x = 10;
y = 10;
vehicleImage = image(imagem, 'XData', [x-5 x+5], 'YData', [y-5 y+5], 'AlphaData', transparency);