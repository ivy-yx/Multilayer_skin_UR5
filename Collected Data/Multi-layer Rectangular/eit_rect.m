% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created 02-Aug-2023 16:10:34
% This script assumes these variables are defined:
%   inp - input data.
%   out - target data.

before_touch_data = csvread('C:\Users\ivywa\Desktop\ur5_rect\before_formatted.csv');
after_touch_data = csvread('C:\Users\ivywa\Desktop\ur5_rect\after_formatted.csv');
coord = csvread('C:\Users\ivywa\Desktop\ur5_rect\coord_formatted.csv');

before_touch_data(:,any(before_touch_data==0))=[];
after_touch_data(:,any(after_touch_data==0))=[];

data = before_touch_data - after_touch_data;

%x = data';
%x = [before_touch_data  after_touch_data]';
x_r = [before_touch_data- after_touch_data  after_touch_data]';
t_r = coord(:, 1:2)';


% Choose a Training Function

% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.

trainFcn = 'trainscg';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 400;
net = fitnet(hiddenLayerSize,trainFcn);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess

net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing

% For a list of all data division functions type: help nndivision

net.divideFcn = 'dividerand';  % Divide data randomly

net.divideMode = 'sample';  % Divide up every sample

net.divideParam.trainRatio = 80/100;

net.divideParam.valRatio = 10/100;

net.divideParam.testRatio = 10/100;


% Choose a Performance Function
% For a list of all performance functions type: help nnperformance

net.performFcn = 'mse';  % Mean Squared Error

% Choose Plot Functions

% For a list of all plot functions type: help nnplot
%===========================
% net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
% 
%     'plotregression', 'plotfit'};

 

% Train the Network

[net,tr] = train(net,x_r,t_r);

 

% Test the Network
y_r = net(x_r);

performance = perform(net,t_r,y_r)


% Recalculate Training, Validation and Test Performance

trainTargets = t_r .* tr.trainMask{1};

valTargets = t_r .* tr.valMask{1};

testTargets = t_r .* tr.testMask{1};

trainPerformance = perform(net,trainTargets,y_r)

valPerformance = perform(net,valTargets,y_r)

testPerformance = perform(net,testTargets,y_r)