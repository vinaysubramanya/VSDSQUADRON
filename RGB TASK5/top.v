module top (
  output wire rgb1_red,
  output wire rgb1_green,
  output wire rgb1_blue,
  output wire rgb2_red,
  output wire rgb2_green,
  output wire rgb2_blue,
  input wire uart_rx
);

  wire int_clk;
  reg [7:0] rx_data;
  reg rx_data_ready;
  reg receiving;
  reg [3:0] bit_cnt;
  reg [15:0] clk_cnt;
  reg [7:0] rx_shift_reg;
  reg uartrx_sync_0, uartrx_sync_1;

  // Internal oscillator
  SB_HFOSC #(.CLKHF_DIV("0b10")) u_SB_HFOSC (
    .CLKHFPU(1'b1),
    .CLKHFEN(1'b1),
    .CLKHF(int_clk)
  );

  // Sync uart_rx to int_clk domain
  always @(posedge int_clk) begin
    uartrx_sync_0 <= uart_rx;
    uartrx_sync_1 <= uartrx_sync_0;
  end

  wire rx_falling_edge = (uartrx_sync_1 == 1'b1) && (uartrx_sync_0 == 1'b0);

  localparam CLK_FREQ = 12000000;
  localparam BAUD = 115200;

  // UART RX state machine to receive one byte
  always @(posedge int_clk) begin
    if (receiving) begin
      if (clk_cnt == 0) begin
        clk_cnt <= CLK_FREQ/BAUD - 1;
        bit_cnt <= bit_cnt + 1;

        if (bit_cnt == 0) begin
          // start bit, ignore
        end else if (bit_cnt <= 8) begin
          rx_shift_reg <= {uartrx_sync_1, rx_shift_reg[7:1]};
        end else begin
          receiving <= 0;
          rx_data <= rx_shift_reg;
          rx_data_ready <= 1;
        end
      end else begin
        clk_cnt <= clk_cnt - 1;
      end
    end else begin
      rx_data_ready <= 0;
      if (rx_falling_edge) begin
        receiving <= 1;
        clk_cnt <= CLK_FREQ/(BAUD*2); // half bit delay
        bit_cnt <= 0;
      end
    end
  end

  reg rgb_red, rgb_green, rgb_blue;
  reg rgb2_red_r, rgb2_green_r, rgb2_blue_r;

  // LED logic based on uart rx
  always @(posedge int_clk) begin
    if (rx_data_ready) begin
      if (rx_data == "r") begin
        // rgb1 red, rgb2 red
        rgb_red    <= 0;  
        rgb_green  <= 1;
        rgb_blue   <= 1;
        rgb2_red_r   <= 0;
        rgb2_green_r <= 1;
        rgb2_blue_r  <= 1;
      end else if (rx_data == "g") begin
        // rgb1 green, rgb2 green
        rgb_red    <= 1;
        rgb_green  <= 0;
        rgb_blue   <= 1;
        rgb2_red_r   <= 1;
        rgb2_green_r <= 0;
        rgb2_blue_r  <= 1;
      end else if (rx_data == "b") begin
        // rgb1 blue, rgb2 blue
        rgb_red    <= 1;
        rgb_green  <= 1;
        rgb_blue   <= 0;
        rgb2_red_r   <= 1;
        rgb2_green_r <= 1;
        rgb2_blue_r  <= 0;
      end
    end
  end

  assign rgb1_red   = gb_red;
  assign rgb1_green = rgb_green;
  assign rgb1_blue  = rgb_blue;

  assign rgb2_red   = rgb2_red_r;
  assign rgb2_green = rgb2_green_r;
  assign rgb2_blue  = rgb2_blue_r;

endmodule
