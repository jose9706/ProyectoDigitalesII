module fsm (
    input clk, 
    input reset, 
    input init,
    input [4:0] main_fifo_low,
    input [4:0] main_fifo_high,
    input [4:0] Vco_low,
    input [4:0] Vco_high,
    input [4:0] Vc1_low, 
    input [4:0] Vc1_high,
    input [4:0] Do_low,
    input [4:0] Do_high,
    input [4:0] D1_low,
    input [4:0] D1_high, 
    input [4:0] empties,
    input [4:0]errors, 
    output reg error_out, 
    output reg active_out, 
    output reg idle_out, 
    output reg  [4:0] mf_l,
    output reg  [4:0] mf_h,
    output reg  [4:0] vco_l,
    output reg  [4:0] vco_h,
    output reg  [4:0] vc1_l,
    output reg  [4:0] vc1_h,
    output reg  [4:0] do_l,
    output reg  [4:0] do_h,
    output reg  [4:0] d1_l,
    output reg  [4:0] d1_h

); 


parameter SIZE = 5;
parameter RESET = 5'b00001; //1
parameter INIT = 5'b00010;  //2
parameter IDLE = 5'b00100;  //4
parameter ACTIVE = 5'b01000; //8
parameter ERROR = 5'b10000; //16

reg [SIZE-1:0]  state;
reg [SIZE-1:0]  next_state;
reg lol;


always @(posedge clk) begin
	if (~reset) begin 
		state <= RESET; 
        lol<=0;
	end else begin 
		state <= next_state;  
        if(state == RESET) begin
            {mf_l,mf_h,vco_l,vco_h,vc1_l,vc1_h,do_l,do_h,d1_l,d1_h} <= 0;

        end
        if(state == INIT) begin
            mf_l <= main_fifo_low;
            mf_h <= main_fifo_high;
            vco_l <= Vco_low;
            vco_h <= Vco_high;
            vc1_l <= Vc1_low;
            vc1_h <= Vc1_high;
            do_l <= Do_low;
            do_h <= Do_high;
            d1_l <= D1_low;
            d1_h <= D1_high;
        end
	end


end

always @(*) begin 
    next_state=state;
    error_out=0; 
    idle_out=0; 
    active_out=0; 

    case(state)
    
        RESET: begin 

            if(reset==1)begin 
                next_state=INIT; 
            end else if(reset==1 && init==1) begin 
                next_state=INIT; 
            end 
        end 


        INIT: begin 

            if(init==0) begin 
                next_state=IDLE; 
            end else begin 
                next_state=INIT; 
            end 
        end 


        IDLE: begin 
            if(empties==0) begin //si todos empties 
                idle_out=1;  //esta esperando 
                next_state=IDLE; 
            end else begin //nada más espera si no
                idle_out=0;     
                next_state=ACTIVE; 
                end 
            if(init)
                next_state=INIT;    
        end 


        ACTIVE: begin 
            if(errors[4:0]==0)begin 
                next_state=ACTIVE;
                active_out=1;     
            end else if(errors[4:0]>=1) begin 
                next_state=ERROR;
                active_out=0; 
                end 
            if (init) begin
                next_state=INIT;
            end    
        end 


        ERROR: begin  
            if(reset==0)begin 
                next_state=RESET;
                error_out=0; 
            end else begin 
                next_state=ERROR;
                error_out=1; 
                end 
        end 

        default: begin
            next_state=RESET; 

        end
        
    endcase   
end 




endmodule