import os
import torch
import torchvision.transforms as tvt

import argparser
from custom_loader import CustomLoader
import utils

#==================================================================================
# reproducible results
#==================================================================================
seed = 0
os.environ['PYTHONHASHSEED'] = str(seed)
torch.manual_seed(seed)
torch.cuda.manual_seed(seed)
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmarks = False

#==================================================================================
# parse arguments
#==================================================================================
args, args_other = argparser.get_task2_args()


#==================================================================================
# load data and create dataloader object
#==================================================================================
transform = tvt.Compose([
    tvt.ToTensor(),
    tvt.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))
])

batch_size = 10
train_dataset = CustomLoader(args.imagenet_root, args.class_list, transform, True)
train_data_loader = utils.get_loader(train_dataset, batch_size)
val_dataset = CustomLoader(args.imagenet_root, args.class_list, transform, False)
val_data_loader = utils.get_loader(val_dataset, batch_size)


#==================================================================================
# define network
#==================================================================================
dtype = torch.float64
device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

epochs = 40
learning_rate = 1e-9
D_in, H1, H2, D_out = 3*64*64, 1000, 256, 2

w1 = torch.randn(D_in, H1, device=device, dtype=dtype)
w2 = torch.randn(H1, H2, device=device, dtype=dtype)
w3 = torch.randn(H2, D_out, device=device, dtype=dtype)


#==================================================================================
# training
#==================================================================================
for t in range(epochs):
    mb_loss = 0
    for i, data in enumerate(train_data_loader):
        inputs, labels = data
        inputs, labels = inputs.to(device), labels.to(device)

        x, y = inputs.view(inputs.size(0), -1), labels
        
        h1 = x.mm(w1)
        h1_relu = h1.clamp(min=0)
        h2 = h1_relu.mm(w2)
        h2_relu = h2.clamp(min=0)
        y_pred = h2_relu.mm(w3)

        loss = (y_pred - y).pow(2).sum().item()
        y_error = y_pred - y
        mb_loss += loss

        grad_w3 = h2_relu.t().mm(2*y_error)
        h2_error = 2.0*y_error.mm(w3.t())
        h2_error[h2_error<0] = 0

        grad_w2 = h1_relu.t().mm(2*h2_error)
        h1_error = 2.0*h2_error.mm(w2.t())
        h1_error[h1_error<0] = 0

        grad_w1 = x.t().mm(2*h1_error)

        w1 -= learning_rate * grad_w1
        w2 -= learning_rate * grad_w2
        w3 -= learning_rate * grad_w3

    epoch_loss = mb_loss / len(train_data_loader)
    print ('Epoch %d:\t %0.4f'%(t, epoch_loss))

torch.save({'w1': w1, 'w2': w2, 'w3': w3}, './wts.pkl')


#==================================================================================
# load and validate
#==================================================================================
model = torch.load('./wts.pkl')
w1 = model['w1']
w2 = model['w2']
w3 = model['w3']

mb_accuracy = 0
mb_loss = 0
for i, data in enumerate(val_data_loader):
    inputs, labels = data
    inputs, labels = inputs.to(device), labels.to(device)
    x, y = inputs.view(inputs.size(0), -1), labels

    h1 = x.mm(w1)
    h1_relu = h1.clamp(min=0)
    h2 = h1_relu.mm(w2)
    h2_relu = h2.clamp(min=0)
    y_pred = h2_relu.mm(w3)
    
    loss = (y_pred - y).pow(2).sum().item()
    mb_loss += loss
    pred = y_pred.argmax(1, keepdim=True)
    true = y.argmax(1, keepdim=True)
    mb_accuracy += pred.eq(true).sum().item()

val_loss = mb_loss/len(val_data_loader)
val_accuracy = mb_accuracy/len(val_data_loader.dataset)
print('\nVal Loss: {:.4f}'.format(val_loss))
print('Val Accuracy: {:.4f}'.format(val_accuracy))
