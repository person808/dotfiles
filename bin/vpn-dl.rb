#!/usr/bin/env ruby
### 1. Download(curl) vpngate csv from offical site
### 2. Convert csv to ruby array
### 3. Decode openvpn config by base64
### 4. Run command openvpn and use the highest score server config file

require 'csv'
require 'base64'
require 'tempfile'

### 1.
vpngate_csv_url = "http://www.vpngate.net/api/iphone/"
puts "==> Downloading vpngate csv from #{vpngate_csv_url}"
vpngate_ori_csv = `curl #{vpngate_csv_url}`
if not vpngate_ori_csv.empty?
  puts "==> Successfully download"
else
  puts "==> Fail to download vpngate csv"
  exit 0
end


### 2.
vg_rb_csv = CSV.parse(vpngate_ori_csv)
# vg_rb_csv[1]
# => ["#HostName", "IP", "Score", "Ping", "Speed", "CountryLong", "CountryShort",
#     "NumVpnSessions", "Uptime", "TotalUsers", "TotalTraffic", "LogType", "Operator",
#     "Message", "OpenVPN_ConfigData_Base64"]


### 3.
openvpn_config = Base64.decode64 vg_rb_csv[2][-1] # vg_rb_csv[2] is the first server csv data


### 4.
openvpn_config_file = Tempfile.new(vg_rb_csv[2][0])
openvpn_config_file.write(openvpn_config)
begin
  puts "========================================================================"
  puts "==> Use the highest score server"
  puts "==> Server info:"
  puts "    IP:#{vg_rb_csv[2][1]} Country:#{vg_rb_csv[2][5]} Ping:#{vg_rb_csv[2][3]}ms Speed:#{vg_rb_csv[2][4][0..3].to_i/100.0}Mbps Score:#{vg_rb_csv[2][2]}"

  openvpn_cmd = "sudo openvpn --config #{openvpn_config_file.path}"
  puts "==> Run openvpn and use vpngate openvpn config file at #{openvpn_config_file.path}"
  puts openvpn_cmd
  system(openvpn_cmd, out: $stdout, err: :out)
ensure
  openvpn_config_file.close
  openvpn_config_file.unlink
end
