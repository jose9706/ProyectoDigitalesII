module pro(output reg clk,
            output reg RESET_L,
            output reg [2:0] address,
            output reg [5:0] data,
            output reg write, 
            output reg read);


    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
        {data,write,address,RESET_L, read} <= 0;
        @(posedge clk);
        RESET_L <= 1;
        repeat(1) begin
            write<=1;
            data<='h1;
            address<=0;
            @(posedge clk);
            data<='h2;
            address<=1;
            @(posedge clk);
            data<='h3;
            address<=2;
            @(posedge clk);
            data<='h4;
            address<=3;
            @(posedge clk);
            data<='h5;
            address<=4;
            @(posedge clk);
            data<='h6;
            address<=5;
            @(posedge clk);
            data<='h7;
            address<=6;
            @(posedge clk);
            data<='h8;
            address<=7;
            @(posedge clk);
            @(posedge clk);
            write<=0;
            read<=1;
            address<=0;
            @(posedge clk);
            address<=1;
            @(posedge clk);
            address<=2;
            @(posedge clk);
            address<=3;
            @(posedge clk);
            address<=4;
            @(posedge clk);
            address<=5;
            @(posedge clk);
            address<=6;
            @(posedge clk);
            address<=7;
            @(posedge clk);
            @(posedge clk);

        end
        @(posedge clk);
        read<=1;
        write<=1;
        @(posedge clk);
        @(posedge clk);


        $finish;

    end


    initial clk <=0;
    always #2 clk <= ~clk;

endmodule
