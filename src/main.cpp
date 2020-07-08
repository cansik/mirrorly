#include <iostream>
#include <thread>
#include "ScreenMirror.h"

using namespace std;

volatile bool running = true;
ScreenMirror mirror{};

int main(int argc, char *argv[]) {
    std::cout << "Mirrorly Test" << std::endl;

    mirror.start();
    mirror.play();

    std::thread thread_object([]() {
        std::string command;

        while (running) {
            cout << "Command: ";
            cin >> command;

            if(command == "play") {
                mirror.play();
            }

            if(command == "pause") {
                mirror.pause();
            }

            if(command == "quit") {
                running = false;
            }
        }
    });

    while (running) {
        mirror.update();
    }

    mirror.stop();

    cout << "Done!" << endl;
    thread_object.join();

    return 0;
}
