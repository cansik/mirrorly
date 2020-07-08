#include <iostream>
#include <thread>
#include "ScreenMirror.h"

using namespace std;

volatile bool running = true;

int main(int argc, char *argv[]) {
    std::cout << "Mirrorly Test" << std::endl;

    std::thread thread_object([]() {
        ScreenMirror mirror{};

        mirror.start();
        mirror.play();

        while (running) {
            mirror.update();
        }

        mirror.stop();
    });

    char command[20];
    cout<<"Command: ";
    cin>> command;

    cout << "Done!" << endl;
    running = false;
    thread_object.join();

    return 0;
}
