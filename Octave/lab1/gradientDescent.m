function [theta, J_history, theta_history] = gradientDescent(X, y, theta, alpha, num_iters)
%gradientDescent Performs gradient descent to learn theta
%   theta = gradientDescent(X, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
theta_history = zeros(num_iters, 2); %for contour plot

for iter = 1:num_iters
    theta_history(iter,:) = theta'; %store the one before update
    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta.
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
   prediction = X*theta;
   error = prediction - y;
   gradient = (1/m)*(X'*error);
   theta = theta - alpha*gradient;



    % ============================================================

    % Save the cost J in every iteration
    J_history(iter) = computeCost(X, y, theta);
  %  fprintf('J_history(%i)=%.4f theta=%.4f, %.4f\n', iter, J_history(iter), theta);

end

end
