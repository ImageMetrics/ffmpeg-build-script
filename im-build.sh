make_dir () {
    if [ ! -d $1 ]; then
        if ! mkdir $1; then            
            printf "\n Failed to create dir %s" "$1";
            exit 1
        fi
    fi    
}

docker build --tag=ffmpeg:default --output type=local,dest=build -f Dockerfile .


DIST_FOLDER = ./dist
make_dir $DIST_FOLDER

cp build/lib/aarch64-linux-gnu/libm.so.6 $DIST_FOLDER
cp build/lib/aarch64-linux-gnu/libstdc++.so.6 $DIST_FOLDER
cp build/lib/aarch64-linux-gnu/libgcc_s.so.1 $DIST_FOLDER
cp build/lib/aarch64-linux-gnu/libc.so.6 $DIST_FOLDER
cp build/lib/ld-linux-aarch64.so.1 $DIST_FOLDER
# copy binary
cp build/bin/ffprobe $DIST_FOLDER # OPTIONALLY include ffmpeg. Lambda layer only need ffprobe