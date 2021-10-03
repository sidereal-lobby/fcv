local graphics = {}

function graphics.init()
  graphics.title = "Sidereal Lobby: FCV"
  graphics.frame = 0
  graphics.spinner_frame = 0
  graphics.spinner_index = 1
  graphics.spinner_glyph = {}
  graphics.spinner_glyph[1] = "/"
  graphics.spinner_glyph[2] = "-"
  graphics.spinner_glyph[3] = "\\"
  graphics.spinner_glyph[4] = "-"
  graphics.fps = 15
  screen.aa(1)
  screen.font_face(0)
  screen.font_size(8)
end

function graphics:draw_home()
  graphics.frame = graphics.frame + 1
  graphics:setup()
  graphics:local_status()
  graphics:network_status()
  graphics:spinner()
  graphics:teardown()  
end

function graphics:local_status()
  self:text(0, 8, graphics.title)
  self:text(0, 16, "Laws & Etters, mmxxi")
  -- self:text(0, 32, "Item: " .. "status")
  -- self:text(0, 40, "Item: " .. "status")
  -- self:text(0, 48, "Item: " .. "status")
  -- self:text(0, 56, "Item: " .. "status")
  -- self:text(0, 64, "Item: " .. "status")
end

function graphics:network_status()
  self:text(123, 7, network.ready and ":)" or ":(", 15)
end

function graphics:spinner()
  self.spinner_frame = util.wrap(self.spinner_frame + 1, 1, 8)
  if self.frame % 8 == 0 then
    self.spinner_index = util.wrap(self.spinner_index + 1, 1, 4)
  end
  self:text(117, 7, self.spinner_glyph[self.spinner_index], 15)
end

-- northern information
-- graphics library plus

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
