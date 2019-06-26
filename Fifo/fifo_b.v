`include "mem.v"

module fifo(input clk,
            input RESET_L,
            input [5:0] data_in,
            input fifo_rd,
            input fifo_wr,
            output reg fifo_empty,
            output reg fifo_full,
            output wire [5:0] data_out,
            output reg err_full);
    
    //Params.
    parameter FIFO_SIZE = 8;
    
    //Regs.
    reg [FIFO_SIZE-1:0] wr_ptr;
    reg [FIFO_SIZE-1:0] rd_ptr;
    wire ok;
    wire nada;

    reg err;
    reg wr;
    reg rd;
    reg [5:0] inner_data;
    reg [FIFO_SIZE-1:0] counter;
    //wires.
    wire [5:0] data2write;
    
    //mem de tamaño deseado para cada fifo.
    mem  #(.RAM_DEPTH(FIFO_SIZE))  lul (clk,
    rd_ptr,
    wr_ptr,
    data_in,
    wr,
    rd,
    ok,
    data_out,
    RESET_L,
    nada);
    
    
    //write logic:
    
    always @(posedge clk) begin
        if (~RESET_L) begin
            wr_ptr  <= 0;
            counter <= 0;
            err     <= 0;
            wr<=0;
            rd<=0;
            end else begin
            if (fifo_wr) begin
                if (fifo_empty) begin
                    wr_ptr  <= 0;
                    wr      <= 1;
                    counter <= counter + 1;
                end
                if (wr_ptr == FIFO_SIZE) begin
                    wr_ptr <= 0;
                    counter <= counter + 1; 
                    end else begin
                    if (fifo_full) begin
                        err_full <= 1;
                        end else begin
                        wr_ptr <= wr_ptr + 1;
                        wr     <= 1;
                        counter <= counter + 1;
                    end
                end
                
            end
        end
    end
    
    always @(*) begin
        fifo_empty    = 1;
        fifo_full     = 0;
        if (counter >= 0) fifo_empty = 0;
        if (counter == FIFO_SIZE) fifo_full = 1;
    end
    
    //read logic:

    always @(posedge clk ) begin
        if(~RESET_L) begin
            rd_ptr <= 0;
        end else begin
            if (fifo_rd) begin
                if(fifo_empty) begin
                    err_full <=1;
                end else begin
                    if(rd_ptr == FIFO_SIZE) begin
                        rd_ptr <= 0; 
                        rd <= 1;
                        counter <= counter - 1; 
                    end else begin
                        rd_ptr <= rd_ptr + 1;
                        counter <= counter - 1;
                        rd <= 1;
                    end
                    
                end
            end
        end

    end

    
    
    
endmodule
    

