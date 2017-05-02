#!/usr/bin/env ruby

require "openssl"
require "json"

def certificates
  json = `gcloud --format json compute ssl-certificates list`

  data = JSON.parse(json)

  data.map do |cert_data|
    cert = OpenSSL::X509::Certificate.new(cert_data["certificate"])
    cert.subject.to_s.sub("/CN=", "")
  end
end

puts [{ "targets" => certificates }].to_json
