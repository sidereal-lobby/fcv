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
  graphics:reset_font()
  graphics:pulse()
  graphics:silo()
  graphics:reset_font()
  graphics:state()
  graphics:teardown()  
end

function graphics:pulse()
  self:circle(9, 56, 8, 15)
  self:circle(9, 56, 7, 0)
  self:circle(9, 56, 5, self.frame % 15)
end

function graphics:reset_font()
  screen.font_face(0)
  screen.font_size(8)
end

function graphics:silo()
  screen.font_face(8)
  screen.font_size(25)
  self:text(77, 23, "SiLo", 15)
  self:text(0, 23, tempo_cache, 15)
end

function graphics:state()
  local col_1_x, col_2_x, col_3_x = 0, 42, 85
  local row_1_y, row_2_y, row_3_y = 26, 39, 52
  self:draw_status("gye", v.gye.ena, col_2_x, row_1_y)
  self:draw_status("ixb", v.ixb.ena, col_2_x, row_2_y)
  self:draw_status("mek", v.mek.ena, col_2_x, row_3_y)
  self:draw_status("qpo", v.qpo.ena, col_3_x, row_1_y)
  self:draw_status("urn", v.urn.ena, col_3_x, row_2_y)
  self:draw_status("vrs", v.vrs.ena, col_3_x, row_3_y)
  self:text(col_1_x, row_1_y + 7, "root " .. root_cache, 15)
  self:text(col_1_x, row_2_y + 2, "server " .. (network.ready and ":)" or ":("), 15)
end

function graphics:draw_status(text, status, col, row)
  local width = 42
  local height = 12
  if status == 0 then
    self:rect(col, row, width, height, 15)
    self:rect(col + 1, row + 1, width - 2, height - 2, 0)
    self:text_right(col + 20, row + 7, text, 15)
    self:text(col + 25, row + 7, "off", 15)
  elseif status == 1 then
    self:rect(col, row, width, height, 15)
    self:text_right(col + 20, row + 7, text, 0)
    self:text(col + 25, row + 7, "on", 0)
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
