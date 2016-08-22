function didt = equation5(t, i)
    R = 200;
    C = .0012;
    L = 3;
    didt_3 = i(2);
    didt_4 = (-R*i(2)-(1/C)*i(1)+10)/L;
    didt = [ didt_3; didt_4];
    