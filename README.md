# zw
Terminal Timer / Stopwatch using zsh

Must have gdate installed
```
$ brew install coreutils
```

Start/restart the stopwatch:
```
$ ./zw.sh
```

Continue the stopwatch:
```
$ ./zw.sh -l
```

Start the timer (default 10 seconds):
```
$ ./zw.sh -t
```
or
```
$ ./zw.sh -t [hours] [minutes] [seconds]
```
If only one argument is given, it will be considered as seconds.
If two arguments are given, it will be considered as minutes and seconds.

__Tip__: create an alias in your ```.zshrc``` file to access it quicker (e.g. ```alias zw='./zw.sh'```)
```
$ zw
$ zw -l
$ zw -t
```
