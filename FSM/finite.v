module finite (
    input clk, 
    input reset, 
    input init,
    //input UmbralMfs, 
    //input UmbralVcs, 
    //input UmbralDs, 
    input errorIn, 
    input emptiesIn, 
    output reg error_out, 
    output reg active_out, 
    output reg idle_out, //primero el umbral MFS
    input [2:0]umbralEnt1, //el de Mfs1  
    output reg [2:0]umbralSal1 //el de Mfs1
    input [2:0]umbralEnt2, //el de Vcs1  
    output reg [2:0]umbralSal2 //el de Vcs1 
    input [2:0]umbralEnt3, //el de Ds1  
    output reg [2:0]umbralSal3 //el de Ds1
); 



//En teoría debería usar one hot pero primero probemos
//así a ver como va a dar son 5 estados 

parameter RESET='b000; //0
parameter INIT='b001; //1
parameter IDLE='b010; //2
parameter ACTIVE='b011; //3
parameter ERROR ='b100; //4

reg [2:0] state; 
reg [2:0] next_state; 

//reg next_error; 
//reg next_active; 
reg next_idle=0; 

always @(posedge clk) begin
			if (reset==0) begin 
			state <= RES; 
			//error_out <= 0;
            idle_out<=0; 
            //active_out<=0; 
			//vamo a ver 

			end else begin 
			state <= next_state; 
			
            //error_out<=next_error; //este tambien ya que quiero que me indique los errores  
			idle_out<=next_idle; 
            //active_out<=next_active;  
			end
end

//hasta aqui ya defini todas las señales con 
//posibles teporales 

//reg[3:0] temporal= 'h0; //variable temporal que llevo para las secuencias
//El de arriba es el valor inmediato pero ocupo un valor anterior 
//tengo que flopear un temporal para tener el valor anterior de temporal 
//reg [3:0] next_temp='h0;

always @(*) begin

        //flopear a idle con idle_out  
		next_state=state; 
        next_idle=idle_out;
        //next_temp=temporal;
        error_out=0; 
        //idle_out=0; 
        active_out=0; 
        //umbralEnt1=0; 
        umbralSal1=0; 
        //definir los estados con valores iniciales        
        case(state)
        RESET: begin 
        if(reset==1 ) begin 
        next_state=RESET;     
        end else if(reset==1 && init==1) begin 
        next_state=INIT;    
        end 
        end

        INIT: begin  //ES SUPER IMPORTANTE
        if(init==1)begin 
        next_state=IDLE;
        umbralSal1=umbralEnt1;


        next_state=IDLE;   
        end else begin 
        next_state=RESET; 
        end
        end

        IDLE: begin 
        if(/*CONDICION*/)begin 



        end 
        end 

        ACTIVE: begin 
        if(/*CONDICION*/) begin 
        
        
        
        end 
        end


        ERROR: begin 
        if(/*CONDICION*/) begin 
        /******************/

        end 
        end


        default: 
			next_state=RES;
        endcase 
end






endmodule 
