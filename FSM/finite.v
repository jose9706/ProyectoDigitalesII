module finite (
    input clk, 
    input reset, 
    input init,
    input UmbralMfs, 
    input UmbralVcs, 
    input Ds, 
    output reg error_out, 
    output reg active_out, 
    output reg idle_out 
); 



//En teoría debería usar one hot pero primero probemos
//así a ver como va a dar son 5 estados 

parameter RESET='b000; //0
parameter INIT='b001; //1
parameter IDLE='b010; //2
parameter ACTIVE='b011; //3
parameter ERROR ='b100; //4

reg [2:0] state; 
reg [2:0] nxt_state; 







endmodule 
