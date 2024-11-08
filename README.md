# session-locker

Lock local systemd sessions when switching a local terminal

## Prerequisites

- a distribution using systemd 

## Installation

copy the script session-locker.sh to `/usr/local/bin/session-locker.sh` and make it executable.  
copy the service file session-locker.service to `/etc/systemd/system/session-locker.service`.  
run `systemctl daemon-reload` to load the service.

## Execution

run `systemctl enable --now session-locker.service`

## Conclusion
Now, all types of graphical local sessions will be locked on changing a session.  
Text-based sessions will be killed, because locking text TTYs is unreliable [#35093](https://github.com/systemd/systemd/issues/35093).

This is merely a workaround for some security gaps in systemd.  
Hopefully, the issues covered will be fixed soon.
