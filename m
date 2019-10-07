From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  7 Oct 2019 13:08:59 +0200
Subject: [LTP] [PATCH] bpf_prog03: Add regression test for sign extension bug
Message-ID: <20191007110859.25316-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h                         |  13 ++
 runtest/cve                                |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_common.h |  15 ++
 testcases/kernel/syscalls/bpf/bpf_map01.c  |  13 +-
 testcases/kernel/syscalls/bpf/bpf_prog02.c |  11 +-
 testcases/kernel/syscalls/bpf/bpf_prog03.c | 191 +++++++++++++++++++++
 8 files changed, 224 insertions(+), 22 deletions(-)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog03.c

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 5582e344a..d3d444b0c 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -21,8 +21,11 @@
 #define		BPF_LDX		0x01
 #define		BPF_ST		0x02
 #define		BPF_STX		0x03
+#define		BPF_ALU		0x04
 #define		BPF_JMP		0x05
 
+#define BPF_JNE		0x50	/* jump != */
+
 #define BPF_SIZE(code)  ((code) & 0x18)
 #define		BPF_W		0x00    /* 32-bit */
 #define         BPF_DW		0x18	/* double word (64-bit) */
@@ -34,6 +37,8 @@
 #define BPF_OP(code)    ((code) & 0xf0)
 #define		BPF_ADD		0x00
 #define		BPF_SUB		0x10
+#define		BPF_LSH		0x60
+#define		BPF_RSH		0x70
 
 #define		BPF_JEQ		0x10
 
@@ -521,6 +526,14 @@ enum bpf_func_id {
 		.off   = 0,					\
 		.imm   = IMM })
 
+#define BPF_MOV32_IMM(DST, IMM)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_MOV | BPF_K,		\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
 #define BPF_EMIT_CALL(FUNC)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_JMP | BPF_CALL,			\
diff --git a/runtest/cve b/runtest/cve
index acbbbe5f5..57cf66075 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -33,6 +33,7 @@ cve-2017-1000364 stack_clash
 cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
 cve-2017-16939 cve-2017-16939
+cve-2017-16995 bpf_prog03
 cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
 cve-2017-1000380 snd_timer01
diff --git a/runtest/syscalls b/runtest/syscalls
index 4e6310193..12d3e0d3b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -35,6 +35,7 @@ bind03 bind03
 bpf_map01 bpf_map01
 bpf_prog01 bpf_prog01
 bpf_prog02 bpf_prog02
+bpf_prog03 bpf_prog03
 
 brk01 brk01
 
diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
index 1704f9841..3c33a844b 100644
--- a/testcases/kernel/syscalls/bpf/.gitignore
+++ b/testcases/kernel/syscalls/bpf/.gitignore
@@ -1,3 +1,4 @@
 bpf_map01
 bpf_prog01
 bpf_prog02
+bpf_prog03
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index 03e46c5d4..93abf115f 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -28,4 +28,19 @@ void rlimit_bump_memlock(void)
 	}
 }
 
+int bpf_map_create(union bpf_attr *attr)
+{
+	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EPERM) {
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
 #endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index 49d32776e..69473cd04 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -50,19 +50,8 @@ void run(unsigned int n)
 	attr->value_size = VAL_SZ;
 	attr->max_entries = 1;
 
-	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (TST_ERR == EPERM) {
-			tst_brk(TCONF | TTERRNO,
-				"bpf() requires CAP_SYS_ADMIN on this system");
-		} else {
-			tst_res(TFAIL | TTERRNO, "Failed to create %s map",
-				map_types[n].name);
-			return;
-		}
-	}
+	fd = bpf_map_create(attr);
 	tst_res(TPASS, "Created %s map", map_types[n].name);
-	fd = TST_RET;
 
 	memset(attr, 0, sizeof(*attr));
 	attr->map_fd = fd;
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index 295439e8e..801358947 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -111,16 +111,7 @@ static void run(void)
 	attr->value_size = 8;
 	attr->max_entries = 2;
 
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
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
new file mode 100644
index 000000000..47088a250
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ * Original byte code was provided by jannh@google.com
+ *
+ * Check for the bug fixed by 95a762e2c8c942780948091f8f2a4f32fce1ac6f
+ * "bpf: fix incorrect sign extension in check_alu_op()"
+ * CVE-2017-16995
+ *
+ * This test is very similar to the reproducer found here:
+ * https://bugs.chromium.org/p/project-zero/issues/detail?id=1454
+ *
+ * However it has been modified to try to corrupt the map struct instead of
+ * writing to a noncanonical pointer. This appears to be more reliable at
+ * producing stack traces and confirms we would be able to overwrite the ops
+ * function pointers, as suggested by Jan.
+ *
+ * If the eBPF code is loaded then this is considered a failure regardless of
+ * whether it is able to cause any visible damage.
+ */
+
+#include <string.h>
+#include <stdio.h>
+#include <inttypes.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_capability.h"
+#include "lapi/socket.h"
+#include "lapi/bpf.h"
+#include "bpf_common.h"
+
+#define LOG_SIZE (1024 * 1024)
+
+static const char MSG[] = "Ahoj!";
+static char *msg;
+
+static char *log;
+static uint32_t *key;
+static uint64_t *val;
+static union bpf_attr *attr;
+
+static int load_prog(int fd)
+{
+	static struct bpf_insn *prog;
+	struct bpf_insn insn[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, fd),
+
+		// fill r0 with pointer to map value
+		BPF_MOV64_REG(BPF_REG_8, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_8, -4), // allocate 4 bytes stack
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_2, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+		BPF_MOV64_REG(BPF_REG_0, 0), // prepare exit
+		BPF_EXIT_INSN(), // exit
+
+		// r1 = 0xffff'ffff, mistreated as 0xffff'ffff'ffff'ffff
+		BPF_MOV32_IMM(BPF_REG_1, -1),
+		// r1 = 0x1'0000'0000, mistreated as 0
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+		// r1 = 64, mistreated as 0
+		BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 26),
+
+		// Write actual value of r1 to map for debugging this test
+		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+
+		// Corrupt the map meta-data which comes before the map data
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+		BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
+
+		BPF_MOV64_IMM(BPF_REG_3, 0xdeadbeef),
+		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+		BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
+		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+		BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
+		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+		BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
+		BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+
+		// terminate to make the verifier happy
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+	};
+
+	if (!prog)
+		prog = tst_alloc(sizeof(insn));
+	memcpy(prog, insn, sizeof(insn));
+
+	memset(attr, 0, sizeof(*attr));
+	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	attr->insns = ptr_to_u64(prog);
+	attr->insn_cnt = ARRAY_SIZE(insn);
+	attr->license = ptr_to_u64("GPL");
+	attr->log_buf = ptr_to_u64(log);
+	attr->log_size = LOG_SIZE;
+	attr->log_level = 1;
+
+	TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		if (log[0] != 0)
+			tst_res(TPASS | TTERRNO, "Failed verification");
+		else
+			tst_brk(TBROK | TTERRNO, "Failed to load program");
+	} else {
+		tst_res(TINFO, "Verification log:");
+		fputs(log, stderr);
+	}
+
+	return TST_RET;
+}
+
+static void setup(void)
+{
+	rlimit_bump_memlock();
+	memcpy(msg, MSG, sizeof(MSG));
+}
+
+static void run(void)
+{
+	int map_fd, prog_fd;
+	int sk[2];
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_type = BPF_MAP_TYPE_ARRAY;
+	attr->key_size = 4;
+	attr->value_size = 8;
+	attr->max_entries = 32;
+
+	map_fd = bpf_map_create(attr);
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = map_fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val);
+	attr->flags = BPF_ANY;
+
+	TEST(bpf(BPF_MAP_UPDATE_ELEM, attr, sizeof(*attr)));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "Failed to lookup map element");
+
+	prog_fd = load_prog(map_fd);
+	if (prog_fd == -1)
+		goto exit;
+
+	tst_res(TFAIL, "Loaded bad eBPF, now we will run it and maybe crash");
+
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
+	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
+			&prog_fd, sizeof(prog_fd));
+
+	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = map_fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val);
+	*key = 0;
+
+	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "array map lookup");
+	else
+		tst_res(TINFO, "Pointer offset was 0x%"PRIx64, *val);
+
+	SAFE_CLOSE(sk[0]);
+	SAFE_CLOSE(sk[1]);
+	SAFE_CLOSE(prog_fd);
+exit:
+	SAFE_CLOSE(map_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "3.18",
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&key, .size = sizeof(*key)},
+		{&val, .size = sizeof(*val)},
+		{&log, .size = LOG_SIZE},
+		{&attr, .size = sizeof(*attr)},
+		{&msg, .size = sizeof(MSG)},
+		{},
+	}
+};
-- 
2.23.0

