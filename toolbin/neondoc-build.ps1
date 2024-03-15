#Requires -Version 7.1.3 -RunAsAdministrator
#------------------------------------------------------------------------------
# FILE:         neondoc-build.ps1
# CONTRIBUTOR:  Jeff Lill
# COPYRIGHT:    Copyright (c) 2005-2024 by NEONFORGE LLC.  All rights reserved.
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
    [switch]$publish,
    [switch]$skipBrowser
)

#------------------------------------------------------------------------------
# Returns a named string constant value from: $NK_ROOT\Lib\Neon.Kube\KubeVersion.cs

function Get-KubeVersion
{
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$name
    )

    $version = $(& neon-build read-version "$env:NK_ROOT\Lib\Neon.Kube\KubeVersions.cs" $name)

    if ([System.String]::IsNullOrEmpty($version))
    {
        throw "Get-KubeVersion: [KubeVersion.$name] constant was not found."
    }

    return $version
}

#------------------------------------------------------------------------------
# Main

$ndRoot          = $env:ND_ROOT
$docSiteRoot     = $env:ND_SITE_ROOT
$nodeJsVersion   = $env:ND_NODEJS_VERSION
$neonKubeVersion = (Get-KubeVersion NeonKube)

# Check the required environment variables and also ensure that the GitHub
# pages repo is cloned locally.

if ([System.String]::IsNullOrEmpty($ndRoot))
{
    Write-Error "*** ERROR: ND_ROOT environment variable not found.  Re-run [~\neon-doc\buildenv.cmd]"
    exit 1
}

if ([System.String]::IsNullOrEmpty($docSiteRoot))
{
    Write-Error "*** ERROR: NC_DOCSITEROOT environment variable not found.  Re-run [~\neon-doc\buildenv.cmd]"
    exit 1
}

if ([System.String]::IsNullOrEmpty($nodeJsVersion))
{
    Write-Error "*** ERROR: ND_NODEJS_VERSION environment variable not found.  Re-run: ~\neon-doc\buildenv.cmd"
    exit 1
}

# We're going to use the presence of the [.neon-doc-site] file at the root 
# document site folder to verify that ND_SITE_ROOT actually hosts the documentation
# GitHub Pages site.

$docSiteIdentifier = [System.IO.Path]::Combine($docSiteRoot, ".neon-doc-site")

if (-not [System.IO.Directory]::Exists($docSiteRoot) -or -not [System.IO.File]::Exists($docSiteIdentifier))
{
    Write-Error "*** ERROR: GitHub repo [nforgeio-docs/nforgeio-docs] is not cloned to: $docSiteRoot"
    exit 1
}

# The git commands below need to run within the [neon-doc] repo directory.

Push-Location $ndRoot

try
{
    # Select the required version of Node.js.

    nvm use $env:ND_NODEJS_VERSION

    # Update the info about known browsers; this is used when
    # generating documentation files.

    if (-not $skipBrowser)
    {
        npx update-browserslist-db@latest
    }

    # Build the documentation.

    npm run build

    if (-not $?)
    {
        Write-Error "*** ERROR: Documentation build failed."
        exit 1
    }

    # Publish when requested.

    if ($publish)
    {
        # The repo at [$docSiteRoot] is a GitHub Pages site.  To publish,
        # all we need to do is:
        #
        #   1. Pull any upstream changes so git won't complain when
        #      we push any changes.
        #
        #   2. Remove all root files and folders except for the [.git]
        #      and [.vs] folders and the [.gitignore] and [.neon-doc-site]
        #      files.
        #
        #   3. Copy the contents of the [neon-doc/build] repo folders
        #      into the [$docSiteRoot] repo.
        #
        #   4. Stage, commit, and push all changes to GitHub.  It may
        #      take 10-30 minutes for GitHub to make the changes live.

        Push-Location $docSiteRoot

        try
        {
            # Exit when the [$docSiteRoot] repo is dirty.

            $response = (git status --porcelain)
            if (-not $?)
            {
                Write-Error "*** ERROR: [git status] failed."
                exit 1
            }

            if ($null -ne $response)
            {
                Write-Output "*** ERROR: Cannot publish when [$docSiteRoot] repo is dirty."
                exit 0
            }

            # Pull the upstream.

            git pull
            if (-not $?)
            {
                Write-Error "*** ERROR: [git pull] failed."
                exit 1
            }

            # Remove all folders from the [$docSiteRoot] repo except for [.git] and [.vs].

            foreach ($folderPath in [System.IO.Directory]::GetDirectories($docSiteRoot, "*", [System.IO.SearchOption]::TopDirectoryOnly))
            {
                $folderName = [System.IO.Path]::GetFileName($folderPath);

                if ($folderName -eq ".git")
                {
                    continue;
                }

                if ($folderName -eq ".vs")
                {
                    continue;
                }

                [System.IO.Directory]::Delete($folderPath, $true)
            }

            # Remove all top-level files except [.gitignore] and [.neon-doc-site] files

            foreach ($filePath in [System.IO.Directory]::GetFiles($docSiteRoot, "*", [System.IO.SearchOption]::TopDirectoryOnly))
            {
                $fileName = [System.IO.Path]::GetFileName($filePath);

                if ($fileName -eq ".gitignore")
                {
                    continue
                }

                if ($fileName -eq ".neon-doc-site")
                {
                    continue
                }

                [System.IO.File]::Delete($filePath)
            }

            # Copy the contents of the [/build] folder into the [$docSiteRoot] repo.

            Copy-Item -Path "$ndRoot\build\*" -Destination $docSiteRoot -Recurse

            # We don't need to commit/push when the repo isn't dirty.

            $response = (git status --porcelain)
            if (-not $?)
            {
                Write-Error "*** ERROR: [git status] failed."
                exit 1
            }

            if ($null -eq $response)
            {
                Write-Output " "
                Write-Output "** GitHub Pages not published: nothing changed **"
                Write-Output " "
            }

            # Commit and push changes to the [$docSiteRoot] repo.

            git add .
            if (-not $?)
            {
                Write-Error "*** ERROR: [git add] failed."
                exit 1
            }

            git commit -m "Publish documentation, NEONKUBE Version: $neonKubeVersion"
            if (-not $?)
            {
                Write-Error "*** ERROR: [git commit] failed."
                exit 1
            }

            git push
            if (-not $?)
            {
                Write-Error "*** ERROR: [git push] failed."
                exit 1
            }
        }
        finally
        {
            Pop-Location
        }

        Write-Output " "
        Write-Output "*** GitHub Pages Published ***"
        Write-Output " "
    }
}
finally
{
    Pop-Location
}
