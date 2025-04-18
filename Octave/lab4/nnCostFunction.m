function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%nnCostFunction Implements the neural network cost function for a two layer (L=3)
%neural network which performs classification
%   [J grad] = nnCostFunction(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts. After completing each part, you
%               should verify your result in ex4.m.
%
% Part 4: Feedforward the neural network and return the cost in the
%         variable J. After implementing this part, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 5: Implement regularization with the cost function.
%
% Part 6: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. They are the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 respectively.
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: Backpropagation may be implemented using a for-loop
%               over the training examples as stated in the lecture notes
%               for easy understanding. 
%               However, we recommend you to implement it with vectorization
%               here for efficiency.
%
% Part 7: Implement regularization with the gradients.
%
% Check worksheet for important hints.


%% Part 4 code
% Feedforward propagation
a1 = [ones(m, 1) X]; % Add bias unit
z2 = a1 * Theta1';
a2 = [ones(m, 1) sigmoid(z2)]; % Add bias unit
z3 = a2 * Theta2';
a3 = sigmoid(z3);

% Convert y to binary matrix
y_matrix = eye(num_labels)(y,:);

% Calculate unregularized cost
J = (1/m) * sum(sum(-y_matrix .* log(a3) - (1 - y_matrix) .* log(1 - a3)));

%% Part 5 code
% Regularization term
reg_term = (lambda/(2*m)) * (sum(sum(Theta1(:, 2:end).^2)) + sum(sum(Theta2(:, 2:end).^2)));

% Add regularization to cost
J = J + reg_term;

%% Part 6 code
% Backpropagation
d3 = a3 - y_matrix;
d2 = (d3 * Theta2(:, 2:end)) .* sigmoidGradient(z2);

% Accumulate gradients
Delta1 = d2' * a1;
Delta2 = d3' * a2;

Theta1_grad = (1/m) * Delta1;
Theta2_grad = (1/m) * Delta2;

%% Part 7
% Regularization of gradients
Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + (lambda/m) * Theta1(:, 2:end);
Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + (lambda/m) * Theta2(:, 2:end);



% =========================================================================

% Retruning unrolled gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
