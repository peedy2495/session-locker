#!/bin/bash

active=$(cat /sys/class/tty/tty0/active)

while true; do
    state=$(cat /sys/class/tty/tty0/active)
    if [ "${active}" != "${state}" ]; then
        for session in $(loginctl | grep tty | awk '{print $1}'); do
            session_type=$(sudo loginctl show-session ${session} | grep Type | cut -d '=' -f2)
            if [ "$session_type" = "tty" ]; then
                if loginctl show-session ${session} | grep TTY | grep -q pts; then
                    # Don't touch remote pseudo terminals
                    continue
                fi
                # Locking text TTYs is unreliable; use secure termination instead.
                loginctl kill-session ${session}
            else
                loginctl lock-session ${session}
            fi
        done
        active="${state}"
    fi
    sleep 0.1
done