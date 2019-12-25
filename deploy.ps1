#
# Object: Script to automate deployment of a simple AD Lab with heterogeneous OS, on Azure
# Thanks: Based on automatedlab https://github.com/AutomatedLab/
# Author: @lydericlefebvre
#


#################
# Prerequisites #
#################
# To deploy on Azure, you have to have an Azure account.
# You can have a free one, but limited to 4 Core (OK to deploy up to 4 VMs).
# https://azure.microsoft.com/en-us/free/

# Install automatedlab (msi setup)
# https://github.com/AutomatedLab/AutomatedLab/releases

# Install Azure Powershell
# Install-Module -Name Az -AllowClobber -Scope CurrentUser


##################
# Lab Deployment #
##################
# Interactively connect to Azure with Azure Powershell
Login-AzAccount

# We choose our Location
# https://azure.microsoft.com/en-us/global-infrastructure/locations/
$azureDefaultLocation = 'France Central'

# Lab definition
New-LabDefinition -Name PawPatrol -DefaultVirtualizationEngine Azure

# We add a lab Azure subscription. Can take 1 hour the first time it is launched because of lab sources sync.
Add-LabAzureSubscription -DefaultLocationName $azureDefaultLocation

# Définition des machines à déployer
# You can get available Azure image names with the following command
# Get-LabAvailableOperatingSystem -Azure -Location WestEurope
Add-LabMachineDefinition -Name DC1-2019-DAT -Memory 1GB -OperatingSystem 'Windows Server 2019 Datacenter' -Roles RootDC -DomainName pawpatrol.local
Add-LabMachineDefinition -Name SRV-2019-DAT -Memory 1GB -OperatingSystem 'Windows Server 2019 Datacenter' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name SRV-2016-DAT -Memory 1GB -OperatingSystem 'Windows Server 2016 Datacenter' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name SRV-2012-R2-DAT -Memory 1GB -OperatingSystem 'Windows Server 2012 R2 Datacenter (Server with a GUI)' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name SRV-2012-DAT -Memory 1GB -OperatingSystem 'Windows Server 2012 Datacenter (Server with a GUI)' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name SRV-2008-R2-DAT -Memory 1GB -OperatingSystem 'Windows Server 2008 R2 Datacenter (Full Installation)' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name PC-7-ENT -Memory 1GB -OperatingSystem 'Windows 7 Enterprise' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name PC-81-ENT -Memory 1GB -OperatingSystem 'Windows 8.1 Enterprise' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name PC-10-PRO -Memory 1GB -OperatingSystem 'Windows 10 Pro' -DomainName pawpatrol.local
Add-LabMachineDefinition -Name PC-10-ENT -Memory 1GB -OperatingSystem 'Windows 10 Enterprise' -DomainName pawpatrol.local

# Launch lab installation
Install-Lab

# Get a deployment summary (passwords, etc)
Show-LabDeploymentSummary -Detailed


##################
# Remove the lab
##################
# Remove-Lab
