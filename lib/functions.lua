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

function rerun()
  norns.script.load(norns.state.script)
end

function r()
  rerun()
end

return fn