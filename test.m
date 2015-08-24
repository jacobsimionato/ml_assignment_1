
clear all; clc;

%file_path = 'libsvm-3.20/heart_scale';
file_path = 'data/mushrooms_data';


addpath(genpath('libsvm-3.20/matlab'))

% Load data
[y, x] = libsvmread(file_path);
c = 0.5;

% Run lib_svm
model = svmtrain(y, x, '-c 0.5 -t 0 -q');
[predict_label, accuracy_output, dec_values] = svmpredict(y, x, model); % test the training data
lib_svm_accuracy = accuracy_output(1);

% Run js_train
[w, b, E] = js_train(y, x, c);
[js_predict_label, js_accuracy, js_dec_values] = js_predict(y, x, w, b);

% Run js_train_dual
[w_d, b_d, E_d] = js_train_dual(y, x, c);
[js_dual_label, js_dual_accuracy, js_dec_values] = js_predict(y, x, w_d, b_d);


% Print results
fprintf('libsvm accuracy: %f\n', lib_svm_accuracy);
fprintf('js_svm accuracy: %f\n', js_accuracy);
fprintf('js_svm_dual accuracy: %f\n', js_dual_accuracy);

