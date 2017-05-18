#!/usr/bin/env ruby

require "openssl"
require "json"
require "diplomat"

Diplomat.configure do |config|
  config.url = "http://consul-consul:8500"
end

def certificates
  json = `gcloud --format json compute ssl-certificates list`

  data = JSON.parse(json)

  data.map do |cert_data|
    cert = OpenSSL::X509::Certificate.new(cert_data["certificate"])
    cert.subject.to_s.sub("/CN=", "")
  end
end

def service(address)
  {
    "ID"      => address,
    "Name"    => address,
    "Address" => "127.0.0.1",
    "Tags"    => [ "gcp-ssl-cert-cn" ]
  }
end

def defunct_services
  cert_cache = certificates
  Diplomat::Service.get_all.each_pair.reject do |service, tags|
    (cert_cache.include?(service.to_s) && tags.include?("gcp-ssl-cert-cn")) \
      || !tags.include?("gcp-ssl-cert-cn")
  end
end

certificates.each do |address|
  puts "registering: #{address}"
  Diplomat::Service.register(service(address))
end

defunct_services.to_h.each do |service, _|
  puts "deregistering: #{service}"
  Diplomat::Service.deregister(service.to_s)
end
