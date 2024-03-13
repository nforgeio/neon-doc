@echo off
REM Configures the environment variables required to build NEONDOCS projects.
REM 
REM 	buildenv [ <source folder> ]
REM
REM Note that <source folder> defaults to the folder holding this
REM batch file.
REM
REM This must be [RUN AS ADMINISTRATOR].

echo ============================================
echo * NEONDOCS Build Environment Configurator  *
echo ============================================

REM Default ND_ROOT to the folder holding this batch file after stripping
REM off the trailing backslash.

set ND_ROOT=%~dp0 
set ND_ROOT=%ND_ROOT:~0,-2%

if not [%1]==[] set ND_ROOT=%1

if exist %ND_ROOT%\.neon-doc goto goodPath
echo The [%ND_ROOT%\.neon-doc] file does not exist.  Please pass the path
echo to the [neon-docs] repo folder.
goto done

:goodPath 

echo.
echo Configuring...
echo.

REM Set NF_REPOS to the parent directory holding the NEONFORGE repositories.

pushd "%NF_ROOT%\.."
set NF_REPOS=%cd%
popd

REM Set other environment variables.

set ND_SITE_ROOT=%NF_REPOS%\nforgeio-docs
set ND_NODEJS_VERSION=20.11.1

REM Persist the environment variables.

setx ND_ROOT "%ND_ROOT%" /M                               > nul
setx ND_SITE_ROOT "%NF_REPOS%\nforgeio-docs.github.io" /M > nul
setx ND_NODEJS_VERSION "%ND_NODEJS_VERSION%" /M           > nul

REM Check whether NVM (Node Version Manager) is installed and install
REM when it's not present.

where NVM > nul 2> nul

if NOT "%ERRORLEVEL%" == "0" (
	echo "Installing NVM (Node Version Manager)"
	echo.
	echo "* Answer YES to manage any installed Node.js versions."
	"%ND_ROOT%\toolbin\nvm-setup.exe" /silent
)

REM Configure the PATH.

pathtool -dedup -system -add "%ND_ROOT%\toolbin"

REM Install the required version of Node.js.

nvm install %ND_NODEJS_VERSION%
nvm use %ND_NODEJS_VERSION%

REM Install Yarn.

cd %ND_ROOT%
npm install --global yarn

REM Install the Docusaurus tools.

cd %ND_ROOT%
npm install

REM Update latest browser information.

echo y | npx update-browserslist-db@latest

REM Build the documentation to: ~/build
REM
REM NOTE: Publication is performed using the NEONCLOUD neon-kube tool.

npm run build

:done
echo.
echo ============================================================================================
echo * Be sure to close and reopen Visual Studio and any command windows to pick up the changes *
echo ============================================================================================
pause
