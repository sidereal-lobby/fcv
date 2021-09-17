# fcv

- ssh/vim/tmux && norns && chill
- mr stonks: structure & melody (lua)
- mr sparkle: sound design (sc)


# TMUX TECH

Both apes ssh into a server. Each has vim up in a tmux session and livecodes there.

## ref: https://www.howtoforge.com/sharing-terminal-sessions-with-tmux-and-screen

## 1. SETUP (users, groups, sudo)
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

## 2a. TYLER DO THIS (setup session for Ryan)
```
tmux -S /tmp/stonks_socket new -s stonks_session
sudo chgrp shrewdness /tmp/stonks_socket
```

## 2b. RYAN DO THIS (setup session for Tyler)
```
tmux -S /tmp/sparkle_socket new -s sparkle_session
sudo chgrp shrewdness /tmp/sparkle_socket
```

## 3. THEN TYLER DO THIS (read only Ryan's session)
```
tmux -S /tmp/sparkle_socket attach -t sparkle_session -r
```

## 3. AND RYAN DO THIS (read only Tyler's session)
```
tmux -S /tmp/stonks_socket attach -t stonks_session -r
```
