#!/usr/bin/env zsh
# Make sure gdate is installed --> $ brew install coreutils
tput civis

# TODO quit method

if [[ "$1" == "-t" ]]; then
  # Timer -t hr min sec
  if [[ $4 ]]; then
    length=$(($2*3600+$3*60+$4))
  elif [[ $3 ]]; then
    length=$(($2*60+$3))
  elif [[ $2 ]]; then
    length=$(($2))
  else
    length=10
  fi
  # TODO dynamic space adding for every magnitude of hours
  if [[ length -gt 36000 ]]; then
    space="  "
  else
    space=""
  fi
  started=$(($(gdate +%s.%N)+$length))
  while [[ 1 ]]
  do
    watch=$((${started}-$(gdate +%s.%N)))
    printf "\r%01d:%02d:%02d\e%.3f%s" $((watch/3600)) $((watch%3600/60)) $((watch%60)) $((watch%1)) $space
    if [[ $(gdate +%s.%N) -ge $started ]]; then
      echo -ne '\007' # beep
      while [[ 1 ]] # blink
      do
        printf "\r%s" "0:00:00.000"
        sleep 0.5
        printf "\r%s" "           "
        sleep 0.5
      done
    fi
    #sleep 1
  done
else
  # TODO show LAP
  # Stopwatch
  if [[ "$1" == "-n" ]]; then
    started=$(gdate +%s.%N)
    echo $2 $started >> ~/.zws
  elif [[ "$1" == "-l" ]]; then
    # Load Specific
    if [[ $2 ]]; then
      # TODO fix error when two similar names
      ln=$(echo -n $2 | wc -m)
      line=$(grep $2 ~/.zws)
      lns=$(echo -n $line| wc -m)
      echo $ln
      echo $lns
      started=$(echo $line | cut -c$(($ln+2))-$(($ln+15)))
      echo $started
      # Load Default
    else 
      # Create .zw if it doesn't exist
      if [[ ! -f ~/.zw ]]; then
        gdate +%s.%N > ~/.zw
      fi
      started=$(cat ~/.zw)
    fi
  else
    started=$(gdate +%s.%N)
    echo -n $started > ~/.zw
  fi
  while [[ 1 ]]
  do
    watch=$(($(gdate +%s.%N)-${started}))
    printf "\r%02d:%02d:%02d\e%.3f" $((watch/3600)) $((watch%3600/60)) $((watch%60)) $((watch%1))
    #sleep 1
  done
fi
