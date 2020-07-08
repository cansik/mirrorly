//
// Created by Bruggisser Florian on 08.07.20.
//

#include "ScreenMirror.h"

void ScreenMirror::start() {
    //initialize all elements
    gst_init(NULL, NULL);
    pipeline = gst_pipeline_new("pipeline");
    source = gst_element_factory_make("avfvideosrc", "source");
    queue = gst_element_factory_make("queue", "queue");
    sink = gst_element_factory_make("autovideosink", "sink");

    //check for null objects
    if (!pipeline || !source || !queue || !sink) {
        std::cout << "not all elements created: pipeline[" << !pipeline << "]" << "source[" << !source << "]" << "queue["
             << !queue << "]" << "sink[" << !sink << "]" << std::endl;
        return;
    }

    //set video source
    g_object_set(G_OBJECT (source), "capture-screen", TRUE, NULL);
    g_object_set(G_OBJECT (source), "capture-screen-cursor", TRUE, NULL);
    std::cout << "==>Set video source." << std::endl;
    g_object_set(G_OBJECT (sink), "sync", FALSE, NULL);
    std::cout << "==>Set video sink." << std::endl;

    //add all elements together
    gst_bin_add_many(GST_BIN (pipeline), source, queue, sink, NULL);
    if (gst_element_link(source, sink) != TRUE) {
        std::cout << "Elements could not be linked." << std::endl;
        gst_object_unref(pipeline);
        return;
    }
    std::cout << "==>Link elements." << std::endl;

    //get pipeline's bus
    bus = gst_element_get_bus(pipeline);
    std::cout << "==>Setup bus." << std::endl;

    loop = g_main_loop_new(NULL, FALSE);
    std::cout << "==>Begin stream." << std::endl;
    //g_main_loop_run(loop);

    context = g_main_loop_get_context(loop);
}

void ScreenMirror::update() {
    g_main_context_iteration(context, FALSE);
}

void ScreenMirror::stop() {
    std::cout << "==>Shutting down." << std::endl;
    g_main_loop_quit(loop);
    g_main_loop_unref(loop);
    gst_object_unref(bus);
    gst_element_set_state(pipeline, GST_STATE_NULL);
    gst_object_unref(pipeline);
}

void ScreenMirror::play() {
    //set the pipeline state to playing
    ret = gst_element_set_state(pipeline, GST_STATE_PLAYING);
    if (ret == GST_STATE_CHANGE_FAILURE) {
        std::cout << "Unable to set the pipeline to the playing state." << std::endl;
        gst_object_unref(pipeline);
        return;
    }
    std::cout << "==>Set video to play." << std::endl;
}

void ScreenMirror::pause() {
    //set the pipeline state to pause
    ret = gst_element_set_state(pipeline, GST_STATE_PAUSED);
    if (ret == GST_STATE_CHANGE_FAILURE) {
        std::cout << "Unable to set the pipeline to the paused state." << std::endl;
        gst_object_unref(pipeline);
        return;
    }
    std::cout << "==>Set video to pause." << std::endl;
}
