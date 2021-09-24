--  ////   ////  //    //
--  //      //     //     //
--  ////   //      //  //
--  //      //      //   //
--  //      //       // //
--  //      ////      //

lattice = require("lattice")
s = include("lib/Sequins")
fn = include("lib/functions")
hotswap = include("lib/hotswap")
graphics = include("lib/graphics")
network = include("lib/network")

-- DEBUGGINSON
tabutil = require("tabutil")

fcv_timer = nil

function init()
  arrow = 0

  -- better than r() a lot of the time
  -- on crash, copy+paste+execute from REPL output
  print('norns.script.load("'..norns.state.script..'")')

  init_config()

  hotswap.init()
  graphics.init()
  network.init()

  init_clock()
end

function init_config()
  -- https://stackoverflow.com/a/41176826
  config = {}
  local apply, err = loadfile("/home/we/dust/code/fcv/config.lua", "t", config)
  if apply then
    apply()
    print("THIS IS CONFIG\n")
    tabutil.print(config)
    print("THAT WAS CONFIG\n")
  else
    print(err)
  end
end

function init_clock()
  fcv_lattice = lattice:new{}
  fcv_umbilicus = fcv_lattice:new_pattern{
    action = fcv_umbilicus_action
  }
  fcv_timer = fcv_lattice:new_pattern{
    action = fcv_timer_action,
    division = 1/8
  }
  netverk = fcv_lattice:new_pattern{
    action = network.step
  }
  fcv_lattice:start()

  params:set("clock_tempo", config.tempo)
  clock.set_source(config.clock_source)
  redraw_clock_id = clock.run(redraw_clock)
end

function fcv_timer_action()
  network.countdown = util.wrap(network.countdown + 1, 0, 16)
end

function fcv_umbilicus_action(t)
  arrow = arrow + 1
  print(t, arrow, hotswap.switch)
  if type(hotswap.payload) == 'table' then
    print(hotswap.payload[1]())
  end
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

function redraw_clock()
  while true do
    redraw()
    clock.sleep(1 / graphics.fps)
  end
end

function redraw()
  graphics:setup()
  graphics:local_status()
  graphics:network_status()
  graphics:teardown()  
end

function cleanup()
  network.cleanup()
end
