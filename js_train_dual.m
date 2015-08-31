function [w, b, optval] = js_train_dual(label, features, C)
    y = label;
    x = features;
    
    % n is the number of points, and l is the number of features
    [n, l] = size(x);
    
    % Used to determine the set of support vectors S from alpha
    zeroThresh = 0;

    H = diag(y) * x * x' * diag(y);

    cvx_begin;
        variable A(n);

        A >= 0;
        A <= C
        sum(y .* A) == 0;

        maximize(sum(A) -  0.5 .* A' * H * A);
    cvx_end;
    
    % Calculate w
    w = ((A .* y)' * x)';
    
    % Contains 1 for indices that are a support vector, and 0 for ones that
    % aren't
    S = A > zeroThresh;
    
    % Calculate b
    b = sum((y .* S - sum(x * (diag(S .* A .* y) * x)', 2))) / sum(S);
    
    % Calculate epsilon
    %epsilon = (y .* (x * w + b) - ones(l)') .* S;
    
    %optval_dual = (0.5 * w'*w + C * sum(epsilon))
    
    optval = cvx_optval