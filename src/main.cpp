#include <iostream>
#include <gst/gst.h>
#include <iostream>
using namespace std;

int main(int argc, char *argv[]) {
    std::cout << "Mirrorly Test" << std::endl;

    GstElement *pipeline, *source, *sink;
    GstBus *bus;
    GstMessage *msg;
    GMainLoop *loop;
    GstStateChangeReturn ret;
    //initialize all elements
    gst_init(&argc, &argv);
    pipeline = gst_pipeline_new ("pipeline");
    source = gst_element_factory_make ("autovideosrc", "source");
    sink = gst_element_factory_make ("autovideosink", "sink");

    //check for null objects
    if (!pipeline || !source || !sink) {
        cout << "not all elements created: pipeline["<< !pipeline<< "]" << "source["<< !source<< "]" << "sink["<< !sink << "]" << endl;
        return -1;
    }

    //set video source
    g_object_set(G_OBJECT (source), "location", argv[1], NULL);
    cout << "==>Set video source." << endl;
    g_object_set(G_OBJECT (sink), "sync", FALSE, NULL);
    cout << "==>Set video sink." << endl;

    //add all elements together
    gst_bin_add_many (GST_BIN (pipeline), source, sink, NULL);
    if (gst_element_link (source, sink) != TRUE) {
        cout << "Elements could not be linked." << endl;
        gst_object_unref (pipeline);
        return -1;
    }
    cout << "==>Link elements." << endl;

    //set the pipeline state to playing
    ret = gst_element_set_state (pipeline, GST_STATE_PLAYING);
    if (ret == GST_STATE_CHANGE_FAILURE) {
        cout << "Unable to set the pipeline to the playing state." << endl;
        gst_object_unref (pipeline);
        return -1;
    }
    cout << "==>Set video to play." << endl;

    //get pipeline's bus
    bus = gst_element_get_bus (pipeline);
    cout << "==>Setup bus." << endl;

    loop = g_main_loop_new(NULL, FALSE);
    cout << "==>Begin stream." << endl;
    g_main_loop_run(loop);

    g_main_loop_unref(loop);
    gst_object_unref (bus);
    gst_element_set_state (pipeline, GST_STATE_NULL);
    gst_object_unref (pipeline);

    return 0;
}
