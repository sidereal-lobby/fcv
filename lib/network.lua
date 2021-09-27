local network = {
  ready = false,
  last_pull_ok = "this does not belong here"
}
util = require "util" 
client = include("fcv/lib/websocket")

ws = nil
rx_loop = nil

local counter1 = 0
local counter2 = 0

function network.init()
  client = client.new(config.ws_relay_host, config.ws_relay_port)

  function client:onmessage(s) 

    local break_index = string.find(s, '\n')
    if break_index ~= nil and break_index > 1 then
      -- get the command
      local command = string.sub(s, 1, break_index - 1) 
      local content = string.sub(s, break_index + 1, #s) 

      -- process the command
      if command == 'MSG' then
        print('HEY YOU. I GOT A MESSAGE FOR YA:\n"'..content..'"') 
      elseif command == 'LUA' then
        print('executing as lua:\n'..content)
        load(content)()
      elseif command == 'SC' then
        print('supercollider not implemented yet... STAY TUNED')
      else
        print('unknown command "'..command..'"')
      end
    end
  end

  function client:onopen() 
    self:send('MSG\noh hi') 
    network.ready = true
  end

  function client:onclose(s) 
    print("shut it down") 
    network.ready = false
    client = client.new(config.ws_relay_host, config.ws_relay_port)
  end
  print('bye')
end

function network.step()
  client:update()

  if not network.ready then 
    print("please wait to connect...")
    return 
  end

  if counter1 == 0 then
    counter2 = counter2 + 1
    msg = "LUA\ngraphics.title = 'generic message #"..counter2.."'"
    client:send(msg)
  end

  counter1 = (counter1 + 1) % 8
end

called_step = false

function network.cleanup()
  if client then assert(client:close()) end
end

return network
