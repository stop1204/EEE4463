function plotData(X, y)
%plotData Plots the data points X and y into a new figure
%   plotData(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%


pos =find(y == 1);

neg = find(y == 0);
plot(X(pos,1),X(pos,2),'k+','LineWidth', 2, 'MarkerSize', 5);
plot(X(neg,1),X(neg,2),'ko', 'MarkerFaceColor', 'y','MarkerSize', 5);




% =========================================================================



hold off;

end
