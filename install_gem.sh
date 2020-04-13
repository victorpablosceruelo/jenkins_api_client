#!/bin/bash

http_proxy=http://artefactos-ic-g.scae.redsara.es:3128 https_proxy=http://artefactos-ic-g.scae.redsara.es:3128 bundle install

gem build jenkins_api_client

echo "Esto tarda pq intenta conectar con el repositorio rubygems y no le hemos puesto proxy (innecesario)." 
gem install jenkins_api_client-1.5.3.gem


