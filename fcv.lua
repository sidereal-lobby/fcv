-- "apes together strong"

engine.name = 'Fcv'
  
  -- audio = require("audio")
      s = require("sequins")
lattice = require("lattice")
tabutil = require("tabutil")
   util = require("util") 

  client = include("lib/websocket")
      fn = include("lib/functions")
graphics = include("lib/graphics")
 network = include("lib/network")
     six = include("lib/six")

-- START LIVECODE SETUP

v = { gye = {}, ixb = {}, mek = {}, qpo = {}, urn = {}, vrs = {} }     
   
for key, val in pairs(v) do
  v[key]["ena"] = 1     -- enabled: 0 or 1
  v[key]["mod"] = s{1}  -- modulation: 0 - 1000
  v[key]["mtr"] = s{1}  -- meter: 1 - n
  v[key]["nte"] = s{0}  -- note: semitones from v.root aka root 
  v[key]["tpz"] = s{0}  -- transpose: just this voice
  v[key]["trg"] = s{1}  -- trigger: 0 or 1
  v[key]["vel"] = s{1}  -- velocity: 0 - 1000
end

v.root = s{60}  -- root
v.tempo = s{120} -- tempo

root_cache, tempo_cache = v.root(), v.tempo()

-- END LIVECODE SETUP


function init()
  -- y u no work
  -- audio.comp_on()
  -- audio.comp_mix(.5)
  -- audio.comp_param("ratio",      4.0)
  -- audio.comp_param("threshold",  -10.0)
  -- audio.comp_param("attack",     5.0)
  -- audio.comp_param("release",    51.0)
  -- audio.comp_param("pre_gain",   0.0)
  -- audio.comp_param("post_gain",  9.0)  


  print('norns.script.load("'..norns.state.script..'")')
  params:set("clock_tempo", v.tempo())
  fn.init_config()
  clock.set_source(config.clock_source)
  graphics.init()
  network.init()
  network.init_clock()
  six.init()
  redraw_clock_id = clock.run(graphics.redraw_clock)
  tempo_lattice = lattice:new{}
  tempo_pattern = tempo_lattice:new_pattern{
    action = tempo_action
  }
  tempo_lattice:start()
end

function tempo_action()
  -- cache these so we can display them
  -- cos sequins change values on each access
  screen.ping()
  root_cache = v.root()
  tempo_cache = v.tempo()
  params:set("clock_tempo", tempo_cache)
  engine.bpm(tempo_cache)
end

function key(k, z)
  if z == 0 then return end
  if k == 1 then return end
  if k == 2 then return end
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
