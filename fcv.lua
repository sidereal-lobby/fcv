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
     grd = include("lib/grid")


-- START LIVECODE SETUP

v = { gye = {}, ixb = {}, lor = {}, mek = {}, qpo = {}, vrs = {} }
   
for key, val in pairs(v) do
  v[key]["ena"] = s{1}    -- enabled: 0 or 1
  v[key]["mod"] = s{0}    -- modulation: 0 - 100
  v[key]["mtr"] = s{1}    -- meter: 1 - n
  v[key]["nte"] = s{0}    -- note: semitones from v.root
  v[key]["tpz"] = s{0}    -- transpose: just this voice
  v[key]["trg"] = s{1}    -- trigger: 0 or 1
  v[key]["vel"] = s{100}  -- velocity: 0 - 100
  v[key]["lvl"] = s{1}    -- volume: -1 - 1 (or more, to clip)
  v[key]["pan"] = s{0}    -- pan: -1 - 1
  v[key]["del"] = s{0}    -- delay send: -1 - 1 (or more, to clip)
  v[key]["lag"] = s{0}    -- channel strip lag: 0 - +inf (seconds)
end

v.ape              = s{1}      -- ape
v.root             = s{60}     -- root
v.tempo            = s{120}    -- tempo
v.reverb           = s{1}      -- off 1, on 2
v.rev_return_level = s{0.0}    -- db
v.rev_pre_delay    = s{60.0}   -- ms
v.rev_lf_fc        = s{200.0}  -- hz
v.rev_low_time     = s{6.0}    -- seconds
v.rev_mid_time     = s{6.0}    -- seconds
v.rev_hf_damping   = s{6000.0} -- hz
v.delay_beats      = s{3/4}    -- beats
v.delay_decay      = s{5}      -- seconds
v.delay_lag        = s{0.05}   -- seconds

root_cache, tempo_cache = v.root(), v.tempo()

-- END LIVECODE SETUP


function init()
  -- "security"
  local naughty_util_keys = {"os_capture","make_dir"}
  for key, val in pairs(naughty_util_keys) do
    util[val]= function () 
      print(val..", huh? that's nice") 
    end
  end

  -- compressor settings
  params:set("compressor",      2)    -- off 1, on 2
  params:set("comp_mix",        0.5)  -- 0.0 - 1.0
  params:set("comp_ratio",      4.0)  -- 1.0 - 20.0
  params:set("comp_threshold",  -9.0) -- dB
  params:set("comp_attack",     5.0)  -- ms
  params:set("comp_release",    51.0) -- ms
  params:set("comp_pre_gain",   0.0)  -- dB
  params:set("comp_post_gain",  9.0)  -- dB

  -- reverb settings
  params:set("reverb",            v.reverb())
  params:set("rev_eng_input",     -9.0)   -- dB
  params:set("rev_cut_input",     -9.0)   -- dB
  params:set("rev_monitor_input", -100.0) -- dB
  params:set("rev_tape_input",    -100.0) -- dB
  params:set("rev_return_level",  v.rev_return_level())
  params:set("rev_pre_delay",     v.rev_pre_delay())
  params:set("rev_lf_fc",         v.rev_lf_fc())
  params:set("rev_low_time",      v.rev_low_time())
  params:set("rev_mid_time",      v.rev_mid_time())
  params:set("rev_hf_damping",    v.rev_hf_damping())
  
  -- delay settings
  -- todo: wire these into the ancient tables
  -- engine.pan("gye", 0.5)
  -- engine.lag("gye", 20)
  -- engine.level("gye", 1.0)
  -- engine.send_delay("gye", 0.1)
  -- engine.delay_beats(3/4)
  -- engine.delay_decay(10)
  -- engine.delay_lag(0.2)

  print('norns.script.load("'..norns.state.script..'")')
  params:set("clock_tempo", v.tempo())
  fn.init_config()
  clock.set_source(config.clock_source)
  graphics.init()
  network.init()
  network.init_clock()
  six.init()
  grd.init()
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
