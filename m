Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E475C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC4EC3CF435
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:20:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75F403CC2E8
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A5F220B654
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21BAF1F8C5;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+cuinXgHFggqHlQXuAc2GuMGoTKTibR4+SCDobX1qk=;
 b=e5d7NQrukWxb75yM8F9vaCiK76j2jm+pwvGgs8vf15F22vuvrRddDYNrpV8MRNg01Qw3oc
 5KQ6TId2dbFq+5WaOihe0mb9bMhZRu6ipefoTdkJ3rQafnTq0F8tdgFtugDQGY46mmVBmK
 ZcIuKHsD0IWZ3qqda+YBwMsqPKDLQVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+cuinXgHFggqHlQXuAc2GuMGoTKTibR4+SCDobX1qk=;
 b=6vA9hxR2DeJfdfgGytpZdXXZUpv6bxgsWV0gO/y94EbAlvrY/pVbnUUojgx6/atltKdYpN
 DCty/VxmVGhu9NCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e5d7NQru;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6vA9hxR2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+cuinXgHFggqHlQXuAc2GuMGoTKTibR4+SCDobX1qk=;
 b=e5d7NQrukWxb75yM8F9vaCiK76j2jm+pwvGgs8vf15F22vuvrRddDYNrpV8MRNg01Qw3oc
 5KQ6TId2dbFq+5WaOihe0mb9bMhZRu6ipefoTdkJ3rQafnTq0F8tdgFtugDQGY46mmVBmK
 ZcIuKHsD0IWZ3qqda+YBwMsqPKDLQVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+cuinXgHFggqHlQXuAc2GuMGoTKTibR4+SCDobX1qk=;
 b=6vA9hxR2DeJfdfgGytpZdXXZUpv6bxgsWV0gO/y94EbAlvrY/pVbnUUojgx6/atltKdYpN
 DCty/VxmVGhu9NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F30139E0;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SP+2OI2/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:16 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6654;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=A40ZY9XRdAlb1c22HtmyYfLP/zWVcDJtvmVqq+Fjfzo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/4gJ5OMMrJblWO7C8s1JU9fVBrEenztJv4
 iwhHJKon/OJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 RlMXDAC2ZQr4ESX/kO/KkQyQKt9WsjBNC2/jKdCxx0Vv1HZmIbs63bTFOVaJsjQOUBXdWHqI7rg
 RhyyWk5Hb45S+fvHdeV3KaIeWe0/+wnoO8hYpj+nW4gVg0AlFzzQIBejozw+lFQf43IN13iUQow
 e8TUJWCD2CF92D0bOtRt2rvPNqoZzHcGsg7PYWDMrKSdf54H1kf4d00Tq1aIoBBC17KqRW6/3wz
 Yk9hzdI8dWitjExc/lTx5R19EpnyssGHO699j8c0ZY5bw7VC7IUx6c5asK7xESParm6LEZLm+Bj
 isSEw7wqG2HvJk496r3Pi0eEb8ojv06+TXLHCZTByHPvrp8FJFr9L2pmoyNd6bXSe6zNGWdkDhb
 fnpfysPN3CmOCaiFouoXw1l3+URMlBiT/fL2TvEnRs6w+3JtNtDu+MXrSC+oycij4jOFOjCFedt
 kOAxsaZiCO+ymFG1biuuM48DiQED/+qbKaEa0lO91c+LpuNRQfUd6fYHFDWmETMmD3LGI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 21BAF1F8C5
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/11] Add landlock01 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test verifies that landlock_create_ruleset syscall fails with the
right error codes:

- EINVAL Unknown flags, or unknown access, or too small size
- E2BIG size is too big
- EFAULT attr was not a valid address
- ENOMSG Empty accesses (i.e., attr->handled_access_fs is 0)

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/landlock/.gitignore      |  1 +
 testcases/kernel/syscalls/landlock/Makefile        |  7 ++
 testcases/kernel/syscalls/landlock/landlock01.c    | 92 ++++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     | 74 +++++++++++++++++
 5 files changed, 176 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a7cf296a9..d0a9bd14e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -685,6 +685,8 @@ kill11 kill11
 kill12 kill12
 kill13 kill13
 
+landlock01 landlock01
+
 lchown01 lchown01
 lchown01_16 lchown01_16
 lchown02  lchown02
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
new file mode 100644
index 000000000..b69f9b94a
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -0,0 +1 @@
+landlock01
diff --git a/testcases/kernel/syscalls/landlock/Makefile b/testcases/kernel/syscalls/landlock/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
new file mode 100644
index 000000000..0c50b55d8
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that landlock_create_ruleset syscall fails with the right
+ * error codes:
+ *
+ * - EINVAL Unknown flags, or unknown access, or too small size
+ * - E2BIG size is too big
+ * - EFAULT attr was not a valid address
+ * - ENOMSG Empty accesses (i.e., attr->handled_access_fs is 0)
+ */
+
+#include "landlock_common.h"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_ruleset_attr *null_attr;
+static size_t rule_size;
+static size_t rule_small_size;
+static size_t rule_big_size;
+
+static struct tcase {
+	struct landlock_ruleset_attr **attr;
+	uint64_t access_fs;
+	size_t *size;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{&ruleset_attr, -1, &rule_size, 0, EINVAL, "Unknown access"},
+	{&ruleset_attr, 0, &rule_small_size, 0, EINVAL, "Size is too small"},
+	{&ruleset_attr, 0, &rule_size, -1, EINVAL, "Unknown flags"},
+	{&ruleset_attr, 0, &rule_big_size, 0, E2BIG, "Size is too big"},
+	{&null_attr,    0, &rule_size, 0, EFAULT, "Invalid attr address"},
+	{&ruleset_attr, 0, &rule_size, 0, ENOMSG, "Empty accesses"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (*tc->attr)
+		(*tc->attr)->handled_access_fs = tc->access_fs;
+
+	TST_EXP_FAIL(tst_syscall(__NR_landlock_create_ruleset,
+			*tc->attr, *tc->size, tc->flags),
+		tc->exp_errno,
+		"%s",
+		tc->msg);
+
+	if (TST_RET >= 0)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void setup(void)
+{
+	verify_landlock_is_enabled();
+
+	rule_size = sizeof(struct landlock_ruleset_attr);
+
+#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
+	rule_small_size = rule_size - sizeof(uint64_t) - 1;
+#else
+	rule_small_size = rule_size - 1;
+#endif
+
+	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "5.13",
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+};
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
new file mode 100644
index 000000000..66f8fd19a
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LANDLOCK_COMMON_H
+
+#include "tst_test.h"
+#include "lapi/prctl.h"
+#include "lapi/fcntl.h"
+#include "lapi/landlock.h"
+
+static inline void verify_landlock_is_enabled(void)
+{
+	int abi;
+
+	abi = tst_syscall(__NR_landlock_create_ruleset,
+		NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+
+	if (abi < 0) {
+		if (errno == EOPNOTSUPP) {
+			tst_brk(TCONF, "Landlock is currently disabled. "
+				"Please enable it either via CONFIG_LSM or "
+				"'lsm' kernel parameter.");
+		}
+
+		tst_brk(TBROK | TERRNO, "landlock_create_ruleset error");
+	}
+
+	tst_res(TINFO, "Landlock ABI v%d", abi);
+}
+
+static inline void apply_landlock_rule(
+	struct landlock_path_beneath_attr *path_beneath_attr,
+	const int ruleset_fd,
+	const int access,
+	const char *path)
+{
+	path_beneath_attr->allowed_access = access;
+	path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
+
+	SAFE_LANDLOCK_ADD_RULE(
+		ruleset_fd,
+		LANDLOCK_RULE_PATH_BENEATH,
+		path_beneath_attr,
+		0);
+
+	SAFE_CLOSE(path_beneath_attr->parent_fd);
+}
+
+static inline void enforce_ruleset(const int ruleset_fd)
+{
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, 0);
+}
+
+static inline void apply_landlock_layer(
+	struct landlock_ruleset_attr *ruleset_attr,
+	struct landlock_path_beneath_attr *path_beneath_attr,
+	const char *path,
+	const int access)
+{
+	int ruleset_fd;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	apply_landlock_rule(path_beneath_attr, ruleset_fd, access, path);
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
