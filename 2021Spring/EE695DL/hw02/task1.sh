#!/bin/bash

debug() {
    python hw02_ImageNet_Scrapper.py --subclass_list 'Siamese cat' 'Persian cat' 'Burmese cat' \
	   --main_class 'cat' --data_root ../data/Train/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 2

    python hw02_ImageNet_Scrapper.py --subclass_list 'hunting dog' 'sporting dog' 'shepherd dog' \
	   --main_class 'dog' --data_root ../data/Train/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 2

    python hw02_ImageNet_Scrapper.py --subclass_list 'domestic cat' 'alley cat' \
	   --main_class 'cat' --data_root ../data/Val/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 1

    python hw02_ImageNet_Scrapper.py --subclass_list 'working dog' 'police dog' \
	   --main_class 'dog' --data_root ../data/Val/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 1
}


run() {
    python hw02_ImageNet_Scrapper.py --subclass_list 'Siamese cat' 'Persian cat' 'Burmese cat' \
	   --main_class 'cat' --data_root ../data/Train/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 200

    python hw02_ImageNet_Scrapper.py --subclass_list 'hunting dog' 'sporting dog' 'shepherd dog' \
	   --main_class 'dog' --data_root ../data/Train/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 200

    python hw02_ImageNet_Scrapper.py --subclass_list 'domestic cat' 'alley cat' \
	   --main_class 'cat' --data_root ../data/Val/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 100

    python hw02_ImageNet_Scrapper.py --subclass_list 'working dog' 'police dog' \
	   --main_class 'dog' --data_root ../data/Val/ \
	   --imagenet_info_json imagenet_class_info.json --images_per_subclass 100
}


$1
