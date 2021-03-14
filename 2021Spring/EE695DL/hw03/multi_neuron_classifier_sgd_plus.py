#!/usr/bin/env python

##  multi_neuron_classifier_sgd_plus.py

# comment out if installed in $PATH
import sys
sys.path.append('../ComputationalGraphPrimer-1.0.5')

import random
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import operator

seed = 0           
random.seed(seed)
np.random.seed(seed)

from ComputationalGraphPrimer import *

# extending class to modify
class ComputationalGraphPrimerPlus(ComputationalGraphPrimer):
    def __init__(self, momentum, **kwargs):
        super().__init__(**kwargs)
        self.momentum = momentum

    def run_training_loop_multi_neuron_model(self, momentum):
        training_data = self.training_data
        self.vals_for_learnable_params = {param: random.uniform(0,1) for param in self.learnable_params}
        self.bias = [random.uniform(0,1) for _ in range(self.num_layers-1)]

        class DataLoader:
            def __init__(self, training_data, batch_size):
                self.training_data = training_data
                self.batch_size = batch_size
                self.class_0_samples = [(item, 0) for item in self.training_data[0]]
                self.class_1_samples = [(item, 1) for item in self.training_data[1]]
            def __len__(self):
                return len(self.training_data[0]) + len(self.training_data[1])
            def _getitem(self):    
                cointoss = random.choice([0,1])
                if cointoss == 0:
                    return random.choice(self.class_0_samples)
                else:
                    return random.choice(self.class_1_samples)            
            def getbatch(self):
                batch_data,batch_labels = [],[]
                maxval = 0.0
                for _ in range(self.batch_size):
                    item = self._getitem()
                    if np.max(item[0]) > maxval: 
                        maxval = np.max(item[0])
                    batch_data.append(item[0])
                    batch_labels.append(item[1])
                batch_data = [item/maxval for item in batch_data]                
                batch = [batch_data, batch_labels]
                return batch                

        data_loader = DataLoader(self.training_data, batch_size=self.batch_size)
        loss_running_record = []
        i = 0
        avg_loss_over_literations = 0.0
        prev_grad = {param: 0 for param in self.learnable_params}
        prev_bias = [0 for _ in range(self.num_layers-1)]
        for i in range(self.training_iterations):
            data = data_loader.getbatch()
            data_tuples = data[0]
            class_labels = data[1]
            self.forward_prop_multi_neuron_model(data_tuples)
            predicted_labels_for_batch = self.forw_prop_vals_at_layers[self.num_layers-1]
            y_preds =  [item for sublist in  predicted_labels_for_batch  for item in sublist]
            loss = sum([(abs(class_labels[i] - y_preds[i]))**2 for i in range(len(class_labels))])
            loss_avg = loss / float(len(class_labels))
            avg_loss_over_literations += loss_avg
            if i%(self.display_loss_how_often) == 0: 
                avg_loss_over_literations /= self.display_loss_how_often
                loss_running_record.append(avg_loss_over_literations)
                print("[iter=%d]  loss = %.4f" %  (i+1, avg_loss_over_literations))
                avg_loss_over_literations = 0.0
            y_errors = list(map(operator.sub, class_labels, y_preds))
            y_error_avg = sum(y_errors) / float(len(class_labels))
            if not momentum:
                self.backprop_and_update_params_multi_neuron_model(y_error_avg, class_labels)
            else:
                prev_grad, prev_bias = self.backprop_and_update_params_multi_neuron_model_plus(y_error_avg, class_labels, prev_grad, prev_bias)

        return loss_running_record

    def backprop_and_update_params_multi_neuron_model_plus(self, y_error, class_labels, prev_grad, prev_bias):
        # backproped prediction error:
        pred_err_backproped_at_layers = {i : [] for i in range(1,self.num_layers-1)}  
        pred_err_backproped_at_layers[self.num_layers-1] = [y_error]
        for back_layer_index in reversed(range(1,self.num_layers)):
            input_vals = self.forw_prop_vals_at_layers[back_layer_index -1]
            input_vals_avg = [sum(x) for x in zip(*input_vals)]
            input_vals_avg = list(map(operator.truediv, input_vals_avg, [float(len(class_labels))] * len(class_labels)))
            deriv_sigmoid =  self.gradient_vals_for_layers[back_layer_index]
            deriv_sigmoid_avg = [sum(x) for x in zip(*deriv_sigmoid)]
            deriv_sigmoid_avg = list(map(operator.truediv, deriv_sigmoid_avg, 
                                                             [float(len(class_labels))] * len(class_labels)))
            vars_in_layer  =  self.layer_vars[back_layer_index]                 ## a list like ['xo']
            vars_in_next_layer_back  =  self.layer_vars[back_layer_index - 1]   ## a list like ['xw', 'xz']

            layer_params = self.layer_params[back_layer_index]         
            ## note that layer_params are stored in a dict like        
                ##     {1: [['ap', 'aq', 'ar', 'as'], ['bp', 'bq', 'br', 'bs']], 2: [['cp', 'cq']]}
            ## "layer_params[idx]" is a list of lists for the link weights in layer whose output nodes are in layer "idx"
            transposed_layer_params = list(zip(*layer_params))         ## creating a transpose of the link matrix

            backproped_error = [None] * len(vars_in_next_layer_back)
            for k,varr in enumerate(vars_in_next_layer_back):
                for j,var2 in enumerate(vars_in_layer):
                    backproped_error[k] = sum([self.vals_for_learnable_params[transposed_layer_params[k][i]] * 
                                               pred_err_backproped_at_layers[back_layer_index][i] 
                                               for i in range(len(vars_in_layer))])
#                                               deriv_sigmoid_avg[i] for i in range(len(vars_in_layer))])
            pred_err_backproped_at_layers[back_layer_index - 1]  =  backproped_error
            input_vars_to_layer = self.layer_vars[back_layer_index-1]
            for j,var in enumerate(vars_in_layer):
                layer_params = self.layer_params[back_layer_index][j]
                for i,param in enumerate(layer_params):
                    gradient_of_loss_for_param = input_vals_avg[i] * pred_err_backproped_at_layers[back_layer_index][j]
                    gradient = gradient_of_loss_for_param * deriv_sigmoid_avg[j]
                    step = self.momentum*prev_grad[param] + self.learning_rate*gradient
                    prev_grad[param] = step
                    self.vals_for_learnable_params[param] += step
            gradient = sum(pred_err_backproped_at_layers[back_layer_index]) * sum(deriv_sigmoid_avg)/len(deriv_sigmoid_avg)
            step = self.momentum*prev_bias[back_layer_index-1] + self.learning_rate*gradient
            prev_bias[back_layer_index-1] = step
            self.bias[back_layer_index-1] += step

        return prev_grad, prev_bias

cgp = ComputationalGraphPrimerPlus(
    momentum=0.99,
    num_layers = 3,
    layers_config = [4,2,1],                         # num of nodes in each layer
    expressions = ['xw=ap*xp+aq*xq+ar*xr+as*xs',
                   'xz=bp*xp+bq*xq+br*xr+bs*xs',
                   'xo=cp*xw+cq*xz'],
    output_vars = ['xo'],
    dataset_size = 5000,
    learning_rate = 1e-3,
#    learning_rate = 5 * 1e-2,
    training_iterations = 40000,
    batch_size = 8,
    display_loss_how_often = 100,
    debug = True,
)

cgp.parse_multi_layer_expressions()
cgp.display_network2()
cgp.gen_training_data()

l1 = cgp.run_training_loop_multi_neuron_model(False)
l2 = cgp.run_training_loop_multi_neuron_model(True)

plt.figure()
plt.plot(l1)
plt.plot(l2)
plt.legend(['SGD Training Loss', 'SGD+ Training Loss'])
plt.title('SGD+ vs SGD Loss')
plt.savefig('multi_neuron_loss.jpg')
plt.show()
