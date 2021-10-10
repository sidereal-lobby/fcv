local graphics = {}

function graphics.init()
  graphics.frame = 0
  graphics.fps = 15
  screen.aa(1)
end


function graphics.redraw_clock()
  while true do
    redraw()
    clock.sleep(1 / graphics.fps)
  end
end

function graphics:draw_home()
  graphics.frame = graphics.frame + 1
  graphics:setup()
  graphics:state()
  graphics:teardown()  
end

function graphics:state()

  local c1, c2, c3, c4 = 0, 32, 64, 96
  local r1, r2, r3, r4, r5, r6 = 0, 10, 20, 30, 40, 50, 60

  -- col 1
  screen.font_face(8)
  screen.font_size(24)
  self:text(c1, r1 + 18, tempo_cache, 15)

  
  -- col 2
  screen.font_face(64)
  screen.font_size(8)
  local network_string = network.ready and ":)" or ":("
  local network_status = network.ready and 1 or 0
  self:draw_status(network_string, network_status, c1, r4 + 3)
  self:draw_status(root_cache, 1, c1, r5 + 4)
  self:draw_status(">>>", 1, c1, r6 + 5, self.frame % 15)

  -- col 3
  self:draw_status(v.gye.tpz.data[v.gye.tpz.ix], v.gye.ena, c3, r1)
  self:draw_status(v.ixb.tpz.data[v.ixb.tpz.ix], v.ixb.ena, c3, r2 + 1)
  self:draw_status(v.mek.tpz.data[v.mek.tpz.ix], v.mek.ena, c3, r3 + 2)
  self:draw_status(v.qpo.tpz.data[v.qpo.tpz.ix], v.qpo.ena, c3, r4 + 3)
  self:draw_status(v.urn.tpz.data[v.urn.tpz.ix], v.urn.ena, c3, r5 + 4)
  self:draw_status(v.vrs.tpz.data[v.vrs.tpz.ix], v.vrs.ena, c3, r6 + 5)

  -- col 4
  self:draw_status("gye", v.gye.ena, c4, r1)
  self:draw_status("ixb", v.ixb.ena, c4, r2 + 1)
  self:draw_status("mek", v.mek.ena, c4, r3 + 2)
  self:draw_status("qpo", v.qpo.ena, c4, r4 + 3)
  self:draw_status("urn", v.urn.ena, c4, r5 + 4)
  self:draw_status("vrs", v.vrs.ena, c4, r6 + 5)
end

function graphics:draw_status(text, status, col, row, level)
  local level = (level ~= nil) and level or 15
  local width = 4
  local height = 9
  if status == 0 then
    self:rect(28 + col, row, width, height, 15)
    self:rect(28 + col + 1, row + 1, width - 2, height - 2, 0)
    self:text_right(col + 2 + 25, row + 9,text, 3)
  elseif status == 1 then
    self:rect(28 + col, row, width, height, 15)
    self:text_right(col + 2 + 25, row + 9, text, level)
  end
end

-- northern information
-- graphics library

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
