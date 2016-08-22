function quadratic(matrix)
    if size(matrix) ~= 3
       fprintf('Error! You must enter a vector of three numbers.\n');
       return;
    end
    
    a = matrix(1);
    b = matrix(2);
    c = matrix(3);

    x1 = ((-b + sqrt( (b^2) - (4*a*c) )) / (2*a));
    x2 = ((-b - sqrt( (b^2) - (4*a*c) )) / (2*a));

    fprintf('Roots: x_1=%1.2f and x_2=%1.2f\n', x1, x2);