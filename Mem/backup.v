
module mem (
clk         , // Clock Input
address     , // Address Input
data        , // Data bi-directional
we          , // Write Enable/Read Enable
oe            // Output Enable
); 

parameter DATA_WIDTH = 6 ;
parameter ADDR_WIDTH = 8 ;
parameter RAM_DEPTH = 8 << ADDR_WIDTH;

//--------------Input Ports----------------------- 
input                  clk         ;
input [ADDR_WIDTH-1:0] address     ;
input                  we          ;
input                  oe          ; 

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0]  data       ;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg                  oe_r;


always @ (posedge clk)
begin : MEM_WRITE
   if ( we ) begin
       mem[address] = data;
   end
end

always @ (posedge clk)
begin : MEM_READ
  if ( !we && oe) begin
    data_out = mem[address];
    oe_r = 1;
  end else begin
    oe_r = 0;
    data_out = 0;
  end
end

endmodule // End of Module ram_sp_sr_sw
