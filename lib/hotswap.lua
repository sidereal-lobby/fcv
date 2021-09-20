local hotswap = {}

function hotswap.init()
  hotswap.switch = "a" -- this is just for the spike, rest is probably ok for prod
  hotswap.payload = {}
end

-- https://www.lua.org/pil/8.html
function hotswap:do_file(filename)
  local f = assert(loadfile(filename))
  return f()
end

function hotswap:lua()
  self.switch = self.switch == "a" and "b" or "a"
  local hot = self:do_file("/home/we/dust/code/fcv/lib/hot_stonks_" .. self.switch .. ".lua")
  self.payload = hot
end

return hotswap