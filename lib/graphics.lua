local graphics = {}

function graphics.init()
  graphics.frame = 0
  graphics.fps = 15
  graphics.ancient_frames = { gye = 0, ixb = 0, lor = 0, mek = 0, qpo = 0, vrs = 0 }
  screen.aa(1)
end


function graphics.redraw_clock()
  while true do
    redraw()
    for k, v in pairs(graphics.ancient_frames) do
      if v > 0 then
        graphics.ancient_frames[k] = util.clamp(v - 2, 0, 15)
      end
    end
    clock.sleep(1 / graphics.fps)
  end
end

function graphics:trigger(voice)
  self.ancient_frames[voice] = 15
end

function graphics:draw_home()
  self.frame = graphics.frame + 1
  self:setup()
  self:state()
  self:teardown()  
end

function graphics:state()
  local c1, c2, c3, c4 = 0, 32, 64, 96
  local r1, r2, r3, r4, r5, r6 = 0, 10, 20, 30, 40, 50, 60

  -- tempo
  screen.font_face(8)
  screen.font_size(32)
  self:text(c1, r2 + 18, tempo_cache, 15)

  -- freeze indicator
  screen.font_face(64)
  screen.font_size(8)
  self:text(c1, r4 + 3 + 9, ">>>>>>>>", self.frame % 15)
  self:text(c1, r5 + 4 + 9, ">>>>>>>>", self.frame % 15)

  -- col 1
  local network_string = network.ready and ":)" or ":("
  local network_status = network.ready and 1 or 0
  local network_text   = network.ready and 15 or 3
  local network_fill   = network.ready and 15 or 0
  self:draw_status(network_string, network_status, c1, r6 + 5, 15, network_fill)  

  -- col 2
  self:draw_status(root_cache, 1, c2, r6 + 5, 15, 15)

  -- col 3
  self:draw_status(v.gye.tpz.data[v.gye.tpz.ix], v.gye.ena.data[v.gye.ena.ix], c3, r1 + 0, 15, self.ancient_frames.gye)
  self:draw_status(v.ixb.tpz.data[v.ixb.tpz.ix], v.ixb.ena.data[v.ixb.ena.ix], c3, r2 + 1, 15, self.ancient_frames.ixb)
  self:draw_status(v.lor.tpz.data[v.lor.tpz.ix], v.lor.ena.data[v.lor.ena.ix], c3, r3 + 2, 15, self.ancient_frames.lor)
  self:draw_status(v.mek.tpz.data[v.mek.tpz.ix], v.mek.ena.data[v.mek.ena.ix], c3, r4 + 3, 15, self.ancient_frames.mek)
  self:draw_status(v.qpo.tpz.data[v.qpo.tpz.ix], v.qpo.ena.data[v.qpo.ena.ix], c3, r5 + 4, 15, self.ancient_frames.qpo)
  self:draw_status(v.vrs.tpz.data[v.vrs.tpz.ix], v.vrs.ena.data[v.vrs.ena.ix], c3, r6 + 5, 15, self.ancient_frames.vrs)

  -- col 4
  self:draw_status("gye", v.gye.ena.data[v.gye.ena.ix], c4, r1 + 0, 15, self.ancient_frames.gye)
  self:draw_status("ixb", v.ixb.ena.data[v.ixb.ena.ix], c4, r2 + 1, 15, self.ancient_frames.ixb)
  self:draw_status("lor", v.lor.ena.data[v.lor.ena.ix], c4, r3 + 2, 15, self.ancient_frames.lor)
  self:draw_status("mek", v.mek.ena.data[v.mek.ena.ix], c4, r4 + 3, 15, self.ancient_frames.mek)
  self:draw_status("qpo", v.qpo.ena.data[v.qpo.ena.ix], c4, r5 + 4, 15, self.ancient_frames.qpo)
  self:draw_status("vrs", v.vrs.ena.data[v.vrs.ena.ix], c4, r6 + 5, 15, self.ancient_frames.vrs)


end

function graphics:draw_status(text, status, col, row, text_level, trig_level)
  local width = 4
  local height = 9
  local text_calc = 3
  local trig_calc = 0
  local border_calc = 15
  if status == 1 then
    text_calc = text_level
    trig_calc = trig_level
    if trig_calc > 10 then
      border_calc = 0
    end
  end
  self:rect(28 + col, row, width, height, border_calc)
  self:rect(28 + col + 1, row + 1, width - 2, height - 2, trig_calc)
  self:text_right(col + 2 + 25, row + 9, text, text_calc)
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
