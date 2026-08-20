Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E06AC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:47:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 818F63CE107
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:47:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCA753CE356
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C412C200250
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26E653EF2;
 Thu, 20 Aug 2026 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChS46TFZYG6EIzGsCmOEJz0Ti3RK28G4/m5aHgUK8eQ=;
 b=nNvQNAQ8lsA9SP8c6EqaR/mXLik8ATawnUupdhZXZWtgIiyqHXo4t0Y6dDgnaSkltgZtFB
 rpKojCfeEah0cL7pTfHZM2gK9/AxeU152jBstnSPQ8oOBdbaABzuixiSTnYorLEPyxZwQr
 bYKWQJX1yoOOxyY6FHT06IT7VHRQCD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChS46TFZYG6EIzGsCmOEJz0Ti3RK28G4/m5aHgUK8eQ=;
 b=neHHC+C3s52DeZRV5tVzcYZK3iQJvHwFOyuDdrYm88s2Cq3sF8c5/CGB3/uNtX4qb8ra4F
 R3w9AwgnaTPdE8Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IFFGYIlv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b+ayt+Xd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChS46TFZYG6EIzGsCmOEJz0Ti3RK28G4/m5aHgUK8eQ=;
 b=IFFGYIlvZ+8DUeORR9ix9hDzTZTKa1T420cRGMMuiZBJc+YUJEpkVjTJqxR7GnK0JFAuHg
 3MRNJ2L8Htb17csYjYiKHgHnq2lIkJIZw5noLwS5lPagYhDsI8RuUPfYUWhjFDr+xG+Ijq
 J9wPvEZ5Ag1wE2PvZcPEhvjDekN2vhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChS46TFZYG6EIzGsCmOEJz0Ti3RK28G4/m5aHgUK8eQ=;
 b=b+ayt+XdZ+Ce9sQpkacGTy//1mbGP2t2ku12T3kI4muaf7oaCufqJ2eGgIc3JvuQkfJXfC
 YyzzL+muWtTcvOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8C6C3684;
 Thu, 20 Aug 2026 07:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBLUMW6whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:52 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-12-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3691;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IfBpVCYc+BUTq916ryWmd/eYSrixxLxDKWAeVldtrGo=;
 b=syw/cM6CO2LWtHyajTvGV8OzOKteo4g48y/OiJJ2slct5XFHNU9ePHpZa0wc4D4p0epESDQiz
 YMiwC7anh4rDoWCiqmo0PhJGcXw6V9yS2SWJ85cBVplDo4uzkQwDgls
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 26E653EF2
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 12/16] fchroot09: test setns escape from
 failfs root
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

Verify that entering failfs with fchroot() is hard to undo: a process
inside counts as chrooted, so the remaining way out is a pre-opened
mount namespace fd. setns() into it resets both the root and the
working directory.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot09.c | 87 +++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 8dfe95c4a..23f6c6a20 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -8,3 +8,4 @@ fchroot05 fchroot05
 fchroot06 fchroot06
 fchroot07 fchroot07
 fchroot08 fchroot08
+fchroot09 fchroot09
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index c099b4b3a..e803fa2b7 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -6,3 +6,4 @@ fchroot05
 fchroot06
 fchroot07
 fchroot08
+fchroot09
diff --git a/testcases/kernel/syscalls/fchroot/fchroot09.c b/testcases/kernel/syscalls/fchroot/fchroot09.c
new file mode 100644
index 000000000..adcc47352
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot09.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`setns(2)` escapes the failfs root.
+ *
+ * Entering failfs with :manpage:`fchroot(2)` is hard to undo: a process
+ * inside counts as chrooted, so :manpage:`chroot(2)` and fchroot() back
+ * out require ``CAP_SYS_CHROOT``. The remaining way out is a pre-opened mount
+ * namespace file descriptor: setns() into it resets both the root and the
+ * working directory.
+ *
+ * Root is required because entering failfs requires ``CAP_SYS_CHROOT`` and
+ * :manpage:`setns(2)` into the mount namespace requires ``CAP_SYS_ADMIN``.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/sched.h"
+#include "lapi/setns.h"
+#include "lapi/syscalls.h"
+
+#define ABSDIR "abs"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	struct stat realroot, realcwd, st;
+	int nsfd;
+
+	SAFE_STAT("/", &realroot);
+	SAFE_STAT(".", &realcwd);
+	nsfd = SAFE_OPEN("/proc/self/ns/mnt", O_RDONLY);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	TST_EXP_FAIL2(open(ABSDIR, O_PATH), EOPNOTSUPP,
+		"absolute lookup after entering failfs");
+
+	TST_EXP_PASS(setns(nsfd, CLONE_NEWNS),
+		"setns() back into the mount namespace");
+
+	SAFE_CLOSE(nsfd);
+
+	SAFE_STAT("/", &st);
+	TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
+		st.st_ino == realroot.st_ino,
+		"root restored after setns()");
+
+	SAFE_STAT(tst_tmpdir_path(), &st);
+	TST_EXP_EXPR(st.st_dev == realcwd.st_dev &&
+		st.st_ino == realcwd.st_ino,
+		"working directory restored after setns()");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+	char abs_path[PATH_MAX];
+
+	tmpdir = tst_tmpdir_path();
+	snprintf(abs_path, sizeof(abs_path), "%s/%s", tmpdir, "target");
+
+	SAFE_TOUCH("target", 0644, NULL);
+	SAFE_SYMLINK(abs_path, ABSDIR);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
