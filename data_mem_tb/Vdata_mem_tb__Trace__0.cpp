// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals

#include "verilated_vcd_c.h"
#include "Vdata_mem_tb__Syms.h"


void Vdata_mem_tb___024root__trace_chg_0_sub_0(Vdata_mem_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vdata_mem_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root__trace_chg_0\n"); );
    // Body
    Vdata_mem_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdata_mem_tb___024root*>(voidSelf);
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vdata_mem_tb___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vdata_mem_tb___024root__trace_chg_0_sub_0(Vdata_mem_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root__trace_chg_0_sub_0\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 0);
    bufp->chgBit(oldp+0,(vlSelfRef.data_mem_tb__DOT__clk));
    bufp->chgBit(oldp+1,(vlSelfRef.data_mem_tb__DOT__mem_read));
    bufp->chgBit(oldp+2,(vlSelfRef.data_mem_tb__DOT__mem_write));
    bufp->chgCData(oldp+3,(vlSelfRef.data_mem_tb__DOT__address),8);
    bufp->chgSData(oldp+4,((vlSelfRef.data_mem_tb__DOT__dut__DOT__data_memory
                            [vlSelfRef.data_mem_tb__DOT__address] 
                            & (- (IData)((IData)(vlSelfRef.data_mem_tb__DOT__mem_read))))),16);
    bufp->chgSData(oldp+5,(vlSelfRef.data_mem_tb__DOT__write),16);
}

void Vdata_mem_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root__trace_cleanup\n"); );
    // Locals
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = 0;
    }
    // Body
    Vdata_mem_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vdata_mem_tb___024root*>(voidSelf);
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    __Vm_traceActivity[0U] = 0U;
}
