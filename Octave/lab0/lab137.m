clear;clc;

theta = [1 2 3]'

x = [4 5 6]'

n=size(x,1)

prediction = 0.0;

for j=1:n
  prediction = prediction + theta(j) * x(j);
end


fprintf('\n for loo:');
fprintf('\nprediction=%f \n\n',prediction);

prediction2=theta' *x;
fprintf('\n vector operation:');
fprintf('\nprediction2=%f \n\n',prediction2);


