
### Test sql connectivity naar domain database TST
sqlline --showwarnings=false \
-u 'jdbc:informatica:sqlserver://sw20infa200a.database.windows.net:1433;DatabaseName=INFA_DOM_BDM;EncryptionMethod=SSL;HostNameInCertificate=*.database.windows.net;ValidateServerCertificate=false;SelectMethod=cursor;SnapshotSerializable=true;;allowPortWithNamedInstance=true' \
-n "infabdmtest" \
-p "Dh5rZHPPvSyxV**Y"


### Test sql connectivity naar domain database DEV
sqlline --showwarnings=false \
-u 'jdbc:informatica:sqlserver://sw20infa100a.database.windows.net:1433;DatabaseName=INFA_DOM_BDM;EncryptionMethod=SSL;HostNameInCertificate=*.database.windows.net;ValidateServerCertificate=false;SelectMethod=cursor;SnapshotSerializable=true;;allowPortWithNamedInstance=true' \
-n "infabdmdev" \
-p "HK@9dg5=F@vHBQHS"
