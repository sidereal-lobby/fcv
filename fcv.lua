-- "apes together strong"

engine.name = 'Fcv'
  
      s = require("sequins")
lattice = require("lattice")
tabutil = require("tabutil")
   util = require("util") 

local orig_cpath = package.cpath
-- cpath must be set BEFORE including
if not string.find(orig_cpath,"/home/we/dust/code/fcv/lib/") then
  package.cpath=orig_cpath..";/home/we/dust/code/fcv/lib/?.so"
end

  client = include("lib/websocket")
      fn = include("lib/functions")
graphics = include("lib/graphics")
 network = include("lib/network")
     six = include("lib/six")


-- START LIVECODE SETUP

v = { gye = {}, ixb = {}, lor = {}, mek = {}, qpo = {}, vrs = {} }
   
for key, val in pairs(v) do
  v[key]["ena"] = s{math.random(0,1)}    -- enabled: 0 or 1
  v[key]["mod"] = s{0}    -- modulation: 0 - 100
  v[key]["mtr"] = s{1}    -- meter: 1 - n
  v[key]["nte"] = s{0}    -- note: semitones from v.root
  v[key]["tpz"] = s{0}    -- transpose: just this voice
  v[key]["trg"] = s{1}    -- trigger: 0 or 1
  v[key]["vel"] = s{100}  -- velocity: 0 - 100
end

v.root = s{60}  -- root
v.tempo = s{120} -- tempo

root_cache, tempo_cache = v.root(), v.tempo()

-- END LIVECODE SETUP


function init()
  -- compressor settings
  params:set("compressor",      2)    -- on 1, off 2
  params:set("comp_mix",        0.5)  -- 0.0 - 1.0
  params:set("comp_ratio",      4.0)  -- 1.0 - 20.0
  params:set("comp_threshold",  -9.0) -- dB
  params:set("comp_attack",     5.0)  -- ms
  params:set("comp_release",    51.0) -- ms
  params:set("comp_pre_gain",   0.0)  -- dB
  params:set("comp_post_gain",  9.0)  -- dB

  -- reverb settings
  params:set("reverb",            1)      -- on 1, off 2
  params:set("rev_eng_input",     -9.0)   -- dB
  params:set("rev_cut_input",     -9.0)   -- dB
  params:set("rev_monitor_input", -100.0) -- dB
  params:set("rev_tape_input",    -100.0) -- dB
  params:set("rev_return_level",  0.0)    -- dB
  params:set("rev_pre_delay",     60.0)   -- ms
  params:set("rev_lf_fc",         200.0)  -- hz
  params:set("rev_low_time",      6.0)    -- seconds
  params:set("rev_mid_time",      6.0)    -- seconds
  params:set("rev_hf_damping",    6000.0) -- hz

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
  print('cleaning up...')
  print('restoring cpath to '..orig_cpath)
  package.cpath = orig_cpath 
  print('cleaning up network...')
  network:cleanup()
  print('saying goodbye: Goodbye!')
end
