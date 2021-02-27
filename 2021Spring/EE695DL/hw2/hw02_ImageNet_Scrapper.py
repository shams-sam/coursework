# initial import calls
import os

import argparser
import utils

args, args_other = argparser.get_task1_args()
imagenet_info = utils.load_json_file(args.imagenet_info_json)
class_to_url = utils.get_class_urls(args.subclass_list, imagenet_info)

class_folder = os.path.join(args.data_root, args.main_class)
utils.check_dir(class_folder)

for class_name, class_url in class_to_url.items():
    print('Downloading class:{} subclass: {}'.format(args.main_class, class_name))
    count = 1
    for image_url in utils.get_image_urls(class_url):
        flag, save_path = utils.get_image(image_url, class_folder)
        if flag:
            print(count, save_path)
            count += 1
        if count>args.images_per_subclass:
            break
