local network = {}

function network.init()
  network.countdown = 0
  network.last_pull_ok = true
end

return network