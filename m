From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 18 Feb 2020 10:45:41 +0100
Subject: [LTP] [PATCH v4 3/3] Fix BPF test program loading issues
In-Reply-To: <20200218094541.27201-1-mdoucha@suse.cz>
References: <20200217141622.26912-1-mdoucha@suse.cz>
 <20200218094541.27201-1-mdoucha@suse.cz>
Message-ID: <20200218094541.27201-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BPF programs require locked memory which will be released asynchronously.
If a BPF program gets loaded too many times too quickly, memory allocation
may fail due to race condition with asynchronous cleanup.

Wrap the bpf() test calls in a retry loop to fix the issue.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- bpf_common.h split was moved to a separate patch
- use redesigned TST_RETRY_FUNC() instead of TST_SPIN_TEST()
- simplify bpf() return value validation
- minor function name refactoring in the common code

Changes since v2: None.

 testcases/kernel/syscalls/bpf/bpf_common.c | 60 +++++++++++--
 testcases/kernel/syscalls/bpf/bpf_common.h |  3 +
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 97 +++++++---------------
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 28 +------
 testcases/kernel/syscalls/bpf/bpf_prog03.c | 38 ++++-----
 5 files changed, 108 insertions(+), 118 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index fce364af8..1db91e29a 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -30,16 +30,66 @@ void rlimit_bump_memlock(void)
 
 int bpf_map_create(union bpf_attr *attr)
 {
-	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
+	int ret;
+
+	ret = TST_RETRY_FUNC(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)),
+		TST_RETVAL_GE0);
+
+	if (ret == -1) {
 		if (TST_ERR == EPERM) {
 			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
-			tst_brk(TCONF | TTERRNO,
+			tst_brk(TCONF | TERRNO,
 				"bpf() requires CAP_SYS_ADMIN on this system");
 		} else {
-			tst_brk(TBROK | TTERRNO, "Failed to create array map");
+			tst_brk(TBROK | TERRNO, "Failed to create array map");
 		}
 	}
 
-	return TST_RET;
+	return ret;
+}
+
+void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
+	size_t prog_size, char *log_buf, size_t log_size)
+{
+	static struct bpf_insn *buf;
+	static size_t buf_size;
+	size_t prog_len = prog_size / sizeof(*prog);
+
+	/* all guarded buffers will be free()d automatically by LTP library */
+	if (!buf || prog_size > buf_size) {
+		buf = tst_alloc(prog_size);
+		buf_size = prog_size;
+	}
+
+	memcpy(buf, prog, prog_size);
+	memset(attr, 0, sizeof(*attr));
+	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	attr->insns = ptr_to_u64(buf);
+	attr->insn_cnt = prog_len;
+	attr->license = ptr_to_u64("GPL");
+	attr->log_buf = ptr_to_u64(log_buf);
+	attr->log_size = log_size;
+	attr->log_level = 1;
+}
+
+int bpf_load_prog(union bpf_attr *attr, const char *log)
+{
+	int ret;
+
+	ret = TST_RETRY_FUNC(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)),
+		TST_RETVAL_GE0);
+
+	if (ret >= 0) {
+		tst_res(TPASS, "Loaded program");
+		return ret;
+	}
+
+	if (ret != -1)
+		tst_brk(TBROK, "Invalid bpf() return value: %d", ret);
+
+	if (log[0] != 0)
+		tst_brk(TBROK | TERRNO, "Failed verification: %s", log);
+
+	tst_brk(TBROK | TERRNO, "Failed to load program");
+	return ret;
 }
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index e46a519eb..1dbbd5f25 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -10,5 +10,8 @@
 
 void rlimit_bump_memlock(void);
 int bpf_map_create(union bpf_attr *attr);
+void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
+	size_t prog_size, char *log_buf, size_t log_size);
+int bpf_load_prog(union bpf_attr *attr, const char *log);
 
 #endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index 46a909fe2..966bf2092 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -32,72 +32,47 @@
 const char MSG[] = "Ahoj!";
 static char *msg;
 
-/*
- * The following is a byte code template. We copy it to a guarded buffer and
- * substitute the runtime value of our map file descriptor.
- *
- * r0 - r10 = registers 0 to 10
- * r0 = return code
- * r1 - r5 = scratch registers, used for function arguments
- * r6 - r9 = registers preserved across function calls
- * fp/r10 = stack frame pointer
- */
-const struct bpf_insn PROG[] = {
-	/* Load the map FD into r1 (place holder) */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	/* Put (key = 0) on stack and key ptr into r2 */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* r2 = fp */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* r2 = r2 - 8 */
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),    /* *r2 = 0 */
-	/* r0 = bpf_map_lookup_elem(r1, r2) */
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	/* if r0 == 0 goto exit */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	/* Set map[0] = 1 */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),     /* r1 = r0 */
-	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 1),     /* *r1 = 1 */
-	BPF_MOV64_IMM(BPF_REG_0, 0),             /* r0 = 0 */
-	BPF_EXIT_INSN(),		         /* return r0 */
-};
-
-static struct bpf_insn *prog;
 static char *log;
 static union bpf_attr *attr;
 
 int load_prog(int fd)
 {
-	prog[0] = BPF_LD_MAP_FD(BPF_REG_1, fd);
-
-	memset(attr, 0, sizeof(*attr));
-	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr->insns = ptr_to_u64(prog);
-	attr->insn_cnt = ARRAY_SIZE(PROG);
-	attr->license = ptr_to_u64("GPL");
-	attr->log_buf = ptr_to_u64(log);
-	attr->log_size = BUFSIZ;
-	attr->log_level = 1;
-
-	TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (log[0] != 0) {
-			tst_brk(TFAIL | TTERRNO,
-				"Failed verification: %s",
-				log);
-		} else {
-			tst_brk(TFAIL | TTERRNO, "Failed to load program");
-		}
-	} else {
-		tst_res(TPASS, "Loaded program");
-	}
-
-	return TST_RET;
+	/*
+	 * The following is a byte code template. We copy it to a guarded buffer and
+	 * substitute the runtime value of our map file descriptor.
+	 *
+	 * r0 - r10 = registers 0 to 10
+	 * r0 = return code
+	 * r1 - r5 = scratch registers, used for function arguments
+	 * r6 - r9 = registers preserved across function calls
+	 * fp/r10 = stack frame pointer
+	 */
+	struct bpf_insn PROG[] = {
+		/* Load the map FD into r1 (place holder) */
+		BPF_LD_MAP_FD(BPF_REG_1, fd),
+		/* Put (key = 0) on stack and key ptr into r2 */
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* r2 = fp */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* r2 = r2 - 8 */
+		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),    /* *r2 = 0 */
+		/* r0 = bpf_map_lookup_elem(r1, r2) */
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		/* if r0 == 0 goto exit */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+		/* Set map[0] = 1 */
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),     /* r1 = r0 */
+		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 1),     /* *r1 = 1 */
+		BPF_MOV64_IMM(BPF_REG_0, 0),             /* r0 = 0 */
+		BPF_EXIT_INSN(),		         /* return r0 */
+	};
+
+	bpf_init_prog_attr(attr, PROG, sizeof(PROG), log, BUFSIZ);
+	return bpf_load_prog(attr, log);
 }
 
 void setup(void)
 {
 	rlimit_bump_memlock();
 
-	memcpy(prog, PROG, sizeof(PROG));
 	memcpy(msg, MSG, sizeof(MSG));
 }
 
@@ -114,16 +89,7 @@ void run(void)
 	attr->value_size = 8;
 	attr->max_entries = 1;
 
-	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (TST_ERR == EPERM) {
-			tst_brk(TCONF | TTERRNO,
-				"bpf() requires CAP_SYS_ADMIN on this system");
-		} else {
-			tst_brk(TBROK | TTERRNO, "Failed to create array map");
-		}
-	}
-	map_fd = TST_RET;
+	map_fd = bpf_map_create(attr);
 
 	prog_fd = load_prog(map_fd);
 
@@ -161,7 +127,6 @@ static struct tst_test test = {
 	.min_kver = "3.19",
 	.bufs = (struct tst_buffers []) {
 		{&log, .size = BUFSIZ},
-		{&prog, .size = sizeof(PROG)},
 		{&attr, .size = sizeof(*attr)},
 		{&msg, .size = sizeof(MSG)},
 		{},
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index acff1884a..eeba16a54 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -37,7 +37,6 @@ static union bpf_attr *attr;
 
 static int load_prog(int fd)
 {
-	static struct bpf_insn *prog;
 	struct bpf_insn insn[] = {
 		BPF_MOV64_IMM(BPF_REG_6, 1),            /* 0: r6 = 1 */
 
@@ -67,31 +66,8 @@ static int load_prog(int fd)
 		BPF_EXIT_INSN(),		        /* 26: return r0 */
 	};
 
-	if (!prog)
-		prog = tst_alloc(sizeof(insn));
-	memcpy(prog, insn, sizeof(insn));
-
-	memset(attr, 0, sizeof(*attr));
-	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr->insns = ptr_to_u64(prog);
-	attr->insn_cnt = ARRAY_SIZE(insn);
-	attr->license = ptr_to_u64("GPL");
-	attr->log_buf = ptr_to_u64(log);
-	attr->log_size = BUFSIZ;
-	attr->log_level = 1;
-
-	TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (log[0] != 0) {
-			tst_res(TINFO, "Verification log:");
-			fputs(log, stderr);
-			tst_brk(TBROK | TTERRNO, "Failed verification");
-		} else {
-			tst_brk(TBROK | TTERRNO, "Failed to load program");
-		}
-	}
-
-	return TST_RET;
+	bpf_init_prog_attr(attr, insn, sizeof(insn), log, BUFSIZ);
+	return bpf_load_prog(attr, log);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index d79815961..5b8a394e8 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -32,6 +32,8 @@
 
 #define LOG_SIZE (1024 * 1024)
 
+#define CHECK_BPF_RET(x) ((x) >= 0 || ((x) == -1 && errno != EPERM))
+
 static const char MSG[] = "Ahoj!";
 static char *msg;
 
@@ -42,7 +44,8 @@ static union bpf_attr *attr;
 
 static int load_prog(int fd)
 {
-	static struct bpf_insn *prog;
+	int ret;
+
 	struct bpf_insn insn[] = {
 		BPF_LD_MAP_FD(BPF_REG_1, fd),
 
@@ -85,31 +88,24 @@ static int load_prog(int fd)
 		BPF_EXIT_INSN()
 	};
 
-	if (!prog)
-		prog = tst_alloc(sizeof(insn));
-	memcpy(prog, insn, sizeof(insn));
+	bpf_init_prog_attr(attr, insn, sizeof(insn), log, LOG_SIZE);
+	ret = TST_RETRY_FUNC(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)),
+		CHECK_BPF_RET);
 
-	memset(attr, 0, sizeof(*attr));
-	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr->insns = ptr_to_u64(prog);
-	attr->insn_cnt = ARRAY_SIZE(insn);
-	attr->license = ptr_to_u64("GPL");
-	attr->log_buf = ptr_to_u64(log);
-	attr->log_size = LOG_SIZE;
-	attr->log_level = 1;
-
-	TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (log[0] != 0)
-			tst_res(TPASS | TTERRNO, "Failed verification");
-		else
-			tst_brk(TBROK | TTERRNO, "Failed to load program");
-	} else {
+	if (ret < -1)
+		tst_brk(TBROK, "Invalid bpf() return value %d", ret);
+
+	if (ret >= 0) {
 		tst_res(TINFO, "Verification log:");
 		fputs(log, stderr);
+		return ret;
 	}
 
-	return TST_RET;
+	if (log[0] == 0)
+		tst_brk(TBROK | TERRNO, "Failed to load program");
+
+	tst_res(TPASS | TERRNO, "Failed verification");
+	return ret;
 }
 
 static void setup(void)
-- 
2.25.0

