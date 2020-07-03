# Mirrorly
Mirror your main screen to your second screen for presentations.

### Install

### GStreamer

```bash
gst-launch-1.0 -v avfvideosrc capture-screen=true ! glimagesink
```