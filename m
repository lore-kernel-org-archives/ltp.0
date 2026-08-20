Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB4C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:47:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24C983C1E1C
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:47:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17FF03CE782
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85756600157
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 443D43EF3;
 Thu, 20 Aug 2026 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XsK/M68ki2c9QfX3Ku6Lv80iJFfWxHof8WouLPuITY=;
 b=tqTmbDAlF5QmkHGye9dpAlsgHdyVe+3FZDq4rHLwN5oR8rLFc5en3A1dlF5nM4cCslF4DZ
 dqjQmmCGlszoR747xtOPIMB0EscezT4F3S9vVH6tTVMu7Q/Cnn5sBE3QadAmwQfcui9cS5
 O4SP+gULJXiJxP4AIq7Fzu5A2RkMaEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XsK/M68ki2c9QfX3Ku6Lv80iJFfWxHof8WouLPuITY=;
 b=YU4e77HeoJomfWAH49oNA/iCzLCeypuAx3OF/7JaXJNsYa8w3/1eZLyGU8hCGlo+HEg1Kt
 rFxPzgPguGSL1bBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XsK/M68ki2c9QfX3Ku6Lv80iJFfWxHof8WouLPuITY=;
 b=Y1WEMotH7WtyPS7wNbhXJD4AQZlEhvA/rTPtuvBovS08C81CnGfPKcGrEguNxQq2nlHK8a
 5FI9WF7AmgUQiHq8tWSY6cK1Br+yeHXzVs4y+rFfj9Fvd2QemWS1ubTJ7cV96q1jkEafGH
 NuOmybNmcei4IKxZsJtAwQB/e2inzaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XsK/M68ki2c9QfX3Ku6Lv80iJFfWxHof8WouLPuITY=;
 b=yzEkWqrJSMaH6i1FakfbNbs4L/oXxzrjURNI15iQ5j8FyiAQq0dbhp+Gv1uESc9NChrjHY
 GV+W260S8asUdeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 659EB3687;
 Thu, 20 Aug 2026 07:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aEu5FW+whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:54 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-14-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3299;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Gtd8m+OIBggB5iBKvdxycMw0u9ZFPBiXjmOemxhZC6c=;
 b=NYL6wCqcQ68gJfI8z8h53sG+UyIOS3TAVnuy7TiutCi9xf3fiaJuxXOHPnNBj65sI33Cf0eoz
 RlNZwBtJFG4BzCic494hBAPE/x+TpxiYt5xM+ZiOgdLWBFgEBtq28kI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 14/16] fchroot11: test failfs entry with
 no_new_privs
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

Verify that an unprivileged process may enter failfs when it
committed to no_new_privs, since setuid binaries then pose no
confused deputy risk anymore. The test also verifies that a process
which entered failfs counts as chrooted: it can no longer create a
user namespace with unshare() to regain CAP_SYS_CHROOT.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot11.c | 70 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 9ec2a7897..137e3f99a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -10,3 +10,4 @@ fchroot07 fchroot07
 fchroot08 fchroot08
 fchroot09 fchroot09
 fchroot10 fchroot10
+fchroot11 fchroot11
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 570da2b98..0eca20548 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -8,3 +8,4 @@ fchroot07
 fchroot08
 fchroot09
 fchroot10
+fchroot11
diff --git a/testcases/kernel/syscalls/fchroot/fchroot11.c b/testcases/kernel/syscalls/fchroot/fchroot11.c
new file mode 100644
index 000000000..85401e5fe
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot11.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test unprivileged :manpage:`fchroot(2)` into failfs with no_new_privs
+ * set.
+ *
+ * An unprivileged process may enter failfs when it committed to
+ * no_new_privs, since setuid binaries then pose no confused deputy risk
+ * anymore. The test also verifies that a process which entered failfs
+ * counts as chrooted: it can no longer create a user namespace with
+ * :manpage:`unshare(2)` to regain ``CAP_SYS_CHROOT``.
+ *
+ * The user namespace check requires ``CONFIG_USER_NS``, which is enforced
+ * with ``.needs_kconfigs``.
+ *
+ * Root is required to drop to an unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <pwd.h>
+#include <sched.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/sched.h"
+#include "lapi/syscalls.h"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"unprivileged fchroot() with no_new_privs");
+
+	TST_EXP_FAIL2(open("/etc/passwd", O_RDONLY), EOPNOTSUPP,
+		"absolute lookup after entering failfs");
+
+	TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
+		"user namespace creation blocked by the failfs root");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		NULL,
+	}
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
