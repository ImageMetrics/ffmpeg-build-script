docker build --tag=ffmpeg:default --output type=local,dest=build -f Dockerfile .

DIST_FOLDER = ./dist
mkdir $DIST_FOLDER

cp build/lib/aarch64-linux-gnu/libm.so.6 $DIST_FOLDER
cp build/lib/aarch64-linux-gnu/libstdc++.so.6 $DIST_FOLDER
cp build/lib/aarch64-linux-gnu/libgcc_s.so.1 $DIST_FOLDER
cp build/lib/aarch64-linux-gnu/libc.so.6 $DIST_FOLDER
cp build/lib/ld-linux-aarch64.so.1 $DIST_FOLDER
# copy binary
cp build/bin/ffprobe $DIST_FOLDER # OPTIONALLY include ffmpeg. Lambda layer only need ffprobe