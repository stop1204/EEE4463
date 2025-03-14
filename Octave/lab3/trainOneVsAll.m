function [all_theta] = trainOneVsAll(X, y, num_labels, lambda)
%trainOneVsAll trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = trainOneVsAll(X, y, num_labels, lambda) trains num_labels (ie 10)
%   logistic regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i

% Some useful variables
m = size(X, 1);
n = size(X, 2);

% You need to return the following variables correctly 
all_theta = zeros(num_labels, n + 1); %num_labels has been set to 10 in main

% Add ones to the X data matrix
X = [ones(m, 1) X]; %mxn -> mx(n+1)

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the following code to train num_labels (ie 10)
%               logistic regression classifiers with regularization
%               parameter lambda. 
%
% Hint: theta(:) will return a column vector.
%
% Hint: You can use y == c to obtain a vector of 1's and 0's that tell you
%       whether the ground truth is true/false for this class.
%
% Note: For this lab, we recommend using fmincg to optimize the cost
%       function. It is okay to use a for-loop (for c = 1:num_labels) to
%       loop over the different classes.
%
%       fmincg works similarly to fminunc, but is more efficient when we
%       are dealing with large number of parameters.
%
% Example Code for fmincg:
%
%     % Set Initial theta
%     initial_theta = zeros(n + 1, 1);
%     
%     % Set options for fminunc
%     options = optimset('GradObj', 'on', 'MaxIter', 50);
% 
%     % Run fmincg to obtain the optimal theta
%     % This function will return theta and the cost 
%     [theta] = ...
%         fmincg (@(t)(costFunctionReg(t, X, (y == c), lambda)), ...
%                 initial_theta, options);
%

for c=1;num_labels
    initial_theta=zeros(n+1,1); %initial theta
    options=optimset('GradObj','on','MaxIter',50); %options for fminunc
    [theta] = fmincg(@(t)(costFunctionReg(t, X, (y == c), lambda)), initial_theta, options); %run fmincg to obtain optimal theta
    all_theta(c,:)=theta'; %store theta in all_theta
end



% =========================================================================


end
