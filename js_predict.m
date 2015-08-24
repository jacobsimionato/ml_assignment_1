function [predict_label, accuracy, dec_values] = js_predict(label, features, w, b)
    %label
    %features
    %model
    dec_values = features * w + b;
    predict_label = dec_values >= 0;
    predict_label = predict_label * 2;
    predict_label = predict_label - 1;
      
    numSuccess = sum(predict_label == label);
    numCases = size(label, 1);
    accuracy = (numSuccess / numCases) * 100;