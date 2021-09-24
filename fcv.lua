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

fcv_timer = nil

function init()
  arrow = 0
  hotswap.init()
  graphics.init()
  network.init()
  fcv_lattice = lattice:new{}
  fcv_umbilicus = fcv_lattice:new_pattern{
    action = function(t) fcv_umbilicus_action(t) end
  }
  fcv_timer = fcv_lattice:new_pattern{
    action = function(t) fcv_timer_action(t) end,
    division = 1/8
  }
  fcv_lattice:start()
  params:set("clock_tempo", 120)
  clock.set_source("internal")
  redraw_clock_id = clock.run(redraw_clock)
end

function fcv_timer_action(t)
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
  if k == 1 then return end
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


