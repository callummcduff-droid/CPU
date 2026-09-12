// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vdata_mem_tb.h for the primary calling header

#ifndef VERILATED_VDATA_MEM_TB___024UNIT_H_
#define VERILATED_VDATA_MEM_TB___024UNIT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vdata_mem_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vdata_mem_tb___024unit final {
  public:

    // INTERNAL VARIABLES
    Vdata_mem_tb__Syms* vlSymsp;
    const char* vlNamep;

    // CONSTRUCTORS
    Vdata_mem_tb___024unit();
    ~Vdata_mem_tb___024unit();
    void ctor(Vdata_mem_tb__Syms* symsp, const char* namep);
    void dtor();
    VL_UNCOPYABLE(Vdata_mem_tb___024unit);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
