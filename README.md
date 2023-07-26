# Devcontainer image for IBM Cloud Projects

This repository contains code for running a [devcontainer][dev-containers] environment with the following toolset installed:

- `ibmcloud cli` - IBM Cloud command line client and plugins
- `softlayer` - SoftLayer python command line client
- `terraform` - Infrastructure as Code tool 
- `tfswitch` - handy tool to switch between versions of Terraform.
- `ansible` - Ansible CLI to run playbooks on deployed infrastructure.

## Prerequisites

In order to use this devcontainer, your local system must meet the following prerequisites:

- [Docker](https://www.docker.com/products/docker-desktop/) installed
- [Visual Studio Code](https://code.visualstudio.com/) installed.
- [VSCode Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) installed.

## Getting Started

1. Inside your existing project, execute the following on Mac, Linux or [WSL][wsl]:

```bash
curl -sL https://raw.githubusercontent.com/greyhoundforty/tycho-devbox/main/scripts/init.sh | bash
````

2. Open the folder with VSCode
3. When prompted, click `Reopen in Container`

---

The program is provided as-is with no warranties of any kind, express or implied.

[dev-containers]: https://code.visualstudio.com/docs/remote/containers
[wsl]: https://learn.microsoft.com/en-us/windows/wsl/install
