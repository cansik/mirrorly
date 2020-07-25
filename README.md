# Mirrorly [![Build Status](https://travis-ci.org/cansik/mirrorly.svg?branch=master)](https://travis-ci.org/cansik/mirrorly)
Mirror your main screen to your second screen for presentations.

### Build

```
# macOS
./preMacOS.sh
./build.sh

# linux
./preLinux.sh
./build.sh

# windows
preWindows.bat
build.bat
```

### Help

Just use the following commands to control the stream:

- `play` - Plays the stream
- `pause` - Stops the stream (freeze mode)
- `quit` - Stop the application

### GStreamer

```bash
gst-launch-1.0 -v avfvideosrc capture-screen=true capture-screen-cursor=true ! queue ! videoscale ! glimagesink
```