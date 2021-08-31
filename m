From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Aug 2021 10:10:05 +0100
Subject: [LTP] [PATCH v2 4/4] bpf_prog05: Drop CAP_BPF and check if ptr
 arithmetic is allowed
In-Reply-To: <20210831091005.25361-1-rpalethorpe@suse.com>
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
Message-ID: <20210831091005.25361-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On older kernels pointer arithmetic requires CAP_BPF. They also lack
the ability to call BPF subprogs. This makes it difficult to exploit
the div/mod behavior.

Older kernels leave div/mod by zero undefined. This causes the test to
fail and backporting the new behavior is difficult. So when we find
that pointer arithmetic is not possible without CAP_BPF we can return
TCONF. Because in this case, we know the test will fail, the risk is
limited and there is little that can be done about it.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h                         |  1 +
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 44 +++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 0e4527b8b..f9e50c6b7 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -27,6 +27,7 @@
 #define BPF_JNE		0x50	/* jump != */
 
 #define BPF_SIZE(code)  ((code) & 0x18)
+#define		BPF_B		0x10 /*  8-bit */
 #define		BPF_W		0x00    /* 32-bit */
 #define         BPF_DW		0x18	/* double word (64-bit) */
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index b2792c505..2be5a2cc9 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -63,6 +63,45 @@ static uint64_t *val;
 static char *log;
 static union bpf_attr *attr;
 
+static void ensure_ptr_arithmetic(void)
+{
+	const struct bpf_insn prog_insn[] = {
+		/* r2 = r10
+		 * r3 = -1
+		 * r2 += r3
+		 * *(char *)r2 = 0
+		 */
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_MOV64_IMM(BPF_REG_3, -1),
+		BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
+		BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0),
+
+		/* exit(0) */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+	};
+	int ret;
+
+	bpf_init_prog_attr(attr, prog_insn, sizeof(prog_insn), log, BUFSIZE);
+
+	ret = TST_RETRY_FUNC(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)),
+				       TST_RETVAL_GE0);
+
+	if (ret >= 0) {
+		tst_res(TINFO, "Have pointer arithmetic");
+		SAFE_CLOSE(ret);
+		return;
+	}
+
+	if (ret != -1)
+		tst_brk(TBROK, "Invalid bpf() return value: %d", ret);
+
+	if (log[0] != 0)
+		tst_brk(TCONF | TERRNO, "No pointer arithmetic:\n %s", log);
+
+	tst_brk(TBROK | TERRNO, "Failed to load program");
+}
+
 static int load_prog(void)
 {
 	const struct bpf_insn prog_insn[] = {
@@ -132,7 +171,9 @@ static void run(void)
 {
 	int prog_fd;
 
-	map_fd = bpf_map_array_create(4);
+	map_fd = bpf_map_array_create(8);
+
+	ensure_ptr_arithmetic();
 	prog_fd = load_prog();
 	bpf_run_prog(prog_fd, msg, sizeof(MSG));
 	SAFE_CLOSE(prog_fd);
@@ -157,6 +198,7 @@ static struct tst_test test = {
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.caps = (struct tst_cap []) {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		TST_CAP(TST_CAP_DROP, CAP_BPF),
 		{}
 	},
 	.bufs = (struct tst_buffers []) {
-- 
2.31.1

