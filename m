From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 30 Jul 2019 15:44:56 +0200
Subject: [LTP] [PATCH v2 3/4] BPF: Essential headers for a basic program
In-Reply-To: <20190730134457.27845-1-rpalethorpe@suse.com>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
 <20190730134457.27845-1-rpalethorpe@suse.com>
Message-ID: <20190730134457.27845-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h    | 286 +++++++++++++++++++++++++++++++++++++++++-
 include/lapi/socket.h |   4 +
 2 files changed, 289 insertions(+), 1 deletion(-)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 369de0175..122eb5469 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -15,7 +15,57 @@
 
 #include "lapi/syscalls.h"
 
-/* Start copy from linux/bpf.h */
+/* Start copy from linux/bpf_(common).h */
+#define BPF_CLASS(code) ((code) & 0x07)
+#define		BPF_LD		0x00
+#define		BPF_ST		0x02
+#define		BPF_JMP		0x05
+
+#define BPF_SIZE(code)  ((code) & 0x18)
+#define         BPF_DW		0x18	/* double word (64-bit) */
+
+#define BPF_MODE(code)  ((code) & 0xe0)
+#define		BPF_IMM		0x00
+#define		BPF_MEM		0x60
+
+#define BPF_OP(code)    ((code) & 0xf0)
+#define		BPF_ADD		0x00
+
+#define		BPF_JEQ		0x10
+
+#define BPF_SRC(code)   ((code) & 0x08)
+#define		BPF_K		0x00
+#define		BPF_X		0x08
+
+#define BPF_ALU64	0x07	/* alu mode in double word width */
+#define BPF_MOV		0xb0	/* mov reg to reg */
+#define BPF_CALL	0x80	/* function call */
+#define BPF_EXIT	0x90	/* function return */
+
+/* Register numbers */
+enum {
+	BPF_REG_0 = 0,
+	BPF_REG_1,
+	BPF_REG_2,
+	BPF_REG_3,
+	BPF_REG_4,
+	BPF_REG_5,
+	BPF_REG_6,
+	BPF_REG_7,
+	BPF_REG_8,
+	BPF_REG_9,
+	BPF_REG_10,
+	MAX_BPF_REG,
+};
+
+struct bpf_insn {
+	uint8_t	code;		/* opcode */
+	uint8_t	dst_reg:4;	/* dest register */
+	uint8_t	src_reg:4;	/* source register */
+	int16_t	off;		/* signed offset */
+	int32_t	imm;		/* signed immediate constant */
+};
+
 enum bpf_cmd {
 	BPF_MAP_CREATE,
 	BPF_MAP_LOOKUP_ELEM,
@@ -70,6 +120,37 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SK_STORAGE,
 };
 
+enum bpf_prog_type {
+	BPF_PROG_TYPE_UNSPEC,
+	BPF_PROG_TYPE_SOCKET_FILTER,
+	BPF_PROG_TYPE_KPROBE,
+	BPF_PROG_TYPE_SCHED_CLS,
+	BPF_PROG_TYPE_SCHED_ACT,
+	BPF_PROG_TYPE_TRACEPOINT,
+	BPF_PROG_TYPE_XDP,
+	BPF_PROG_TYPE_PERF_EVENT,
+	BPF_PROG_TYPE_CGROUP_SKB,
+	BPF_PROG_TYPE_CGROUP_SOCK,
+	BPF_PROG_TYPE_LWT_IN,
+	BPF_PROG_TYPE_LWT_OUT,
+	BPF_PROG_TYPE_LWT_XMIT,
+	BPF_PROG_TYPE_SOCK_OPS,
+	BPF_PROG_TYPE_SK_SKB,
+	BPF_PROG_TYPE_CGROUP_DEVICE,
+	BPF_PROG_TYPE_SK_MSG,
+	BPF_PROG_TYPE_RAW_TRACEPOINT,
+	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+	BPF_PROG_TYPE_LWT_SEG6LOCAL,
+	BPF_PROG_TYPE_LIRC_MODE2,
+	BPF_PROG_TYPE_SK_REUSEPORT,
+	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_CGROUP_SYSCTL,
+	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+};
+
+#define BPF_PSEUDO_MAP_FD	1
+
 #define BPF_OBJ_NAME_LEN 16U
 
 #define BPF_ANY		0 /* create new element or update existing */
@@ -225,8 +306,211 @@ union bpf_attr {
 	} task_fd_query;
 } __attribute__((aligned(8)));
 
+#define __BPF_FUNC_MAPPER(FN)		\
+	FN(unspec),			\
+	FN(map_lookup_elem),		\
+	FN(map_update_elem),		\
+	FN(map_delete_elem),		\
+	FN(probe_read),			\
+	FN(ktime_get_ns),		\
+	FN(trace_printk),		\
+	FN(get_prandom_u32),		\
+	FN(get_smp_processor_id),	\
+	FN(skb_store_bytes),		\
+	FN(l3_csum_replace),		\
+	FN(l4_csum_replace),		\
+	FN(tail_call),			\
+	FN(clone_redirect),		\
+	FN(get_current_pid_tgid),	\
+	FN(get_current_uid_gid),	\
+	FN(get_current_comm),		\
+	FN(get_cgroup_classid),		\
+	FN(skb_vlan_push),		\
+	FN(skb_vlan_pop),		\
+	FN(skb_get_tunnel_key),		\
+	FN(skb_set_tunnel_key),		\
+	FN(perf_event_read),		\
+	FN(redirect),			\
+	FN(get_route_realm),		\
+	FN(perf_event_output),		\
+	FN(skb_load_bytes),		\
+	FN(get_stackid),		\
+	FN(csum_diff),			\
+	FN(skb_get_tunnel_opt),		\
+	FN(skb_set_tunnel_opt),		\
+	FN(skb_change_proto),		\
+	FN(skb_change_type),		\
+	FN(skb_under_cgroup),		\
+	FN(get_hash_recalc),		\
+	FN(get_current_task),		\
+	FN(probe_write_user),		\
+	FN(current_task_under_cgroup),	\
+	FN(skb_change_tail),		\
+	FN(skb_pull_data),		\
+	FN(csum_update),		\
+	FN(set_hash_invalid),		\
+	FN(get_numa_node_id),		\
+	FN(skb_change_head),		\
+	FN(xdp_adjust_head),		\
+	FN(probe_read_str),		\
+	FN(get_socket_cookie),		\
+	FN(get_socket_uid),		\
+	FN(set_hash),			\
+	FN(setsockopt),			\
+	FN(skb_adjust_room),		\
+	FN(redirect_map),		\
+	FN(sk_redirect_map),		\
+	FN(sock_map_update),		\
+	FN(xdp_adjust_meta),		\
+	FN(perf_event_read_value),	\
+	FN(perf_prog_read_value),	\
+	FN(getsockopt),			\
+	FN(override_return),		\
+	FN(sock_ops_cb_flags_set),	\
+	FN(msg_redirect_map),		\
+	FN(msg_apply_bytes),		\
+	FN(msg_cork_bytes),		\
+	FN(msg_pull_data),		\
+	FN(bind),			\
+	FN(xdp_adjust_tail),		\
+	FN(skb_get_xfrm_state),		\
+	FN(get_stack),			\
+	FN(skb_load_bytes_relative),	\
+	FN(fib_lookup),			\
+	FN(sock_hash_update),		\
+	FN(msg_redirect_hash),		\
+	FN(sk_redirect_hash),		\
+	FN(lwt_push_encap),		\
+	FN(lwt_seg6_store_bytes),	\
+	FN(lwt_seg6_adjust_srh),	\
+	FN(lwt_seg6_action),		\
+	FN(rc_repeat),			\
+	FN(rc_keydown),			\
+	FN(skb_cgroup_id),		\
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),		\
+	FN(sk_select_reuseport),	\
+	FN(skb_ancestor_cgroup_id),	\
+	FN(sk_lookup_tcp),		\
+	FN(sk_lookup_udp),		\
+	FN(sk_release),			\
+	FN(map_push_elem),		\
+	FN(map_pop_elem),		\
+	FN(map_peek_elem),		\
+	FN(msg_push_data),		\
+	FN(msg_pop_data),		\
+	FN(rc_pointer_rel),		\
+	FN(spin_lock),			\
+	FN(spin_unlock),		\
+	FN(sk_fullsock),		\
+	FN(tcp_sock),			\
+	FN(skb_ecn_set_ce),		\
+	FN(get_listener_sock),		\
+	FN(skc_lookup_tcp),		\
+	FN(tcp_check_syncookie),	\
+	FN(sysctl_get_name),		\
+	FN(sysctl_get_current_value),	\
+	FN(sysctl_get_new_value),	\
+	FN(sysctl_set_new_value),	\
+	FN(strtol),			\
+	FN(strtoul),			\
+	FN(sk_storage_get),		\
+	FN(sk_storage_delete),		\
+	FN(send_signal),
+
+/* integer value in 'imm' field of BPF_CALL instruction selects which helper
+ * function eBPF program intends to call
+ */
+#define __BPF_ENUM_FN(x) BPF_FUNC_ ## x
+enum bpf_func_id {
+	__BPF_FUNC_MAPPER(__BPF_ENUM_FN)
+	__BPF_FUNC_MAX_ID,
+};
+#undef __BPF_ENUM_FN
+
 /* End copy from linux/bpf.h */
 
+/* Start copy from tools/include/filter.h */
+
+#define BPF_ALU64_IMM(OP, DST, IMM)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_K,	\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
+#define BPF_MOV64_REG(DST, SRC)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
+#define BPF_LD_IMM64(DST, IMM)					\
+	BPF_LD_IMM64_RAW(DST, 0, IMM)
+
+#define BPF_LD_IMM64_RAW(DST, SRC, IMM)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_LD | BPF_DW | BPF_IMM,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = (uint32_t) (IMM) }),			\
+	((struct bpf_insn) {					\
+		.code  = 0, /* zero is reserved opcode */	\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = ((uint64_t) (IMM)) >> 32 })
+
+/* pseudo BPF_LD_IMM64 insn used to refer to process-local map_fd */
+#define BPF_LD_MAP_FD(DST, MAP_FD)				\
+	BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)
+
+#define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = OFF,					\
+		.imm   = IMM })
+
+#define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_OP(OP) | BPF_K,		\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = OFF,					\
+		.imm   = IMM })
+
+#define BPF_MOV64_IMM(DST, IMM)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_K,		\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
+#define BPF_EMIT_CALL(FUNC)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_CALL,			\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = ((FUNC) - BPF_FUNC_unspec) })
+
+#define BPF_EXIT_INSN()						\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_EXIT,			\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
+/* End copy from tools/include/filter.h */
+
 /* Start copy from tools/lib/bpf  */
 inline uint64_t ptr_to_u64(const void *ptr)
 {
diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 2605443e8..299a4f27a 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -37,6 +37,10 @@
 # define SO_BUSY_POLL	46
 #endif
 
+#ifndef SO_ATTACH_BPF
+# define SO_ATTACH_BPF  50
+#endif
+
 #ifndef SO_ZEROCOPY
 # define SO_ZEROCOPY	60
 #endif
-- 
2.22.0

