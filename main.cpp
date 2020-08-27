#include <iostream>
#include <thread>
#include <elements.hpp>
#include <utility>
#include "src/ScreenMirror.h"

using namespace std;
using namespace cycfi::elements;

volatile bool running = true;
ScreenMirror mirror{};

auto constexpr bkd_color = rgba(35, 35, 37, 255);
auto background = box(bkd_color);

auto btn_rbox(std::string text, color c)
{
    return
            layer(
                    margin(
                            { 25, 20, 25, 18 },
                            label(std::move(text))
                    ),
                    rbox(c, 10)
            );
}

auto make_button(std::string text)
{
    return layered_button(
            btn_rbox(std::move(text), colors::medium_blue),            // Normal state
            btn_rbox(std::move(text), colors::medium_blue.level(0.8))  // Pushed state
    );
}

void post_func(view& v)
{
    mirror.update();
}

int main(int argc, char *argv[]) {
    std::cout << "Mirrorly Test" << std::endl;

    app _app(argc, argv, "Mirrorly", "ch.cansik.mirrorly");

    window _win("Mirroly");
    _win.on_close = [&_app]() { _app.stop(); };

    view view_(_win);

    auto startButton = make_button("Play/Pause");
    startButton.on_click =
            [startButton, &view_](bool) mutable {
                if(mirror.isPlaying()) {
                    std::cout << "pause" << std::endl;
                    mirror.pause();
                } else {
                    std::cout << "play" << std::endl;
                    mirror.play();
                }
            };

    view_.content(
            startButton,
            background
    );

    mirror.start();
    mirror.play();

    view_.post([&view_](){ post_func(view_); });

    _app.run();

    mirror.stop();
    return 0;
}