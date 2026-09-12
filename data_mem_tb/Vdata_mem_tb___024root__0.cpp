// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vdata_mem_tb.h for the primary calling header

#include "Vdata_mem_tb__pch.h"

VlCoroutine Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__0(Vdata_mem_tb___024root* vlSelf);
VlCoroutine Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__1(Vdata_mem_tb___024root* vlSelf);

void Vdata_mem_tb___024root___eval_initial(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_initial\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    {
        // Inlined CFunc: _eval_initial__TOP
        vlSymsp->_vm_contextp__->dumpfile("waves/data_mem_tb.vcd"s);
        vlSymsp->_traceDumpOpen();
    }
    Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__0(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.data_mem_tb__DOT__clk = 0U;
    while (true) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "tb/data_mem_tb.sv", 
                                             29);
        vlSelfRef.data_mem_tb__DOT__clk = (1U & (~ (IData)(vlSelfRef.data_mem_tb__DOT__clk)));
    }
    co_return;
}

void Vdata_mem_tb___024root____VbeforeTrig_h0663bfc7__0(Vdata_mem_tb___024root* vlSelf, const char* __VeventDescription);

VlCoroutine Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__1(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.data_mem_tb__DOT__mem_read = 0U;
    vlSelfRef.data_mem_tb__DOT__mem_write = 1U;
    vlSelfRef.data_mem_tb__DOT__address = 0U;
    vlSelfRef.data_mem_tb__DOT__write = 1U;
    Vdata_mem_tb___024root____VbeforeTrig_h0663bfc7__0(vlSelf, 
                                                       "@(posedge data_mem_tb.clk)");
    co_await vlSelfRef.__VtrigSched_h0663bfc7__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge data_mem_tb.clk)", 
                                                         "tb/data_mem_tb.sv", 
                                                         41);
    co_await vlSelfRef.__VdlySched.delay(1ULL, nullptr, 
                                         "tb/data_mem_tb.sv", 
                                         42);
    vlSelfRef.data_mem_tb__DOT__mem_read = 1U;
    vlSelfRef.data_mem_tb__DOT__mem_write = 0U;
    if (vlSymsp->_vm_contextp__->assertCtlGet(VerilatedAssertCtlQuery::ASSERT_CTL_ON, 2, 1)) {
        if (vlSymsp->_vm_contextp__->assertCtlGet(VerilatedAssertCtlQuery::ASSERT_CTL_FAIL_ON, 2, 1)) {
            if (VL_UNLIKELY(((vlSelfRef.data_mem_tb__DOT__data_memory
                              [vlSelfRef.data_mem_tb__DOT__address] 
                              != (IData)(vlSelfRef.data_mem_tb__DOT__write))))) {
                VL_WRITEF_NX("[%0t] %%Error: data_mem_tb.sv:44: Assertion failed in %m: Writing to memory failed\n",3, 'M',vlSymsp->name(),"data_mem_tb", 'T',-12
                             , '#',64,VL_TIME_UNITED_Q(1));
                VL_STOP_MT("tb/data_mem_tb.sv", 44, "");
            }
        }
    }
    Vdata_mem_tb___024root____VbeforeTrig_h0663bfc7__0(vlSelf, 
                                                       "@(posedge data_mem_tb.clk)");
    co_await vlSelfRef.__VtrigSched_h0663bfc7__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge data_mem_tb.clk)", 
                                                         "tb/data_mem_tb.sv", 
                                                         50);
    co_await vlSelfRef.__VdlySched.delay(1ULL, nullptr, 
                                         "tb/data_mem_tb.sv", 
                                         51);
    if (vlSymsp->_vm_contextp__->assertCtlGet(VerilatedAssertCtlQuery::ASSERT_CTL_ON, 2, 1)) {
        if (vlSymsp->_vm_contextp__->assertCtlGet(VerilatedAssertCtlQuery::ASSERT_CTL_FAIL_ON, 2, 1)) {
            if (VL_UNLIKELY((((IData)(vlSelfRef.data_mem_tb__DOT__dut__DOT__read) 
                              != vlSelfRef.data_mem_tb__DOT__data_memory
                              [vlSelfRef.data_mem_tb__DOT__address])))) {
                VL_WRITEF_NX("[%0t] %%Error: data_mem_tb.sv:53: Assertion failed in %m: Reading from memory failed\n",3, 'M',vlSymsp->name(),"data_mem_tb", 'T',-12
                             , '#',64,VL_TIME_UNITED_Q(1));
                VL_STOP_MT("tb/data_mem_tb.sv", 53, "");
            }
        }
    }
    VL_WRITEF_NX("Data memory testbench has finished.\n",0);
    VL_FINISH_MT("tb/data_mem_tb.sv", 56, "");
    co_return;
}

bool Vdata_mem_tb___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___trigger_anySet__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        if (in[n]) {
            return (1U);
        }
        n = ((IData)(1U) + n);
    } while ((1U > n));
    return (0U);
}

void Vdata_mem_tb___024root___timing_ready(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___timing_ready\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VtrigSched_h0663bfc7__0.ready("@(posedge data_mem_tb.clk)");
    }
}

void Vdata_mem_tb___024root___timing_resume(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___timing_resume\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VtrigSched_h0663bfc7__0.moveToResumeQueue(
                                                          "@(posedge data_mem_tb.clk)");
    vlSelfRef.__VtrigSched_h0663bfc7__0.resume("@(posedge data_mem_tb.clk)");
    if ((2ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vdata_mem_tb___024root___trigger_orInto__act_vec_vec(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___trigger_orInto__act_vec_vec\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((0U >= n));
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vdata_mem_tb___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

bool Vdata_mem_tb___024root___eval_phase__act(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_phase__act\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    {
        // Inlined CFunc: _eval_triggers_vec__act
        vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                        ((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                          << 1U) 
                                                         | ((IData)(vlSelfRef.data_mem_tb__DOT__clk) 
                                                            & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__data_mem_tb__DOT__clk__0))))));
        vlSelfRef.__Vtrigprevexpr___TOP__data_mem_tb__DOT__clk__0 
            = vlSelfRef.data_mem_tb__DOT__clk;
    }
    Vdata_mem_tb___024root___timing_ready(vlSelf);
    Vdata_mem_tb___024root___trigger_orInto__act_vec_vec(vlSelfRef.__VactTriggered, vlSelfRef.__VactTriggeredAcc);
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vdata_mem_tb___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
    Vdata_mem_tb___024root___trigger_orInto__act_vec_vec(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vdata_mem_tb___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        vlSelfRef.__VactTriggeredAcc.fill(0ULL);
        Vdata_mem_tb___024root___timing_resume(vlSelf);
        {
            // Inlined CFunc: _eval_act
            if ((3ULL & vlSelfRef.__VactTriggered[0U])) {
                {
                    // Inlined CFunc: _act_comb__TOP__0
                    vlSelfRef.data_mem_tb__DOT__dut__DOT__read 
                        = (vlSelfRef.data_mem_tb__DOT__dut__DOT__data_memory
                           [vlSelfRef.data_mem_tb__DOT__address] 
                           & (- (IData)((IData)(vlSelfRef.data_mem_tb__DOT__mem_read))));
                }
            }
        }
    }
    return (__VactExecute);
}

bool Vdata_mem_tb___024root___eval_phase__inact(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_phase__inact\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VinactExecute;
    // Body
    __VinactExecute = vlSelfRef.__VdlySched.awaitingZeroDelay();
    if (__VinactExecute) {
        VL_FATAL_MT("tb/data_mem_tb.sv", 3, "", "ZERODLY: Design Verilated with '--no-sched-zero-delay', but #0 delay executed at runtime");
    }
    return (__VinactExecute);
}

void Vdata_mem_tb___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vdata_mem_tb___024root___eval_phase__nba(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_phase__nba\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vdata_mem_tb___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        {
            // Inlined CFunc: _eval_nba
            if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
                {
                    // Inlined CFunc: _nba_sequent__TOP__0
                    SData/*15:0*/ __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyVal__data_mem_tb__DOT__dut__DOT__data_memory__v0;
                    __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyVal__data_mem_tb__DOT__dut__DOT__data_memory__v0 = 0;
                    CData/*7:0*/ __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyDim0__data_mem_tb__DOT__dut__DOT__data_memory__v0;
                    __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyDim0__data_mem_tb__DOT__dut__DOT__data_memory__v0 = 0;
                    CData/*0:0*/ __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlySet__data_mem_tb__DOT__dut__DOT__data_memory__v0;
                    __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlySet__data_mem_tb__DOT__dut__DOT__data_memory__v0 = 0;
                    __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlySet__data_mem_tb__DOT__dut__DOT__data_memory__v0 = 0U;
                    if (vlSelfRef.data_mem_tb__DOT__mem_write) {
                        __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyVal__data_mem_tb__DOT__dut__DOT__data_memory__v0 
                            = vlSelfRef.data_mem_tb__DOT__write;
                        __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyDim0__data_mem_tb__DOT__dut__DOT__data_memory__v0 
                            = vlSelfRef.data_mem_tb__DOT__address;
                        __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlySet__data_mem_tb__DOT__dut__DOT__data_memory__v0 = 1U;
                    }
                    if (__Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlySet__data_mem_tb__DOT__dut__DOT__data_memory__v0) {
                        vlSelfRef.data_mem_tb__DOT__dut__DOT__data_memory[__Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyDim0__data_mem_tb__DOT__dut__DOT__data_memory__v0] 
                            = __Vinline_0__eval_nba___Vinline_0__nba_sequent__TOP__0___VdlyVal__data_mem_tb__DOT__dut__DOT__data_memory__v0;
                    }
                }
            }
            if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
                {
                    // Inlined CFunc: _act_comb__TOP__0
                    vlSelfRef.data_mem_tb__DOT__dut__DOT__read 
                        = (vlSelfRef.data_mem_tb__DOT__dut__DOT__data_memory
                           [vlSelfRef.data_mem_tb__DOT__address] 
                           & (- (IData)((IData)(vlSelfRef.data_mem_tb__DOT__mem_read))));
                }
            }
        }
        Vdata_mem_tb___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vdata_mem_tb___024root___eval(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00002710U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vdata_mem_tb___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("tb/data_mem_tb.sv", 3, "", "DIDNOTCONVERGE: NBA region did not converge after '--converge-limit' of 10000 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VinactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00002710U < vlSelfRef.__VinactIterCount)))) {
                VL_FATAL_MT("tb/data_mem_tb.sv", 3, "", "DIDNOTCONVERGE: Inactive region did not converge after '--converge-limit' of 10000 tries");
            }
            vlSelfRef.__VinactIterCount = ((IData)(1U) 
                                           + vlSelfRef.__VinactIterCount);
            vlSelfRef.__VactIterCount = 0U;
            do {
                if (VL_UNLIKELY(((0x00002710U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                    Vdata_mem_tb___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                    VL_FATAL_MT("tb/data_mem_tb.sv", 3, "", "DIDNOTCONVERGE: Active region did not converge after '--converge-limit' of 10000 tries");
                }
                vlSelfRef.__VactIterCount = ((IData)(1U) 
                                             + vlSelfRef.__VactIterCount);
                vlSelfRef.__VactPhaseResult = Vdata_mem_tb___024root___eval_phase__act(vlSelf);
            } while (vlSelfRef.__VactPhaseResult);
            vlSelfRef.__VinactPhaseResult = Vdata_mem_tb___024root___eval_phase__inact(vlSelf);
        } while (vlSelfRef.__VinactPhaseResult);
        vlSelfRef.__VnbaPhaseResult = Vdata_mem_tb___024root___eval_phase__nba(vlSelf);
    } while (vlSelfRef.__VnbaPhaseResult);
}

void Vdata_mem_tb___024root____VbeforeTrig_h0663bfc7__0(Vdata_mem_tb___024root* vlSelf, const char* __VeventDescription) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root____VbeforeTrig_h0663bfc7__0\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    VlUnpacked<QData/*63:0*/, 1> __VTmp;
    // Body
    __VTmp[0U] = (QData)((IData)(((IData)(vlSelfRef.data_mem_tb__DOT__clk) 
                                  & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__data_mem_tb__DOT__clk__0)))));
    vlSelfRef.__Vtrigprevexpr___TOP__data_mem_tb__DOT__clk__0 
        = vlSelfRef.data_mem_tb__DOT__clk;
    if ((1ULL & __VTmp[0U])) {
        vlSelfRef.__VtrigSched_h0663bfc7__0.ready(__VeventDescription);
        vlSelfRef.__VtrigSched_h0663bfc7__0.ready(__VeventDescription);
    }
    vlSelfRef.__VactTriggeredAcc[0U] = (vlSelfRef.__VactTriggeredAcc[0U] 
                                        | __VTmp[0U]);
}

#ifdef VL_DEBUG
void Vdata_mem_tb___024root___eval_debug_assertions(Vdata_mem_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vdata_mem_tb___024root___eval_debug_assertions\n"); );
    Vdata_mem_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
