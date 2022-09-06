#!/bin/dash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/catppuccin

cpu() {
  cpu_temp=$(sensors | grep -oP 'Package.*?\+\K[0-9.]+')

  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_temp C"
}

cpu_util() {
  cpu_util=$(mpstat 2 1 | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ { print 100 - $field }')

  printf '%s\n' "^c$white^ ^b$grey^ $cpu_util%"
}

mem() {
  printf "^c$blue^^b$black^ "
  printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

clock() {
  printf "^c$black^ ^b$darkblue^ $(date +'%a %b %d') "
	printf "^c$black^^b$blue^ $(date +'%r') "
}

gpu() {
  gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv | awk 'NR==2')

  printf "^c$black^ ^b$green^ GPU"
  printf "^c$white^ ^b$grey^ $gpu_temp C"
}

gpu_util() {
  gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv | awk 'NR==2')
  printf '%s\n' "^c$white^ ^b$grey^ $gpu_util"
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] 
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(cpu) $(cpu_util) $(gpu) $(gpu_util) $(mem) $(clock)"
done
