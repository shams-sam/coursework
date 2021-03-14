#!/usr/bin/env python

##  one_neuron_classifier_sgd_plus.py

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

    def run_training_loop_one_neuron_model(self, momentum):
        training_data = self.training_data
        self.vals_for_learnable_params = {param: random.uniform(0,1) for param in self.learnable_params}
        self.bias = random.uniform(0,1)

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
        prev_bias = 0
        for i in range(self.training_iterations):
            data = data_loader.getbatch()
            data_tuples = data[0]
            class_labels = data[1]
            y_preds, deriv_sigmoids =  self.forward_prop_one_neuron_model(data_tuples)
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
            deriv_sigmoid_avg = sum(deriv_sigmoids) / float(len(class_labels))
            data_tuple_avg = [sum(x) for x in zip(*data_tuples)]
            data_tuple_avg = list(map(operator.truediv, data_tuple_avg, 
                                     [float(len(class_labels))] * len(class_labels) ))
            if not momentum:
                self.backprop_and_update_params_one_neuron_model(y_error_avg, data_tuple_avg, deriv_sigmoid_avg)
            else:
                prev_grad, prev_bias = self.backprop_and_update_params_one_neuron_model_plus(
                    y_error_avg, data_tuple_avg, deriv_sigmoid_avg, prev_grad, prev_bias)

        return loss_running_record
        
    def backprop_and_update_params_one_neuron_model_plus(self, y_error, vals_for_input_vars, deriv_sigmoid, prev_grad, prev_bias):
        input_vars = self.independent_vars
        vals_for_input_vars_dict =  dict(zip(input_vars, list(vals_for_input_vars)))
        vals_for_learnable_params = self.vals_for_learnable_params
        for i,param in enumerate(self.vals_for_learnable_params):
            gradient = y_error * vals_for_input_vars_dict[input_vars[i]] * deriv_sigmoid
            step = self.momentum*prev_grad[param] + self.learning_rate*gradient
            prev_grad[param] = step
            self.vals_for_learnable_params[param] += step

        gradient = y_error * deriv_sigmoid
        step = self.momentum*prev_bias + self.learning_rate*gradient
        prev_bias = step
        self.bias += step

        return prev_grad, prev_bias

cgp = ComputationalGraphPrimerPlus(
    momentum=0.99,
    one_neuron_model = True,
    expressions = ['xw=ab*xa+bc*xb+cd*xc+ac*xd'],
    output_vars = ['xw'],
    dataset_size = 5000,
    learning_rate = 1e-3,
    # learning_rate = 5 * 1e-2,
    training_iterations = 40000,
    batch_size = 8,
    display_loss_how_often = 100,
    debug = True,
)


cgp.parse_expressions()
cgp.display_network2()
cgp.gen_training_data()

l1= cgp.run_training_loop_one_neuron_model(False)
l2 = cgp.run_training_loop_one_neuron_model(True)

plt.figure()
plt.plot(l1)
plt.plot(l2)
plt.legend(['SGD Training Loss', 'SGD+ Training Loss'])
plt.title('SGD+ vs SGD Loss')
plt.savefig('one_neuron_loss.jpg')
plt.show()
