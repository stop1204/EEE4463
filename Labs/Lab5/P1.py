"""
example:
How many stars are needed (int): 5
1-sided or 2-sided (1 or 2): 2
*
**
***
****
*****
****
***
**
*
"""
def print_star(num, side=1):
    """
    this function prints '*' depending on the number by the user inputs
    :param num: max number of '*' to be printed in a line
    :type num: int
    :param side: 1 / 2 ,1-sided or 2-sided, default 1
    :type side: int
    """

    for i in range(num):
        print("*" * (i + 1))
    if side == 2:
        for i in range(num - 1):
            print("*" * (num - i - 1))


def main():
    while True:
        try:
            num = int(input("How many stars are needed (int): "))
            side = int(input("1-sided or 2-sided (1 or 2): "))
            if side != 1 and side != 2:
                raise ValueError
            print_star(num, side)
        except ValueError:
            print("Invalid input")
        except Exception as e:
            print("Unknown error", e)


if __name__ == "__main__":
    main()
