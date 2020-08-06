From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  6 Aug 2020 13:08:05 +0200
Subject: [LTP] [PATCH 1/2] Add some 32-bit instruction macros to BPF LAPI
Message-ID: <20200806110806.28793-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/bpf.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 22b13b47b..f27a92146 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -449,6 +449,14 @@ enum bpf_func_id {
 		.off   = 0,					\
 		.imm   = 0 })
 
+#define BPF_ALU32_REG(OP, DST, SRC)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_OP(OP) | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
 #define BPF_ALU64_IMM(OP, DST, IMM)				\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_K,	\
@@ -457,6 +465,14 @@ enum bpf_func_id {
 		.off   = 0,					\
 		.imm   = IMM })
 
+#define BPF_ALU32_IMM(OP, DST, IMM)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_OP(OP) | BPF_K,		\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
 #define BPF_MOV64_REG(DST, SRC)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
@@ -465,6 +481,14 @@ enum bpf_func_id {
 		.off   = 0,					\
 		.imm   = 0 })
 
+#define BPF_MOV32_REG(DST, SRC)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
 #define BPF_LD_IMM64(DST, IMM)					\
 	BPF_LD_IMM64_RAW(DST, 0, IMM)
 
-- 
2.27.0

