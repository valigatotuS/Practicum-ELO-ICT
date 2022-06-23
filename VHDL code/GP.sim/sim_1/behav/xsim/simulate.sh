#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Jun 23 17:46:16 CEST 2022
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim Matrix_Controler_TB_behav -key {Behavioral:sim_1:Functional:Matrix_Controler_TB} -tclbatch Matrix_Controler_TB.tcl -log simulate.log"
xsim Matrix_Controler_TB_behav -key {Behavioral:sim_1:Functional:Matrix_Controler_TB} -tclbatch Matrix_Controler_TB.tcl -log simulate.log

