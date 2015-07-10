#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "./deepdreamer.sh [originalVideoFilename.mp4] [outputFilename.mp4]"
    exit 1
fi

mkdir -p frames
mkdir -p processed
echo "creating temporary directories ./frames/ and ./processed/"

./1_movie2frames.sh ffmpeg $1 frames
python ./2_dreaming_time.py -i frames -o processed --gpu
./3_frames2movie.sh processed $1 $2

rm -rf frames
rm -rf processed
echo "cleaned up temporary directories ./frames/ and ./processed/"
