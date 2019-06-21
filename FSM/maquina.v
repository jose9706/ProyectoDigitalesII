module maquina(
    input clk, 
    input reset, 
    input init,
    input [4:0]MfEntBajo,
    input [4:0]Vc0EntBajo,
    input [4:0]Vc1EntBajo,
    input [4:0]D0EntBajo,
    input [4:0]DA1EntBajo, 
    input [4:0]MfEntAlto,
    input [4:0]Vc0EntAlto,
    input [4:0]Vc1EntAlto,
    input [4:0]D0EntAlto,
    input [4:0]DA1EntAlto, 
    input [4:0]empties,
    /*input empty1,
    input empty2,
    input empty3,
    input empty4,
    input empty5,*/
    input [4:0]errors, 
    output reg error_out, 
    output reg active_out, 
    output reg idle_out, 
    input [4:0]MfEntBajo,
    output reg  [4:0]Vc0EntBajoSal,
    output reg  [4:0]Vc1EntBajoSal,
    output reg  [4:0]D0EntBajoSal,
    output reg  [4:0]DA1EntBajoSal,
    output reg  [4:0]MfEntAltoSal,
    output reg  [4:0]Vc0EntAltoSal,
    output reg  [4:0]Vc1EntAltoSal,
    output reg  [4:0]D0EntAltoSal,
    output reg  [4:0]DA1EntAltoSal,

); 


parameter RESET='b000; //0
parameter INIT='b001; //1
parameter IDLE='b010; //2
parameter ACTIVE='b011; //3
parameter ERROR ='b100; //4

reg [2:0] state; 
reg [2:0] next_state; 

always @(posedge clk) begin
			if (reset==0) begin 
			state <= RESET; 
			end else begin 
			state <= next_state;  
			end

            //if(state==INIT) begin 


end

always (*) begin 
    next_state=state;
    //Y si lo tiro fuera del always??? 
    error_out=0; 
    idle_out=0; 
    active_out=0; 


    /******/
    MfEntBajoSal[4:0]=0;
    Vc0EntBajoSal[4:0]=0;
    Vc1EntBajoSal[4:0]=0;
    D0EntBajoSal[4:0]=0;
    DA1EntBajoSal[4:0]=0;
    MfEntAltoSal[4:0]=0;
    Vc0EntAltoSal[4:0]=0;
    Vc1EntAltoSal[4:0]=0;
    D0EntAltoSal[4:0]=0;
    DA1EntAltoSal[4:0]=0;    

    /******/
    case(state)
    
    RESET: begin 
    MfEntBajoSal[4:0]=0;
    Vc0EntBajoSal[4:0]=0;
    Vc1EntBajoSal[4:0]=0;
    D0EntBajoSal[4:0]=0;
    DA1EntBajoSal[4:0]=0;
    MfEntAltoSal[4:0]=0;
    Vc0EntAltoSal[4:0]=0;
    Vc1EntAltoSal[4:0]=0;
    D0EntAltoSal[4:0]=0;
    DA1EntAltoSal[4:0]=0;
    if(reset==1)begin 
    next_state=INIT; 
    end else if(reset==1 && init==1) begin 
    next_state=INIT; 
    end 
    end 


    INIT: begin 
    //Asiga el valor de los estados 
    MfEntBajoSal[4:0]=MfEntBajo;
    Vc0EntBajoSal[4:0]=Vc0EntBajo;
    Vc1EntBajoSal[4:0]=Vc1EntBajo;
    D0EntBajoSal[4:0]=;D0EntBajo;
    DA1EntBajoSal[4:0]=DA1EntBajo;
    MfEntAltoSal[4:0]=;MfEntAlto;
    Vc0EntAltoSal[4:0]=Vc0EntAlto;
    Vc1EntAltoSal[4:0]=Vc1EntAlto;
    D0EntAltoSal[4:0]=;D0EntAlto;
    DA1EntAltoSal[4:0]=DA1EntAlto;
    if(init==0) begin 
    next_state=IDLE; 
    end else begin 
    next_state=INIT; 
    end 
    end 


    IDLE: begin 

    if(empties[4:0==1]) begin //si todos empties 
    idle_out=1;  //esta esperando 
    next_state=IDLE; 
    end else begin //nada más espera si no
    idle_out=0; 
    next_state=ACTIVE; 
    end 
    end 


    ACTIVE: begin 
    if(errors[4:0]==0)begin 
    next_state=ACTIVE;
    active_out=1;     
    end else if(errors[4:0]==1) begin 
    next_state=ERROR;
    active_out=0; 
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

    default: 
    next_state=RESET; 

end 




endmodule