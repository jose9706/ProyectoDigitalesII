module control_fsm (input clk,
                    input reset_L,
                    input init,
                    input [4:0] in_almost_full,
                    input [4:0] in_almost_empty,
                    input [4:0] FIFO_empty,
                    input [4:0] FIFO_error,
                    output reg [4:0] out_almost_full,
                    output reg [4:0] out_almost_empty,
                    output reg error_out,
                    output reg active_out,
                    output reg idle_out);

parameter SIZE = 5;
parameter RESET = 5'b00001;
parameter INIT = 5'b00010;
parameter IDLE = 5'b00100;
parameter ACTIVE = 5'b01000;
parameter ERROR = 5'b10000;

reg [SIZE-1:0]  state;
reg [SIZE-1:0]  next_state;
reg modify_umb;
reg comodin;

always @(posedge clk) begin
    if (!reset_L) begin
        modify_umb<=0;
        state<=RESET;
    end
    else
        state <= next_state;
        if(state==RESET) begin
            out_almost_empty<='b0;
            out_almost_full<='b0;    
        end
        if(state==INIT) begin
            in_almost_empty<=out_almost_empty;
            in_almost_full<=out_almost_full;        
        end
end


always @(*) begin
    next_state=state;
    error_out=0;
    active_out=0;
    idle_out=0;
    case (state)
        RESET:begin
                next_state=INIT;
        end
        INIT: begin   
            out_almost_empty=in_almost_empty;
            out_almost_full=in_almost_full;        
            if(!init) begin
                next_state=IDLE;
            end
            else 
                next_state=INIT;
        end 
        IDLE: begin
            idle_out=1;
            if(&FIFO_empty)begin
                idle_out=0;
                next_state=ACTIVE;
            end
            if (init)
                next_state=INIT;    
        end
        ACTIVE: begin
            active_out=1;
            if (init)
                active_out=0;
                next_state=INIT;
            if (&FIFO_error)
                active_out=0;
                next_state=ERROR;    
        end
        ERROR: begin
            if(&FIFO_error) begin
                error_out=1;
            end
            if(!reset_L)
                next_state=RESET;
        end

        default: begin
            next_state=RESET; 

        end

    endcase    
end


endmodule