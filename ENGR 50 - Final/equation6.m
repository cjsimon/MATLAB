function didt = equation6(t, i)
    R = 201;
    C = .0003;
    L = 3;
    didt2 = i(2);
    didt1 = (-R*i(2)-(1/C)*i(1)+10)/L;
    didt = [ didt2; didt1];