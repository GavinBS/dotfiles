#!/bin/bash

# 获取主显示器的分辨率
# RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')
RESOLUTION=$(xrandr | awk '/\*/ {print $1; exit}')

case "$RESOLUTION" in
"3840x2160")
  # 4K 分辨率，设置 DPI 200%，调整 i3 相关配置
  # xrandr --output HDMI-1 --mode 3840x2160
  xrdb -merge <<<"Xft.dpi: 192"
  ;;
"1920x1080")
  # 1080p 分辨率，设置 DPI 150%
  # xrandr --output HDMI-1 --mode 1920x1080
  xrdb -merge <<<"Xft.dpi: 144"
  # xrdb -merge <<<"Xft.dpi: 96"
  ;;
*)
  # "未匹配到特定分辨率，使用默认设置"
  # xrandr --output HDMI-1 --mode 1920x1080
  xrdb -merge <<<"Xft.dpi: 96"
  ;;
esac

exec i3
