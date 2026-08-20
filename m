Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA46C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:48:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94E2E3CE682
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:48:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB1883CE782
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 729BA14002DD
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 212E13EF0;
 Thu, 20 Aug 2026 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRtsWp+BNcGp8d4nsmHFQjQNr2/3Xp+/2UEAiGiN5ZE=;
 b=sqVzDm41uWmWy1GNJkmSdogdLlkAB/jp7t59A34I4R9E6+i1Ra4huirnd7jpg1EjF2fysx
 7lBdwn9br/ITWoAMrj5CjPb2v2BPqCm8AurOO0DJw0tkzI4uja1Gdr8w+qUatfYlzDSCaQ
 4glfsXs1O94SPzZQKcH84puPALqz7x0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRtsWp+BNcGp8d4nsmHFQjQNr2/3Xp+/2UEAiGiN5ZE=;
 b=28LciHGp9F/T/IY+l2f0htkTBFFrPAxgAefcUXHvnCKVyibAebMUMT8IjWTJIUeKCZiYMk
 9+0LRwlcK9xGgzCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FSiWLN2O;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZXgbPiDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRtsWp+BNcGp8d4nsmHFQjQNr2/3Xp+/2UEAiGiN5ZE=;
 b=FSiWLN2OaM/hp7DAYQjVON+Cef8R5QIOPg1MXPxdoMTq2TZk43Qgd4QEsFMq9kyLrwGCvw
 HvOn/ISJHOPVECGzDx1DBRGEYp5hqgztAgVTpJ7VFAR/87QbjY+JXWv5qh6vqmgjx48BC/
 s89+C3lhJoBoclBNANHbQkSFc1z5974=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRtsWp+BNcGp8d4nsmHFQjQNr2/3Xp+/2UEAiGiN5ZE=;
 b=ZXgbPiDRBR7dUtt8S5MXgFaw1pVOcSawQyGOvZSb8Ph48nQsyXoWjnciUb+0RoDHx8206C
 RzmhPjVClpDXwbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98D6B3683;
 Thu, 20 Aug 2026 07:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oFw2Im6whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:51 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-11-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=2990;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xER28fWmJQspThM8dl7NAMeJJr3HiAKu18e82cFcAkg=;
 b=Xy2DApm6gULg5jnFdG4k5IBpT7H0ujgIHtHDpXL3M7cihkOD9bC9qS+n8wEy9CB4X6mR/fogp
 9N36kQ9Jwn9DYHK4cRMLTBVYzdnOsWHrpn8tHp9nwvLvkj1hZbP4qqc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 212E13EF0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 11/16] fchroot08: test failfs root fork
 inheritance
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

Verify that the root moved into failfs by fchroot() lives in the
fs_struct which is duplicated on fork, so a child of a process with
the failfs root also fails every absolute path lookup with
EOPNOTSUPP.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot08.c | 69 +++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index b8954bb5a..8dfe95c4a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -7,3 +7,4 @@ fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
 fchroot07 fchroot07
+fchroot08 fchroot08
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index b68069d9a..c099b4b3a 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -5,3 +5,4 @@ fchroot04
 fchroot05
 fchroot06
 fchroot07
+fchroot08
diff --git a/testcases/kernel/syscalls/fchroot/fchroot08.c b/testcases/kernel/syscalls/fchroot/fchroot08.c
new file mode 100644
index 000000000..3efe8d85f
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot08.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that the failfs root is inherited across :manpage:`fork(2)`.
+ *
+ * The root moved into failfs by :manpage:`fchroot(2)` lives in the
+ * fs_struct which is duplicated on fork, so a child of a process with the
+ * failfs root also fails every absolute path lookup with ``EOPNOTSUPP``.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define ABSDIR "abs"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	pid_t pid;
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL2(open(ABSDIR, O_PATH), EOPNOTSUPP,
+			"absolute lookup in a forked child");
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
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
