Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E27C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9AFD3C9592
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 12:42:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09DDC3C0F3F
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 12:42:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 28B796009FF
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 12:42:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A130221C91;
 Thu, 23 Jun 2022 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655980952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Py1aWWbpS6dOjlpMNQE4H4wkv8FW36AB4KKR6GrTqV0=;
 b=XHb0f34qOh8V8KAXGXz0IShTqIP8yw8oMHQjAigR07kbx1ryx9lfYyEe03ggB9hmhUr7lB
 D73IT5xTTt7GuhqwgkNqJB2c2arjFtdsR2rgApmnax5B4/tQ1eNxFRuWoqCNgFsitN+IV2
 Q9yqyKGchsUlLlOnuzVZ7Lk05E/xCoQ=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id 64D2D2C142;
 Thu, 23 Jun 2022 10:42:32 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 23 Jun 2022 11:42:24 +0100
Message-Id: <20220623104224.18751-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623104224.18751-1-rpalethorpe@suse.com>
References: <20220623104224.18751-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/bpf: Add test for CVE-2021-4204
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

Fixes: #944

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_prog06.c | 158 +++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 36fc50aeb..770b28137 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -43,6 +43,7 @@ bpf_prog02 bpf_prog02
 bpf_prog03 bpf_prog03
 bpf_prog04 bpf_prog04
 bpf_prog05 bpf_prog05
+bpf_prog06 bpf_prog06
 
 brk01 brk01
 brk02 brk02
diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
index 42365cef5..2af9c6ff0 100644
--- a/testcases/kernel/syscalls/bpf/.gitignore
+++ b/testcases/kernel/syscalls/bpf/.gitignore
@@ -4,3 +4,4 @@ bpf_prog02
 bpf_prog03
 bpf_prog04
 bpf_prog05
+bpf_prog06
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog06.c b/testcases/kernel/syscalls/bpf/bpf_prog06.c
new file mode 100644
index 000000000..c38dd8239
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_prog06.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * ringbuf_submit takes a pointer to a ringbuf record, but not the
+ * size of this record. The verifier only validates offset ptrs[1] passed
+ * to functions if the function has a size parameter. So we can
+ * perform a wide range of ptr arithmetic on this record ptr.
+ *
+ * ringbuf_submit updates some data (i.e. the length) in the
+ * ringbuf header which is calculated from the record ptr. So this can
+ * be used to corrupt memory.
+ *
+ * This test does not try to cause a crash. Howver it does run the
+ * eBPF if it can. This will result in an instant crash or memory
+ * corruption which may later cause a crash.
+ *
+ * This test is adapted from a full reproducer which can be found here:
+ * https://github.com/tr3ee/CVE-2021-4204
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
+ *
+ * [1]: Depending on the ptr/reg type
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
+		// r0 = bpf_ringbuf_reserve(ctx->ringbuf_fd, 0xff0, 0)
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0xff0),
+		BPF_MOV64_IMM(BPF_REG_3, 0x00),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_reserve),
+
+		// if (r0 == NULL) exit(2)
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+
+		// r0 = BPF_FUNC_ringbuf_submit(r0-(0x3008-0x38), BPF_RB_NO_WAKEUP)
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, (0x3008-0x38)),
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+		BPF_MOV64_IMM(BPF_REG_2, 1),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_submit),
+
+		/* exit(0) */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
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
+		{"CVE", "CVE-2021-4204"},
+		{}
+	}
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
