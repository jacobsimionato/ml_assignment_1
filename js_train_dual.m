function [w, b, E] = js_train_dual(label, features, C)
    y = label;
    x = features;
    
    % n is the number of points, and l is the number of features
    [n, l] = size(features);
    
    % Used to determine the set of support vectors S from alpha
    zeroThresh = 0.0001;

    H = diag(y) * x * x' * diag(y);

    cvx_begin;
        variable A(n);

        A >= 0;
        A <= C
        sum(y .* A) == 0;

        maximize(sum(A) -  0.5 * A' * H * A);
    cvx_end;
    
    
    w = ((A .* y)' * x)';
    
    % Indicates the set of support vectors
    S = A > 0;
    
    % 
    b = sum((y .* S - sum(x * (diag(S .* A .* y) * x)', 2))) / sum(S);
    
    E = -1;