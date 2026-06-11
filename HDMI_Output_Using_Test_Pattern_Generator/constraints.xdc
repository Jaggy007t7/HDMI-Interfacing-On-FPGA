
# 125 MHz onboard FPGA clock
set_property PACKAGE_PIN H16 [get_ports sys_clock]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clock]

create_clock -period 8.000 -name sys_clk [get_ports sys_clock]


## HDMI TX
set_property -dict {PACKAGE_PIN L17 IOSTANDARD TMDS_33} [get_ports {TMDS_Clk_n_0}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD TMDS_33} [get_ports {TMDS_Clk_p_0}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n_0[0]}]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p_0[0]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n_0[1]}]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p_0[1]}]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_n_0[2]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD TMDS_33} [get_ports {TMDS_Data_p_0[2]}]
#set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports {hdmi_out_hpd[0]}]
