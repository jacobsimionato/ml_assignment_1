clear all; clc;

addpath(genpath('libsvm-3.20/matlab'))

resultHeart = js_runDataSet('data/heart_scale');
resultDiabetes = js_runDataSet('data/diabetes_scale');
resultAustralian = js_runDataSet('data/australian_scale');

sprintf('%s \n', [resultHeart, resultDiabetes, resultAustralian])
