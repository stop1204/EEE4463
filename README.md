![Static Badge](https://img.shields.io/badge/https%3A%2F%2Fimg.shields.io%2Fbadge%2F%2Fantext-3.12.4-blue?style=plastic&logo=Python&logoColor=%233776AB&label=Python&labelColor=white&link=https%3A%2F%2Fwww.python.org%2Fdownloads%2F)
![Static Badge](https://img.shields.io/badge/Jupyter-white?style=plastic&logo=Jupyter&logoColor=%23F37626)

![Static Badge](https://img.shields.io/badge/https%3A%2F%2Fimg.shields.io%2Fbadge%2Fany_text-1.26.4-red?style=plastic&logo=Numpy&logoColor=%23013243&label=Numpy)
![Static Badge](https://img.shields.io/badge/https%3A%2F%2Fimg.shields.io%2Fbadge%2Fany_text-2.2.2-red?style=plastic&logo=Pandas&logoColor=%23150458&label=Pandas)
![Static Badge](https://img.shields.io/badge/https%3A%2F%2Fimg.shields.io%2Fbadge%2Fany_text-3.10.0-red?style=plastic&logo=&logoColor=%23150458&label=Matplotlib)

#

# EEE4463 Course Code Repository

This repository is dedicated to storing code and related materials for the EEE4463 course. It aims to provide a centralized location for all the programming tasks, projects, and examples related to the course content.

## Repository Contents
- **Location**: The main source code files for various algorithms and applications covered in the course are stored in the `Labs` directory.
- **Organization**: Each lab has its own subdirectory within `Labs`, which helps in organizing the codebase efficiently. Within these subdirectories, you will find Python scripts along with their corresponding Jupyter notebooks for each algorithm or application. For instance, there will be code related to machine learning models such as linear regression, logistic regression, neural networks, and more. Each model's code and its associated Jupyter notebook will be organized in separate subdirectories under the respective lab's directory. This dual-code format (Python and Jupyter) allows for both traditional script execution and interactive data exploration and experimentation.

## How to Use
1. **Clone the repository** to your local machine using the command:
```bash
git clone https://github.com/stop1204/EEE4463.git
```
2. Navigate to the relevant directories to access the code, data, or documentation you need.
3. Follow the instructions provided in the documentation to run the code and perform the required tasks.

## Troubleshooting
1. When you run the code, if File Load Error for `xxx.ipynb` Unreadable Notebook: `/Users/xxx/Labs/xxx.ipynb` NBFormatError [('Unsupported nbformat version 5')](). Please open the `xxx.ipynb` file with a `text editor`, change [("nbformat": 5 to "nbformat": 4)](), or lower (the version supported by your environment), then save the file, rerun the code

If you encounter any issues while running the code or have any questions, please open an issue in the repository.
## Contribution Guidelines
- Fork the repository to your own GitHub account.
- Create a new branch for your changes:
```bash
git checkout -b main
```
- Make your changes and commit them with descriptive commit messages.
- Push your changes to your forked repository:
```bash
git push origin main
```
- Open a pull request in the original repository, describing the changes you have made.


## License
[MIT License](LICENSE)
