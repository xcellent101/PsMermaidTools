# PsMermaidTools

PowerShell Module to create [Mermaid](https://mermaid-js.github.io) diagrams.

## Installation

### From PowerShell Gallery

Install PsMermaidTools from [PowerShell Gallery](https://www.powershellgallery.com/packages/PsMermaidTools) using a PowerShell command line:

```powershell
Install-Module -Name PsMermaidTools -Scope CurrentUser
#The above command fails when tested in Aug2024. Suspect the module is removed from PSGallery

#Alternatively you can download the zip file from the [releases page](https://github.com/xcellent101/PsMermaidTools) and extract it to a folder of your choice and then install
Install-Module -Name PsMermaidTools -Scope CurrentUser -Path "path-to-extracted-zip-file"
```

### From GitHub (Clone)
Clone the project from Github and run the following command on your project folder
```pwsh
#git clone the project from Github and run the following command on your project folder
git clone https://github.com/xcellent101/PsMermaidTools

#and then import the main module in your code
Import-Module -Name .\PsMermaidTools\src\PsMermaidTools.psm1
```



### From Source

```powershell
Invoke-Build Install
```

## Usage

See [the command reference](./docs/) for descriptions and examples.

See detailed examples & How to at the [HowTo Link](./XcellentNotes.md/) 

## Changelog

See the [changelog](./CHANGELOG.md) file.

## Development

[![.github/workflows/build-validation.yml](https://github.com/abbgrade/PsMermaidTools/actions/workflows/build-validation.yml/badge.svg?branch=develop)](https://github.com/abbgrade/PsMermaidTools/actions/workflows/build-validation.yml)

- This is a [Portable Module](https://docs.microsoft.com/de-de/powershell/scripting/dev-cross-plat/writing-portable-modules?view=powershell-7).
- [VSCode](https://code.visualstudio.com) is recommended as IDE. [VSCode Tasks](https://code.visualstudio.com/docs/editor/tasks) are configured.
- Build automation is based on [InvokeBuild](https://github.com/nightroman/Invoke-Build)
- Test automation is based on [Pester](https://pester.dev)
- Commands are named based on [Approved Verbs for PowerShell Commands](https://docs.microsoft.com/de-de/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands)
- This project uses [git-flow](https://github.com/nvie/gitflow).
- This project uses [keep a changelog](https://keepachangelog.com/en/1.0.0/).
- This project uses [PsBuildTasks](https://github.com/abbgrade/PsBuildTasks).

### Build

The build scripts require InvokeBuild. If it is not installed, install it with the command `Install-Module InvokeBuild -Scope CurrentUser`.

You can build the module using the VS Code build task or with the command `Invoke-Build Build`.

### Release

1. Create a release branch using git-flow.
2. Update the version number in the module manifest.
3. Extend the changelog in `CHANGELOG.md`.
4. If you want to create a pre-release:
   1. Push the release branch to github, to publish the pre-release to PsGallery.
5. run `Update-Changelog -ReleaseVersion $version -LinkMode None`
6. Finish release using git-flow.
7. Check if tags are not pushed to github.
8. Check if the release branch is deleted on github.
9. Create the release on github.

