//
// Created by Bruggisser Florian on 08.07.20.
//

#ifndef MIRRORLY_SCREENMIRROR_H
#define MIRRORLY_SCREENMIRROR_H

#include <iostream>
#include <gst/gst.h>
#include <thread>

class ScreenMirror {
private:
    GstElement *pipeline, *source, *sink, *queue;
    GstBus *bus;
    GstMessage *msg;
    GMainLoop *loop;
    GstStateChangeReturn ret;
    GMainContext* context;

    bool playing = false;

public:
    void start();

    void update();

    void stop();

    void play();

    void pause();

    bool isPlaying();
};


#endif //MIRRORLY_SCREENMIRROR_H
