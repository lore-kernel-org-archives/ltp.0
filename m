From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  3 Feb 2020 12:39:56 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <20200203113956.13176-1-mdoucha@suse.cz>
References: <20200203113956.13176-1-mdoucha@suse.cz>
Message-ID: <20200203113956.13176-2-mdoucha@suse.cz>
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
 testcases/kernel/syscalls/bpf/Makefile     |  3 +
 testcases/kernel/syscalls/bpf/bpf_common.c | 89 ++++++++++++++++++++
 testcases/kernel/syscalls/bpf/bpf_common.h | 42 ++--------
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 97 +++++++---------------
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 28 +------
 testcases/kernel/syscalls/bpf/bpf_prog03.c | 20 ++---
 6 files changed, 136 insertions(+), 143 deletions(-)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_common.c

diff --git a/testcases/kernel/syscalls/bpf/Makefile b/testcases/kernel/syscalls/bpf/Makefile
index 990c8c83c..2241bce9b 100644
--- a/testcases/kernel/syscalls/bpf/Makefile
+++ b/testcases/kernel/syscalls/bpf/Makefile
@@ -5,6 +5,9 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+FILTER_OUT_MAKE_TARGETS	:= bpf_common
 CFLAGS			+= -D_GNU_SOURCE
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o bpf_common.o
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
new file mode 100644
index 000000000..8e61b3a74
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019-2020 Linux Test Project
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "lapi/bpf.h"
+#include "bpf_common.h"
+
+void rlimit_bump_memlock(void)
+{
+	struct rlimit memlock_r;
+
+	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
+	memlock_r.rlim_cur += BPF_MEMLOCK_ADD;
+	tst_res(TINFO, "Raising RLIMIT_MEMLOCK to %ld",
+		(long)memlock_r.rlim_cur);
+
+	if (memlock_r.rlim_cur <= memlock_r.rlim_max) {
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
+	} else if ((geteuid() == 0)) {
+		memlock_r.rlim_max += BPF_MEMLOCK_ADD;
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
+	} else {
+		tst_res(TINFO, "Can't raise RLIMIT_MEMLOCK, test may fail "
+			"due to lack of max locked memory");
+	}
+}
+
+int bpf_map_create(union bpf_attr *attr)
+{
+	TST_SPIN_TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EPERM) {
+			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
+			tst_brk(TCONF | TTERRNO,
+				"bpf() requires CAP_SYS_ADMIN on this system");
+		} else {
+			tst_brk(TBROK | TTERRNO, "Failed to create array map");
+		}
+	}
+
+	return TST_RET;
+}
+
+void prepare_bpf_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
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
+int load_bpf_prog(union bpf_attr *attr, const char *log)
+{
+	TST_SPIN_TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
+
+	if (TST_RET >= 0) {
+		tst_res(TPASS, "Loaded program");
+	} else if (TST_RET == -1) {
+		if (log[0] != 0) {
+			tst_brk(TBROK | TTERRNO, "Failed verification: %s",
+				log);
+		} else {
+			tst_brk(TBROK | TTERRNO, "Failed to load program");
+		}
+	} else {
+		tst_brk(TBROK, "Invalid bpf() return value: %ld", TST_RET);
+	}
+
+	return TST_RET;
+}
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index f700bede2..fadb7b75a 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (c) 2019 Linux Test Project
+ * Copyright (c) 2019-2020 Linux Test Project
  */
 
 #ifndef LTP_BPF_COMMON_H
@@ -8,40 +8,10 @@
 
 #define BPF_MEMLOCK_ADD (256*1024)
 
-void rlimit_bump_memlock(void)
-{
-	struct rlimit memlock_r;
-
-	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
-	memlock_r.rlim_cur += BPF_MEMLOCK_ADD;
-	tst_res(TINFO, "Raising RLIMIT_MEMLOCK to %ld",
-		(long)memlock_r.rlim_cur);
-
-	if (memlock_r.rlim_cur <= memlock_r.rlim_max) {
-		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
-	} else if ((geteuid() == 0)) {
-		memlock_r.rlim_max += BPF_MEMLOCK_ADD;
-		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
-	} else {
-		tst_res(TINFO, "Can't raise RLIMIT_MEMLOCK, test may fail "
-			"due to lack of max locked memory");
-	}
-}
-
-int bpf_map_create(union bpf_attr *attr)
-{
-	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (TST_ERR == EPERM) {
-			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
-			tst_brk(TCONF | TTERRNO,
-				"bpf() requires CAP_SYS_ADMIN on this system");
-		} else {
-			tst_brk(TBROK | TTERRNO, "Failed to create array map");
-		}
-	}
-
-	return TST_RET;
-}
+void rlimit_bump_memlock(void);
+int bpf_map_create(union bpf_attr *attr);
+void prepare_bpf_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
+	size_t prog_size, char *log_buf, size_t log_size);
+int load_bpf_prog(union bpf_attr *attr, const char *log);
 
 #endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index 46a909fe2..70645c408 100644
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
+	prepare_bpf_prog_attr(attr, PROG, sizeof(PROG), log, BUFSIZ);
+	return load_bpf_prog(attr, log);
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
index acff1884a..eb783ce3e 100644
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
+	prepare_bpf_prog_attr(attr, insn, sizeof(insn), log, BUFSIZ);
+	return load_bpf_prog(attr, log);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index d79815961..3dd9a174d 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -42,7 +42,6 @@ static union bpf_attr *attr;
 
 static int load_prog(int fd)
 {
-	static struct bpf_insn *prog;
 	struct bpf_insn insn[] = {
 		BPF_LD_MAP_FD(BPF_REG_1, fd),
 
@@ -85,25 +84,16 @@ static int load_prog(int fd)
 		BPF_EXIT_INSN()
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
-	attr->log_size = LOG_SIZE;
-	attr->log_level = 1;
-
-	TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
+	prepare_bpf_prog_attr(attr, insn, sizeof(insn), log, LOG_SIZE);
+	TST_SPIN_TEST_EXP_BACKOFF(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)), 1,
+		EACCES);
 	if (TST_RET == -1) {
 		if (log[0] != 0)
 			tst_res(TPASS | TTERRNO, "Failed verification");
 		else
 			tst_brk(TBROK | TTERRNO, "Failed to load program");
+	} else if (TST_RET < 0) {
+		tst_brk(TBROK, "Invalid bpf() return value %ld", TST_RET);
 	} else {
 		tst_res(TINFO, "Verification log:");
 		fputs(log, stderr);
-- 
2.24.1

