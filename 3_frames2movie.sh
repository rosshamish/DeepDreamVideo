#!/bin/bash
if [ $# -ne 3 ]; then
    echo "please provide the directory of the processed frames"
    echo "./3_frames2movie.sh [frames_directory] [original_video_with_sound] [output_filename.mp4]"
    exit 1
fi

ffmpeg -framerate 25 -i $1/%4d.jpg -c:v libx264 -r 30 -pix_fmt yuv420p tmp.mp4

ffmpeg -i $2 original.mp3
ffmpeg -i original.mp3 music.wav

secs=$(ffprobe -i tmp.mp4 -show_entries format=duration -v quiet -of csv="p=0")
ffmpeg -i music.wav -ss 0 -t $secs musicshort.wav
ffmpeg -i musicshort.wav -i tmp.mp4 -strict -2 $3.mp4

echo 'Removing temp files'
rm original.mp3
echo "original.mp3 removed"
rm music.wav
echo "music.wav removed"
rm musicshort.wav
echo "musicshort.wav removed"
rm tmp.mp4
echo "tmp.mp4 removed"
