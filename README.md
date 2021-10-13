# fcv

- ssh/vim/tmux && norns && chill
- mr stonks: structure & melody (lua)
- mr sparkle: sound design (sc)

# NORNS SETUP

- Restart after downloading.
- Copy `lib/default-config.lua` to `lib/config.lua`.
- Enter secret IP address for the `ws_relay_host`.
- Optionally enter a `norns_name`. 

# SPECTATOR INSTRUCTIONS

 - ssh into the secret server.
 - Attach to Tyler's session: `tmux -S /tmp/stonks_socket attach -t stonks_session -r`
 - Open a new tab or ssh into the server again.
 - Attach to Ryan's session: `tmux -S /tmp/sparkle_socket attach -t sparkle_session -r`
 - Open the FCV script on your norns. You should see a smiley face when the connection is established.

# SilO Secret Stiff

We're using a Digital Ocean Unbuntu Droplet with `1 GB Memory / 25 GB Disk / SFO3 - Ubuntu 20.04 (LTS) x64`.

Both apes ssh into a server. Each has vim up in a tmux session and livecodes there.

## ref: https://www.howtoforge.com/sharing-terminal-sessions-with-tmux-and-screen

```
adduser stonks
adduser sparkle
usermod -aG sudo stonks
usermod -aG sudo sparkle
groupadd -g 666 shrewdness
usermod -aG shrewdness stonks
usermod -aG shrewdness sparkle
cp -r /root/.ssh /home/stonks
cp -r /root/.ssh /home/sparkle
chown -R stonks: /home/stonks
chown -R sparkle: /home/sparkle
```

# TMUX TECH

## 1. TYLER DO THIS (setup session for Ryan)
```
tmux -S /tmp/stonks_socket new -s stonks_session
sudo chgrp shrewdness /tmp/stonks_socket
```

## 2. RYAN DO THIS (setup session for Tyler)
```
tmux -S /tmp/sparkle_socket new -s sparkle_session
sudo chgrp shrewdness /tmp/sparkle_socket
```

## 3. THEN TYLER DO THIS (read only Ryan's session)
```
tmux -S /tmp/sparkle_socket attach -t sparkle_session -r
```

## 4. AND RYAN DO THIS (read only Tyler's session)
```
tmux -S /tmp/stonks_socket attach -t stonks_session -r
```
