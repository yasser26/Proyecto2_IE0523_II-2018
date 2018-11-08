/* Generated by Yosys 0.7+574 (git sha1 0fad1570, gcc 6.3.0-18+deb9u1 -fPIC -Os) */

(* top =  1  *)
(* src = "fsm_Control.v:3" *)
module fsmControlEstructural(clk, reset_L, init, umbral_VCFC, FIFO_error, FIFO_empty, umbrales_VCFC, active, idle, error);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  (* src = "fsm_Control.v:8" *)
  input FIFO_empty;
  (* src = "fsm_Control.v:7" *)
  input FIFO_error;
  (* src = "fsm_Control.v:10" *)
  output active;
  (* src = "fsm_Control.v:3" *)
  input clk;
  (* src = "fsm_Control.v:12" *)
  output error;
  (* src = "fsm_Control.v:11" *)
  output idle;
  (* src = "fsm_Control.v:5" *)
  input init;
  (* src = "fsm_Control.v:4" *)
  input reset_L;
  (* onehot = 32'd1 *)
  wire [4:0] state;
  (* src = "fsm_Control.v:6" *)
  input [7:0] umbral_VCFC;
  (* src = "fsm_Control.v:9" *)
  output [7:0] umbrales_VCFC;
  NOT _31_ (
    .A(state[2]),
    .Y(_03_)
  );
  NOT _32_ (
    .A(FIFO_error),
    .Y(_04_)
  );
  NOT _33_ (
    .A(init),
    .Y(_05_)
  );
  NOT _34_ (
    .A(umbral_VCFC[0]),
    .Y(_06_)
  );
  NOT _35_ (
    .A(umbral_VCFC[1]),
    .Y(_07_)
  );
  NOT _36_ (
    .A(umbral_VCFC[2]),
    .Y(_08_)
  );
  NOT _37_ (
    .A(umbral_VCFC[3]),
    .Y(_09_)
  );
  NOT _38_ (
    .A(umbral_VCFC[4]),
    .Y(_10_)
  );
  NOT _39_ (
    .A(umbral_VCFC[5]),
    .Y(_11_)
  );
  NOT _40_ (
    .A(umbral_VCFC[6]),
    .Y(_12_)
  );
  NOT _41_ (
    .A(umbral_VCFC[7]),
    .Y(_13_)
  );
  NOT _42_ (
    .A(reset_L),
    .Y(_14_)
  );
  NAND _43_ (
    .A(_05_),
    .B(state[0]),
    .Y(_15_)
  );
  NOR _44_ (
    .A(state[1]),
    .B(_14_),
    .Y(_16_)
  );
  NAND _45_ (
    .A(_15_),
    .B(_16_),
    .Y(_00_)
  );
  NOR _46_ (
    .A(FIFO_error),
    .B(_14_),
    .Y(_17_)
  );
  NAND _47_ (
    .A(_04_),
    .B(reset_L),
    .Y(_18_)
  );
  NAND _48_ (
    .A(FIFO_empty),
    .B(state[3]),
    .Y(_19_)
  );
  NOT _49_ (
    .A(_19_),
    .Y(_20_)
  );
  NOR _50_ (
    .A(state[4]),
    .B(_20_),
    .Y(_21_)
  );
  NOR _51_ (
    .A(_18_),
    .B(_21_),
    .Y(_01_)
  );
  NOR _52_ (
    .A(state[2]),
    .B(state[3]),
    .Y(_22_)
  );
  NOT _53_ (
    .A(_22_),
    .Y(_23_)
  );
  NAND _54_ (
    .A(_03_),
    .B(FIFO_empty),
    .Y(_24_)
  );
  NAND _55_ (
    .A(_17_),
    .B(_24_),
    .Y(_26_)
  );
  NOR _56_ (
    .A(_22_),
    .B(_26_),
    .Y(_02_)
  );
  NOR _57_ (
    .A(FIFO_error),
    .B(_19_),
    .Y(idle)
  );
  NOR _58_ (
    .A(_03_),
    .B(FIFO_error),
    .Y(active)
  );
  NOR _59_ (
    .A(state[4]),
    .B(_23_),
    .Y(_28_)
  );
  NOR _60_ (
    .A(_06_),
    .B(_28_),
    .Y(umbrales_VCFC[0])
  );
  NOR _61_ (
    .A(_07_),
    .B(_28_),
    .Y(umbrales_VCFC[1])
  );
  NOR _62_ (
    .A(_08_),
    .B(_28_),
    .Y(umbrales_VCFC[2])
  );
  NOR _63_ (
    .A(_09_),
    .B(_28_),
    .Y(umbrales_VCFC[3])
  );
  NOR _64_ (
    .A(_10_),
    .B(_28_),
    .Y(umbrales_VCFC[4])
  );
  NOR _65_ (
    .A(_11_),
    .B(_28_),
    .Y(umbrales_VCFC[5])
  );
  NOR _66_ (
    .A(_12_),
    .B(_28_),
    .Y(umbrales_VCFC[6])
  );
  NOR _67_ (
    .A(_13_),
    .B(_28_),
    .Y(umbrales_VCFC[7])
  );
  NAND _68_ (
    .A(FIFO_error),
    .B(reset_L),
    .Y(_29_)
  );
  NOR _69_ (
    .A(_28_),
    .B(_29_),
    .Y(_25_)
  );
  NAND _70_ (
    .A(init),
    .B(state[0]),
    .Y(_30_)
  );
  NOR _71_ (
    .A(_14_),
    .B(_30_),
    .Y(_27_)
  );
  DFF _72_ (
    .C(clk),
    .D(_00_),
    .Q(state[0])
  );
  DFF _73_ (
    .C(clk),
    .D(_25_),
    .Q(state[1])
  );
  DFF _74_ (
    .C(clk),
    .D(_02_),
    .Q(state[2])
  );
  DFF _75_ (
    .C(clk),
    .D(_01_),
    .Q(state[3])
  );
  DFF _76_ (
    .C(clk),
    .D(_27_),
    .Q(state[4])
  );
  assign error = state[1];
endmodule
