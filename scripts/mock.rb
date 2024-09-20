#!/usr/bin/env ruby

require 'open3'

def prism_is_running?
  system('curl --silent "http://localhost:4010" > /dev/null 2>&1')
end

def kill_server_on_port(port)
  pids = `lsof -t -i tcp:#{port}`.split("\n")
  unless pids.empty?
    system("kill #{pids.join(' ')}")
    puts "Stopped #{pids.join(', ')}."
  end
end

url = File.join(File.dirname(__FILE__), '..', 'openapi.yml')
daemon_mode = false

ARGV.each do |arg|
  if arg == '--daemon'
    daemon_mode = true
  end
end

if !File.exist?(url)
  puts "Error: openapi.yml file not found, run `rake fetch_api_spec` to attempt to fetch it"
  exit 1
end

puts "==> Starting mock server with file #{url}"

if daemon_mode
  pid = spawn("npx @stainless-api/prism-cli mock #{url}", [:out, :err] => '.prism.log')
  Process.detach(pid)

  print "Waiting for server"
  until prism_is_running? || File.read('.prism.log').include?('✖  fatal')
    print "."
    sleep 0.1
  end
  puts

  if File.read('.prism.log').include?('✖  fatal')
    puts File.read('.prism.log')
    exit 1
  end
else
  exec("npx @stainless-api/prism-cli mock #{url}")
end
