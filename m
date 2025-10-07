Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CEDCCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:49:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9856D3CE321
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:49:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F152E3CE32E
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B808200979
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4917222B9A;
 Tue,  7 Oct 2025 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CmuVbbEQ4JiKo4Lb0tYMBPvzmR1CtKSs4YMVA380d0=;
 b=iPd1wraEyAE2By+VfwjvPg/2RM2R+A0HsEA8VpXF2YWFCXp3kXpKHM8dX3q9sk6B98RPni
 N0MidxWQtdT7RfbrBGLanQiCGSBom5uy92Mw0xkedGMH/msM4uN1r4D2xAtEyxFBSsXHIs
 uADE9A9rIQuUBM0Y0y4mBZxLoDjvAIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CmuVbbEQ4JiKo4Lb0tYMBPvzmR1CtKSs4YMVA380d0=;
 b=h3SeREKJirl39Gd1gtAh5/chELofr9XB5gXFDRnd68blPVpMFJQ3NXlVtWW3Rj4Wk7CHRc
 80Jlw3BQ7oPjeYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CmuVbbEQ4JiKo4Lb0tYMBPvzmR1CtKSs4YMVA380d0=;
 b=iPd1wraEyAE2By+VfwjvPg/2RM2R+A0HsEA8VpXF2YWFCXp3kXpKHM8dX3q9sk6B98RPni
 N0MidxWQtdT7RfbrBGLanQiCGSBom5uy92Mw0xkedGMH/msM4uN1r4D2xAtEyxFBSsXHIs
 uADE9A9rIQuUBM0Y0y4mBZxLoDjvAIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CmuVbbEQ4JiKo4Lb0tYMBPvzmR1CtKSs4YMVA380d0=;
 b=h3SeREKJirl39Gd1gtAh5/chELofr9XB5gXFDRnd68blPVpMFJQ3NXlVtWW3Rj4Wk7CHRc
 80Jlw3BQ7oPjeYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9185913AAC;
 Tue,  7 Oct 2025 06:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qKrGGHS35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:47:01 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-9-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=5071;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=xIPpk6YGKbWopjs6IlAEM0eg2ApJqHMc4eGpzbWnvsI=;
 b=OJg0JdYXDrG0okRx0nNBJt1nS9A6UNCtiK3ozWb7qdKWWPGAS901WKtpxffujADAsw2JASORB
 nSGmzNpYJC1BKQp+lkd19stSPclISMAqtLfQMwwHFRE4QX1KVfooDR0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/10] Add setxattrat01 test
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
 .../kernel/syscalls/setxattrat/setxattrat01.c      | 150 +++++++++++++++++++++
 3 files changed, 159 insertions(+)

diff --git a/testcases/kernel/syscalls/setxattrat/.gitignore b/testcases/kernel/syscalls/setxattrat/.gitignore
new file mode 100644
index 000000000..e636401d7
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/.gitignore
@@ -0,0 +1 @@
+setxattrat01
diff --git a/testcases/kernel/syscalls/setxattrat/Makefile b/testcases/kernel/syscalls/setxattrat/Makefile
new file mode 100644
index 000000000..e582f727d
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
index 000000000..86ad7503f
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/setxattrat01.c
@@ -0,0 +1,150 @@
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
+#include "tst_test.h"
+#include "lapi/xattr.h"
+
+#include <sys/xattr.h>
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
+	args->value = (uint64_t)buff;
+	args->size = XATTR_TEST_VALUE_SIZE;
+
+	ret = SAFE_GETXATTRAT(tmpdir_fd, fname, AT_SYMLINK_NOFOLLOW,
+		XATTR_TEST_KEY, args, sizeof(*args));
+
+	TST_EXP_EQ_LI(ret, XATTR_TEST_VALUE_SIZE);
+	TST_EXP_EQ_LI(args->size, XATTR_TEST_VALUE_SIZE);
+	TST_EXP_EQ_LI(args->flags, 0);
+	TST_EXP_EQ_STRN((char *)args->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE);
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
+	args->value = (uint64_t)buff;
+	args->size = 0;
+
+	TST_EXP_FAIL(tst_syscall(__NR_getxattrat, tmpdir_fd, fname,
+		AT_SYMLINK_NOFOLLOW, XATTR_TEST_KEY, args, sizeof(*args)),
+		ENODATA);
+
+	TST_EXP_EQ_LI(args->size, 0);
+	TST_EXP_EQ_LI(args->flags, 0);
+	TST_EXP_EQ_STRN((char *)args->value, "\0", 1);
+}
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	args->value = (uint64_t)XATTR_TEST_VALUE;
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
