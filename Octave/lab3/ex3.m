%% Exercise 3 One-vs-all

%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions
%  in this exericse:
%
%     costFunctionReg.m (cost function with regularization)
%     trainOneVsAll.m
%     predictOneVsAll.m
%     findFailPrediction.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Your name and group
groupMember=["Chan"; "Lee"; "Cheung"; "Wong"];
groupNo=9;
fprintf('\nGroup %d: %s, %s, %s, %s\n', groupNo, 
  groupMember(1,:), groupMember(2,:), groupMember(3,:), groupMember(4,:));
fprintf('==================================================\n');

%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset.
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('1. Loading and Visualizing Data ...\n')

load('handwritten_digit.mat'); % training data stored in arrays X, y
m = size(X, 1);

% Randomly select 100 data points to display
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayData(sel);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============ Part 2: Vectorize Logistic Regression ============
%  In this part of the exercise, you will reuse your logistic regression
%  code from the last exercise. You task here is to make sure that your
%  regularized logistic regression implementation is vectorized. After
%  that, you will implement one-vs-all classification for the handwritten
%  digit dataset.
%
%  implement: costFunctionReg.m                       <--------- write your code
%
% Test case for costFunctionReg
fprintf('\nGroup %d: %s, %s, %s, %s\n', groupNo, 
  groupMember(1,:), groupMember(2,:), groupMember(3,:), groupMember(4,:));
fprintf('==================================================\n');
fprintf('\n2. Testing costFunctionReg() with regularization');

theta_t = [-2; -1; 1; 2];
X_t = [ones(5,1) reshape(1:15,5,3)/10];
y_t = ([1;0;1;0;1] >= 0.5);
lambda_t = 3;
[J grad] = costFunctionReg(theta_t, X_t, y_t, lambda_t);

fprintf('\nCost: %f\n', J);
fprintf('Expected cost: 2.534819\n');
fprintf('Gradients:\n');
fprintf(' %f \n', grad);
fprintf('Expected gradients:\n');
fprintf(' 0.146561\n -0.548558\n 0.724722\n 1.398003\n');

fprintf('Program paused. Press enter to continue.\n');
pause;
%% ============ Part 3: One-vs-All Training ============
% implement: trainOneVsAll.m                          <--------- write your code
%
fprintf('\nGroup %d: %s, %s, %s, %s\n', groupNo, 
  groupMember(1,:), groupMember(2,:), groupMember(3,:), groupMember(4,:));
fprintf('==================================================\n');
fprintf('\n3. Training One-vs-All Logistic Regression...\n')

lambda = 0.1;
[all_theta] = trainOneVsAll(X, y, num_labels, lambda);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ Part 4: Predict for One-Vs-All ================
% implement: predictOneVsAll.m                        <--------- write your code
%
fprintf('\nGroup %d: %s, %s, %s, %s\n', groupNo, 
  groupMember(1,:), groupMember(2,:), groupMember(3,:), groupMember(4,:));
fprintf('==================================================\n');
fprintf('\n4. Predict for One-Vs-All...\n')
pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

%% =========== Part 5: Manual Evaluation of fail prediction =======
%  To show you the fail result
%  implement: findFailPrediction.m                    <--------- write your code
%
fprintf('\n5. Manual Evaluation of fail prediction ...\n');
fprintf('\nGroup %d: %s, %s, %s, %s\n', groupNo, 
  groupMember(1,:), groupMember(2,:), groupMember(3,:), groupMember(4,:));
fprintf('==================================================\n');
%  find index of fail prediction
fp = findFailPrediction(pred, y);

figure;
for i = 1: length(fp)
    % Display 
    fprintf('\nDisplaying Image of fail prediction %d of %d', i, length(fp));
    displayData(X(fp(i), :));

    % mod(a, 10), divide a by 10 and take remainder, mod(10,10) give 0
    fprintf('\nPrediction: %d (expect: %d)\n', mod(pred(fp(i)), 10), mod(y(fp(i)),10));
    
    % Pause with quit option
    s = input('Paused - press enter to continue, q to exit:','s');
    if s == 'q'
      break
    end
end


