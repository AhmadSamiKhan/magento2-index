#!/bin/bash
#------variables used------#
clear

S="*******************************************************************"
D="-------------------------------------------------------------------"
E="==================================================================="
F="..................................................................."

COLOR="y"
HOME="/home/master/applications/"

IRed='\e[0;91m';
Yel='\e[0;33m';
EndCOLOR="\e[0m"

x=1
y=1

#############--Processing--#################

echo -e "$S"
echo -e "$IRed      MAGENTO 2 MULTISITE CONFIGURATION SCRIPT $EndCOLOR"
echo -e "$S\n"

echo -e "$Yel Gathering Initial Details $EndCOLOR"
echo -e "$F\n"
read -r -p $'\e[0;32m1- Enter the Database name\e[0m: '  DB_NAME
read -r -p $'\e[0;32m2- Enter the number of websites to configure\e[0m: '  NO_OF_STORES
echo " "
#echo "THANKYOU"

sleep 0.5
echo -ne $'\e[1;32mFETCHING STORE LIST --         \r\e[0m'
sleep 0.5
echo -ne $'\e[1;33mFETCHING STORE LIST ----          \r\e[0m'
sleep 0.5
echo -ne $'\e[1;34mFETCHING STORE LIST -------          \r\e[0m'
sleep 0.5
echo -ne $'\e[1;35mFETCHING STORE LIST ---------          \r\e[0m'
sleep 0.5
echo -ne $'\e[1;36mFETCHING STORE LIST ------------          \r\e[0m'
echo -e "$F"
echo -ne '\n'

while [ $y -le $NO_OF_STORES ];
do
	echo -ne '\n'
	php $HOME/$DB_NAME/public_html/bin/magento store:website:list
		while [ $x -le $NO_OF_STORES ]; do
  				
  				echo -e "\n"
  				echo -e "$Yel Gathering SITE-$x Details $EndCOLOR"
  				echo -e "$F\n"
  				
  				read -r -p $'\e[0;32m a- Enter the DOMAIN of the site \e[0m: '  SITE_DOMAIN
  				read -r -p $'\e[0;32m b- Enter the CODE of the site from the above list\e[0m: '  SITE_CODE
				

				cat <<EOT >> block
	case '$SITE_DOMAIN':
                \$mageRunCode = '$SITE_CODE';
                \$mageRunType = 'website';
                break;
            
	    
	    default:
                $mageRunCode = 'base';
                $mageRunType = 'website';
                break;
	}
EOT
				 
				
                x=$(( $x + 1 ))
                y=$(( $y + 1 ))

done
				
done

echo -e "$F"
echo -e "$F\n"


sleep 0.7
echo -ne $'\e[1;32mCOMPOSING THE STEPS --         \r\e[0m'
sleep 0.5
echo -ne $'\e[1;33mCOMPOSING THE STEPS ----          \r\e[0m'
sleep 0.5
echo -ne $'\e[1;34mCOMPOSING THE STEPS -------          \r\e[0m'
sleep 0.7
echo -ne $'\e[1;38mCOMPOSING THE STEPS ---------          \r\e[0m'
sleep 0.5
echo -ne $'\e[1;36mCOMPOSING THE STEPS ------------          \r\e[0m'
echo -e "$F"
echo -ne '\n'

wget -q https://raw.githubusercontent.com/AhmadSamiKhan/magento2-index/main/index1
wget -q https://raw.githubusercontent.com/AhmadSamiKhan/magento2-index/main/index2

clear

echo -e "$E"
echo -e "$IRed STEPS TO CONFIGURE THE MAGENTO MULTISITE 2 $EndCOLOR"
echo -e "$E\n"


echo -e $'\e[1;32mHere are the configuration steps. Please follow as guided.\e[0m'

echo -e $'\e[1;32m1- Change the webroot to pub from application settings.\e[0m'
echo -e $'\e[1;32m2- Updated the pub/index.php as:\e[0m'



cp $HOME/$DB_NAME/public_html/pub/index.php $HOME/$DB_NAME/public_html/pub/index.php-backup-script
echo > $HOME/$DB_NAME/public_html/pub/index.php
cat index1 >> $HOME/$DB_NAME/public_html/pub/index.php
cat block >> $HOME/$DB_NAME/public_html/pub/index.php
cat index2 >> $HOME/$DB_NAME/public_html/pub/index.php


echo -e $'\e[1;32m3- Flushing the cache of application\e[0m'
php $HOME/$DB_NAME/public_html/bin/magento c:f  > /tmp/test
echo -e $'\e[1;32m4- Verify if all above steps have been completed. Kindly check the stores now.\e[0m'

rm block index1 index2
