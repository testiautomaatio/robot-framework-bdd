# Development container

If you want to avoid installation issues and have a ready-to-use environment, you can use the provided [development container configuration](./.devcontainer/devcontainer.json). A [development container](https://code.visualstudio.com/docs/devcontainers/containers) is a [Docker container](https://www.docker.com/resources/what-container/) that has all the necessary tools and dependencies installed, allowing you to work in a consistent environment that is independent of your local setup.

In this case, the development container is [configured](./.devcontainer/devcontainer.json) with Python, Node.js, and the RobotCode VS Code extension, along with typical command-line tools. The repository uses Robot Framework with its Browser library; the Browser library uses Playwright behind the scenes.

The container setup installs the Python dependencies from [`requirements.txt`](./requirements.txt) and initializes Chromium for the Browser library with `rfbrowser init chromium --with-deps`. This also installs the system dependencies required by the browser.


## Run a container locally

To use the development container locally, you need to have [Docker](https://www.docker.com/get-started) installed on your machine and the [Visual Studio Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. Once Docker is set up, you can open the project in VS Code and it will prompt you to reopen the folder in the container. After reopening, VS Code will build the container based on the configuration and install the required tools and dependencies as specified in the [`postCreate.sh` script](./.devcontainer/postCreate.sh) and the [requirements file](./requirements.txt).


### Stopping and removing local containers

Development containers are typically associated with specific projects and folders. When you work with multiple projects over time, you can end up with multiple unnecessary containers that take up disk space.

To stop or remove a container, you can use the Docker CLI, the Docker Desktop application or one of many VS Code extensions. You can also use the VS Code dev containers extension to clean up unnecessary containers: simply open the command palette (Ctrl+Shift+P) and run the "Dev Containers: Clean Up Dev Containers" command to select which containers to remove. Deleting a container is safe assuming that you have committed all your changes to the repository.


## Run a container in the cloud

If installing Docker locally is not your preferred option, you can also use the same development container in a cloud-based environment such as [GitHub Codespaces](https://github.com/features/codespaces). GitHub Codespaces allows you to create a development environment in the cloud that is accessible through your browser or [your locally installed VS Code](https://docs.github.com/en/codespaces/developing-in-a-codespace/using-github-codespaces-in-visual-studio-code). The developer experience in Codespaces is very similar to using a local development container or a local installation.

You can open the project in GitHub Codespaces by following [this guide](https://docs.github.com/en/codespaces/developing-in-a-codespace/creating-a-codespace-for-a-repository#creating-a-codespace). After opening the repository in GitHub, you can create a new codespace by clicking on the "Code" button on the repository's front page and selecting "Open with Codespaces". This will create a new codespace that uses the same development container configuration, so you will have the same tools and dependencies available as if you were running it locally. This can be a convenient option if you want to avoid installing Docker or if you want to work from different machines without having to set up the environment each time.

Cloud based development environments are commercial services and may require a paid subscription. Be sure to check the pricing details of the service you choose to use. At the time of writing, GitHub Codespaces offers a free tier with limited hours of usage per month, and additional hours can be purchased if needed (see [docs.github.com](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces)).


### Stopping and removing remote containers

Development containers have time and storage limits and the storage limits can be exceeded if you have multiple large containers, such as those with browsers and other extra tools installed.

When done using the container, you should stop it to stop incurring costs or using the free hours. When completely done with the exercise, you should also delete the container to free up space. Deleting the container is safe assuming that you have committed all your changes to the repository.

For information about how to [stop](https://docs.github.com/en/codespaces/developing-in-a-codespace/stopping-and-starting-a-codespace) and [delete containers](https://docs.github.com/en/codespaces/developing-in-a-codespace/deleting-a-codespace), see the documentation of the service you are using.


## Tips, troubleshooting, and resources

### Opening Robot Framework reports

Robot Framework creates `report.html` and `log.html` when tests are run. In this repository, test output is written to the `test-results` directory; for example, run `robot --outputdir=test-results tests/example.robot` and open `test-results/report.html` or `test-results/log.html` in VS Code.


### Graphical applications

Opening graphical applications that are running inside the development container, such as a browser launched by a test, might not work the same way as on your local machine. This is because the development container is a separate environment that does not have direct access to your local display server.

We have included the [Desktop Lite feature](https://github.com/devcontainers/features/tree/main/src/desktop-lite) in the development container to provide a way to run graphical applications in a web-based desktop environment. You can access this environment by opening a browser and navigating to `http://localhost:6080`. This will give you a web-based desktop where you can use graphical applications that are installed in the development container.
