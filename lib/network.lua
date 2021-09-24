local network = {}
util = require "util" 
websocket = require "http.websocket"
cq = require "cqueues"

local ws
local rx_loop
-- local ws = websocket.new_from_uri(ws_relay_url)

function network.init()
  network.countdown = 0
  network.last_pull_ok = true

  print('creating new cq')
  rx_loop = cq.new()

  print('creating web socket')
  -- ws = websocket.new_from_uri("wss://echo.websocket.org")
  ws = websocket.new_from_uri(config.ws_relay_url)
  print('connecting to web socket')
  assert(ws:connect())
  print('sending to web socket')
  assert(ws:send("koo-eee!"..util.time()))


  print('starting cq loop')
  network.ctrl = rx_loop:wrap(function ()
    print('doing the loop thing')
    local data = assert(ws:receive())
    print('got something from network!')
    print(data)
    assert(data == "koo-eee!")
  end)
end

function network.step()
  rx_loop:step()
end

function network.cleanup()
  if ws then assert(ws:close()) end
end

return network
