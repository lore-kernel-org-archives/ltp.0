Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3514BC02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:11:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B50EC3C2C8E
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:11:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F9F23C2C92
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:31 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9406A6331F5
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3884B1F399
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibng+SiPqvR5UMiHPRGVe5CHELIcOYrZUOzeVrwGECQ=;
 b=L8G/WflHqkkuWD0GOCavrgpkWC6wVSe+QbXDZxIpi1Us6JghAZxgEmhQBOU0VUI6GHYj6U
 rpBtLp5XPMyKQss2Pm7xuNLgKrieMVyFirqo8dpCYsYpuveU82lSk7GUyB4BNNJMLqFNSc
 VWiy0VSMj93ATI93VXZ2VciC/YgeiYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibng+SiPqvR5UMiHPRGVe5CHELIcOYrZUOzeVrwGECQ=;
 b=nc8fOJ4d/H6Qmb5/4OpZSCuoSk1HSAN2VsdB3biO9L3aLvZzRqAFX41+AYKFwPQzJvRqcu
 xwcYx8IgjTONeiDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibng+SiPqvR5UMiHPRGVe5CHELIcOYrZUOzeVrwGECQ=;
 b=L8G/WflHqkkuWD0GOCavrgpkWC6wVSe+QbXDZxIpi1Us6JghAZxgEmhQBOU0VUI6GHYj6U
 rpBtLp5XPMyKQss2Pm7xuNLgKrieMVyFirqo8dpCYsYpuveU82lSk7GUyB4BNNJMLqFNSc
 VWiy0VSMj93ATI93VXZ2VciC/YgeiYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibng+SiPqvR5UMiHPRGVe5CHELIcOYrZUOzeVrwGECQ=;
 b=nc8fOJ4d/H6Qmb5/4OpZSCuoSk1HSAN2VsdB3biO9L3aLvZzRqAFX41+AYKFwPQzJvRqcu
 xwcYx8IgjTONeiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BE9F137DB
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yA/TBFyTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:25 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-7-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=5237;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=9lbk4/K0HL3uop3QPAv0Ox9745jofOUuEHG1Dc/j2L4=;
 b=r3s67ZYoIiWWo0qu5vt4qDDKXlPoVZ5cbK0dlINtd0bhV0nR8zIiM0Imk5DPOJ2g86ekMvhzU
 SwCTQmDqNBmBpBLohYFt8z2tYtgrfWZ/jOJFGzx8ZF94dkqw6/Yqmcy
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/8] Add setxattrat01 test
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

Test if setxattrat() syscall is correctly following symlink, setting
a xattr on a file.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setxattrat/.gitignore    |   1 +
 testcases/kernel/syscalls/setxattrat/Makefile      |   8 ++
 .../kernel/syscalls/setxattrat/setxattrat01.c      | 151 +++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/testcases/kernel/syscalls/setxattrat/.gitignore b/testcases/kernel/syscalls/setxattrat/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..e636401d7ac3ed58c5f9a24ad31291f0dc1c9ae7
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/.gitignore
@@ -0,0 +1 @@
+setxattrat01
diff --git a/testcases/kernel/syscalls/setxattrat/Makefile b/testcases/kernel/syscalls/setxattrat/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..e582f727dd8719bf51685070d1e4a4c5f5fac61f
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2025 SUSE LLC
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/setxattrat/setxattrat01.c b/testcases/kernel/syscalls/setxattrat/setxattrat01.c
new file mode 100644
index 0000000000000000000000000000000000000000..ef0ab2b1137e800b2edee85bd42bdf6d34fe0adc
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/setxattrat01.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if setxattrat() syscall is correctly following symlink, setting a
+ * xattr on a file.
+ *
+ * [Algorithm]
+ *
+ * - create a file and the symlink pointing to it
+ * - run setxattrat() on the symlink following the pointing file
+ * - verify that file xattr has been set
+ * - verify that symlink xattr has not been set
+ * - run setxattrat() on the symlink with AT_SYMLINK_NOFOLLOW
+ * - verify that file xattr has not been set
+ * - verify that symlink xattr has been set
+ */
+
+#include <sys/xattr.h>
+
+#include "tst_test.h"
+#include "lapi/xattr.h"
+#include "lapi/fcntl.h"
+
+#define FNAME "ltp_file"
+#define SNAME "ltp_symbolic_file"
+#define XATTR_TEST_KEY "trusted.ltptestkey"
+#define XATTR_TEST_VALUE "ltprulez"
+#define XATTR_TEST_VALUE_SIZE 8
+
+static struct xattr_args *args;
+static int tmpdir_fd = -1;
+
+static struct tcase {
+	char *dst_set;
+	char *dst_noset;
+	int at_flags;
+} tcases[] = {
+	{
+		.dst_set = FNAME,
+		.dst_noset = SNAME,
+		.at_flags = 0,
+	},
+	{
+		.dst_set = SNAME,
+		.dst_noset = FNAME,
+		.at_flags = AT_SYMLINK_NOFOLLOW,
+	}
+};
+
+static void expect_xattr(const char *fname)
+{
+	int ret;
+	char buff[XATTR_TEST_VALUE_SIZE];
+
+	tst_res(TINFO, "Check if %s has xattr", fname);
+
+	memset(args, 0, sizeof(*args));
+	memset(buff, 0, XATTR_TEST_VALUE_SIZE);
+
+	args->value = buff;
+	args->size = XATTR_TEST_VALUE_SIZE;
+
+	ret = SAFE_GETXATTRAT(tmpdir_fd, fname, AT_SYMLINK_NOFOLLOW,
+		XATTR_TEST_KEY, args, sizeof(*args));
+
+	TST_EXP_EQ_LI(ret, XATTR_TEST_VALUE_SIZE);
+	TST_EXP_EQ_LI(args->size, XATTR_TEST_VALUE_SIZE);
+	TST_EXP_EQ_LI(args->flags, 0);
+	TST_EXP_EQ_STRN(args->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE);
+}
+
+static void expect_no_xattr(const char *fname)
+{
+	char buff[XATTR_TEST_VALUE_SIZE];
+
+	tst_res(TINFO, "Check if %s has no xattr", fname);
+
+	memset(args, 0, sizeof(*args));
+	memset(buff, 0, XATTR_TEST_VALUE_SIZE);
+
+	args->value = buff;
+	args->size = 0;
+
+	TST_EXP_FAIL(tst_syscall(__NR_getxattrat, tmpdir_fd, fname,
+		AT_SYMLINK_NOFOLLOW, XATTR_TEST_KEY, args, sizeof(*args)),
+		ENODATA);
+
+	TST_EXP_EQ_LI(args->size, 0);
+	TST_EXP_EQ_LI(args->flags, 0);
+	TST_EXP_EQ_STRN(args->value, "\0", 1);
+}
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	args->value = XATTR_TEST_VALUE;
+	args->size = XATTR_TEST_VALUE_SIZE;
+	args->flags = XATTR_CREATE;
+
+	tst_res(TINFO, "Setting xattr '%s' in %s (flags=%s)",
+		XATTR_TEST_KEY, SNAME,
+		!tc->at_flags ? "0" : "AT_SYMLINK_NOFOLLOW");
+
+	SAFE_SETXATTRAT(tmpdir_fd, SNAME, tc->at_flags, XATTR_TEST_KEY,
+		 args, sizeof(*args));
+
+	expect_xattr(tc->dst_set);
+	expect_no_xattr(tc->dst_noset);
+
+	SAFE_REMOVEXATTRAT(tmpdir_fd, tc->dst_set, tc->at_flags,
+		XATTR_TEST_KEY);
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+
+	tmpdir = tst_tmpdir_path();
+	tmpdir_fd = SAFE_OPEN(tmpdir, O_DIRECTORY);
+
+	SAFE_TOUCH(FNAME, 0777, NULL);
+	SAFE_SYMLINK(FNAME, SNAME);
+}
+
+static void cleanup(void)
+{
+	if (tmpdir_fd != -1)
+		SAFE_CLOSE(tmpdir_fd);
+
+	SAFE_UNLINK(SNAME);
+	SAFE_UNLINK(FNAME);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(struct xattr_args)},
+		{},
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
