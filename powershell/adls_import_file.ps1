##############################################################################
# Name        : adls_import_file.ps1
# Author      : Dennis Vrolijk
# Date        : 29-11-2018
# Version     : 1.0
# Description : Script to import a local folder into Azure DataLake Storage
##############################################################################

##############################################################################
# Variable Declaration
##############################################################################
$subscriptionID    = '04cdfc43-575e-4eaf-91c7-14c5d82abdcd'
$accountName       = 'ds20dna100a'
$adlsAccount       = $accountName+'.azuredatalakestore.net'
$destinationFolder = '/Base/UseCases/PnL/'
$sourceFolder      = 'c:\Users\dennis.vrolij_nsp\Downloads\PnL\'
$fileName          = 'P&L Analyse.xlsx'

# Log in to your Azure account if needed
 if ([string]::IsNullOrEmpty($(Get-AzureRmContext).Account)) {Login-AzureRmAccount}
# List all the subscriptions associated to your account
 Get-AzureRmSubscription
# Select a subscription
 Set-AzureRmContext -SubscriptionId $subscriptionID
# Test if datalakestore exists
 Test-AzureRmDataLakeStoreAccount $AccountName
# Import files recursively to datalakestore
 Import-AzureRmDataLakeStoreItem -Account $adlsAccount -Path $sourceFolder -Destination $destinationFolder -Recurse -Force
