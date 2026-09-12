// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vdata_mem_tb.h for the primary calling header

#ifndef VERILATED_VDATA_MEM_TB___024ROOT_H_
#define VERILATED_VDATA_MEM_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vdata_mem_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vdata_mem_tb___024root final {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ data_mem_tb__DOT__clk;
    CData/*0:0*/ data_mem_tb__DOT__mem_read;
    CData/*0:0*/ data_mem_tb__DOT__mem_write;
    CData/*7:0*/ data_mem_tb__DOT__address;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VstlPhaseResult;
    CData/*0:0*/ __Vtrigprevexpr___TOP__data_mem_tb__DOT__clk__0;
    CData/*0:0*/ __VactPhaseResult;
    CData/*0:0*/ __VinactPhaseResult;
    CData/*0:0*/ __VnbaPhaseResult;
    SData/*15:0*/ data_mem_tb__DOT__write;
    SData/*15:0*/ data_mem_tb__DOT__dut__DOT__read;
    IData/*31:0*/ __VactIterCount;
    IData/*31:0*/ __VinactIterCount;
    IData/*31:0*/ __Vi;
    VlUnpacked<SData/*15:0*/, 256> data_mem_tb__DOT__data_memory;
    VlUnpacked<SData/*15:0*/, 256> data_mem_tb__DOT__dut__DOT__data_memory;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggeredAcc;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_h0663bfc7__0;

    // INTERNAL VARIABLES
    Vdata_mem_tb__Syms* vlSymsp;
    const char* vlNamep;

    // CONSTRUCTORS
    Vdata_mem_tb___024root(Vdata_mem_tb__Syms* symsp, const char* namep);
    ~Vdata_mem_tb___024root();
    VL_UNCOPYABLE(Vdata_mem_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
