local six = {}

six.names = {"gye","ixb","lor","mek","qpo","vrs"}

gye_lattice = lattice:new{}
gye_pattern = gye_lattice:new_pattern{
  action = function() six.step("gye") end
}

ixb_lattice = lattice:new{}
ixb_pattern = ixb_lattice:new_pattern{
  action = function() six.step("ixb") end
}

lor_lattice = lattice:new{}
lor_pattern = lor_lattice:new_pattern{
  action = function() six.step("lor") end
}

mek_lattice = lattice:new{}
mek_pattern = mek_lattice:new_pattern{
  action = function() six.step("mek") end
}

qpo_lattice = lattice:new{}
qpo_pattern = qpo_lattice:new_pattern{
  action = function() six.step("qpo") end
}

vrs_lattice = lattice:new{}
vrs_pattern = vrs_lattice:new_pattern{
  action = function() six.step("vrs") end
}



function six.init()
  gye_lattice:start()
  ixb_lattice:start()
  lor_lattice:start()
  mek_lattice:start()
  qpo_lattice:start()
  vrs_lattice:start()
end

function six.step(voice)
  if voice == nil then return end
  six:update_meter(voice)
  if v[voice]["ena"]() == 1 then
    engine.note(voice, root_cache + v[voice]["tpz"]() + v[voice]["nte"]())
    engine.mod(voice, util.linlin(0, 100, 0.0, 1.0, v[voice]["mod"]()))
    if v[voice]["trg"]() == 1 then
      engine.trig(voice, util.linlin(0, 100, 0.0, 1.0, v[voice]["vel"]()))
      graphics:trigger(voice)
    end
  end
end

function six:update_meter(voice)
  if voice == "gye" then
    gye_lattice:set_meter(v.gye.mtr())
  elseif voice == "ixb" then
    ixb_lattice:set_meter(v.ixb.mtr())
  elseif voice == "lor" then
    lor_lattice:set_meter(v.lor.mtr())
  elseif voice == "mek" then
    mek_lattice:set_meter(v.mek.mtr())
  elseif voice == "qpo" then
    qpo_lattice:set_meter(v.qpo.mtr())
  elseif voice == "vrs" then
    vrs_lattice:set_meter(v.vrs.mtr())
  end
end

return six
