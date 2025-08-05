Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B84C87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:04:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11FEE3C4CD2
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 15:04:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6808F3C4C99
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ADCD06001B0
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 515C51F443;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5c83BHJQPBgeTZ8Ybz8Raa6qjiiO1r8BbHqabkWfg0=;
 b=MtN/ApAo6j4ZykCPGQizWbXBHIazHXvCNuMPMiHax16sXI1E1b47VhD2WuPatR0NC82UEE
 PllF8jcc4fMt+M/n0gGd+Vc8QupVXwaa/Pb3xijB3J6ZffktzXiLBY1azqZu2gYeZK8dQ8
 ikokDR8+mEwH8rq+WkcnBXn519rtJ40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5c83BHJQPBgeTZ8Ybz8Raa6qjiiO1r8BbHqabkWfg0=;
 b=QaOboyrA0X5b6m+nGczKv+cd+gHrBgJnpoSl/jelbc4v0E3e8bt7hneiAkFXoklVUl/ns6
 KZrbKM2H8UpL79Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5c83BHJQPBgeTZ8Ybz8Raa6qjiiO1r8BbHqabkWfg0=;
 b=MtN/ApAo6j4ZykCPGQizWbXBHIazHXvCNuMPMiHax16sXI1E1b47VhD2WuPatR0NC82UEE
 PllF8jcc4fMt+M/n0gGd+Vc8QupVXwaa/Pb3xijB3J6ZffktzXiLBY1azqZu2gYeZK8dQ8
 ikokDR8+mEwH8rq+WkcnBXn519rtJ40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5c83BHJQPBgeTZ8Ybz8Raa6qjiiO1r8BbHqabkWfg0=;
 b=QaOboyrA0X5b6m+nGczKv+cd+gHrBgJnpoSl/jelbc4v0E3e8bt7hneiAkFXoklVUl/ns6
 KZrbKM2H8UpL79Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D4613A9F;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gKeMBRoBkmhpFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 13:03:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 15:03:17 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v4-4-08e23354abc8@suse.com>
References: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754399000; l=6600;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=0mlkdupzx9AdP91jiyPyEMOBNW0bbIeYXovOO+mEiSU=;
 b=CDsylusl6eAbMJIuJQEWIp5WIPkr47HyDp+Oqm2FfCDQGMLFax5uMAPFVO5NKdPtgvfPGZk/O
 Zk13mpa0EjAA7fXOZisQyV/p6tN4yHtsaDtW5IgiKxTcRj+VAwhDSQb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/7] Add file_attr01 test
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

Verify that `file_getattr` and `file_setattr` syscalls are raising the
correct errors according to the invalid input arguments. In particular:

- EBADFD: Invalid file descriptor.
- ENOENT: File doesn't exist
- EFAULT: File name is NULL
- EFAULT: File attributes is NULL
- EINVAL: File attributes size is zero
- E2BIG: File attributes size is too big
- EINVAL: Invalid AT flags

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/file_attr/.gitignore    |   1 +
 testcases/kernel/syscalls/file_attr/Makefile      |   8 +
 testcases/kernel/syscalls/file_attr/file_attr01.c | 178 ++++++++++++++++++++++
 4 files changed, 189 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 6a17a34f8b5fc1289947d4504b7a146f3d022f1c..fed17a38baf0586ec886876b58c04158fa11e8e0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -246,6 +246,8 @@ fallocate06 fallocate06
 fsetxattr01 fsetxattr01
 fsetxattr02 fsetxattr02
 
+file_attr01 file_attr01
+
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
 posix_fadvise01_64                posix_fadvise01_64
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..de06f204d34be482a6401f2a5e7931caa5e3ab12
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -0,0 +1 @@
+file_attr01
diff --git a/testcases/kernel/syscalls/file_attr/Makefile b/testcases/kernel/syscalls/file_attr/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..3b19b0ce6be00839038c405eea027b0102761e45
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/Makefile
@@ -0,0 +1,8 @@
+# Copyright (c) 2025 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
new file mode 100644
index 0000000000000000000000000000000000000000..b1eae6a465ff9f036f3baf8914899729e7933005
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_getattr` and `file_setattr` syscalls are raising the
+ * correct errors according to the invalid input arguments. In particular:
+ *
+ * - EBADFD: Invalid file descriptor.
+ * - ENOENT: File doesn't exist
+ * - EFAULT: File name is NULL
+ * - EFAULT: File attributes is NULL
+ * - EINVAL: File attributes size is zero
+ * - E2BIG: File attributes size is too big
+ * - EINVAL: Invalid AT flags
+ */
+
+#include <string.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include "lapi/fcntl.h"
+
+#define MNTPOINT "mntpoint"
+#define FILENAME "ltp_file"
+#define NO_FILENAME "ltp_file_doesnt_exist"
+
+static int valid_dfd = -1;
+static int invalid_dfd = -1;
+static char *valid_filename;
+static char *invalid_filename;
+static char *null_ptr;
+static size_t zero;
+static size_t small_usize;
+static size_t valid_usize;
+static size_t big_usize;
+static struct file_attr *valid_file_attr;
+
+static struct tcase {
+	int *dfd;
+	char **filename;
+	struct file_attr **ufattr;
+	size_t *usize;
+	int at_flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.dfd = &invalid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.exp_errno = EBADF,
+		.msg = "Invalid file descriptor",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &invalid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.exp_errno = ENOENT,
+		.msg = "File doesn't exist",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &null_ptr,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.exp_errno = EFAULT,
+		.msg = "Filename is NULL",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = (struct file_attr **)(&null_ptr),
+		.usize = &valid_usize,
+		.exp_errno = EFAULT,
+		.msg = "File attributes is NULL",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &zero,
+		.exp_errno = EINVAL,
+		.msg = "File attributes size is zero",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &small_usize,
+		.exp_errno = EINVAL,
+		.msg = "File attributes size is too small",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &big_usize,
+		.exp_errno = E2BIG,
+		.msg = "File attributes size is too big",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.at_flags = -1,
+		.exp_errno = EINVAL,
+		.msg = "Invalid AT flags",
+	},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (tst_variant) {
+		TST_EXP_FAIL(file_getattr(
+			*tc->dfd, *tc->filename,
+			*tc->ufattr, *tc->usize,
+			tc->at_flags),
+			tc->exp_errno,
+			"%s", tc->msg);
+	} else {
+		TST_EXP_FAIL(file_setattr(
+			*tc->dfd, *tc->filename,
+			*tc->ufattr, *tc->usize,
+			tc->at_flags),
+			tc->exp_errno,
+			"%s", tc->msg);
+	}
+}
+
+static void setup(void)
+{
+	valid_dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+
+	SAFE_CHDIR(MNTPOINT);
+	SAFE_TOUCH(FILENAME, 0777, NULL);
+	SAFE_CHDIR("..");
+
+	valid_usize = FILE_ATTR_SIZE_LATEST;
+	small_usize = FILE_ATTR_SIZE_LATEST - 1;
+	big_usize = SAFE_SYSCONF(_SC_PAGESIZE) + 100;
+}
+
+static void cleanup(void)
+{
+	if (valid_dfd != -1)
+		SAFE_CLOSE(valid_dfd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.mntpoint = MNTPOINT,
+	.needs_root = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.test_variants = 2,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		"ntfs",
+		"vfat",
+		"exfat",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&valid_filename, .str = FILENAME},
+		{&invalid_filename, .str = NO_FILENAME},
+		{&valid_file_attr, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
