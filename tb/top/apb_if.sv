interface apb_if(input logic PCLK);

    logic        PRESETn;
    logic        PSEL;
    logic        PENABLE;
    logic        PWRITE;

    logic [31:0] PADDR;
    logic [31:0] PWDATA;
    logic [31:0] PRDATA;

    logic        PREADY = 1'b0;
    logic        PSLVERR;

endinterface

