#!/bin/sh
export LUA_PATH="/opt/luaworks/?.lua;/opt/share/lua/5.1/?.lua"
export LUA_CPATH="/opt/lib/?.so"

send_webhook() {
  lua -e 'require("luaworks"); local s=require("socket"); local t=s.tcp(); t:settimeout(2); t:connect("192.168.50.12", 80); t:send("POST /api/webhook/'"$1"' HTTP/1.1\r\nHost: 192.168.50.12:80\r\nConnection: close\r\nContent-Length: 0\r\n\r\n"); t:close(); os.exit(0)' >/dev/null 2>&1
}

logread -f | while read -r line; do
  case "$line" in
    *"given code is 07330004"*)
      send_webhook "harmony_dim"
      ;;
    *"given code is 07330010"*)
      send_webhook "harmony_restore"
      ;;
  esac
done
