#!/bin/sh

TOP_LEVEL=$1
rm -rf xsim*
xvlog *.v
xvlog -sv *.sv
xelab $TOP_LEVEL -debug all  -timescale 1ns/1ps
xsim work.$TOP_LEVEL -g -protoinst axi_wrapper_protocol.proto
# xsim work.wrapper_tb -g -protoinst axi_wrapper_protocol.proto