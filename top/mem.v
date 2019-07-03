
module mem (
clk,
address_read,
address_write,
data,
write,
read,
valid_out,
data_out,
RESET_L,
err
); 

//Params.
parameter DATA_WIDTH = 6;
parameter ADDR_WIDTH = 3;
parameter RAM_DEPTH = 8;

//I/O
input clk;
input [ADDR_WIDTH-1:0] address_read;
input [ADDR_WIDTH-1:0] address_write;
input write;
input read;
input [DATA_WIDTH-1:0] data;
input RESET_L;
output reg [DATA_WIDTH-1:0] data_out;
output reg valid_out;
output reg err;
//Vars
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
integer i; 

//----Code----
always @ (posedge clk or negedge RESET_L) begin
    if(~RESET_L) begin
        for(i=0; i<RAM_DEPTH ; i = i + 1) begin
            mem[i] <= 'h0;
        end
        data_out <= 0;
        valid_out <= 0;
        err <= 0;
    end 
    else begin
        if(write && ~read) begin
            mem[address_write] <= data;
            valid_out <= 0;
            err <= 0;
        end
        if(read && ~write) begin
            data_out <= mem[address_read];
            valid_out <= 1;
            err <= 0;
        end
        if(write && read) begin
            if(address_read != address_write) begin
                data_out <= mem[address_read];
                mem[address_write] <= data;
                valid_out<=1;
                err<=0;
            end else begin
                valid_out<=0;
                data_out<=0;
                err<=1;
            end
        end
        if(~write && ~read) begin
            err<=0;
            valid_out<=0;
            data_out <= 0;
        end
    end


end


endmodule