%{
    Integral function used to calculate the integrals of an equation for x
    integral(1) gives the first integral
    integral(2) gives the second integral
%}
function[integral] = integration(~, x)
    integral = [0;0];
    if x(2) <= 100;
        integral(1) = (784.48 - 0.2502 .* (x(1) .^ 2)) ./ 80;
    else
        integral(1) = (784.48 - 0.2502 .* (x(1) .^ 2) - 10 .* (x(2) - 100) - 1.5 .* x(1)) / 80;
    end
    integral(2) = x(1);
end