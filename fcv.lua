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

function init()
  print("\n\nwelcome to the lobby")
  print("\n\nthis is just a spike for now")
  print("(making it in the actual repo because ape)")
  print("set your clock source to \"internal\"")
  print("and set your bpm to 100, ya ape!\n\n")
  arrow = 0
  hotswap.init()
  spike_lattice = lattice:new{}
  spike_pattern = spike_lattice:new_pattern{
    action = function(t) spike_action(t) end
  }
  spike_lattice:start()
end

function spike_action(t)
  arrow = arrow + 1
  print(t, arrow, hotswap.switch)
  if hotswap.payload ~= nil then
    hotswap.payload()
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

function redraw()
  
end