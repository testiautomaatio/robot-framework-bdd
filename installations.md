# Installing Robot Framework and the Browser Library

In addition to Python and Robot Framework, you will need the [**Browser** library](https://robotframework-browser.org/), which enables browser automation in your tests. The Browser library uses the [**Playwright** testing tool](https://playwright.dev) under the hood, and since Playwright is implemented with Node.js, [you also need Node.js installed](https://nodejs.org/en/download).

There can be quite a few steps to get everything installed and working locally, so be patient. look for instructions and ask for help if needed. 

> [!TIP]
> This repository includes a development container configuration as described in the [development container section](./devcontainer.md). With the container, you can avoid installation issues and have a ready-to-use isolated environment either in the cloud or locally. We highly encourage using development containers for simplicity, reproducibility and security reasons.


## Local installation

First verify that you have the required tools installed by running the following commands in your terminal:

```sh
python3 --version  # or `py --version` on Windows

node --version
pip --version
```

The command used to start Python may vary depending on your operating system and how Python was installed. In most systems, `python3` works, but on Windows you may need to use the `py` command.


If any of the commands above fail, it means that the corresponding tool is either not installed or not added to your [system's PATH](https://en.wikipedia.org/wiki/PATH_(variable)). Either way, look for instructions specific to your operating system, your preferred installation method, and your setup to get the tools installed and working before proceeding.


### 1. Install Robot Framework

The Robot Framework website provides a [quick installation guide](https://robotframework.org/?tab=1#getting-started) to help you get started. There is also a more detailed [separate installation guide](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst) that explains the different options in more depth.

According to the quick guide, you can install Robot Framework using the pip package manager:

```sh
# Install Robot Framework with pip:
pip install robotframework

# Verify the installation (prints usage instructions):
robot --help
```

The `pip` package manager used in the command above is installed with Python by default. More detailed information about the `robotframework` package is available on PyPI: https://pypi.org/project/robotframework/.


### 2. Install the Browser library and test browsers

Robot Framework includes the core functionality needed to run tests, but it does not include built-in libraries for browser automation. For that reason, you need a separate library such as the [Browser library](https://robotframework-browser.org/), which enables browser automation with Robot Framework. The Browser library uses [Playwright](https://playwright.dev) in the background, which is a Node.js-based tool for browser automation.

Read the [Browser library installation instructions](https://robotframework-browser.org/#installation) and install it. According to the quick installation guide, you can install it with pip as follows:

```sh
# Install Browser library from PyPI with pip:
pip install robotframework-browser

# Verify the installation (prints usage instructions):
rfbrowser --help
```

More detailed information about the `robotframework-browser` package is available at https://pypi.org/project/robotframework-browser/. You can also read the usage instructions that were printed to the console with the `--help` command.

Next, you need the Playwright tool and its browser binaries. These can be installed through the Browser library using the `rfbrowser init` command:

```sh
# Initialize the Browser library (installs all browsers):
rfbrowser init

# Alternatively, install only Chromium to save time and disk space:
rfbrowser init chromium
```

You do not need to install Playwright separately when using the Browser library, because it is installed by the commands above.

At the end of the exercise or course, when you no longer need the browsers, you can free up space and remove the tools and browser binaries with the following command:

```sh
# Clean up browsers and node dependencies:
rfbrowser clean-node

# Optionally, uninstall Robot Framework and Browser library:
pip uninstall robotframework-browser
pip uninstall robotframework
```


### 3. Install the VS Code extension (optional but recommended)

The [Robot Framework documentation](https://docs.robotframework.org/docs/getting_started/ide) recommends VS Code together with the [RobotCode](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode) extension for writing and running tests in VS Code. It is worth reviewing the extension and installing it if it fits your workflow. The extension provides [syntax highlighting, autocompletion, and the ability to run tests directly from the editor](https://robotcode.io/) ([robotcode.io](https://robotcode.io/)).
