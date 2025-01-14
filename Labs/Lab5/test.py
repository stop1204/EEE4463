import sys
import unittest
from io import StringIO
from HE_HUA_LIANG_P1 import  print_star

class TestPrintStar(unittest.TestCase):
    def setUp(self):
        self.held, sys.stdout = sys.stdout, StringIO()

    def tearDown(self):
        sys.stdout = self.held

    def test_print_star_1_sided(self):
        print_star(3,1)
        self.assertEqual(sys.stdout.getvalue().strip(), '*\n**\n***')

    def test_print_star_2_sided(self):
        print_star(3,2)
        self.assertEqual(sys.stdout.getvalue().strip(), '*\n**\n***\n**\n*')

if __name__ == '__main__':
    unittest.main()

