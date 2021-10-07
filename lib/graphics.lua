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


function graphics.redraw_clock()
  while true do
    redraw()
    clock.sleep(1 / graphics.fps)
  end
end

function graphics:draw_home()
  graphics.frame = graphics.frame + 1
  graphics:setup()
  graphics:local_status()
  graphics:network_status()
  graphics:spinner()
  graphics:tempo()
  graphics:root()
  graphics:teardown()  
end

function graphics:local_status()
  self:text(0, 8, graphics.title)
  self:text(0, 16, "Laws & Etters, mmxxi")
  self:text_right(20, 40, "gye:") self:text(22, 40, l.gye.ena)
  self:text_right(20, 48, "ixb:") self:text(22, 48, l.ixb.ena)
  self:text_right(20, 56, "mek:") self:text(22, 56, l.mek.ena)
  self:text_right(64, 40, "urn:") self:text(66, 40, l.urn.ena)
  self:text_right(64, 48, "ixb:") self:text(66, 48, l.ixb.ena)
  self:text_right(64, 56, "mek:") self:text(66, 56, l.mek.ena)
end

function graphics:tempo()
  self:text_right(112, 8, l.t, 15)
end

function graphics:root()
  self:text_right(112, 16, l.r, 15)
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
