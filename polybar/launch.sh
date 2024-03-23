polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log 
# polybar bar 2>&1 | tee -a /tmp/polybar1.log & disown

if type "xrandr"; then
    for m in $(polybar --list-monitors | cut -d":" -f1); do
      MONITOR=$m polybar --reload bar & 
    done
else
  polybar --reload bar &
fi

echo "Bars launched..."

