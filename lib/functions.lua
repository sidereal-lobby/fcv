local fn = {}

function rerun()
  norns.script.load(norns.state.script)
end

function r()
  rerun()
end

return fn