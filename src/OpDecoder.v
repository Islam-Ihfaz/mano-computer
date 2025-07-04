module OpDecoder(ir0, ir1, q1, q2, q3);
  input ir0, ir1;
  output q1, q2, q3;
  wire q1 = ir0 & !ir1,
       q2 = ir1 & !ir0,
       q3 = ir0 & ir1;
endmodule
