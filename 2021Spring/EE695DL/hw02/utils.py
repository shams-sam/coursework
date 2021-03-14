import os 
import json
from PIL import Image
import requests
from requests.exceptions import ConnectionError, \
    ReadTimeout, TooManyRedirects, MissingSchema, InvalidURL
import torch

import cfg


def get_class_urls(classes, dict_obj):
    class_to_url = {}
    for idx, item in dict_obj.items():
        if item['class_name'] in classes:
            class_to_url[str(item['class_name'])] = cfg.URL_TEMPLATE.format(idx)

    return class_to_url


# code from hw2 handout
def get_image_urls(class_url):
    resp = requests.get(class_url)
    return [url.decode('utf-8') for url in resp.content.splitlines()]


# code from hw2 handout
def get_image(img_url, class_folder):
    if len(img_url) <= 1:
        return False, None
    try :
        img_resp = requests.get(img_url, timeout=1)
    except ConnectionError:
        return False, None
    except ReadTimeout:
        return False, None
    except TooManyRedirects:
        return False, None
    except MissingSchema:
        return False, None
    except InvalidURL:
        return False, None

    if not 'content-type' in img_resp.headers:
        return False, None
    if not 'image' in img_resp.headers ['content-type']:
        return False, None
    if (len(img_resp.content)<1000):
        return False, None

    img_name = img_url.split('/')[-1]
    img_name = img_name.split ('?')[0]

    if (len(img_name)<=1):
        return False, None
    if not 'flickr' in img_url :
        return False, None
    img_file_path = os.path.join(class_folder, img_name)

    with open(img_file_path, 'wb') as img_f:
        img_f.write(img_resp.content)

    # Resize image to 64x64
    im = Image.open(img_file_path)
    if im.mode != "RGB ":
        im = im.convert(mode="RGB")
    im_resized = im.resize((64, 64), Image.BOX)
    im_resized.save(img_file_path)

    return True, img_file_path


def get_loader(dataset, batch_size=10, shuffle=True, num_workers=4):
    return torch.utils.data.DataLoader(
        dataset=dataset, batch_size=batch_size,
        shuffle=shuffle, num_workers=num_workers)


def check_dir(path):
    full_path = ''
    for folder in path.split('/'):
        full_path = os.path.join(full_path, folder)
        if not os.path.isdir(full_path):
            os.mkdir(full_path)
            print("Made dir: {}".format(full_path))
    assert full_path == path
    print('Checked: {}'.format(path))
    
    
def load_json_file(file_name):
    with open(file_name) as f:
        content = json.load(f)

    return content
