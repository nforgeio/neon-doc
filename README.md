# Developer Setup

1. Run `~\.buildenv.cmd` as administrator, which:

   * Configures the `ND_ROOT` environment variable to reference the **documentation** 
	 git repo folder.

   * Checks for **nvm** installation and executes `~\toolbin\nvm-setup.exe` when
	 that's not already installed.  Answer YES if the installer asks to manage
	 any existing Node.js installations.

   * Sets **ND_NODEJS_VERSION=20.11.1**, specifying the Node.js version to use for bulding 
	 documentartion, and then uses NVM to install that version of node.

