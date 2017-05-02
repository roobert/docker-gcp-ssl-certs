FROM google/cloud-sdk

ADD /gcp-ssl-certs.rb /gcp-ssl-certs.rb

CMD [ "/gcp-ssl-certs.rb" ]
