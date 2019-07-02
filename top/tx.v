`include "../Fifo/fifo.v"
`include "../FSM/fsm.v"

module tx(input clk,
          input RESET_L,
          input PUSH_MAIN,
          input init,
          input POP_D0,
          input POP_D1,
          input [5:0] DATA_IN_TX,
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
          output wire [5:0] DATA_OUT_D0,
          output wire [5:0] DATA_OUT_D1
);
    //REGS usados.
    reg [4:0] fifo_empties;
    reg [4:0] fifo_errors;
    reg [5:0] data_to_VC0;
    reg [5:0] data_to_VC1;
    reg POP_MAIN;
    reg POP_VC0;
    reg PUSH_VC0;
    reg POP_VC1;
    reg PUSH_VC1;
    reg [5:0] data_from_VC0;
    reg [5:0] data_from_VC1;
    reg PUSH_D0;
    reg PUSH_D1;
    reg [5:0] data_to_D1;
    reg [5:0] data_to_D0;
    //wires de interconexion.
   /*AUTOWIRE*/
    wire MAIN_EMPTY;
    wire MAIN_FULL;
    wire MAIN_ERROR;
    wire MAIN_AL_EMPTY;
    wire MAIN_AL_FULL;
    wire [5:0] DATA_OUT_MAIN;
    wire [5:0] DATA_OUT_VC0;
    wire [5:0] DATA_OUT_VC1;
    wire [4:0] MAIN_LOW;
    wire [4:0] MAIN_HIGH;
    wire [4:0] VC0_LOW;
    wire [4:0] VC0_HIGH;
    wire [4:0] VC1_LOW;
    wire [4:0] VC1_HIGH;
    wire [4:0] D0_LOW;
    wire [4:0] D0_HIGH;
    wire [4:0] D1_LOW;
    wire [4:0] D1_HIGH;
    wire FSM_ERROR_OUT;
    wire FSM_ACTIVE_OUT;
    wire FSM_IDLE_OUT;

    /*initial begin
        POP_MAIN = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        POP_MAIN = 1;

    end*/
    //JUNTAR ERRORES DE TODOS LOS FIFOS PARA LA FSM
    //JUNTAR EMPTIES DE TODOS LOS FIFOS PARA FSM.
    always @(posedge clk ) begin
        if(~RESET_L) begin
            POP_MAIN <= 0;
            POP_VC0 <= 0;    
            POP_VC1 <= 0;
        end
        else begin
        if(~MAIN_EMPTY & ~(VC0_PAUSE | VC1_PAUSE)) POP_MAIN <= 1;
        else POP_MAIN<= 0;
        if(~(D0_PAUSE | D1_PAUSE)) begin
            if(~(VC0_EMPTY & VC1_EMPTY)) begin
                POP_VC0 <= 1;
                POP_VC1 <= 1;           
            end else begin
                POP_VC0 <= 0;
                POP_VC1 <= 0;
            end
            if(~VC0_EMPTY) begin
                POP_VC0 <= 1;
            end else begin
                POP_VC0 <= 0;
            end
            if(~VC1_EMPTY) begin
                POP_VC1 <= 1;
            end else begin
                POP_VC1 <= 0;
            end
       end        
        end
    end
    always @(*) begin
        fifo_empties[0] = MAIN_EMPTY;
        fifo_empties[1] = VC0_EMPTY;
        fifo_empties[2] = VC1_EMPTY;
        fifo_empties[3] = D0_EMPTY;
        fifo_empties[4] = D1_EMPTY;

        fifo_errors[0] = MAIN_ERROR;
        fifo_errors[1] = VC0_ERR;
        fifo_errors[2] = VC1_ERR;
        fifo_errors[3] = D0_ERR;
        fifo_errors[4] = D1_ERR;

        data_to_VC0 = 0;
        data_to_VC1 = 0;
        //POP_MAIN = 0;
        PUSH_VC0 = 0;
        PUSH_VC1 = 0;
         //if( ~MAIN_EMPTY) begin
           // POP_MAIN = 1;
        //end
        if(MAIN_VALID) begin
            if(DATA_OUT_MAIN[5] == 0) begin
                data_to_VC0 = DATA_OUT_MAIN;
                PUSH_VC0 = 1;
            end 
            if(DATA_OUT_MAIN[5] == 1) begin
                data_to_VC1 = DATA_OUT_MAIN;
                PUSH_VC1 = 1;
            end
        end
        
    end

    
  

    //DEMUX Y MUX HACIA DEST.
    always @(*) begin
        data_from_VC0 = DATA_OUT_VC0;
        data_from_VC1 = DATA_OUT_VC1;
        PUSH_D0 = 0;
        PUSH_D1 = 0;
        data_to_D0 = 0;
        data_to_D1 = 0;
        if(VC0_VALID & VC1_VALID) begin
            if(data_from_VC0[4] == 0) begin
                data_to_D0 = data_from_VC0;
                PUSH_D0 = 1;
            end
            if(data_from_VC0[4] == 1) begin
                data_to_D1 = data_from_VC0;
                PUSH_D1 = 1;
            end
        end
        if(VC0_VALID) begin
            if(data_from_VC0[4] == 0) begin
                data_to_D0 = data_from_VC0;
                PUSH_D0 = 1;
            end
            if(data_from_VC0[4] == 1) begin
                data_to_D1 = data_from_VC0;
                PUSH_D1 = 1;
            end
        end
        if(VC1_VALID) begin
            if(data_from_VC0[4] == 0) begin
                data_to_D0 = data_from_VC1;
                PUSH_D0 = 1;
            end
            if(data_from_VC0[4] == 1) begin
                data_to_D1 = data_from_VC1;
                PUSH_D1 = 1;
            end
        end
    end


    //FSM.
    fsm CONTROL_MACHINE (clk,
                         RESET_L,
                         init,
                         main_fifo_low,
                         main_fifo_high,
                         Vco_low,
                         Vco_high,
                         Vc1_low,
                         Vc1_high,
                         Do_low,
                         Do_high,
                         D1_low,
                         D1_high,
                         fifo_empties,
                         fifo_errors,
                         FSM_ERROR_OUT,
                         FSM_ACTIVE_OUT,
                         FSM_IDLE_OUT,
                         MAIN_LOW,
                         MAIN_HIGH,
                         VC0_LOW,
                         VC0_HIGH,
                         VC1_LOW,
                         VC1_HIGH,
                         D0_LOW,
                         D0_HIGH,
                         D1_LOW,
                         D1_HIGH);

    //FIFOS a utilizar.
    fifo  #(.FIFO_SIZE(4), .PTR_ADRESS(2)) MAIN (clk,
                                                  RESET_L,
                                                  DATA_IN_TX,
                                                  POP_MAIN,
                                                  PUSH_MAIN,
                                                  MAIN_LOW,
                                                  MAIN_HIGH,
                                                  MAIN_EMPTY,
                                                  MAIN_FULL,
                                                  DATA_OUT_MAIN,
                                                  MAIN_ERROR,
                                                  MAIN_PAUSE,
                                                  MAIN_VALID); 
    fifo #(.FIFO_SIZE(16), .PTR_ADRESS(4)) VC0 (clk,
                                                RESET_L,
                                                data_to_VC0,
                                                POP_VC0,
                                                PUSH_VC0,
                                                VC0_LOW,
                                                VC0_HIGH,
                                                VC0_EMPTY,
                                                VC0_FULL,
                                                DATA_OUT_VC0,
                                                VC0_ERR,
                                                VC0_PAUSE,
                                                VC0_VALID); 
    fifo #(.FIFO_SIZE(16), .PTR_ADRESS(4)) VC1 (clk,
                                                RESET_L,
                                                data_to_VC1,
                                                POP_VC1,
                                                PUSH_VC1,
                                                VC1_LOW,
                                                VC1_HIGH,
                                                VC1_EMPTY,
                                                VC1_FULL,
                                                DATA_OUT_VC1,
                                                VC1_ERR,
                                                VC1_PAUSE,
                                                VC1_VALID);
    fifo #(.FIFO_SIZE(4), .PTR_ADRESS(2)) D0 (clk,
                                              RESET_L,
                                              data_to_D0,
                                              POP_D0,
                                              PUSH_D0,
                                              D0_LOW,
                                              D0_HIGH,
                                              D0_EMPTY,
                                              D0_FULL,
                                              DATA_OUT_D0,
                                              D0_ERR,
                                              D0_PAUSE,
                                              D0_VALID); 
    fifo #(.FIFO_SIZE(4), .PTR_ADRESS(2)) D1 (clk,
                                              RESET_L,
                                              data_to_D1,
                                              POP_D1,
                                              PUSH_D1,
                                              D1_LOW,
                                              D1_HIGH,
                                              D1_EMPTY,
                                              D1_FULL,
                                              DATA_OUT_D1,
                                              D1_ERR,
                                              D1_PAUSE,
                                              D1_VALID); 


endmodule // tx -Transmisor que incluye la interconexion de los modulos
