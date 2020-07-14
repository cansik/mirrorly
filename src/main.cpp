#include <iostream>
#include <thread>
#include <elements.hpp>
#include "ScreenMirror.h"

using namespace std;
using namespace cycfi::elements;

volatile bool running = true;
ScreenMirror mirror{};

auto constexpr bkd_color = rgba(35, 35, 37, 255);
auto background = box(bkd_color);

auto btn_rbox(color c)
{
    return
            layer(
                    margin(
                            { 25, 20, 25, 18 },
                            label("Dogs are my favorite people")
                    ),
                    rbox(c, 10)
            );
}

auto make_button()
{
    return layered_button(
            btn_rbox(colors::medium_blue),            // Normal state
            btn_rbox(colors::medium_blue.level(0.8))  // Pushed state
    );
}

void post_func(view& v)
{
    mirror.update();
}

int main(int argc, char *argv[]) {
    std::cout << "Mirrorly Test" << std::endl;

    app _app(argc, argv, "Mirrorly", "ch.cansik.mirrorly");

    window _win(_app.name());
    _win.on_close = [&_app]() { _app.stop(); };

    view view_(_win);
    view_.content(
            background
    );

    mirror.start();
    mirror.play();

    view_.post([&view_](){ post_func(view_); });

    _app.run();

    mirror.stop();
    return 0;
}