set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk]


set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports {grant[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {grant[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {grant[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {grant[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {req[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {req[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {req[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {req[0]}]

set_property PACKAGE_PIN V17 [get_ports rst]
set_property PACKAGE_PIN V16 [get_ports {req[3]}]
set_property PACKAGE_PIN W16 [get_ports {req[2]}]
set_property PACKAGE_PIN W17 [get_ports {req[1]}]
set_property PACKAGE_PIN W15 [get_ports {req[0]}]
set_property PACKAGE_PIN U16 [get_ports {grant[3]}]
set_property PACKAGE_PIN E19 [get_ports {grant[2]}]
set_property PACKAGE_PIN V19 [get_ports {grant[0]}]
set_property PACKAGE_PIN U19 [get_ports {grant[1]}]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

