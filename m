From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Apr 2021 16:05:10 +0100
Subject: [LTP] [PATCH v2 5/5] bpf: Check truncation on 32bit div/mod by zero
In-Reply-To: <20210429150510.21585-1-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
Message-ID: <20210429150510.21585-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a test which checks for a number of issues surrounding division by
zero.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                                |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 175 +++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog05.c

diff --git a/runtest/cve b/runtest/cve
index f650854f9..3beb88bb0 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -61,3 +61,4 @@ cve-2020-11494 pty04
 cve-2020-14386 sendto03
 cve-2020-14416 pty03
 cve-2020-29373 io_uring02
+cve-2021-3444 bpf_prog05
diff --git a/runtest/syscalls b/runtest/syscalls
index 546a988c2..60c0a7a99 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -42,6 +42,7 @@ bpf_prog01 bpf_prog01
 bpf_prog02 bpf_prog02
 bpf_prog03 bpf_prog03
 bpf_prog04 bpf_prog04
+bpf_prog05 bpf_prog05
 
 brk01 brk01
 brk02 brk02
diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
index 74742c0cd..42365cef5 100644
--- a/testcases/kernel/syscalls/bpf/.gitignore
+++ b/testcases/kernel/syscalls/bpf/.gitignore
@@ -3,3 +3,4 @@ bpf_prog01
 bpf_prog02
 bpf_prog03
 bpf_prog04
+bpf_prog05
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
new file mode 100644
index 000000000..ccaa2cbe1
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Compare the effects of 32-bit div/mod by zero with the "expected"
+ * behaviour.
+ *
+ * The commit "bpf: fix subprog verifier bypass by div/mod by 0
+ * exception", changed div/mod by zero from exiting the current
+ * program to setting the destination register to zero (div) or
+ * leaving it untouched (mod).
+ *
+ * This solved one verfier bug which allowed dodgy pointer values, but
+ * it turned out that the source register was being 32-bit truncated
+ * when it should not be. Also the destination register for mod was
+ * not being truncated when it should be.
+ *
+ * So then we have the following two fixes:
+ * "bpf: Fix 32 bit src register truncation on div/mod"
+ * "bpf: Fix truncation handling for mod32 dst reg wrt zero"
+ *
+ * Testing for all of these issues is a problem. Not least because
+ * division by zero is undefined, so in theory any result is
+ * acceptable so long as the verifier and runtime behaviour
+ * match.
+ *
+ * However to keep things simple we just check if the source and
+ * destination register runtime values match the current upstream
+ * behaviour at the time of writing.
+ *
+ * If the test fails you may have one or more of the above patches
+ * missing. In this case it is possible that you are not vulnerable
+ * depending on what other backports and fixes have been applied. If
+ * upstream changes the behaviour of division by zero, then the test
+ * will need updating.
+ *
+ * Note that we use r6 as the src register and r7 as the dst. w6 and
+ * w7 are the same registers treated as 32bit.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_capability.h"
+#include "lapi/socket.h"
+#include "lapi/bpf.h"
+#include "bpf_common.h"
+
+#define BUFSIZE 8192
+
+static const char MSG[] = "Ahoj!";
+static char *msg;
+
+static int map_fd;
+static uint32_t *key;
+static uint64_t *val;
+static char *log;
+static union bpf_attr *attr;
+
+static int load_prog(void)
+{
+	struct bpf_insn_buf prog_insn = { 0 };
+        /* r6 = 1 << 32
+	 * r7 = -1
+	 */
+	const struct bpf_insn set_src_dst_insn[] = {
+		BPF_LD_IMM64(BPF_REG_6, 1ULL << 32),
+		BPF_MOV64_IMM(BPF_REG_7, -1LL),
+	};
+	/* w7 /= w6 */
+	const struct bpf_insn div_insn =
+		BPF_ALU32_REG(BPF_DIV, BPF_REG_7, BPF_REG_6);
+	/* w7 %= w6 */
+	const struct bpf_insn mod_insn =
+		BPF_ALU32_REG(BPF_MOD, BPF_REG_7, BPF_REG_6);
+	/* exit(0) */
+	const struct bpf_insn exit_insn[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+	};
+
+	bpf_insn_buf_cat(&prog_insn, set_src_dst_insn, sizeof(set_src_dst_insn));
+	bpf_insn_buf_cat(&prog_insn, &div_insn, sizeof(div_insn));
+
+	bpf_insn_buf_array_set(&prog_insn, map_fd, 0, BPF_REG_6);
+	bpf_insn_buf_array_set(&prog_insn, map_fd, 1, BPF_REG_7);
+
+	bpf_insn_buf_cat(&prog_insn, set_src_dst_insn, sizeof(set_src_dst_insn));
+	bpf_insn_buf_cat(&prog_insn, &mod_insn, sizeof(mod_insn));
+
+	bpf_insn_buf_array_set(&prog_insn, map_fd, 2, BPF_REG_6);
+	bpf_insn_buf_array_set(&prog_insn, map_fd, 3, BPF_REG_7);
+
+	bpf_insn_buf_cat(&prog_insn, exit_insn, sizeof(exit_insn));
+
+        bpf_init_prog_attr(attr, prog_insn.insn, prog_insn.byte_len, log, BUFSIZE);
+
+	return bpf_load_prog(attr, log);
+}
+
+static void expect_reg_val(const char *const reg_name,
+			   const uint64_t expected_val)
+{
+        bpf_map_array_get(map_fd, key, val);
+        (*key)++;
+
+        if (*val != expected_val) {
+		tst_res(TFAIL,
+			"%s = %"PRIu64", but should be %"PRIu64,
+			reg_name, *val, expected_val);
+	} else {
+		tst_res(TPASS, "%s = %"PRIu64, reg_name, *val);
+	}
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
+	int prog_fd;
+
+	map_fd = bpf_map_array_create(4);
+	prog_fd = load_prog();
+	bpf_run_prog(prog_fd, msg, sizeof(MSG));
+	SAFE_CLOSE(prog_fd);
+
+	tst_res(TINFO, "Check w7(-1) /= w6(0) [r7 = -1, r6 = 1 << 32]");
+	expect_reg_val("src(r6)", 1UL << 32);
+	expect_reg_val("dst(r7)", 0);
+
+	tst_res(TINFO, "Check w7(-1) %%= w6(0) [r7 = -1, r6 = 1 << 32]");
+	expect_reg_val("src(r6)", 1UL << 32);
+	expect_reg_val("dst(r7)", (uint32_t)-1);
+
+	SAFE_CLOSE(map_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "3.18",
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&key, .size = sizeof(*key)},
+		{&val, .size = sizeof(*val)},
+		{&log, .size = BUFSIZE},
+		{&attr, .size = sizeof(*attr)},
+		{&msg, .size = sizeof(MSG)},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f6b1b3bf0d5f"},
+		{"linux-git", "468f6eafa6c4"},
+		{"linux-git", "e88b2c6e5a4d"},
+		{"linux-git", "9b00f1b78809"},
+		{"CVE", "CVE-2021-3444"},
+		{}
+	}
+};
-- 
2.31.1

