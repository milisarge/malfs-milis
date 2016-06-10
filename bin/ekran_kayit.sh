ffmpeg -video_size 1440x900 -framerate 20 -f x11grab -i :0.0 -c:v libvpx -crf 04 -b:v 1M ekran.webm
