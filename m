From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  6 Aug 2020 13:08:06 +0200
Subject: [LTP] [PATCH 2/2] Add test for CVE 2018-18445
In-Reply-To: <20200806110806.28793-1-mdoucha@suse.cz>
References: <20200806110806.28793-1-mdoucha@suse.cz>
Message-ID: <20200806110806.28793-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #413

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

I'm not entirely sure whether my assumption that the BPF program must always
fail verification is correct. It does fail verification on patched systems.
But I'd like an opinion from one of our BPF experts.

 runtest/cve                                |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog04.c | 145 +++++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog04.c

diff --git a/runtest/cve b/runtest/cve
index fdb455af1..953319735 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -51,6 +51,7 @@ cve-2018-9568 connect02
 cve-2018-1000001 realpath01
 cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
+cve-2018-18445 bpf_prog04
 cve-2018-18559 bind06
 cve-2018-19854 crypto_user01
 cve-2020-11494 pty04
diff --git a/runtest/syscalls b/runtest/syscalls
index b4c5b1ebe..106010e8d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -40,6 +40,7 @@ bpf_map01 bpf_map01
 bpf_prog01 bpf_prog01
 bpf_prog02 bpf_prog02
 bpf_prog03 bpf_prog03
+bpf_prog04 bpf_prog04
 
 brk01 brk01
 
diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
index 3c33a844b..74742c0cd 100644
--- a/testcases/kernel/syscalls/bpf/.gitignore
+++ b/testcases/kernel/syscalls/bpf/.gitignore
@@ -2,3 +2,4 @@ bpf_map01
 bpf_prog01
 bpf_prog02
 bpf_prog03
+bpf_prog04
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog04.c b/testcases/kernel/syscalls/bpf/bpf_prog04.c
new file mode 100644
index 000000000..36e13034c
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_prog04.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2018 Jann Horn <jannh@google.com>
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE 2018-18445
+ *
+ * Check that eBPF verifier correctly handles 32-bit arithmetic, in particular
+ * the right bit shift instruction. It is an error if the BPF program passes
+ * verification regardless of whether it then causes any actual damage. Kernel
+ * bug fixed in:
+ *
+ *  commit b799207e1e1816b09e7a5920fbb2d5fcf6edd681
+ *  Author: Jann Horn <jannh@google.com>
+ *  Date:   Fri Oct 5 18:17:59 2018 +0200
+ *
+ *  bpf: 32-bit RSH verification must truncate input before the ALU op
+ */
+
+#include <stdio.h>
+#include <string.h>
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
+#define CHECK_BPF_RET(x) ((x) >= 0 || ((x) == -1 && errno != EACCES))
+
+static const char MSG[] = "Ahoj!";
+static char *msg;
+
+static char *log;
+static union bpf_attr *attr;
+
+static int load_prog(int fd)
+{
+	int ret;
+	struct bpf_insn insn[] = {
+		BPF_MOV64_IMM(BPF_REG_8, 2),
+		BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 31),
+		BPF_ALU32_IMM(BPF_RSH, BPF_REG_8, 31),
+		BPF_ALU32_IMM(BPF_SUB, BPF_REG_8, 2),
+
+		// store r8 into map
+		BPF_LD_MAP_FD(BPF_REG_1, fd),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_EXIT_INSN(),
+		BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_8),
+		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_8, 0),
+
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+	};
+
+	bpf_init_prog_attr(attr, insn, sizeof(insn), log, BUFSIZE);
+	ret = TST_RETRY_FUNC(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)),
+		CHECK_BPF_RET);
+
+	if (ret >= 0) {
+		tst_res(TINFO, "Verification log:");
+		fputs(log, stderr);
+		return ret;
+	}
+
+	if (ret < -1)
+		tst_brk(TBROK, "Invalid bpf() return value %d", ret);
+
+	if (!*log)
+		tst_brk(TBROK | TERRNO, "Failed to load BPF program");
+
+	tst_res(TPASS | TERRNO, "BPF program failed verification");
+	return ret;
+}
+
+static void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
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
+	attr->max_entries = 1;
+
+	map_fd = bpf_map_create(attr);
+	prog_fd = load_prog(map_fd);
+
+	if (prog_fd >= 0) {
+		tst_res(TFAIL, "Malicious eBPF code passed verification. "
+			"Now let's try crashing the kernel.");
+		SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
+		SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
+			sizeof(prog_fd));
+
+		SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
+		SAFE_CLOSE(sk[0]);
+		SAFE_CLOSE(sk[1]);
+	}
+
+	if (prog_fd >= 0)
+		SAFE_CLOSE(prog_fd);
+
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
+		{&log, .size = BUFSIZE},
+		{&attr, .size = sizeof(*attr)},
+		{&msg, .size = sizeof(MSG)},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "b799207e1e18"},
+		{"CVE", "2018-18445"},
+		{}
+	}
+};
-- 
2.27.0

