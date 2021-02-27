#!/bin/bash
exec > output.txt

run() {
    python hw02_imagenet_task2.py --imagenet_root ../data --class_list 'cat' 'dog' &
}

$1
