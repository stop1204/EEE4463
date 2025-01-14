"""
The coefficients of several quadratic equations (𝑎𝑥 + 𝑏𝑥 + 𝑐 = 0) are given in the CSV file
‘abc_lab5_p2_input.csv’

"""
import cmath
import math


def read_csv(path):
    """
    read csv file and return the content as list
    :param path: path to the csv file
    :type path: str
    :return: csv file content
    :rtype: list
    """
    if not path.endswith(".csv"):
        raise ValueError("Invalid file format")
    with open(path, "r") as f:
        lines = f.readlines()
    return lines


def get_max_col_width(lines, sep=","):
    """
    find the max column width in the each column
    at least (max length + 2) spaces between each column
    :param lines: csv file content
    :type lines: list
    :param sep: separator symbol, default ","
    :type sep: int
    :return: max column width
    :rtype: int
    """
    max_col_width = 4
    for line in lines:
        cols = line.strip().split(sep)
        for i, column in enumerate(cols):
            if len(column) > max_col_width:
                max_col_width = len(column)

    return max_col_width + 2


def print_pretty_csv(lines, col_width=8, sep=","):
    """
    print the csv file content in a pretty format
    :param lines: csv data
    :type lines: list
    :param col_width: column width, default 8
    :type col_width: int
    :param sep: separator symbol, default ","
    :type sep: str
    """
    # if is list
    for line in lines:
        cols = line.strip().split(sep)
        for i, column in enumerate(cols):
            if i == 0:
                print(column.ljust(col_width), end="")
            else:
                print(column.ljust(col_width), end="")
        print()
    return


def quadratics(lines, precision=2, complex=False):
    """
    calculate the quadratic equations
    :param lines: csv file content
    :type lines: list | pd.DataFrame
    :return: result of the quadratic equation
    :rtype: pd.DataFrame
    """
    # if is pandas DataFrame
    result = ["D,p,q"]
    for line in lines:
        a, b, c = line.strip().split(",")
        a, b, c = int(a), int(b), int(c)
        if complex:
            D, p, q = quadratic_complex(a, b, c, precision)
        else:
            D, p, q = quadratic(a, b, c, precision)
        result.append(f"{D},{p},{q}")
    return result


def quadratic(a, b, c, precision=2):
    """
    calculate the quadratic equation
    :param a: a
    :type a: int
    :param b: b
    :type b: int
    :param c: c
    :type c: int
    :param p: precision, default 2
    :type p: int
    :return: discriminant, result 1, result 2
    :rtype: float, float, float
    """
    D = b ** 2 - 4 * a * c
    DD = 0
    try:
        if D < 0:
            raise ValueError
        if D > 0:
            DD = math.sqrt(D)
    except ValueError:
        # print("No real roots")
        return D, 'NaN', 'NaN'

    p = round((-b - DD) / (2 * a), precision)
    q = round((-b + DD) / (2 * a), precision)

    # this will turn the float to int if the float is actually an integer
    return D, int(p) if p.is_integer() else p, int(q) if q.is_integer() else q


def list_concat(list1, list2):
    """
    concatenate two lists in column
    :param list1: main list
    :type list1: list
    :param list2: list to be concatenated
    :type list2: list
    :return: new list
    :rtype: list
    """
    row_count = len(list1)
    list1 = list1.copy()
    for i in range(row_count):
        list1[i] = str(list1[i]).strip('\n') + ',' + str(list2[i]).strip('\n')
    return list1


def quadratic_complex(a, b, c, precision=2):
    """
    calculate the quadratic equation with complex numbers
    :param a: a
    :type a: int
    :param b: b
    :type b: int
    :param c: c
    :type c: int
    :param p: precision, default 2
    :type p: int
    :return: discriminant, result 1, result 2
    :rtype: float, float, float
    """
    D = b ** 2 - 4 * a * c
    DD, p, q = 0, 0, 0
    if D < 0:
        DD = cmath.sqrt(D)
        p = (-b - DD) / (2 * a)
        q = (-b + DD) / (2 * a)
        p = round(p.real, precision)
        q = round(q.imag, precision)
    else:
        DD = math.sqrt(D)
        p = (-b - DD) / (2 * a)
        q = (-b + DD) / (2 * a)
        p = round(p, precision)
        q = round(q, precision)

    # this will turn the float to int if the float is actually an integer
    return D, int(p) if p == int(p) else p, int(q) if q == int(q) else q


def main():
    file_path = "abc_lab5_p2_input.csv"
    lines = read_csv(file_path)
    max_col_width = get_max_col_width(lines)
    print_pretty_csv(lines, max_col_width)
    """
    a    b    c    
    1    5    3    
    2    -4   2    
    3    2    -1   
    3    2    1  
    """
    # deufalt col_width is 8
    print_pretty_csv(lines)
    """
    a       b       c       
    1       5       3       
    2       -4      2       
    3       2       -1      
    3       2       1       
    1       5       3
    """
    new_lines = list_concat(lines, quadratics(lines[1:], precision=3))
    print_pretty_csv(new_lines)
    """
    a       b       c       D       p       q       
    1       5       3       13      -4.303  -0.697  
    2       -4      2       0       1       1       
    3       2       -1      16      -1      0.333   
    3       2       1       -8      NaN     NaN     
    """

    new_lines_complex = list_concat(lines, quadratics(lines[1:], precision=3, complex=True))
    print_pretty_csv(new_lines_complex)
    """
    a       b       c       D       p       q       
    1       5       3       13      -4.303  -0.697  
    2       -4      2       0       1       1       
    3       2       -1      16      -1      0.333   
    3       2       1       -8      -0.333  0.471  
    """
    with open("abc_lab5_p2_output.csv", "w") as f:
        f.write("\n".join(new_lines_complex))


if __name__ == "__main__":
    main()
