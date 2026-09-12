// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdata_mem_tb.h for the primary calling header

#include "Vdata_mem_tb__pch.h"


Vdata_mem_tb___024unit::Vdata_mem_tb___024unit() = default;
Vdata_mem_tb___024unit::~Vdata_mem_tb___024unit() = default;

void Vdata_mem_tb___024unit::ctor(Vdata_mem_tb__Syms* symsp, const char* namep) {
    vlSymsp = symsp;
    vlNamep = strdup(Verilated::catName(vlSymsp->name(), namep));
    // Reset structure values
}

void Vdata_mem_tb___024unit::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

void Vdata_mem_tb___024unit::dtor() {
    VL_DO_DANGLING(std::free(const_cast<char*>(vlNamep)), vlNamep);
}
