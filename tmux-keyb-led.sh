#!/usr/bin/env sh
# exit 0 if caps is on, exit 1 otherwise

# Linux (Hyprland/Wayland)
p="$(find /sys/class/leds -name '*::capslock' 2>/dev/null | head -n1)"
if [ -n "$p" ] && [ -r "$p/brightness" ] && [ "$(cat "$p/brightness" 2>/dev/null)" = "1" ]; then
  exit 0
fi

# WSL (ask Windows)
ps="$(command -v powershell.exe 2>/dev/null || command -v pwsh.exe 2>/dev/null || true)"
[ -z "$ps" ] && ps="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
if [ -x "$ps" ]; then
  st="$("$ps" -NoProfile -Command "[Console]::CapsLock" 2>/dev/null | tr -d '\r\n')"
  [ "$st" = "True" ] && exit 0
fi

exit 1

