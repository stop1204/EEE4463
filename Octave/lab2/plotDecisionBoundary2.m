function plotDecisionBoundary2(theta, X, y)
%plotDecisionBoundary2 Plots the data points X and y into a new figure with
%the decision boundary defined by theta
%   plotDecisionBoundary2(theta, X,y) plots the data points with + for the 
%   positive examples and o for the negative examples. X is assumed to be 
%   a either 
%   1) Mx3 matrix, where the first column is an all-ones column for the 
%      intercept.
%   2) MxN, N>3 matrix, where the first column is all-ones

% Plot Data
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % Only need 2 points to define a line, so choose two endpoints
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % Calculate the decision boundary line
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));
    fprintf('\n\npolt_y='); plot_y

    % Plot, and adjust axes for better viewing
    plot(plot_x, plot_y)
    
    % Legend, specific for the exercise
    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else
    fprintf('ERROR: plotDecisionBoundary2.m did not support size(X,2) > 3')
    fprintf('require plotDecisionBoundary.m and polynomialFeature.m')
    
end
hold off

end
