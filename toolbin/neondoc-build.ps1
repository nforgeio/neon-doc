#Requires -Version 7.1.3 -RunAsAdministrator
#------------------------------------------------------------------------------
# FILE:         neondoc-build.ps1
# CONTRIBUTOR:  Jeff Lill
# COPYRIGHT:    Copyright (c) 2005-2021 by neonFORGE LLC.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Builds and optionally publishes the [neon-doc] documentation.
#
# USAGE: pwsh -file ./neondoc-build.ps1 [-publish]
#
# ARGUMENTS: NONE
#
# OPTIONS:
#
#       -publish        - publish the documentation
#       -skipBrowser    - skip browser file update

param 
(
    [parameter(Mandatory=$true, Position=1)][string]$version,
    [parameter(Mandatory=$true, Position=2)][string]$outputFolder
    [switch]$publish,
    [switch]$skipBrowser
)

$ndRoot        = $env:ND_ROOT
$ndSiteRoot    = $env:ND_SITE_ROOT
$nodeJsVersion = $env:ND_NODEJS_VERSION

# Check the required environment variables and also ensure that the GitHub
# pages repo is cloned locally.

if ([System.String]::IsNullOrEmpty($ndRoot))
{
    Write-Error "ERROR: ND_ROOT environment variable not found.  Re-run [~\neonCLOUD\buildenv.cmd]"
    exit 1
}

if ([System.String]::IsNullOrEmpty($ndSiteRoot))
{
    Write-Error "ERROR: ND_SITE_ROOT environment variable not found.  Re-run [~\neonCLOUD\buildenv.cmd]"
    exit 1
}

if ([System.String]::IsNullOrEmpty($nodeJsVersion))
{
    Write-Error "ERROR: ND_NODEJS_VERSION environment variable not found.  Re-run [~\neonCLOUD\buildenv.cmd]"
    exit 1
}

$ndSiteCnamePath = [System.IO.Path]::Combine($ndSiteRoot, "CNAME")

if (-not [System.IO.Directory]::Exists($ndSiteRoot) -or -not [System.IO.File]::Exists($ndSiteCnamePath))
{
    Write-Error "ERROR: GitHub repo [nforgeio-docs/nforgeio-docs] is not cloned to: $$ndSiteRoot"
    exit 1
}

# Commands below need to run within the [neon-doc] repo.

Push-Location $ndRoot

try
{
    # Select the required version of Node.js.

    nvm use %ND_NODEJS_VERSION%

    # Update the info about known browsers; this is used when
    # generating documentation files.

    if (-not $skipBrowser)
    {
        npx update-browserslist-db@latest
    }

    # Build the documentation.

    npm run build

    if (-not $>)
    {
        Write-Error "ERROR: Documentation build failed."
        exit 1
    }

    # Publish when requested.

    if ($publish)
    {
        # The repo at [$ndSiteRoot] is a GitHub Pages site.  To publish,
        # all we need to do is:
        #
        #   1. Pull any upstream changes so git won't complain when
        #      we push any changes, then we'll remove all files and 
        #      folders except for [.git]
        #
        #   2. Copy the contents of the [neon-doc/build] repo folders
        #      into the [$ndSiteRoot] repo.
        #
        #   3. Stage, commit, and push all changes to GitHub.  It may
        #      take 10-30 minutes for GitHub to make the changes live.

        Push-Location $ndSiteRoot

        try
        {
            git pull
            if (-not $>)
            {
                Write-Error "ERROR: [git pull] failed."
                exit 1
            }

            foreach ($folder in [System.IO.Directory]::GetDirectories($$ndSiteRoot, [System.IO.SearchOption]::TopDirectoryOnly))
            {
                $folderName = [System.IO.Path]::GetFileName($folder));

                if ($folderName -neq ".git")
                {
                    [System.IO.Directory]::Delete($folderName, $true)
                }
            }

            foreach ($file in [System.IO.Directory]::GetFiles($ndSiteRoot, [System.IO.SearchOption]::TopDirectoryOnly))
            {
                [System.IO.File]::Delete($file)
            }

            git add .
            if (-not $>)
            {
                Write-Error "ERROR: [git add] failed."
                exit 1
            }

            git commnit -m "Publish documentation"
            if (-not $>)
            {
                Write-Error "ERROR: [git commit] failed."
                exit 1
            }

            git push
            if (-not $>)
            {
                Write-Error "ERROR: [git push] failed."
                exit 1
            }
        }
        finally
        {
            Pop-Location
        }
    }
}
finally
{
    Pop-Location
}
