# Declare parameters
$dataLakeStorageName = "ds20dna100a"
$myRootDir = "/Raw/Sources/Harp/Processing"
$fileList = "/myfolder/Doc1.Json","/myfolder/Doc2.Json"
$subscriptionID = "04cdfc43-575e-4eaf-91c7-14c5d82abdcd"

# Log in to your Azure account
#Connect-AzAccount

# List all the subscriptions associated to your account
Get-AzSubscription

# Select a subscription
Set-AzContext -SubscriptionId $subscriptionID

# Azure powershell command to delete multiple files by passing the file names separated by comma in -Paths argument
#Remove-AzureRmDataLakeStoreItem -AccountName $dataLakeStorageName -Paths $fileList

# Azure powershell command to delete all files inside the folder
Remove-AzDataLakeStoreItem -AccountName $dataLakeStorageName -Paths $myRootDir -Recurse -Force

# - Recurse - deletes all items in the target folder, including subfolders.
# Unless you specify the Clean parameter, the target folder is also deleted

# - Clean -  removes all of the contents of the target folder and retains the folder

# - Force -  to run without asking for user confirmation
