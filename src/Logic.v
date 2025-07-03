module Logic(q1, q2, q3, t0, t1, t2, t3, t4, t5, t6, t7, x1, x2, x3, x4, x5, x6, x7,
x8);
input q1, q2, q3, t0, t1, t2, t3, t4, t5, t6, t7;
output x1, x2, x3, x4, x5, x6, x7, x8;
wire #100 x1 = t0 | (q2 & t3) | (q3 & t3),
x2 = q3 & t5,
x3 = t1 | (q2 & t4) | (q3 & t4),
x4 = t1 | (q2 & t4) | (q3 & t4) | (q3 & t6),
x5 = (q2 & t5) | (q3 & t7),
x6 = q1 & t3,
x7 = (q2 & t5) | (q3 & t7) | (q1 & t3),
x8 = t2;
endmodule
