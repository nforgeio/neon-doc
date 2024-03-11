# Developer Setup

Run `~\.buildenv.cmd` as administrator, which:

* Configures the `ND_ROOT` environment variable to reference the **documentation** 
  git repo folder.

* Checks for **nvm** installation and executes `~\toolbin\nvm-setup.exe` when
  that's not already installed.  Answer YES if the installer asks to manage
  any existing Node.js installations.

* Sets **ND_NODEJS_VERSION=20.11.1**, specifying the Node.js version to use for bulding 
  documentartion, and then uses NVM to install that version of node.

* Installs the Docusaurus tools.

# Build Documentation


```
# Build the documentation to the [~/build] folder:

neondoc-build

# Build and publish the documentation to [nforgeio-docs.github.io] (GitHub Pages):

neondoc-build -publish
```