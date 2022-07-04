Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C537C43334
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 12:42:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A23BA3C9FEC
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 14:42:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6C2A3C9876
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 14:42:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0354E60047F
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 14:42:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1F0DA1FEF2;
 Mon,  4 Jul 2022 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1656938539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EWNdJDYJoj/wLprSirBnzSBcf+/vFlV5vhnADmCXwsA=;
 b=J8DDlgKUq3kTCjeVGryDzFGDD7ssZkTAgKEO4KV5omM6TBU9+ARhHL0WVzqe2eV4uZMzMP
 LdcY2OH2nBPZECMVWr7noKZNv7g6NpnKXMC5fYxLrw2eyu1fhdjPSGAJhl60j0zn38LUyP
 F6lEMQiTiiauoeVDukLRZ0TeTAHtOBw=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id E29582C14E;
 Mon,  4 Jul 2022 12:42:18 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  4 Jul 2022 13:42:15 +0100
Message-Id: <20220704124215.17439-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/bpf: Add test for CVE-2022-23222
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

This requires the API patch from the bpf_prog06 submission.

 include/lapi/bpf.h                         |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog07.c | 166 +++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog07.c

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 73e4d12cc..b44ab7d65 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -38,6 +38,7 @@
 #define BPF_OP(code)    ((code) & 0xf0)
 #define		BPF_ADD		0x00
 #define		BPF_SUB		0x10
+#define		BPF_MUL		0x20
 #define		BPF_DIV		0x30
 #define		BPF_LSH		0x60
 #define		BPF_RSH		0x70
diff --git a/runtest/syscalls b/runtest/syscalls
index 770b28137..fbc1f8667 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -44,6 +44,7 @@ bpf_prog03 bpf_prog03
 bpf_prog04 bpf_prog04
 bpf_prog05 bpf_prog05
 bpf_prog06 bpf_prog06
+bpf_prog07 bpf_prog07
 
 brk01 brk01
 brk02 brk02
diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
index 2af9c6ff0..aad90020b 100644
--- a/testcases/kernel/syscalls/bpf/.gitignore
+++ b/testcases/kernel/syscalls/bpf/.gitignore
@@ -5,3 +5,4 @@ bpf_prog03
 bpf_prog04
 bpf_prog05
 bpf_prog06
+bpf_prog07
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog07.c b/testcases/kernel/syscalls/bpf/bpf_prog07.c
new file mode 100644
index 000000000..50ff6eed0
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_prog07.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * The verifier did not properly restrict some *_OR_NULL pointer
+ * types. Including RET_PTR_TO_ALLOC_MEM_OR_NULL which is returned by
+ * ringbuf_reserve. Somehow this means they can be used to perform
+ * arbitrary pointer arithmetic.
+ *
+ * The test tries to do some pointer arithmetic on the return value of
+ * ringbuf_reserve. Possibly with a trick to make the verifier believe
+ * the pointer (in r1) is NULL. The test will pass if the eBPF is
+ * rejected and will fail otherwise.
+ *
+ * This test does not try to cause a crash. Howver it does run the
+ * eBPF if it can. This will result in an instant crash or memory
+ * corruption which may later cause a crash.
+ *
+ * This test is adapted from a full reproducer which can be found here:
+ * https://github.com/tr3ee/CVE-2022-23222
+ *
+ * It's recommended to disable unprivileged eBPF by setting
+ * /proc/sys/kernel/unprivileged_bpf_disabled. Also there is a
+ * specific fix for this issue:
+ *
+ * commit 64620e0a1e712a778095bd35cbb277dc2259281f
+ * Author: Daniel Borkmann <daniel@iogearbox.net>
+ * Date:   Tue Jan 11 14:43:41 2022 +0000
+ *
+ *  bpf: Fix out of bounds access for ringbuf helpers
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_capability.h"
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
+	int ret;
+	const struct bpf_insn prog_insn[] = {
+		// r0 = bpf_ringbuf_reserve(ctx->ringbuf_fd, PAGE_SIZE, 0)
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
+		BPF_MOV64_IMM(BPF_REG_2, getpagesize()),
+		BPF_MOV64_IMM(BPF_REG_3, 0x00),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_reserve),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+
+		// if (r0 != NULL) { ringbuf_discard(r0, 1); exit(2); }
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+		BPF_MOV64_IMM(BPF_REG_2, 1),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_discard),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+
+		// *(sp + 4*r1) = INT32_MAX
+		BPF_ALU64_IMM(BPF_MUL, BPF_REG_1, 8),
+		BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
+		BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_1),
+		BPF_ST_MEM(BPF_DW, BPF_REG_3, 0, INT32_MAX),
+
+		/* exit(0) */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+
+	};
+
+	bpf_init_prog_attr(attr, prog_insn, sizeof(prog_insn), log, BUFSIZE);
+
+	ret = TST_RETRY_FUNC(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)),
+			     TST_RETVAL_GE0);
+
+	if (ret >= 0)
+		return ret;
+
+	if (ret != -1)
+		tst_brk(TBROK, "Invalid bpf() return value: %d", ret);
+
+	if (log[0] != 0)
+		tst_printf("%s\n", log);
+
+	return ret;
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
+	map_fd = bpf_map_create(&(union bpf_attr){
+			.map_type = BPF_MAP_TYPE_RINGBUF,
+			.key_size = 0,
+			.value_size = 0,
+			.max_entries = getpagesize()
+		});
+
+	tst_res(TINFO, "Trying to load eBPF with OOB write");
+	prog_fd = load_prog();
+	if (prog_fd == -1) {
+		tst_res(TPASS, "Failed verification");
+		return;
+	}
+
+	tst_res(TFAIL, "Loaded program with OOB write");
+	tst_res(TINFO, "Running eBPF with OOB");
+	bpf_run_prog(prog_fd, msg, sizeof(MSG));
+	tst_res(TINFO, "Ran eBPF");
+
+	SAFE_CLOSE(prog_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.8",
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		TST_CAP(TST_CAP_DROP, CAP_BPF),
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
+		{"linux-git", "64620e0a1e71"},
+		{"CVE", "CVE-2022-23222"},
+		{}
+	}
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
