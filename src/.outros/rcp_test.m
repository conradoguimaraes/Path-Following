%%
clc,clear,close all


xCoordinates = [42.21479, 80.47213, 114.64668, 135.17445, 13.59706, 14.46672, 2.64041, -28.43397, -50.58953, -50.56452, 0.086, -2.01177, 8.33871, 40.43262, 48.76106, 48.6129, -0.56616, 1.21965, -5.34257, -38.30416, -43.74669, -70.88624, -26.099626, -3.20857, -28.448617, -37.234493, -2.12715, -35.552135, -5.693295, -13.571631, -15.02106, 0.0, -1.513332, -1.513244, 0.000158, -1.776894, 12.561916];
yCoordinates = [28.525614, -0.691124, 0.174775, 0.679239, 0.334144, 39.921744, 39.698884, -0.53582, -4.43603, 5.67742, 34.781043, 37.445463, 37.790323, 1.34714, -2.5428, 6.91936, 36.15788, 33.48443, 33.54486, 0.35274, 0.35152, -0.0215, -1.1651, -85.094953, -85.329793, -0.12113, 91.829103, 92.311553, 0.02, -4.94075, -17.27634, 0.0, -30.36348, -48.671313, -33.14508, -64.833055, -65.322673];


figure(1), hold on
plot(sort(xCoordinates),yCoordinates,'-g')


%%
clc,clear,close all

% Replace 'your_output_file.csv' with the actual filename exported from Python
csv_filename = 'XYcoordinates.csv';

% Load the CSV file
data = csvread(csv_filename, 1, 0); % Skip the header row

% Extract X and Y coordinates
X = data(:, 1);
Y = data(:, 2);

% Plot the coordinates
plot(X, Y, '-g', 'LineWidth',2); % 'o' for circular markers, you can choose other markers if you prefer
xlabel('X Coordinates');
ylabel('Y Coordinates');
title('Plot of SVG Path Nodes');
grid on;


%%
clc,clear, close all


%-------------------------------------------------
% Replace 'your_output_file.csv' with the actual filename exported from Python
csv_filename = 'XYcoordinates.csv';

% Load the CSV file
data = csvread(csv_filename, 1, 0); % Skip the header row

% Extract X and Y coordinates
X = data(:, 1);
Y = data(:, 2);

%-------------------------------------------------

% Replace 'your_image_file.png' with the actual filename of the image you want to use
image_filename = 'rcp.png';

% Load the image
background_image = imread(image_filename);
[ySize, xSize, ~] = size(background_image)
% Plot the image
imshow(background_image);

% Hold on to overlay the plot on top of the image
hold on;


%-------------------------------------------------

% Plot the coordinates on top of the image
pathXoffset = -150
pathYoffset = -100
X = X+pathXoffset;
Y = Y+pathYoffset;
plot(X, Y, '-g', 'LineWidth',2);


%-------------------------------------------------
% Set the axis labels and title
xlabel('X Coordinates');
ylabel('Y Coordinates');
title('Plot of SVG Path Nodes');


xlim([5, xSize-10])
ylim([5, ySize-25])

% Add grid if desired
grid on;

% Release the 'hold' state to prevent further superimposition
hold off;

%-------------------------------------------------


