local network = {}
util = require "util" 
websocket = require "http.websocket"
cq = require "cqueues"

ws = nil
rx_loop = nil


-- local ws = websocket.new_from_uri(ws_relay_url)

function network.init()
  network.countdown = 0
  network.last_pull_ok = true

  print('creating new cq')
  -- what does this thing return again?
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
    print("let's say something else to the network!")
    assert(ws:send("what's good fam? it's "..util.time().." o'clock"))
    print("we'll see what they say...")
    -- assert(data == "koo-eee!")
  end)

  rx_loop:loop()
end

function network.step()
  --print("step by step")
  if false then
    while not rx_loop:empty() do
      local ok, err = rx_loop:step()
      if not ok then err("loop.ste: "..err) end
    end
  end
end

function network.cleanup()
  if ws then assert(ws:close()) end
end

return network
