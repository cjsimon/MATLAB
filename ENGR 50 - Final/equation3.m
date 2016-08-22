function [dvc, vs] = equation3(vs, vc)
    r = 48000;
    c = 2.4*(10^-6);
    dvc = (1 / (r*c)) * (vs - vc);