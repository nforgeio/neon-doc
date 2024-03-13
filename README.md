# Useful Maintainer Information

This page describes how to configure your workstation to work with the NEONFORGE
documentation as well as how to build and public it.

## Maintainer Setup

Run `~\.buildenv.cmd` as administrator, which:

* Configures some environment variables:

  * **ND_ROOT:** references the local **neon-doc**  git repo folder

  * **ND_SITE_ROOT:** references the local **nforgeio-docs/nforgeio-docs.github.io** folder

  * **ND_NODEJS_VERSION** configures the version of Node.js we'll use to
	run the Docusaurus tools.

  * **PATH:** Adds **~/toolbin** to the PATH so the documentation build script
	and related tools can be executed easily from the command line.

* Checks for **nvm** installation and executes `~\toolbin\nvm-setup.exe` when
  that's not already installed.  Answer YES if the installer asks to manage
  any existing Node.js installations.

* Installs the Docusaurus tools.

## How this Works

We're using the open source [Docusaurus](https://docusaurus.io) project to generate
a static website from this repo and Microsoft's open source [docfx](https://github.com/dotnet/docfx)
tool to generate API reference documentation from .NET code comments.

> **$todo(jefflill):** **docfx** code reference builds are currently performed manually
> after figuring out and addressing that, I'll need to document how that works here.

Our documentation release process involves these GitHub repos:

* **nforgeio/neon-doc (this repo):** non-SDK reference documentation source
* **nforgeio-docs/nforgeio-docs.github.io:** GitHub Pages repo where the documentation is published

The build script (discussed below) runs the Docusaurus tool on the **nforgeio/neon-doc**
local repository, generating the website files in the `~/build` folder and when plublishing
to the public, the script replaces the website files in the **nforgeio-docs/nforgeio-docs.github.io**
repository and then commits and pushes the changes to GitHub, which will publish this to
the Internet after 10-30 minutes of processing.

# Building and Publishing Documentation

The **neondoc-build** build scripts are located at `~/toolbin/neondoc-build.ps1` and `neondoc-build.cmd`,
with the PowerShell script doing all of the qwork and the Windows CMD script wrapping the
PowerShell script making it easier to launch from the command line.

```
# Build the documentation to the [~/build] folder:

```
# Build docs without publishing:
neondoc-build
   
# Build docs without publishing and without updating browser info:
neondoc-build -skipBrowser
   
# Build and publish the docs:
neondoc-build -publish
```
   
This has been integrated into our **neon-kube** build/stage/release tooling, where
documentation will be built but not published during builds and staging and published
only after the GitHub release has been published.
   
**NOTE:** I've disabled the **deploy.yaml** GitHub action by renaming it because automatically
publishing the site when commits are pushed doesn't really make sense; in general, we don't
want to publish documentation changes before the related software changes are public too.
   
In cases where we need to publish corrections, we can just run this manually:
   
```
neondoc-build -publish
```
