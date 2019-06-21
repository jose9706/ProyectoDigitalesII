module pro(output reg clk,
            output reg RESET_L,
            output reg [2:0] address_write,
            output reg [2:0] address_read,
            output reg [5:0] data,
            output reg write, 
            output reg read);


    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
        {data,write,address_write,address_read,RESET_L, read} <= 0;
        @(posedge clk);
        RESET_L <= 1;
        repeat(1) begin
            write<=1;
            data<='h1;
            address_write<=0;
            @(posedge clk);
            data<='h2;
            address_write<=1;
            @(posedge clk);
            data<='h3;
            address_write<=2;
            @(posedge clk);
            data<='h4;
            address_write<=3;
            @(posedge clk);
            data<='h5;
            address_write<=4;
            @(posedge clk);
            data<='h6;
            address_write<=5;
            @(posedge clk);
            data<='h7;
            address_write<=6;
            @(posedge clk);
            data<='h8;
            address_write<=7;
            @(posedge clk);
            write<=0;
            @(posedge clk);
            
            read<=1;
            address_read<=0;
            @(posedge clk);
            address_read<=1;
            @(posedge clk);
            address_read<=2;
            @(posedge clk);
            address_read<=3;
            @(posedge clk);
            address_read<=4;
            @(posedge clk);
            address_read<=5;
            @(posedge clk);
            address_read<=6;
            @(posedge clk);
            address_read<=7;
            @(posedge clk);
            read <= 0;
            @(posedge clk);
            read<=1;
            write<=1;
            address_write <= 1;
            address_read <= 2;
            data<= 'hC;
            @(posedge clk);
            address_write <= 5;
            address_read<=1;
            data<='hB;
            @(posedge clk);
            write <= 0;
            address_read <= 5;
            @(posedge clk);
            write <= 1;
            address_read <= 1;
            address_write <=1 ;
            @(posedge clk);
            @(posedge clk);


        end
       
        $finish;

    end


    initial clk <=0;
    always #2 clk <= ~clk;

endmodule
