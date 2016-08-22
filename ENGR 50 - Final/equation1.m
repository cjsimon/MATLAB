function [dvc, vs] = equation1(t, vc)
    r = 48000;
    c = 2.4*(10^-6);
    vs = 5 * sin(20 * pi * t);
    dvc = (1 / (r*c)) * (vs - vc);