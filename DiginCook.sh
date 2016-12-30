#!/bin/bash
#Author - Dasitha Karunajeewa
#Version 1.0.1
#Created on 30-12-2016
. params.conf

#Scirpt path location. 
SCRPT_PATH="/usr/src/"

#Veriables defined for config.js initialization
DiginEngine="$Digin_Engine"
DiginTomcatBase="$Digin_Tomcat_Base"
DiginDomain="$Digin_Domain"
DevStudio="$Dev_Studio"
RealTime="$Real_Time"
ReportDevelopment="$Report_Development"
DiginLogoUploader="$Digin_LogoUploader"
DiginAuth="$Digin_Auth"
DiginTenant="$Digin_Tenant"
DiginObjStore="$Digin_ObjStore"
IsLocal="$Is_Local"
LocalShellPath="$Local_Shell_Path"

#Veriables defined for config.php initialization
MainDomain="$main_Domain"
AuthUri="$auth_URI"
ObjUri="$obj_URI"
Media_Path="$MEDIA_PATH"
Application_Path="$APPICON_PATH"
SvcOsUrl="$SVC_OS_URL"
SvcOsBulkUrl="$SVC_OS_BULK_URL"
SvcAuthUrl="$SVC_AUTH_URL"
SvcCebUrl="$SVC_CEB_URL"
DiginDomain="$Digin_Domain"
DiginEngineApi="$Digin_Engine_API"
PaymentGateway="$PAYMENT_GATWAY"
OnSite=$Onsite

ApisPath="$Apis_Path"
AuthPath="$Auth_Path"
IncludePath="$Include_Path"
DbType="$db_type"

#Core script variables. Nothing to do with this.
vtime=$(date +'%r')
vdate=$(date +'%d_%m_%Y')

#Log file paths and log file names
log_file="Detail.log"
log_sum="Summarry.log"
git_log="gitclone.log"
err_log="error.log"
log_path="/usr/local/src/$vdate"
doc_root="/var/www/html"

#git hub branch name that you need to take for deploying the release.
git_branch="Development"


#Setting up the bashrc
 if grep -q export PATH=$PATH:$SCRPT_PATH "/root/.bashrc"; then
   echo " $(date +'%r') Path veriable(export PATH="$PATH:$SCRPT_PATH") is exisits in the location" >> $log_path/$log_sum
 else
   echo "export PATH=\$PATH:$SCRPT_PATH" >> /root/.bashrc 
     if [ "$?" != "0" ] ; then
        echo "Path setting up has failed! Please check whether you have root permission to proceed with this operation" >> $log_path/$err_log
     else
        echo "Path setup has been sucessufully completed" >> $log_path/$log_sum
     fi
 fi

if grep -n '^ ' $doc_root/shell/scripts/config.js >&2; then
     echo "$0: Leading spaces identified on config.js file; aborting the execution" >&2
    exit 1
fi

if grep -n '^ ' $doc_root/include/config.php >&2; then
     echo "$0: Leading spaces identified on config.php file; aborting the execution" >&2
    exit 1
fi


if [ -d "$log_path" ]; then
    echo "$vdate $(date +'%r') cannot create directory $log_path"  >> $log_path/$log_sum
	echo "$vdate $(date +'%r') Initiating with the existing directory $log_path" >> $log_path/$log_sum
fi

mkdir $log_path
echo "$vdate $(date +'%r') Release management project initiated" >> $log_path/$log_sum
tar -zcvf /var/backups/html_$vdate.tar.gz /var/www/html/ >> backuplog_"$vdate"_"$vtime".txt
echo "$vdate $(date +'%r') Backing up document root has been completed" >> $log_path/$log_sum


rm -rf /tmp/DiginRelease

mkdir /tmp/DiginRelease
cd /var/www/html 
mv user_data /tmp/DiginRelease/
mv Uploads /tmp/DiginRelease/
mv Reports /tmp/DiginRelease
cd ..
rm -rf html
cd /var/www/
git clone https://sajeetharan@github.com/DuoSoftware/Digin.git

if [ $? -eq 0 ] ; then
	echo "$vdate $(date +'%r') Cloning from Git sucessfull" >> $log_path/$log_sum
else
	echo "$vdate $(date +'%r') failed Cloning from Git" >> $log_path/$log_sum
fi
cd Digin

git checkout $git_branch
#git clone https://sajeetharan@github.com/DuoSoftware/Digin.git >> append.txt
#git clone https://sajeetharan@github.com/DuoSoftware/Digin.git > log 2>&1
cd ..
mv Digin/ html
chmod 777 html/ 
echo "$vdate $(date +'%r') Setting permission completed for new document root" >> $log_path/$log_sum
cd html/
mv /tmp/DiginRelease/user_data user_data
mv /tmp/DiginRelease/Uploads Uploads
#cp /var/backups/FreezedFiles/config.js /var/www/html/shell/scripts/
#cp /var/backups/FreezedFiles/config.php /var/www/html/include/
rm -rf /tmp/DiginRelease/
echo "$vdate $vtime Release deployement process completed for DigIn UI." >> $log_path/$log_sum
echo "#################################################################################################################################"

#Backing up config.js
cd $doc_root/shell/scripts
cp config.js /var/backups/

#############################Setting up the config.js####################################### 
sed -i "s~^\(\.constant('Digin_Engine_API', \).*~\1'$DiginEngine')~" $doc_root/shell/scripts/config.js 

sed -i "s~^\(\.constant('Digin_Tomcat_Base', \).*~\1'$DiginTomcatBase')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('Digin_Domain', \).*~\1'$DiginDomain')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('DevStudio', \).*~\1'$DevStudio')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('RealTime', \).*~\1'$RealTime')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('ReportDevelopment', \).*~\1'$ReportDevelopment')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('Digin_LogoUploader', \).*~\1'$DiginLogoUploader')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('Digin_Auth', \).*~\1'$DiginAuth')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('Digin_Tenant', \).*~\1'$DiginTenant')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('Digin_ObjStore', \).*~\1'$DiginObjStore')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('IsLocal', \).*~\1'$IsLocal')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('Local_Shell_Path', \).*~\1'$LocalShellPath')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('apis_Path', \).*~\1'$ApisPath')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('auth_Path', \).*~\1'$AuthPath')~" $doc_root/shell/scripts/config.js

sed -i "s~^\(\.constant('include_Path', \).*~\1'$IncludePath')~" $doc_root/shell/scripts/config.js

######################################### Setting up config.php #################################################

sed -E "s/^(\\\$mainDomain=\")[^\"]+(\";)$/\1$MainDomain\2/" /var/www/html/include/config.php

sed -E -i "s~^(\\\$authURI=\")[^\"]+(\";)$~\1$duo_auth\2~" /var/www/html/include/config.php

sed -E -i "s~^(\\\$objURI=\")[^\"]+(\";)$~\1$ObjUri\2~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\Digin_Domain\", \).*~\1'$DiginDomain')~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\Digin_Engine_API\", \).*~\1'$DiginEngineApi')~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\onsite\", \).*~\1'$OnSite')~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\PAYMENT_GATWAY\", \).*~\1'$PaymentGateway')~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\SVC_OS_BULK_URL\", \).*~\1'$SvcOsBulkUrl')~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\SVC_AUTH_URL\", \).*~\1'$SvcAuthUrl')~" /var/www/html/include/config.php

sed -i "s~^\(\define(\"\SVC_CEB_URL\", \).*~\1'$SvcCebUrl')~" /var/www/html/include/config.php

