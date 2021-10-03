-- "apes together strong"

s = include("lib/Sequins")

-- START LIVECODE SETUP

l = { gye = {}, ixb = {}, mek = {}, urn = {}, vrs = {}, yyr = {} }     
   
for k, v in pairs(l) do
  l[k]["nte"] = s{1}
  l[k]["trg"] = s{1}
  l[k]["mod"] = s{1}
  l[k]["div"] = s{1/4}
  l[k]["ena"] = true
end

l.r = 50  -- root
l.t = 120 -- tempo

-- END LIVECODE SETUP

engine.name = 'Fcv'

lattice = require("lattice")
tabutil = require("tabutil")
   util = require("util") 


  client = include("lib/websocket")
      fn = include("lib/functions")
graphics = include("lib/graphics")
 network = include("lib/network")
     six = include("lib/six")

function init()
  print('norns.script.load("'..norns.state.script..'")')
  params:set("clock_tempo", l.t)
  fn.init_config()
  clock.set_source(config.clock_source)
  graphics.init()
  network.init()
  network.init_clock()
  six.init()
  redraw_clock_id = clock.run(graphics.redraw_clock)
  tempo_lattice = lattice:new{}
  tempo_pattern = tempo_lattice:new_pattern{
    action = function()
      local cache_tempo = params:get("clock_tempo")
      if cache_tempo ~= l.t then
        params:set("clock_tempo", l.t)
      end
    end
  }
  tempo_lattice:start()
end

function key(k, z)
  if z == 0 then return end
  if k == 1 then return end -- DAS MACHT NICHTS
  if k == 2 then hotswap:lua() end
  if k == 3 then r() end -- lol, but actually this is awesome
end

function enc(e, d)
  print(e, d)
end

function redraw()
  graphics:draw_home()
end

function cleanup()
  network:cleanup()
end
