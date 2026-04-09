# Installing Robot Framework and the Browser Library

In addition to Python and Robot Framework, you will need the [**Browser** library](https://robotframework-browser.org/), which enables browser automation in your tests. The Browser library uses the [**Playwright** testing tool](https://playwright.dev) under the hood, and since Playwright is implemented with Node.js, [you also need Node.js installed](https://nodejs.org/en/download).

There can be quite a few steps to get everything installed and working locally, so be patient. look for instructions and ask for help if needed. 

We have also prepared a [development container](https://code.visualstudio.com/docs/remote/containers) that has everything set up and ready to use, which can be a good option if you want to avoid installation issues. With the development container, you can open the project in VS Code and it will automatically create a development environment with the tools and dependencies installed. The container setup is described in the [development container section](#development-container) below.


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


## Development container

If you want to avoid installation issues and have a ready-to-use environment, you can use the provided [development container configuration](./.devcontainer/devcontainer.json). A [development container](https://code.visualstudio.com/docs/devcontainers/containers) is a Docker container that has all the necessary tools and dependencies installed, allowing you to work in a consistent environment that is independent of your local setup.

To use the development container locally, you need to have [Docker](https://www.docker.com/get-started) installed on your machine and the [Visual Studio Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. Once Docker is set up, you can open the project in VS Code and it will prompt you to reopen the folder in the container. After reopening, VS Code will build the container based on the configuration and install all the required tools and dependencies as specified in the [`postCreate.sh` script](./.devcontainer/postCreate.sh).


### Development container in the cloud

If installing Docker locally is not your preferred option, you can also use the same development container in a cloud-based environment such as [GitHub Codespaces](https://github.com/features/codespaces). GitHub Codespaces allows you to create a development environment in the cloud that is accessible through your browser or remotely from VS Code. The developer experience in Codespaces is very similar to using a local development container or a local installation.

You can open the project in GitHub Codespaces by following [this guide](https://docs.github.com/en/codespaces/developing-in-a-codespace/creating-a-codespace-for-a-repository#creating-a-codespace). After opening the repository in GitHub, you can create a new codespace by clicking on the "Code" button on the repository's front page and selecting "Open with Codespaces". This will create a new codespace that uses the same development container configuration, so you will have the same tools and dependencies available as if you were running it locally. This can be a convenient option if you want to avoid installing Docker or if you want to work from different machines without having to set up the environment each time.

Cloud based development environments are commercial services and may require a paid subscription. Be sure to check the pricing details of the service you choose to use. At the time of writing, GitHub Codespaces offers a free tier with limited hours of usage per month, and additional hours can be purchased if needed (see [docs.github.com](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces)).
