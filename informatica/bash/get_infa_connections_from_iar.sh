#sed -n -e "s/.*[Nn]ame=\"\(.*\)_DEV\"\/>/\1_DEV\|\1_TST/p" ./Datafundament/STG/APP_STG_HARP/APP_STG_HARP.iar | sort | uniq

find . -name *.iar -exec sed -n -e "s|.*stringIdentity:\([[:alnum:]_]*\)\".*connectionName=\"\([[:alnum:]_]*\)\".*|\1;\2|p" {} \; | sort | uniq