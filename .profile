if [ "$XDG_SESSION_DESKTOP" = "sway" ]; then
  export SDL_VIDEODRIVER=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_TYPE=wayland
  export QT_QPA_PLATFORMTHEME=gtk3
  export MOZ_ENABLE_WAYLAND=1
  export _JAVA_AWT_WM_NONREPARENTING=1
fi
