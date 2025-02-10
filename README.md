## Installation
1. Download and Install [Python](https://www.python.org/downloads/ "Python").
2. Check Python installation

    `python3 -V`

3. Install [pip](https://pip.pypa.io/ "pip").

    `pip3 -V`

4. Install Robot Framework.

    `pip3 install robotframework`
    
5. Install Requests Library.

    `pip3 install robotframework-requests`
    
6. Download and install VSCode [VSCode](https://code.visualstudio.com/docs/?dv=osx "VSCode").
7. Install [Robot Code](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode "Robot Code") extension from VSCode's Marketplace

## File organization
```
|- robotframework/                           // Home folder for robot API automation project
  |- config/env.robot                           // Common variables of the application
  |- libraries/assert.robot                                  // Common Assert keywords to validate the result
  |- libraries/data.csv                                  // Data for testing
  |- libraries/readData.robot                                  // Common keywords to read and get data from CSV
  |- libraries/utility.robot                                  // Keywords for common function
  |- test/merchant_service_automated_test.robot                                           // Test cases of the application
|- results                                                        // Test results will be saving here
|- .gitignore                                                     // Excluded the unnecessary files in the repo
|- README.md                                                      // This file
```

## Usage
Starting from Robot Framework 3.0, tests are executed from the command line
using the ``robot`` script or by executing the ``robot`` module directly
like ``python -m robot`` or ``jython -m robot``.

The basic usage is giving a path to a test (or task) file or directory as an
argument with possible command line options before the path

    python3 -m robot -d results test

"***-d***" refers to the test results. The location to save the test results can be specified here.

Additionally there is ``rebot`` tool for combining results and otherwise
post-processing outputs

    rebot --name Example output1.xml output2.xml

Run ``robot --help`` and ``rebot --help`` for more information about the command
line usage. For a complete reference manual see [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html "Robot Framework User Guide").
