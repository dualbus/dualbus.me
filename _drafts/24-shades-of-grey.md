---
layout: post
title: 24 Shades Of Grey
---

This is just a little write up on what I learned about colors in the terminal.

    vt100/ANSI colors
    256 colors
    RGB colors

    for i in {232..255}; do
        printf '\033[38;5;%dmall work and no play makes jack a dull boy\n' $i;
    done

http://www.pixelbeat.org/docs/terminal_colours/
