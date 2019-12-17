
$dataLakeStorageName = "ds20dna100a"
$myrootdir = "/Raw/Sources/Harp/in"
$subscriptionID = "04cdfc43-575e-4eaf-91c7-14c5d82abdcd"

 # Log in to your Azure account
 #Connect-AzAccount

 # List all the subscriptions associated to your account
 Get-AzSubscription

 # Select a subscription
 Set-AzContext -SubscriptionId $subscriptionID

 # Register for Azure Data Lake Storage Gen1
 Register-AzResourceProvider -ProviderNamespace "Microsoft.DataLakeStore"

$dataLakeStorageName = "ds20dna100a"
$myrootdir = "/Raw/Sources/Harp/In"

Get-AzDataLakeStoreAccount -Name $dataLakeStorageName

Get-AzDataLakeStoreChildItem -Account $dataLakeStorageName -Path $myrootdir | ConvertTo-Csv | Out-File -FilePath "C:\Azure\ADLS_HARP_FileList.json"


