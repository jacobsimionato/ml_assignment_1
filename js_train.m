function [w, b, E] = js_train(label, features, C)
    y = label;
    x = features;
    
    % n is the number of points, and l is the number of features
    [n, l] = size(features);
    n
    l
        
    cvx_begin
%         variable w(l)
%         variable E(n)
%         variable b(n)
%         E >= 0;
%         diag(y) * (x * w + b) -1 + E >= 0;
%         minimize(0.5 * w' * w + C * sum(E))

        
    variables w(l) E(n) b
    
    y .* (x * w + b) - 1 + E >= 0;
    E >= 0;
    
    minimize(0.5 * w'*w + C*sum(E)) %norm(w) almost works except it takes an extra sqrt

    cvx_end
        
    