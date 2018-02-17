
grep -q  "^%wheel[[:space:]]ALL=(ALL)[[:space:]]NOPASSWD" /etc/sudoers \
   || echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
