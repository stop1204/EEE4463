function fp = findFailPrediction(pred, y)
%findFailPrediction find the index of fail predictions and return in fp
%  fp = findFailPrediction(pred, y) will return a vector of fail predictions,
%  while pred is the prediction vector and y is the ground true label vector.

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to return a vector 
%               of fail predications
%
% Hint: This code can be done all vectorized using the find() function
%       which returns a vector of indices of nonzero elements of a 
%       matrix, as a row if x is a row vector or as a column otherwise.
%       
%       

fp = find(pred ~= y); % find the index of fail predictions





% =========================================================================


end
