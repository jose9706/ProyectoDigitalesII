module control_fsm (input clk,
                    input reset_L,
                    input init,
                    input U_mf,
                    input U_VC,
                    input U_D,
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


always @(*) begin
    next_state=state;
    error_out=0;
    active_out=0;
    idle_out=0;
    case (state)
        RESET:begin
            if (!reset_L)begin
                //senales internas 0;
                U_mf=0;
                U_D=0;
                U_VC=0;
                next_state=INIT;
            end
        end
        INIT: begin
            if (init) begin
                
            end
        end 
        IDLE: begin
            if(FIFO_empty) begin
                idle_out=1;
            end
        end
        ACTIVE: begin
            if(!FIFO_empty) begin
                active_out=1;
            end
        end
        ERROR: begin
            if(!read && write && FIFO_full) begin
                error_out=1;
            end
        end

    endcase    
end


endmodule