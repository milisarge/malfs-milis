ffmpeg  -video_size 1024x768 -framerate 20 -f x11grab -i :0.0 -c:v libvpx -crf 4 -b:v 1M  video.webm
