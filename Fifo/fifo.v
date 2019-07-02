`include "../Mem/mem.v"

module fifo(input clk,
            input RESET_L,
            input [5:0] data_in,
            input fifo_rd,
            input fifo_wr,
            input [4:0] al_empty_in,
            input [4:0] al_full_in,
            output reg fifo_empty,
            output reg fifo_full,
            output wire [5:0] data_out,
            output reg err_fifo,
            output reg pause,
            output wire valid_out);
    
    //Params.
    parameter FIFO_SIZE  = 8;
    parameter PTR_ADRESS = 3;
    //Regs.
    reg [PTR_ADRESS-1:0] wr_ptr;
    reg [PTR_ADRESS-1:0] rd_ptr;
    reg [FIFO_SIZE-1:0] counter;
    reg wr;
    reg rd;
    reg pause_reg;
    reg al_empty;
    reg al_full;
    //wires.
    wire err_mem;
    //mem de tamaño deseado para cada fifo.
    mem  #(.RAM_DEPTH(FIFO_SIZE), .ADDR_WIDTH(PTR_ADRESS))  SPACE (clk,
    rd_ptr,
    wr_ptr,
    data_in,
    wr,
    rd,
    valid_out,
    data_out,
    RESET_L,
    err_mem);
    
    always @(posedge clk) begin
        if (~RESET_L) begin
            wr_ptr    <= 0;
            counter   <= 0;
            rd_ptr    <= 0;
            pause_reg <= 0;
            end else begin
                pause_reg <= pause;
                if (fifo_wr && ~fifo_rd) begin
                    if (fifo_empty) begin
                        wr_ptr  <= 0;
                        counter <= counter + 1;
                    end
                    if (counter == FIFO_SIZE)begin
                     counter <= counter;
                    end else begin
                    if (wr_ptr == FIFO_SIZE-1) begin
                        wr_ptr  <= 0;
                        counter <= counter + 1;
                    end else begin
                           wr_ptr  <= wr_ptr + 1;
                           counter <= counter + 1;
                    end
                end
            end
            if (fifo_rd && ~fifo_wr) begin //read logic
                if (counter == 0) begin
                    counter <= counter;
                    end else begin
                    if (rd_ptr == FIFO_SIZE-1) begin
                        rd_ptr  <= 0;
                        // rd   <= 1;
                        counter <= counter - 1;
                    end else begin
                        rd_ptr  <= rd_ptr + 1;
                        counter <= counter - 1;
                        // rd   <= 1;
                    end
                end
            end
            if(fifo_rd && fifo_wr) begin
                if(wr_ptr == FIFO_SIZE-1) begin
                    wr_ptr <= 0;
                    counter <= counter;
                    rd_ptr <= rd_ptr+1;
                end else begin
                    if(rd_ptr == FIFO_SIZE -1) begin
                        rd_ptr <= 0;
                        wr_ptr<=wr_ptr+1;
                        counter <= counter;
                    end else begin
                        wr_ptr <= wr_ptr+1;
                        counter <= counter; 
                        rd_ptr <= rd_ptr+1;
                    end
                end  
            end
        end
    end
    
    always @(*) begin
        pause      = pause_reg;
        fifo_empty = 1;
        fifo_full  = 0;
        al_empty   = 0;
        al_full    = 0;
        wr         = 0;
        rd         = 0;
        err_fifo   = 0;
        if (counter > 0) begin
            fifo_empty = 0;
            if (counter >= al_full_in[4:0]) begin
                al_full       = 1;
                pause         = 1;
                if (counter >= FIFO_SIZE) fifo_full = 1;
            end
                if (counter <= al_empty_in)begin
                    al_empty = 1;
                    pause    = 0;
                end
        end
        if(fifo_wr & fifo_rd) begin
            wr = 1; 
            rd = 1; 
        end else begin
            if (fifo_wr) begin
                if (fifo_full) begin
                    err_fifo = 1;
                    wr       = 0;
                end else begin
                    wr = 1;
                end
            end
            if (fifo_rd) begin
                if (fifo_empty) err_fifo = 1;
                else begin 
                    rd   = 1;
                    if(counter-1 == 0) begin
                        fifo_empty = 1;
                    end
                end

            end
        end

    end
    
    
    
endmodule
    
