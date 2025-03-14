function g = sigmoidGradient(z)
%sigmoidGradient returns the gradient of the sigmoid function
%evaluated at z
%   g = sigmoidGradient(z) computes the gradient of the sigmoid function
%   evaluated at z. This should work regardless if z is a matrix or a
%   vector. In particular, if z is a vector or matrix, you should return
%   the gradient for each element.

g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Compute sigmoid function
g = sigmoid(z);

% Compute gradient
g = g .* (1 - g);
% =============================================================




end
