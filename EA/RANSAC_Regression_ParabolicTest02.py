#  MIT License
#
#  Copyright (c) 2025 terry.hhl@icloud.com
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.

import csv

import numpy as np
from matplotlib import pyplot as plt
from sklearn.linear_model import RANSACRegressor


def ReadCSV(filename):
    """
        Read data from a CSV file and return two lists of x and y values.

        This function opens a CSV file, reads its contents, and extracts two columns
        of numerical data. It assumes the CSV file has two columns separated by a comma,
        where the first column represents x values and the second column represents y values.

        Parameters:
        filename (str): The name or path of the CSV file to be read.

        Returns:
        tuple: A tuple containing two lists:
            - x_mylist (list): A list of float values from the first column of the CSV.
            - y_mylist (list): A list of float values from the second column of the CSV.

    """
    with open(filename) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        x_mylist = []
        y_mylist = []
        for row in csv_reader:
            x_mylist.append(float(row[0]))
            y_mylist.append(float(row[1]))
    return x_mylist, y_mylist


# ******************
# Data Preparation
"""
Read data from CSV file, convert to numpy arrays, and reshape for further processing.
This section prepares the input data for the RANSAC regression model.
"""
_x, _y = ReadCSV('ParabolaWithNoiseOutlier.csv')
number_of_samples = len(_x)
x_pos = np.array(_x)
x_pos = x_pos.reshape(number_of_samples, 1)
y_pos = np.array(_y)
y_pos = y_pos.reshape(number_of_samples, 1)

# *************************** 
# Feature Engineering
"""
Prepare the feature matrix for quadratic regression.
Create a matrix K that includes x^2 and x as features for the regression model.
"""
t1 = x_pos ** 2
t1 = t1.reshape(number_of_samples, 1)
t2 = x_pos.reshape(number_of_samples, 1)
K = np.concatenate((t1, t2), axis=1)

# ************************
# Model Training
"""
Train a RANSAC regression model using the prepared features.
The model will fit a quadratic function to the data.
"""

ransac = RANSACRegressor(random_state=0).fit(K, y_pos)
print(
    f'RANSAC regression model (with noise and outliers): Coefficients = {ransac.estimator_.coef_}  intercept = {ransac.estimator_.intercept_}')
print(f'y = {ransac.estimator_.coef_[0][0]} * x^2 + {ransac.estimator_.coef_[0][1]} * x + {ransac.estimator_.intercept_[0]}')

inlier_mask = ransac.inlier_mask_
outlier_mask = np.logical_not(inlier_mask)
# *************************
# Draw the fitted line using RANSAC
min_x = min(x_pos)
max_x = max(x_pos)

numOfPoint = 300
temp_x = np.linspace(min_x, max_x, num=numOfPoint)
t1_pred = temp_x ** 2
t1_pred = t1_pred.reshape(numOfPoint, 1)
t2_pred = temp_x.reshape(numOfPoint, 1)
xpoints = np.concatenate((t1_pred, t2_pred), axis=1)
ypoints = ransac.predict(xpoints)
# Data Visualization - Scatter Plot
"""
Create a scatter plot of the input data.
This helps visualize the distribution of the data points, including noise and outliers.
"""
plt.figure("Figure 1")

plt.plot(temp_x, ypoints, color="blue", linewidth=2, label="RANSAC regression model")
plt.scatter(
    x_pos[inlier_mask], y_pos[inlier_mask], color="orange", marker=".", label="Training data with noise"
)
plt.scatter(
    x_pos[outlier_mask], y_pos[outlier_mask], color="red", marker=".", label="Training data with outliers"
)
plt.xlabel('X (Distance unit: m)', fontsize=15)
plt.ylabel('Y (Height unit: m)', fontsize=15)
plt.title('RANSAC regression - data with noise and outliers')
plt.legend(loc='lower left', fontsize=12)
plt.show()

# ******************************
# Residual Analysis
"""
Analyze the residuals of the model to assess its performance.
Plot a histogram of residuals to visualize their distribution.
"""
prediction = ransac.predict(K)
residual = prediction - y_pos
plt.figure("Figure 2")
plt.hist(residual, bins=30)
plt.xlabel('Residual', fontsize=15)
plt.ylabel('Count', fontsize=15)
plt.title('Residual histogram (data with noise and outliers)')
plt.show()

# ****************************
# Predict y value given x value of 40.0
"""
Use the trained model to make a prediction for a specific x value.
This demonstrates how to use the model for new data points.
"""
x_test = np.array([[40.0 ** 2, 40.0], ])
y_result = ransac.predict(x_test)

print(f'When x = {x_test[0]}, y = {y_result[0]}')

# ****************************
# k[inlier_mask] show the residual without outliers
prediction = ransac.predict(K[inlier_mask])
residual = prediction - y_pos[inlier_mask]
plt.figure("Figure 4")
plt.hist(residual, bins=30)
plt.xlabel('Residual', fontsize=15)
plt.ylabel('Count', fontsize=15)
plt.title('Residual histogram (data without noise and outliers)')
plt.show()
