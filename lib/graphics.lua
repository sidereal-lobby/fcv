-- northern information
-- graphics library plus silo nonsense

graphics = {}

function graphics.init()
  screen.aa(1)
  screen.font_face(0)
  screen.font_size(8)
  graphics.fps = 15
end

function graphics:local_status()
  self:mls(1, 0, 0, 64, 15)
  self:text(3, 8, "Sideral Lobby: FCV")
  self:text(3, 16, "Laws & Etters, mmxxi")
  self:text(3, 24, "Lua: " .. hotswap.switch)
  self:text(3, 32, "Item: " .. "status")
  self:text(3, 40, "Item: " .. "status")
  self:text(3, 48, "Item: " .. "status")
  self:text(3, 56, "Item: " .. "status")
  self:text(3, 64, "Item: " .. "status")
end

function graphics:network_status()
  self:timer()
  local status = network.last_pull_ok and "UMBILICUS OK" or self:scramble()
  screen.level(16 - network.countdown)
  screen.text_rotate(119, 63, status, -90)
  self:mls(111, 0, 110, 64, 15)
  local smile_like_you_mean_it = network.last_pull_ok and ":)" or ":("
  self:text(123, 7, smile_like_you_mean_it, 15)
end

function graphics:timer()
  local y = util.linlin(0, 16, 0, 64, network.countdown)
  self:rect(121, y, 7, 64, network.countdown)
  screen.level(16 - network.countdown)
  screen.text_rotate(127, 63, 16 - network.countdown, -90)
end

function graphics:scramble()
  local status = {"U","%","B","!","L","!","C","u","$",",H","4","6","M"}
  local out = ""
  -- fwiw fisher-yates shuffle 
  for i = #status, 2, -1 do
    local j = math.random(i)
    status[i], status[j] = status[j], status[i]
  end
  for i = #status, 2, -1 do
    out = out .. status[i]
  end
  return out
end

function graphics:setup()
  screen.clear()
end

function graphics:teardown()
  screen.update()
end

function graphics:mlrs(x1, y1, x2, y2, l)
  screen.level(l or 15)
  screen.move(x1, y1)
  screen.line_rel(x2, y2)
  screen.stroke()
end

function graphics:mls(x1, y1, x2, y2, l)
  screen.level(l or 15)
  screen.move(x1, y1)
  screen.line(x2, y2)
  screen.stroke()
end

function graphics:rect(x, y, w, h, l)
  screen.level(l or 15)
  screen.rect(x, y, w, h)
  screen.fill()
end

function graphics:circle(x, y, r, l)
  screen.level(l or 15)
  screen.circle(x, y, r)
  screen.fill()
end

function graphics:text(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text(s)
end

function graphics:text_right(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text_right(s)
end

function graphics:text_center(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text_center(s)
end

return graphics