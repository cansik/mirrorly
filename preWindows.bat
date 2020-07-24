echo "installing all dependencies for mirrorly, this can take a while!"

REM install gstreamer
bitsadmin /transfer mydownloadjob /download /priority FOREGROUND "https://gstreamer.freedesktop.org/data/pkg/windows/1.16.2/gstreamer-1.0-msvc-x86_64-1.16.2.msi" "gstreamer.msi"
msiexec /i gstreamer.msi /quiet /qn /norestart

REM download elements
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"