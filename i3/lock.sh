#!/bin/bash
import -window root /tmp/screenshot.png
#convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
convert /tmp/screenshot.png -spread 30 /tmp/screenshotblur.png
#convert /tmp/screenshot.png -swirl 215 -spread 6 /tmp/screenshotblur.png
rm /tmp/screenshot.png
i3lock -i /tmp/screenshotblur.png

