--  ////   ////  //    //
--  //      //     //     //
--  ////   //      //  //
--  //      //      //   //
--  //      //       // //
--  //      ////      //

engine.name = 'Fcv'

lattice = require("lattice")
tabutil = require("tabutil")
   util = require("util") 


  client = include("lib/websocket")
      fn = include("lib/functions")
graphics = include("lib/graphics")
 network = include("lib/network")
       s = include("lib/Sequins")
      
       l = {} -- this is the good ape (all apes are good apes)

function init()
  print('norns.script.load("'..norns.state.script..'")')
  fn.init_config()
  graphics.init()
  network.init()
  fn.init_clock()
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
