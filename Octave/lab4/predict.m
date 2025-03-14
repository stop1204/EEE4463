function p = predict(Theta1, Theta2, X)
%predict Predict the label of an input given a trained neural network
%   p = predict(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Add bias unit to X
X = [ones(m, 1) X];

% Calculate hidden layer activations
z2 = X * Theta1';
a2 = [ones(m, 1) sigmoid(z2)];

% Calculate output layer activations
z3 = a2 * Theta2';
a3 = sigmoid(z3);

% Get the index of the max value for each example
[_, p] = max(a3, [], 2);
% =============================================================


end
