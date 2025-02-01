%% Exercise 1: Linear Regression

%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions
%  in this exericse:
%
%     squareAndCube.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%
% x refers to the population size in 10,000s
% y refers to the profit in $10,000s
%

%% Initialization
clear ; close all; clc

%% ==================== Part 1: Basic Function ====================
% Complete squareAndCube.m                            <--------- write your code
fprintf('1. Running Warm Up Exercise ... \n');
fprintf('square and cube of x');
x=[-2:0.4:2];
[y2, y3]=squareAndCube(x);
%show x, y2, y3
x
y2
y3
hold on;
plot(x,y2,'r-', 'MarkerSize', 10);
plot(x,y3,'b-', 'MarkerSize', 10);
xlabel('x');
ylabel('y');
legend('y^2','y^3');

fprintf('Program paused. Press enter to continue.\n');
##pause;


%% ======================= Part 2: Load data and Plotting =======================
fprintf('2. Load data and Plotting Data ...\n')
data = load('ex1data1.txt'); % read comma separated data
X = data(:, 1);
y = data(:, 2); % X=training examples, y=labels
m = length(y); % number of training examples

% Plot Data
% Note: You have to complete the code in plotData.m   <--------- write your code
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
#pause;

%% =================== Part 3: Cost and Gradient descent ===================
fprintf('3. Compute Cost and Gradient ...\n')
X = [ones(m, 1), data(:,1)]; % Add a column of ones to x
theta = zeros(2, 1); % initialize fitting parameters
%theta = [9.8 3.8]';

% Some gradient descent settings
%iterations = 5000; % try different values, will be close to python result
%iterations = 2000;
iterations = 1500;
%alpha = 0.001; % too slow
%alpha = 0.003; %
alpha = 0.01; % 0.01 is better
%alpha = 0.02; % 0.02 oscillate, very sensitive

fprintf('\n3.1 Testing the cost function ...\n')
% compute and display initial cost with computeCost.m <--------- write your code
J = computeCost(X, y, theta);
fprintf('3.1a With theta = [0 ; 0]\nCost computed = %f\n', J);
fprintf('Expected cost value (approx) 32.07\n');

% further testing of the cost function
J = computeCost(X, y, [-1 ; 2]);
fprintf('\n3.1b With theta = [-1 ; 2]\nCost computed = %f\n', J);
fprintf('Expected cost value (approx) 54.24\n');

fprintf('Program paused. Press enter to continue.\n');
#pause;

fprintf('\n3.2 Running Gradient Descent ...\n')
% run gradient descent: gradientDescent.m             <--------- write your code
[theta, J_history, theta_history] = gradientDescent(X, y, theta, alpha, iterations);

% print theta to screen
fprintf('Theta found by gradient descent:\n');
fprintf('%f\n', theta);
fprintf('Expected theta values (approx)\n');
fprintf(' -3.6303\n  1.1664\n\n');

% Plot the linear fit
fprintf('\n3.3 Plot the linear fit\n');
hold on; % keep previous plot visible
plot(X(:,2), X*theta, '-')
legend('Training data', 'Linear regression')
hold off % don't overlay any more plots on this figure

% Predict values for population sizes of 35,000 and 70,000
fprintf('\n3.4 Predict values for population sizes of 35,000 and 70,000\n');
predict1 = [1, 3.5] *theta;
fprintf('For population = 35,000, we predict a profit of %f\n',...
    predict1*10000);
predict2 = [1, 7] * theta;
fprintf('For population = 70,000, we predict a profit of %f\n',...
    predict2*10000);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

%% ============= Part 4: Visualizing J(theta_0, theta_1) =============
fprintf('\n4. Visualizing J(theta_0, theta_1) ...\n')

% Grid over which we will calculate J
theta0_vals = linspace(-10, 10, 100);
theta1_vals = linspace(-1, 4, 100);

% initialize J_vals to a matrix of 0's
J_vals = zeros(length(theta0_vals), length(theta1_vals));

% Fill out J_vals
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];
	  J_vals(i,j) = computeCost(X, y, t);
    end
end


% Because of the way meshgrids work in the surf command, we need to
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';
% Surface plot
figure;
surf(theta0_vals, theta1_vals, J_vals)

xlabel('\theta_0'); ylabel('\theta_1'); % use LateX notation

% Contour plot
figure;
% Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20))
xlabel('\theta_0'); ylabel('\theta_1'); % use LateX notation
hold on;
% plot theta history over the 1500 iteration
plot(theta_history(:, 1), theta_history(:, 2), 'b-', 'MarkerSize', 10, 'LineWidth', 1);
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2); %final value

