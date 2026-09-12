// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdata_mem_tb.h for the primary calling header

#include "Vdata_mem_tb__pch.h"

void Vdata_mem_tb___024root___ctor_var_reset(Vdata_mem_tb___024root* vlSelf);

Vdata_mem_tb___024root::Vdata_mem_tb___024root(Vdata_mem_tb__Syms* symsp, const char* namep)
    : __VdlySched{*symsp->_vm_contextp__}
 {
    vlSymsp = symsp;
    vlNamep = strdup(namep);
    // Reset structure values
    Vdata_mem_tb___024root___ctor_var_reset(this);
}

void Vdata_mem_tb___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vdata_mem_tb___024root::~Vdata_mem_tb___024root() {
    VL_DO_DANGLING(std::free(const_cast<char*>(vlNamep)), vlNamep);
}
