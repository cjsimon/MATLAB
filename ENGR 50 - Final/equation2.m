function [dvc, vs] = equation2(t, vc)
    r = 48000;
    c = 2.4*(10^-6);
    vs = 5 * exp(-t/0.08) * sin(20 * pi * t);
    dvc = (1 / (r*c)) * (vs - vc);