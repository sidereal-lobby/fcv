local fn = {}

function fn.init_config()
  -- https://stackoverflow.com/a/41176826
  config = {}
  local apply, err = loadfile("/home/we/dust/code/fcv/lib/config.lua", "t", config)
  if apply then
    apply()
    print("-- CONFIG --")
    tabutil.print(config)
    print("-- END CONFIG --")
  else
    print(err)
  end
end

function fn.init_clock()
  fcv_lattice = lattice:new{}
  -- the http examples just had this in a while loop
  -- not sure whether that would block other norns stuff (redraw, clock)
  -- if not that's probably the way to go
  netverk = fcv_lattice:new_pattern{
    action = network.step
  }
  fcv_lattice:start()
  params:set("clock_tempo", config.tempo)
  clock.set_source(config.clock_source)
  redraw_clock_id = clock.run(fn.redraw_clock)
end

function fn.redraw_clock()
  while true do
    redraw()
    clock.sleep(1 / graphics.fps)
  end
end

function rerun()
  norns.script.load(norns.state.script)
end

function r()
  rerun()
end

return fn