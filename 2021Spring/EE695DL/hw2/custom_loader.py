import numpy as np
import os
from PIL import Image
from torch.utils.data import DataLoader, Dataset

import cfg


class CustomLoader(Dataset):
    def __init__(self, data_root, classes, transform, train=True):
        if train:
            data_root = os.path.join(data_root, cfg.TRAIN_FOLDER)
        else:
            data_root = os.path.join(data_root, cfg.VALID_FOLDER)

        class_to_idx = {cls: idx for idx, cls in enumerate(sorted(classes))}
        data_samples = self.get_samples(data_root, class_to_idx)

        self.classes = classes
        self.class_to_idx = class_to_idx
        self.data = data_samples
        self.transform = transform

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        sample = self.data[idx]
        image = np.asarray(Image.open(sample[0])).astype(np.float64)

        # image = image/cfg.MAX_PIXEL_VAL
        # image = image.transpose(2, 0, 1)
        # Note: ToTensor() does normalization and channel transpose

        image = self.transform(image)
        label = np.zeros((len(self.classes),))
        label[sample[1]] = 1

        return image, label
        

    def get_classes(self, data_root):
        classes = sorted([obj.name for obj in os.scandir(data_root) if obj.is_dir()])
        

        return classes, class_to_idx

    def get_samples(self, data_root, class_to_idx):
        samples = []
        for cls, idx in class_to_idx.items():
            cls_dir = os.path.join(data_root, cls)
            for sample_path in os.scandir(cls_dir):
                if sample_path.is_file():
                    samples.append((sample_path.path, idx))

        return samples
