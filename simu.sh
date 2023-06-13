#!/bin/sh


xvlog -sv *.sv
xvlog *.v
xelab wrapper_tb -debug all  -timescale 1ns/1ps
 xsim wrapper_tb -g -snapshot work.wrapper_tb
# xsim -snapshot work.wrapper_tb
# -protoinst axi_wrapper_protocol.proto
