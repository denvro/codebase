### Update service process options
#	GeneralOptions.NodeName=ssu20infa231a
#	GeneralOptions.JVMOptions=-Xmx4g -Dfile.encoding=UTF-8 -server -Xms1024M -XX:GCTimeRatio=19 -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError -XX:ParallelGCThreads=4 -XX:NewRatio=2 -XX:MaxMetaspaceSize=384m
#	GeneralOptions.HttpPort=0
#	GeneralOptions.HttpsPort=8195
#	SQLServiceOptions.MaxConcurrentConnections=100
#	LoggingOptions.LogDirectory=$ServiceLogDirectory/disLogs
#	ResultSetCacheOptions.MaxTotalDiskSize=0
#	ResultSetCacheOptions.MaxPerCacheMemorySize=0
#	ResultSetCacheOptions.MaxTotalMemorySize=0
#	ResultSetCacheOptions.MaxNumCaches=0
#	HttpConfigurationOptions.MaxConcurrentRequests=200
#	HttpConfigurationOptions.MaxBacklogRequests=100
#	HttpConfigurationOptions.KeyStoreFile=/opt/informatica/infa1021/tomcat/conf/Default.keystore
#	HttpConfigurationOptions.KeyStorePassword=**********
#	HttpConfigurationOptions.TrustStoreFile=/opt/informatica/infa1021/services/shared/security/infa_truststore.jks
#	HttpConfigurationOptions.TrustStorePassword=**********
#	HttpConfigurationOptions.SSLProtocol=

#	DOUBLE QUOTES around the options
#	SINGLE QUOTES around the values

###

infacmd.sh dis UpdateServiceProcessOptions \
	-dn $INFA_DOMAIN_NAME \
	-sn $INFA_SERVICE_NAME \
	-nn $INFA_NODE_NAME \
	-un $BDM_INFA_USERNAME \
	-pd $BDM_INFA_PASSWORD \
	-sdn "Native" \
	-o "GeneralOptions.JVMOptions='-Xmx8192M -Dfile.encoding=UTF-8 -server -Xms2048M -XX:GCTimeRatio=19 -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError -XX:ParallelGCThreads=4 -XX:NewRatio=2 -XX:MaxMetaspaceSize=384m'"
	
