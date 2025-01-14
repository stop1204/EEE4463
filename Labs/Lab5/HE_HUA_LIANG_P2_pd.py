"""
The coefficients of several quadratic equations (𝑎𝑥 + 𝑏𝑥 + 𝑐 = 0) are given in the CSV file
‘abc_lab5_p2_input.csv’

"""
import numpy as np
import pandas as pd
from setuptools.command.build_ext import if_dl


def main():
    file_path = "abc_lab5_p2_input.csv"



    pd.set_option('display.colheader_justify', 'left')
    pd.set_option('display.precision', 3)

    df = pd.read_csv(file_path,sep=",")
    print(df.to_string(index=False))
    """
     a  b  c
     1  5  3
     2 -4  2
     3  2 -1
     3  2  1
     """
    df['D'] = df['b'] ** 2 - 4 * df['a'] * df['c']
    df['p'] = ((-df['b'] - df['D'].apply(lambda x:  x**0.5)) / (2 * df['a']))
    df['q'] = ((-df['b'] + df['D'].apply(lambda x:  x**0.5)) / (2 * df['a']))

    df['p'] = df['p'].apply(lambda x: x.real)
    df['q'] = np.where(df['D'] >= 0,df['q'].apply(lambda x: round(x.real) if x.real.is_integer() else x.real ), df['q'].apply(lambda x: int(x.imag) if x.imag.is_integer() else x.imag))
    print(df.to_string(index=False))
    """
    a  b  c  D  p      q    
    1   5  3 13 -4.303 -0.697
    2  -4  2  0  1.000  1.000
    3   2 -1 16 -1.000  0.333
    3   2  1 -8 -0.333  0.471
    """

    df = df.map(lambda x: f"{int(x)}".ljust(10) if x == int(x) else f"{x:.3f}".ljust(10))
    print(df.to_string(index=False))
    """
    a          b          c          D          p          q         
    1          5          3          13         -4.303     -0.697    
    2          -4         2          0          1          1         
    3          2          -1         16         -1         0.333     
    3          2          1          -8         -0.333     0.471  
    """
    df.to_csv("abc_lab5_p2_output.csv",index=False,float_format="%.3f")

if __name__ == "__main__":
    main()
