Installation
Download and Install Python.

Check Python installation

python3 -V

Install pip.

pip3 -V

Install Robot Framework.

pip3 install robotframework

Install Requests Library.

pip3 install robotframework-requests

Download and install VSCode VSCode.

Install Robot Code extension from VSCode's Marketplace

Example
Here, I have developed sample test cases for a sample API project JSONPlaceholder.

This project is developed to demontrate API automation using Robot Framework and Requests Library.

File organization
|- robot-framework-api-automation-demo/                           // Home folder for robot API automation project
  |- configs/ApplicationVariables.robot                           // Common variables of the application
  |- configs/Environment.robot                                    // Test execution environment configurations
  |- libraries/ApiKeywords.robot                                  // Common API keywords of the application
  |- test-cases/*.robot                                           // Test cases of the application
|- results                                                        // Test results will be saving here
|- .gitignore                                                     // Excluded the unnecessary files in the repo
|- README.md                                                      // This file
Usage
Starting from Robot Framework 3.0, tests are executed from the command line using the robot script or by executing the robot module directly like python -m robot or jython -m robot.

The basic usage is giving a path to a test (or task) file or directory as an argument with possible command line options before the path

python3 -m robot -v ENV:SIT -i Smoke -d results path/to/tests/
python3 -m robot -v ENV:SIT -i Smoke -d results test-cases
"-v" refers to the variables. To replace a declared value within the code, you can specify a variable name and value.

"-i" refers to the tags. To run only a selected group of tests, you may specify a tag name.

"-d" refers to the test results. The location to save the test results can be specified here.

Additionally there is rebot tool for combining results and otherwise post-processing outputs

rebot --name Example output1.xml output2.xml
Run robot --help and rebot --help for more information about the command line usage. For a complete reference manual see Robot Framework User Guide.