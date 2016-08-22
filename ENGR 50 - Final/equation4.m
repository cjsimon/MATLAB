function didt = equation4(t, i)
    R = 10;
    C = .00008;
    L = 3;
    didt_1 = i(2);
    didt_2 = (-R*i(2)-(1/C)*i(1)+10)/L;
    didt = [ didt_1; didt_2];