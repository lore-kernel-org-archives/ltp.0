Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB88C624A5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0653F3E947F
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:03:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECEE73E9479
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5167D1400B6B
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02FAB1FB2B;
 Mon, 31 Aug 2026 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p1eMnuMX0qFow3FQkJa+7m1RrJgMCuBW5Cno6Dkc7E=;
 b=s/2RlaP8bF2rJsYglO6Tw/GjdGufswxdm8G026fage1PagleIQ9NNVkZCT49oyTX1izjll
 XYOt8gIAtXAMBGdTff7xewwp9DY3A+Zxb09MM+5MDe0UwAvsGGSBh4bONzAeBXqDx0pCiO
 sqtdtHUoZ8QPvTcGoWPaU3jxNSsNg2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p1eMnuMX0qFow3FQkJa+7m1RrJgMCuBW5Cno6Dkc7E=;
 b=1wd0ZpmAMRu6YEDKMY4HZTkgZvg0+uFzdVvYvwpaG37QVtl7ITeDnK0yopG4sp9RUaavMp
 pPEJE+K+nRXm7zDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ok8+wvZH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GOYE9+EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p1eMnuMX0qFow3FQkJa+7m1RrJgMCuBW5Cno6Dkc7E=;
 b=Ok8+wvZHJTqT1Nq+4972uMXNgEnnZUqouUqoGkUVioCy9nqK9q9rSeHN0YmINArh1jPcFa
 1DgAdaoxApcLTTLcGsuEaZS4sOZ3EZ8TjL4fkNpFLYe3m9sGND+jUg00kaHEm9U9Bk2AFT
 Kr43RrInD4y3yGSGUmhMggosFzOVbeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p1eMnuMX0qFow3FQkJa+7m1RrJgMCuBW5Cno6Dkc7E=;
 b=GOYE9+ECuC4IRO3aemjFBppHFNPPb8EL/m9MaHCiblS4tRo30MnP4AUJQcN1P0SLZOJ1Kh
 MOD/PXGi2Br5YNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7B55137DB;
 Mon, 31 Aug 2026 08:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kIBKJ4c0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:13 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-12-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3671;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=HuatMma88Vb7vu+agin3BZOXdLM9qN5ADvRtFgPEFj4=;
 b=KJMJI8e9C/Ty6EWo37l5e9QKqUsUC89CRps1ModnarmkiZDiiLhSnsdt6mwjs900QHygQvInQ
 Cz8keumIoJmBnTWu98oBmGpdgpB4j7s+Mqnrk5J8piJ84auNUskSgDx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 02FAB1FB2B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 12/16] fchroot09: test setns escape from
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
 testcases/kernel/syscalls/fchroot/fchroot09.c | 86 +++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

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
index 0a2510d8a..b577da61f 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -7,3 +7,4 @@ fchroot06
 fchroot07
 fchroot07_child
 fchroot08
+fchroot09
diff --git a/testcases/kernel/syscalls/fchroot/fchroot09.c b/testcases/kernel/syscalls/fchroot/fchroot09.c
new file mode 100644
index 000000000..bc9324ceb
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot09.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`setns(2)` escapes the failfs root.
+ *
+ * Entering failfs with :manpage:`fchroot(2)` is hard to undo: a process
+ * inside counts as chrooted, so :manpage:`chroot(2)` and :manpage:`fchroot(2)`
+ * back out require ``CAP_SYS_CHROOT``. The remaining way out is a pre-opened
+ * mount namespace file descriptor: :manpage:`setns(2)` into it resets both the
+ * root and the working directory.
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
+	struct stat realroot, st;
+	int nsfd;
+
+	SAFE_STAT("/", &realroot);
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
+	SAFE_STAT(".", &st);
+	TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
+		st.st_ino == realroot.st_ino,
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
