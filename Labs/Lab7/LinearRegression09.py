from matplotlib import pyplot as plt
import numpy as np
import csv
            
def ReadCSV(filename):
    with open(filename) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        x_mylist = []
        y_mylist = []
        for row in csv_reader:
            x_mylist.append( float(row[0]) )
            y_mylist.append( float(row[1]) )
    return x_mylist, y_mylist

# **********************
plt.close('all')

_x, _y = ReadCSV('Line.csv')
n_samples = len(_x)
x = np.array(_x)
x = x.reshape(n_samples, 1)
y = np.array(_y)
y = y.reshape(n_samples, 1)

plt.figure("Figure 1")
plt.scatter(
   x, y, color="orange", marker=".", label="data without noise"
)

plt.xlabel('Time (s)', fontsize=15)
plt.ylabel('Speed (m/s)', fontsize=15)
plt.title('Linear regression - data without noise')
# plt.legend(loc='upper left', fontsize=12)
# plt.show()

# **********************
from sklearn.linear_model import LinearRegression
reg = LinearRegression().fit(x, y)

print( f'Linear regression model (without noise): Coefficients = {reg.coef_}  intercept = {reg.intercept_}' )
print( f'y = {reg.coef_[0]} * x  +  {reg.intercept_}' )


# *************************
# Draw the fitted line
min_x = min(x)
max_x = max(x)

numOfPoint = 300
temp_x = np.linspace(min_x, max_x, num = numOfPoint)
xpoints = temp_x.reshape(numOfPoint, 1)
ypoints = reg.predict(xpoints)

plt.plot(xpoints, ypoints, color="blue", linewidth=1, label="LR model")
plt.legend(loc='upper left', fontsize=12)
plt.show()
# ******************************
# Compute the residual and show it.
prediction = reg.predict( x )
residual = prediction - y

plt.figure("Figure 2")
plt.hist(residual, bins=30)
plt.xlabel('Residual', fontsize=15)
plt.ylabel('Count', fontsize=15)
plt.title('Residual histogram (data without noise)')
plt.show()
# ****************************
# Predict y value given x value

x_test = np.array([[14.0],])
y_result = reg.predict(x_test)

print(f'When x = {x_test[0]}, y = {y_result[0]}')