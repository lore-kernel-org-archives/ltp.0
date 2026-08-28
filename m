Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477EAC61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA9983E5E0E
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:15:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 391C43E9A5E
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A923A60065C
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F1B521F05;
 Fri, 28 Aug 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WhIOlMMsqjzN4f2uB1JJrGgIOpJrvxENa+iFYMsRwU=;
 b=Y4c55ICInAiqBHLycwrP+tNPnLufd7aWLYuG+fbxHKNukYg44fhUhsGdA/S/Nbm4iD+IOw
 gwIQ1LBbhGeQqJPpyYqqS0344INHgfA03j2BasoSPAkUe/rUHabz78VBbRl8Rd+RInbd5A
 gUEZVzCh3ggiY2YgvLn7Ihy+zhg2HWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WhIOlMMsqjzN4f2uB1JJrGgIOpJrvxENa+iFYMsRwU=;
 b=ZfIEwh+m+oELwP05NBpt15IIFZtCTORPZLGxOsOkk5e+DeEbrqFsuskCudfXKTwZxJY5LW
 RDga8grFpsUD9JBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WhIOlMMsqjzN4f2uB1JJrGgIOpJrvxENa+iFYMsRwU=;
 b=VoSrGhO88txGcnNVC3Ge3Z4kd2U41NXYQB1HGDOq0hNvytqnSFhBh21XxPbJDLlHYKBHGB
 48SVgYpkYINyl4iLwnuCdmRUcKRNU2c1g4UKPlZY2qecPqRqtKFA3jRiYhdbQMoQXV5+yx
 SBdVfgswPcqRsUXSgMMqWfTS8rW0u1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WhIOlMMsqjzN4f2uB1JJrGgIOpJrvxENa+iFYMsRwU=;
 b=ZNpjyVje1/mNj98GYFKm6fYowJDF6bZjFX0days7YLHkDeRdC2PVCKE/j4HiWFvbK6c8vP
 zvwAqojslz/mo9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C49A3136E3;
 Fri, 28 Aug 2026 14:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4OZuLiGXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:45 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-11-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=3647;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=dGODLBqGim4JdMcZoElLmS4zp9HAOxPRzgxBPvNsbr8=;
 b=HwrZ8UdYLSWKdk7m4J5ZvOp8ftpJPjLXb7xkUd8lGQtBOJssBlMOGV456IHQ385KFGRJTynBM
 0/nEqZAzaR0BlYomaXiCDiC+VM74O8hh0KvSvg8i4y0enplvxkrDrtA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 11/15] fchroot09: test setns escape from
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
index 000000000..a6bca5085
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
