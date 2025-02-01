%% Exercise 2: Logistic Regression
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the logistic
%  regression exercise. You will need to complete the following functions 
%  in this exericse:
%
%     sigmoid.m
%     costFunction.m
%     plotData.m
%     predict.m
%     
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Load Data
%  The first two columns contains the exam scores and the third column
%  contains the label.

data = load('ex2data1.txt'); % load csv file
X = data(:, [1, 2]); y = data(:, 3); % X=col 1,2  y=col 3 of csv data

%% ==================== Part 1: Plotting ====================
%  We start the exercise by first plotting the data to understand the 
%  the problem we are working with.

% use [ 'quoted string' ... 'string continue' ] for multiple-line string
fprintf(['1. Plotting data with + indicating (y = 1) examples and o ' ...
         'indicating (y = 0) examples.\n']); 
% plot data with plotData.m                           <--------- write your code
plotData(X, y);

% Put some labels 
hold on;
% Labels and Legend
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============ Part 2: Compute Cost and Gradient ============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in 
%  costFunction.m
fprintf('\n2. Compute Cost and Gradient\n');

% Plot sigmoid function
% sigmoid will be used in costFunction: sigmoid.m        <------ write your code
fprintf('\n2a. Plot sigmoid function\n');
%plotSigmoid();
z_plot= linspace(-10,10,50);
g_plot= sigmoid(z_plot);
figure; hold on;
plot(z_plot, g_plot);
xlabel('z');
ylabel('g(z)');
legend('sigmoid(z)');
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X);

% Add intercept term to x and X_test
X = [ones(m, 1) X];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

% Compute and display cost and gradient: costFunction.m  <------ write your code
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('\n2b. Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n -0.1000\n -12.0092\n -11.2628\n');

% Compute and display cost and gradient with non-zero theta
test_theta = [-24; 0.2; 0.2];
[cost, grad] = costFunction(test_theta, X, y);

fprintf('\n2c. Cost at test theta(%.2f, %.2f, %.2f): %f\n', test_theta, cost);
fprintf('Expected cost (approx): 0.218\n');
fprintf('Gradient at test theta: \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n 0.043\n 2.566\n 2.647\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============= Part 3: Optimizing using fminunc  =============
%  In this exercise, you will use a built-in function (fminunc) to find the
%  optimal parameters theta.
fprintf('\n3. Optimizing using fminunc\n');
%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
  % advance: passing function "costFunction" to fminunc as 1 of the parameters

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('Expected cost (approx): 0.203\n');
fprintf('theta: \n');
fprintf(' %f \n', theta);
fprintf('Expected theta (approx):\n');
fprintf(' -25.161\n 0.206\n 0.201\n');

fprintf('\n3.1 Plot Decision Boundary\n');
% Plot Decision Boundary
plotDecisionBoundary2(theta, X, y); %use plotDecisionBoundarys for size(X,2) > 3

% Put some labels 
hold on;
% Labels and Legend
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============== Part 4: Predict and Accuracies ==============
%  After learning the parameters, you'll like to use it to predict the outcomes
%  on unseen data. In this part, you will use the logistic regression model
%  to predict the probability that a student with score 45 on exam 1 and 
%  score 85 on exam 2 will be admitted.
%
%  Furthermore, you will compute the training and test set accuracies of 
%  our model.
%
%  Your task is to complete the code in predict.m

%  Predict probability for a student with score 45 on exam 1 
%  and score 85 on exam 2 
fprintf('\n4. Prediction and Accuracies\n');

% use of sigmoid to find the probability
prob = sigmoid([1 45 85] * theta);
fprintf(['For a student with scores 45 and 85,\nwe predict an admission ' ...
         'probability of %f\n'], prob);
fprintf('Expected value: 0.775 +/- 0.002\n\n');

% Compute accuracy on our training set: predict.m     <--------- write your code
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100); 
%try this 1 step at a time: sum(double(p == y)/length(y) * 100
fprintf('Expected accuracy (approx): 89.0\n');
fprintf('\n');

%% Extra

%% ============ Part 5: Plot plot_y in plotDecisionBoundary2============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in 
%  costFunction.m
fprintf('\n5: Plot plot_y in plotDecisionBoundary2\n');
plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

X(:,2)= linspace(plot_x(1)-5,plot_x(2)+5,100);
g_plot= sigmoid(X*theta);

figure; hold on;
plot(X(:,2), g_plot);
xlabel('X2');
ylabel('sigmoid(z)');
hold off;

