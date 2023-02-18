#!/usr/bin/lua

-- Load required libraries
local argparse = require("argparse")
local socket = require("socket")
local io = require("io")

-- Define command-line arguments
local parser = argparse("lua-scan", "A Lua-based port scanning utility.")
parser:option("-t --target", "The target IP address or hostname."):count(1)
parser:option("-p --ports", "The port range to scan."):count("*")
parser:option("-r --rate", "The packets per second to send."):count(1)

-- Parse command-line arguments
local args = parser:parse()

-- Parse target address and port range
local target = args.target
local port_range = args.ports
local rate = args.rate or "10000"

-- Convert port range to string
local port_range_str = table.concat(port_range, ",")

-- Run masscan to detect open ports
local masscan_cmd = string.format("masscan %s -p %s --rate %s --open --max-rate %s ", target, port_range_str, rate, rate)
local masscan_output = io.popen(masscan_cmd)
local open_ports = {}

-- Parse masscan output to get open ports
for line in masscan_output:lines() do
  local port = line:match("Discovered open port (%d+)")
  if port then
    table.insert(open_ports, tonumber(port))
  end
end

-- Run nmap on open ports
local nmap_cmd = string.format("nmap %s -p %s", target, table.concat(open_ports, ","))
local nmap_output = io.popen(nmap_cmd)

-- Print nmap output
for line in nmap_output:lines() do
  print(line)
end
