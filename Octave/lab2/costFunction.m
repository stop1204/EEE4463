function [J, grad] = costFunction(theta, X, y)
%costFunction Compute cost and gradient for logistic regression
%   J = costFunction(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly
J = 0;
grad = zeros(size(theta)); %=n

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
% Note: grad should have the same dimensions as theta
%
% code
% h(X)
h = sigmoid( X * theta); % mx3 * 3x1 = mx1
% J, cost is scalar
J = -(log(h)'*y + log(1-h)'*(1-y))/m ;
% gradient (dim same as that of theta)
grad = (X' * (h - y ))/m ; % X' is transpose of X = 3xm
% 3xm * mx1 = 3x1 (same as 𝜃)

% =============================================================

end
