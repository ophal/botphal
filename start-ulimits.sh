#!/bin/bash
ulimit -f 52428800 -t 30 -v 67108864
lua main.lua
