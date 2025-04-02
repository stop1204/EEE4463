import csv

import numpy as np
from matplotlib import pyplot as plt


# https://scikit-learn.org/stable/auto_examples/linear_model/plot_ransac.html#sphx-glr-auto-examples-linear-model-plot-ransac-py

def ReadCSV(filename):
    with open(filename) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        x_mylist = []
        y_mylist = []
        for row in csv_reader:
            x_mylist.append(float(row[0]))
            y_mylist.append(float(row[1]))
    return x_mylist, y_mylist


# ******************
_x, _y = ReadCSV('ParabolaWithNoiseOutlier.csv')
number_of_samples = len(_x)
x_pos = np.array(_x)
x_pos = x_pos.reshape(number_of_samples, 1)
y_pos = np.array(_y)
y_pos = y_pos.reshape(number_of_samples, 1)

# *****************************
plt.scatter(
    x_pos, y_pos, color="gold", marker=".", label="Training data with noise and outliers"
)

# *************************** 

t1 = x_pos ** 2
t1 = t1.reshape(number_of_samples, 1)
t2 = x_pos.reshape(number_of_samples, 1)
K = np.concatenate((t1, t2), axis=1)

# **********************
from sklearn.linear_model import RANSACRegressor

ransac = RANSACRegressor(random_state=0).fit(K, y_pos)
print(f'RANSAC regression model (with noise and outliers): Coefficients = {ransac.estimator_.coef_}  intercept = {ransac.estimator_.intercept_}')
# print( f'y = {ransac.estimator_.coef_[0]} * x  +  {ransac.estimator_.intercept_}' )
print(f' y = {ransac.estimator_.coef_[0][0]} * x**2 + {ransac.estimator_.coef_[0][1]} * x + {ransac.estimator_.intercept_}')

inlier_mask = ransac.inlier_mask_
outlier_mask = np.logical_not(inlier_mask)

# *************************
# Draw the fitted curve
min_x = 0  # min(x_pos)
max_x = max(x_pos)

numOfPoint = 300
temp_x = np.linspace(min_x, max_x, num=numOfPoint)
xpoints = temp_x.reshape(numOfPoint, 1)
xxpoints = xpoints ** 2
H = np.concatenate((xxpoints, xpoints), axis=1)
prediction = ransac.predict(H)

plt.plot(temp_x, prediction, color="blue", linewidth=1, label="RANSAC regression model")

plt.xlabel('x', fontsize=15)
plt.ylabel('y', fontsize=15)
plt.legend(loc='lower left', fontsize=12)
plt.title('RANSAC regressor: data with noise and outliers')
plt.show()
# ******************************
# Extract all the inlier points using the inlier_mask
our_inlier_x = x_pos[inlier_mask]
our_inlier_y = y_pos[inlier_mask]

number_of_inlier = len(our_inlier_x)
# *************************** 
# Show all the inliers
plt.scatter(
    our_inlier_x, our_inlier_y, color="green", marker=".", label="our inliers"
)

plt.xlabel('x', fontsize=15)
plt.ylabel('y', fontsize=15)
plt.title('Our inliers')
plt.show()
# *************************** 
# Prepare data
t1 = our_inlier_x ** 2
t1 = t1.reshape(number_of_inlier, 1)
t2 = our_inlier_x.reshape(number_of_inlier, 1)
K = np.concatenate((t1, t2), axis=1)

# ******************************
# Use linear regressor to fit a curve with our inliers
from sklearn.linear_model import LinearRegression

reg = LinearRegression().fit(K, our_inlier_y)

print(f'Linear regression model (using only inliers): Coefficients = {reg.coef_}  intercept = {reg.intercept_}')
print(f' y = {reg.coef_[0][0]} * x**2 + {reg.coef_[0][1]} * x + {reg.intercept_}')

# ******************************
# Draw the fitted curve using linear regressor
min_x = min(our_inlier_x)
max_x = max(our_inlier_x)

numOfPoint = 300
temp_x = np.linspace(min_x, max_x, num=numOfPoint)
xpoints = temp_x.reshape(numOfPoint, 1)
xxpoints = xpoints ** 2
Z = np.concatenate((xxpoints, xpoints), axis=1)
prediction = reg.predict(Z)

plt.plot(xpoints, prediction, color="blue", linewidth=1, label="LR model using inliers")

# Show all the data as well
plt.scatter(
    x_pos, y_pos, color="orange", marker=".", label="data with noise and outliers"
)

plt.legend(loc='lower left', fontsize=12)
plt.xlabel('X', fontsize=15)
plt.ylabel('y', fontsize=15)
plt.title('Estimated model using inliers')

plt.show()

# ******************************
# Prepare data
t1 = x_pos ** 2
t1 = t1.reshape(number_of_samples, 1)
t2 = x_pos.reshape(number_of_samples, 1)
K = np.concatenate((t1, t2), axis=1)

# ******************************
prediction = reg.predict(K)
residual = prediction - y_pos
plt.hist(residual, bins=30)
plt.xlabel('Residual', fontsize=15)
plt.ylabel('Count', fontsize=15)
plt.title('Residual histogram (data with noise and outliers)')
plt.show()

# ****************************
# Predict y value given x value of 40.0

x_test = np.array([[40.0 ** 2, 40.0], ])
y_result = reg.predict(x_test)

print(f'When x = {x_test[0]}, y = {y_result[0]}')
