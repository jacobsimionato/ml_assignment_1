function [printResult] = js_runDataSet(file_path)
    [y, x] = libsvmread(file_path);
    
    c = 0.5;

    % Run lib_svm
    model = svmtrain(y, x, '-c 0.5 -t 0 -q');
    [predict_label, accuracy_output, dec_values] = svmpredict(y, x, model); % test the training data
    w_l = model.SVs' * model.sv_coef;
    b_l = -model.rho;

    lib_svm_accuracy = accuracy_output(1);

    % Run js_train
    [w_p, b_p, optval_p] = js_train(y, x, c);
    [js_predict_label, js_accuracy, js_dec_values] = js_predict(y, x, w_p, b_p);

    % Run js_train_dual
    [w_d, b_d, optval_d] = js_train_dual(y, x, c);
    [js_dual_label, js_dual_accuracy, js_dec_values] = js_predict(y, x, w_d, b_d);

    % Overall statistics
    duality_gap = abs(optval_p - optval_d)

    % Print results
    w_p
    w_d
    w_l
    b_p
    b_d
    b_l
    
    l1 = sprintf('===== Results for %s =====\n', file_path);
    l2 = sprintf('libsvm accuracy: %f\n', lib_svm_accuracy);
    l3 = sprintf('js_svm accuracy: %f\n', js_accuracy);
    l4 = sprintf('js_svm_dual accuracy: %f\n', js_dual_accuracy);
    l5 = sprintf('duality_gap: %f\n', duality_gap);
    l6 = sprintf('\n');

    printResult = sprintf('%s \n', [l1, l2, l3, l4, l5, l6]);