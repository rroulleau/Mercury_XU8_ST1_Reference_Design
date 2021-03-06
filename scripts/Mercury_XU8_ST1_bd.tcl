# ----------------------------------------------------------------------------------
# Copyright (c) 2020 by Enclustra GmbH, Switzerland.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this hardware, software, firmware, and associated documentation files (the
# "Product"), to deal in the Product without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Product, and to permit persons to whom the
# Product is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Product.
#
# THE PRODUCT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# PRODUCT OR THE USE OR OTHER DEALINGS IN THE PRODUCT.
# ----------------------------------------------------------------------------------

create_bd_design $module


create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e
set_property -dict [ list \
  CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \
  CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
  CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
  CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
  CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {DPLL} \
  CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {DPLL} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {200} \
  CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {RPLL} \
  CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
  CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
  CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
  CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} \
  CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} \
  CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 10 .. 11} \
  CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 38 .. 39} \
  CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__ENET0__GRP_MDIO__ENABLE {1} \
  CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {0} \
  CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__FPGA_PL1_ENABLE {1} \
  CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {50} \
  CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU_MIO_12_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_23_PULLUPDOWN {disable} \
] [get_bd_cells zynq_ultra_ps_e]

create_bd_cell -type ip -vlnv xilinx.com:ip:system_management_wiz system_management_wiz
set_property -dict [ list \
  CONFIG.CHANNEL_ENABLE_VP_VN {false} \
] [get_bd_cells system_management_wiz]

if { $PS_DDR == "PS_D11E"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Enabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_DDR == "PS_D12E"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Enabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_1
  set_property -dict [ list \
    CONFIG.CLKOUT1_JITTER {144.572} \
    CONFIG.CLKOUT1_PHASE_ERROR {87.181} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {33.33} \
    CONFIG.CLKOUT2_JITTER {102.087} \
    CONFIG.CLKOUT2_PHASE_ERROR {87.181} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {200} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLKOUT3_JITTER {215.924} \
    CONFIG.CLKOUT3_PHASE_ERROR {235.769} \
    CONFIG.CLKOUT3_USED {false} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {12.000} \
    CONFIG.MMCM_CLKIN1_PERIOD {10.000} \
    CONFIG.MMCM_CLKIN2_PERIOD {10.000} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {36.000} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {6} \
    CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
    CONFIG.MMCM_DIVCLK_DIVIDE {1} \
    CONFIG.NUM_OUT_CLKS {2} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.USE_RESET {false} \
  ] [get_bd_cells clk_wiz_1]
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:vcu vcu_0
  set_property -dict [ list \
    CONFIG.ENABLE_ENCODER {true} \
    CONFIG.ENC_BUFFER_B_FRAME {0} \
    CONFIG.ENC_BUFFER_EN {true} \
    CONFIG.ENC_BUFFER_SIZE {760} \
    CONFIG.ENC_BUFFER_SIZE_ACTUAL {808} \
    CONFIG.ENC_BUFFER_TYPE {2} \
    CONFIG.ENC_CODING_TYPE {1} \
    CONFIG.ENC_FPS {1} \
    CONFIG.ENC_FRAME_SIZE {1} \
    CONFIG.ENC_MEM_URAM_USED {0} \
    CONFIG.NO_OF_STREAMS {7} \
    CONFIG.TABLE_NO {3} \
  ] [get_bd_cells vcu_0]
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0
  set_property -dict [ list \
    CONFIG.NUM_PORTS {1} \
  ] [get_bd_cells xlconcat_0]
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0
  set_property -dict [ list \
    CONFIG.DIN_FROM {0} \
    CONFIG.DIN_TO {0} \
    CONFIG.DIN_WIDTH {95} \
  ] [get_bd_cells xlslice_0]
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice axi_register_slice_0
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice axi_register_slice_1
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice axi_register_slice_2
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice axi_register_slice_3
}

if { $Video_Codec == "VCU"} {
  set_property -dict [ list \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__S_AXI_GP0 {1} \
    CONFIG.PSU__USE__S_AXI_GP2 {1} \
    CONFIG.PSU__USE__S_AXI_GP3 {1} \
    CONFIG.PSU__USE__S_AXI_GP4 {1} \
    CONFIG.PSU__USE__S_AXI_GP5 {1} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__GPIO_EMIO_WIDTH {95} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {95} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $Video_Codec == "VCU"} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_vcu
  set_property -dict [ list \
    CONFIG.NUM_SI {1} \
  ] [get_bd_cells smartconnect_vcu]
}

create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4 ddr4

create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_1
set_property -dict [ list \
  CONFIG.NUM_SI {1} \
] [get_bd_cells smartconnect_1]
set_property -dict [ list \
  CONFIG.PSU__USE__M_AXI_GP0 {1} \
] [get_bd_cells zynq_ultra_ps_e]

if { $PL_DDR == "PL_1_D11E"} {
  set_property -dict [ list \
    CONFIG.C0.DDR4_TimePeriod {833} \
    CONFIG.C0.DDR4_InputClockPeriod {9996} \
    CONFIG.C0.DDR4_MemoryPart {MT40A256M16GE-083E} \
    CONFIG.C0.DDR4_DataWidth {32} \
    CONFIG.C0.DDR4_CasLatency {17} \
    CONFIG.C0.DDR4_CasWriteLatency {12} \
  ] [get_bd_cells ddr4]
}

if { $PL_DDR == "PL_2_D12E"} {
  set_property -dict [ list \
    CONFIG.C0.DDR4_TimePeriod {833} \
    CONFIG.C0.DDR4_InputClockPeriod {9996} \
    CONFIG.C0.DDR4_MemoryPart {MT40A512M16HA-083E} \
    CONFIG.C0.DDR4_DataWidth {32} \
    CONFIG.C0.DDR4_CasLatency {17} \
    CONFIG.C0.DDR4_CasWriteLatency {12} \
  ] [get_bd_cells ddr4]
}
set_property -dict [ list \
  CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
  CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
  CONFIG.PSU__USB0__REF_CLK_FREQ {100} \
] [get_bd_cells zynq_ultra_ps_e]

create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0
set_property -dict [list CONFIG.NUM_SI {1}] [get_bd_cells smartconnect_0]
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM0_LPD] [get_bd_intf_pins smartconnect_0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins system_management_wiz/S_AXI_LITE]
connect_bd_net [get_bd_pins smartconnect_0/aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins system_management_wiz/s_axi_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ps_sys_rst
connect_bd_net [get_bd_pins ps_sys_rst/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins system_management_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins ps_sys_rst/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
connect_bd_net [get_bd_pins ps_sys_rst/interconnect_aresetn] [get_bd_pins smartconnect_0/aresetn]

if { $Video_Codec == "VCU"} {
  set_property -dict [list CONFIG.NUM_MI {2} CONFIG.NUM_SI {1} CONFIG.NUM_CLKS {2}] [get_bd_cells smartconnect_1]
  connect_bd_net [get_bd_pins smartconnect_1/aclk1] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
  connect_bd_intf_net [get_bd_intf_pins smartconnect_1/M01_AXI] [get_bd_intf_pins vcu_0/S_AXI_LITE]
  if {[catch {disconnect_bd_net /ddr4_c0_ddr4_ui_clk [get_bd_pins zynq_ultra_ps_e/maxihpm0_fpd_aclk]} errmsg]} { puts [string map {ERROR DEBUG} $errmsg] }
  connect_bd_net [get_bd_pins zynq_ultra_ps_e/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins vcu_0/vcu_resetn] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net zynq_ultra_ps_e_emio_gpio_o [get_bd_pins xlslice_0/Din] [get_bd_pins zynq_ultra_ps_e/emio_gpio_o]
  connect_bd_net [get_bd_pins vcu_0/pll_ref_clk] [get_bd_pins clk_wiz_1/clk_out1]
  connect_bd_net [get_bd_pins vcu_0/m_axi_mcu_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins vcu_0/m_axi_enc_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins vcu_0/m_axi_dec_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
  create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 vcu_sys_rst
  connect_bd_net [get_bd_pins vcu_sys_rst/slowest_sync_clk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins vcu_sys_rst/dcm_locked] [get_bd_pins clk_wiz_1/locked]
  connect_bd_net [get_bd_pins vcu_sys_rst/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
  connect_bd_net [get_bd_pins vcu_0/s_axi_lite_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_0/S_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC0]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_1/S_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC1]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_3/S_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC0]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_2/S_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC1]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP0_FPD]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_1/M_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP1_FPD]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_2/M_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP2_FPD]
  connect_bd_intf_net [get_bd_intf_pins axi_register_slice_3/M_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP3_FPD]
  connect_bd_net [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins vcu_sys_rst/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_register_slice_1/aresetn] [get_bd_pins vcu_sys_rst/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_register_slice_2/aresetn] [get_bd_pins vcu_sys_rst/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_register_slice_3/aresetn] [get_bd_pins vcu_sys_rst/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins axi_register_slice_1/aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins axi_register_slice_2/aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins axi_register_slice_3/aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins zynq_ultra_ps_e/saxihp0_fpd_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins zynq_ultra_ps_e/saxihp1_fpd_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins zynq_ultra_ps_e/saxihp2_fpd_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins zynq_ultra_ps_e/saxihp3_fpd_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins zynq_ultra_ps_e/saxihpc0_fpd_aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins vcu_0/vcu_host_interrupt] [get_bd_pins xlconcat_0/In0]
  connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins zynq_ultra_ps_e/pl_ps_irq0]
  connect_bd_intf_net [get_bd_intf_pins smartconnect_vcu/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HPC0_FPD]
  connect_bd_net [get_bd_pins smartconnect_vcu/aclk] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net [get_bd_pins smartconnect_vcu/aresetn] [get_bd_pins vcu_sys_rst/peripheral_aresetn]
  connect_bd_intf_net [get_bd_intf_pins smartconnect_vcu/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_MCU]
}
set_property generic BG_WIDTH=1 [current_fileset]
set C0_SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C0_SYS_CLK ]
connect_bd_intf_net [get_bd_intf_ports C0_SYS_CLK] [get_bd_intf_pins ddr4/C0_SYS_CLK]
set C0_DDR4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 C0_DDR4 ]
connect_bd_intf_net [get_bd_intf_ports C0_DDR4] [get_bd_intf_pins ddr4/C0_DDR4]
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ddr4_sys_rst
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM0_FPD] [get_bd_intf_pins smartconnect_1/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smartconnect_1/M00_AXI] [get_bd_intf_pins ddr4/C0_DDR4_S_AXI]
if {[catch { connect_bd_net [get_bd_pins zynq_ultra_ps_e/maxihpm0_fpd_aclk] [get_bd_pins ddr4/c0_ddr4_ui_clk] } errmsg]} { puts [string map {ERROR DEBUG} $errmsg] }
connect_bd_net [get_bd_pins ddr4_sys_rst/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
connect_bd_net [get_bd_pins ddr4/c0_ddr4_ui_clk] [get_bd_pins smartconnect_1/aclk]
connect_bd_net [get_bd_pins ddr4_sys_rst/slowest_sync_clk] [get_bd_pins ddr4/c0_ddr4_ui_clk]
connect_bd_net [get_bd_pins ddr4_sys_rst/peripheral_aresetn] [get_bd_pins ddr4/c0_ddr4_aresetn]
connect_bd_net [get_bd_pins ddr4_sys_rst/peripheral_reset] [get_bd_pins ddr4/sys_rst]
connect_bd_net [get_bd_pins smartconnect_1/aresetn] [get_bd_pins ddr4_sys_rst/interconnect_aresetn]

set DP_AUX_OUT [ create_bd_port -dir O DP_AUX_OUT]
connect_bd_net [get_bd_ports DP_AUX_OUT] [get_bd_pins zynq_ultra_ps_e/dp_aux_data_out]
set DP_AUX_OE [ create_bd_port -dir O DP_AUX_OE]
connect_bd_net [get_bd_ports DP_AUX_OE] [get_bd_pins zynq_ultra_ps_e/dp_aux_data_oe_n]
set DP_AUX_IN [ create_bd_port -dir I DP_AUX_IN]
connect_bd_net [get_bd_ports DP_AUX_IN] [get_bd_pins zynq_ultra_ps_e/dp_aux_data_in]
set DP_HPD [ create_bd_port -dir I DP_HPD]
connect_bd_net [get_bd_ports DP_HPD] [get_bd_pins zynq_ultra_ps_e/dp_hot_plug_detect]
set Clk100 [ create_bd_port -dir O -type clk Clk100]
connect_bd_net [get_bd_ports Clk100] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
set Clk50 [ create_bd_port -dir O -type clk Clk50]
connect_bd_net [get_bd_ports Clk50] [get_bd_pins zynq_ultra_ps_e/pl_clk1]
set Rst_N [ create_bd_port -dir O -type rst Rst_N]
connect_bd_net [get_bd_ports Rst_N] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
assign_bd_address
save_bd_design
validate_bd_design
save_bd_design
