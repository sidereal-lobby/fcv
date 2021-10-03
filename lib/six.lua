local six = {}

gye_lattice = lattice:new{}
gye_pattern = gye_lattice:new_pattern{
  action = function() six:step("gye") end
}

ixb_lattice = lattice:new{}
ixb_pattern = ixb_lattice:new_pattern{
  action = function() six.step("ixb") end
}

mek_lattice = lattice:new{}
mek_pattern = mek_lattice:new_pattern{
  action = function() six.step("mek") end
}

urn_lattice = lattice:new{}
urn_pattern = urn_lattice:new_pattern{
  action = function() six.step("urn") end
}

vrs_lattice = lattice:new{}
vrs_pattern = vrs_lattice:new_pattern{
  action = function() six.step("vrs") end
}

yyr_lattice = lattice:new{}
yyr_pattern = yyr_lattice:new_pattern{
  action = function() six.step("yyr") end
}


function six:step(voice)
  if voice == nil then return end
  six:update_division(voice)
  if l[voice]["ena"] == 1 then
    engine.note(voice, l[voice]["nte"]() + l.r)
    engine.mod(voice, l[voice]["mod"]())
    if l[voice]["trg"]() == 1 then
      engine.trig(voice)
    end
  end
end

function six:update_division(voice)
  if voice == "gye" then
    gye_pattern:set_division(l.gye.div())
  elseif voice == "ixb" then
    gye_pattern:set_division(l.ixb.div())
  elseif voice == "mek" then
    gye_pattern:set_division(l.mek.div())
  elseif voice == "urn" then
    gye_pattern:set_division(l.urn.div())
  elseif voice == "vrs" then
    gye_pattern:set_division(l.vrs.div())
  elseif voice == "yrr" then
    gye_pattern:set_division(l.yrr.div())
  end
end

function six.init()
  gye_lattice:start()
  ixb_lattice:start()
  mek_lattice:start()
  urn_lattice:start()
  vrs_lattice:start()
  yyr_lattice:start()
end  

return six