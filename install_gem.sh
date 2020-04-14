#!/bin/bash

find /usr/local/ | grep -i jenkins_api_client

find /var/www/redmine-4.0/ | grep -v /gems_from_source/ | grep -i jenkins_api_client

read -p "Press ctrl+c to abort if you did not remove the previous files ... " yn

http_proxy=http://artefactos-ic-g.scae.redsara.es:3128 https_proxy=http://artefactos-ic-g.scae.redsara.es:3128 bundle install

gem build jenkins_api_client

echo "Esto tarda pq intenta conectar con el repositorio rubygems y no le hemos puesto proxy (innecesario)." 
http_proxy=http://artefactos-ic-g.scae.redsara.es:3128 https_proxy=http://artefactos-ic-g.scae.redsara.es:3128 gem install jenkins_api_client-1.5.3.gem


