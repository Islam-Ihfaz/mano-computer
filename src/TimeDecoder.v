module TimeDecoder(t, t0, t1, t2, t3, t4, t5, t6, t7);
output t0, t1, t2, t3, t4, t5, t6, t7;
input wire [2:0] t;
assign
t0 = ~t[2] & ~t[1] & ~t[0],
t1 = ~t[2] & ~t[1] & t[0],
t2 = ~t[2] & t[1] & ~t[0],
t3 = ~t[2] & t[1] & t[0],
t4 = t[2] & ~t[1] & ~t[0],
t5 = t[2] & ~t[1] & t[0],
t6 = t[2] & t[1] & ~t[0],
t7 = t[2] & t[1] & t[0];
endmodule
