import argparse


def get_task1_args():
    parser = argparse.ArgumentParser(description='HW02 Task1')
    parser.add_argument('--subclass_list', nargs='*',type=str, required=True)
    parser.add_argument('--images_per_subclass', type=int, required=True)
    parser.add_argument('--data_root', type=str, required=True)
    parser.add_argument('--main_class', type=str, required=True)
    parser.add_argument('--imagenet_info_json',type=str, required=True)
    args, args_other = parser.parse_known_args()

    return args, args_other


def get_task2_args():
    parser = argparse.ArgumentParser(description='HW02 Task2')
    parser.add_argument('--imagenet_root', type=str, required=True)
    parser.add_argument('--class_list', nargs ='*', type =str, required=True)
    args, args_other = parser.parse_known_args()

    return args, args_other
