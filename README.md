# Mirrorly [![Build Status](https://travis-ci.org/cansik/mirrorly.svg?branch=master)](https://travis-ci.org/cansik/mirrorly)
Mirror your main screen to your second screen for presentations.

### Build

```
# install all dependencies (mainly gstreamer-1.0)
./installDepsMacOS.sh

# build
mkdir build && cd build
cmake ..
make release

# run
./mirrorly
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