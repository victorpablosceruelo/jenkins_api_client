#!/bin/bash

echo " "
echo "gem uninstall jenkins_api_client --all --ignore-dependencies --no-check-development --force"
gem uninstall jenkins_api_client --all --ignore-dependencies --no-check-development --force


echo "Removing old installation files ... "
IN_OS=$(find /usr/local/ -type d  | grep -i jenkins_api_client | xargs echo )
IN_REDMINE=$(find /var/www/redmine* -type d  | grep -v /gems_from_source/ | grep -i jenkins_api_client | xargs echo )

rm -fvR ${IN_OS} ${IN_REDMINE}

GEM_TO_REMOVE=$(find . -maxdepth 1 -type f  | grep -i "jenkins_api_client.*\.gem$" )

rm -fv ${GEM_TO_REMOVE}

# read -p "Press ctrl+c to abort if you did not remove the previous files ... " yn

echo " "
echo "Getting dependencies ... "
http_proxy=http://artefactos-ic-g.scae.redsara.es:3128 https_proxy=http://artefactos-ic-g.scae.redsara.es:3128 bundle install

echo " "
echo "Building gem jenkins_api_client ... "
http_proxy=http://artefactos-ic-g.scae.redsara.es:3128 https_proxy=http://artefactos-ic-g.scae.redsara.es:3128 gem build jenkins_api_client

GEM_TO_INSTALL=$(find . -maxdepth 1 -type f  | grep -i "jenkins_api_client.*\.gem$" )
echo " "
echo "Installing gem ${GEM_TO_INSTALL}"

# echo "Esto tarda pq intenta conectar con el repositorio rubygems y no le hemos puesto proxy (innecesario)." 
http_proxy=http://artefactos-ic-g.scae.redsara.es:3128 https_proxy=http://artefactos-ic-g.scae.redsara.es:3128 gem install ${GEM_TO_INSTALL}
# jenkins_api_client-1.5.3.gem

echo "Is jenkins_api_client installed ? Checking ..."
gem list | grep -i jenkins_api_client

find /usr/local/ -type d  | grep -i "jenkins_api_client$"
find /var/www/redmine* -type d  | grep -v /gems_from_source/ | grep -i "jenkins_api_client$"

