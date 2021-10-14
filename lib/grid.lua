local g = {}

local dev = grid.connect()

function g.init ()
  print('adding grid add handler')
  grid.add = function (dev)
    print('we got ourselves a grid!')
    tabutil.print(dev)
  end
  print('added grid add handler')

  function dev.key(x, y, z)
    print('x', x, 'y', y, 'z', z)

    -- not dealing with key up for now
    if z == 0 then return end

    if y < 7 then
      -- level control
      x = x - 1 -- we need 0. 0 is silence
      local lev
      if x <= 10 then 
        lev = x/10
      else
        lev = (x - 10) / 2 + 1 
      end

      local msg = 
        "engine.level('"..six.names[y].."',"..lev..");"..
        "grd.display_level("..y..","..x..");"
      network.tx_lua(msg)
    elseif y == 8 and x < 7 then
      -- toggle enable
      print('x: '..x)
      print('nom: '..six.names[x])
      print('one: ');
      tabutil.print(v[six.names[x]])
      local one = v[six.names[x]]
      if one.ena.length == 1 and one.ena.data[1] == 0 then
        -- was explicitly off, so you want it on - cool.
        print('enabling '..six.names[x])
        local msg = "v."..six.names[x]..".ena = s{1};"..
          "grd.display_enabled("..x..",1);"
        network.tx_lua(msg)
      else
        -- panicking, eh? let's assume you want it off.
        print('disabling '..six.names[x])
        local msg = "v."..six.names[x]..".ena = s{0};"..
          "grd.display_enabled("..x..",0);"
        network.tx_lua(msg)
      end
    end
  end

  for un=1,6 do
    g.display_level(un, 10)
    g.display_enabled(un, 1)
  end
end

function g.display_level(which, level)
  print('setting '..which..' level to '..level)
  for x=0,15 do
    local brightness = (x<=level) and 1 or 0
    brightness = brightness * 6 + 2
    if x == 10 and level ~= 10 then
      -- "unity ruler"
      brightness = 5
    end
    print("level: setting grid "..(x+1)..", "..which.." to "..brightness)
    dev:led(x+1, which, brightness)
  end
  dev:refresh()
end

function g.display_enabled(which, is)
  print("enabled: setting grid "..which..", 8 to "..is)
  dev:led(which, 8, is * 6 + 2)
  dev:refresh()
end

return g
