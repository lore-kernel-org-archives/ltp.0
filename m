Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9D3C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1B73E291E
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:56:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A27D23E5C67
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 11CC31400967
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BA8475DCE;
 Thu,  9 Jul 2026 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80Of4+Cm3l1sULvt8PLDY6dU5ZcZwlFizxSiyJG99Uw=;
 b=tMInf2SayxMvAg/eTV3m+Dlpb+SBvjmmbXVrXxutxa6RjFDYHV3+7jATaXZErhknuiEr6A
 4ddXF3y7xdkd7GtPGjzmgtARM3x4WepK7SuZsRRDK6eGbB7aWj0niAwXUIDj26Hc4KcKt1
 WZQg7g8Ow28RQlULCq4QDSwrcxVXjd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80Of4+Cm3l1sULvt8PLDY6dU5ZcZwlFizxSiyJG99Uw=;
 b=Alb02T9tXAFKfvDOXjJa9repmNz3uQdoFGtWkk7aF0D8mt9pw8q6SWWoWg3SjPWTDY4L0w
 ty3YF0f8rL5YenDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tMInf2Sa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Alb02T9t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80Of4+Cm3l1sULvt8PLDY6dU5ZcZwlFizxSiyJG99Uw=;
 b=tMInf2SayxMvAg/eTV3m+Dlpb+SBvjmmbXVrXxutxa6RjFDYHV3+7jATaXZErhknuiEr6A
 4ddXF3y7xdkd7GtPGjzmgtARM3x4WepK7SuZsRRDK6eGbB7aWj0niAwXUIDj26Hc4KcKt1
 WZQg7g8Ow28RQlULCq4QDSwrcxVXjd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80Of4+Cm3l1sULvt8PLDY6dU5ZcZwlFizxSiyJG99Uw=;
 b=Alb02T9tXAFKfvDOXjJa9repmNz3uQdoFGtWkk7aF0D8mt9pw8q6SWWoWg3SjPWTDY4L0w
 ty3YF0f8rL5YenDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A93A779AC;
 Thu,  9 Jul 2026 08:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SLrPHLJhT2oaHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 08:54:10 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 10:53:49 +0200
Message-ID: <20260709085353.345957-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709085353.345957-1-chrubis@suse.cz>
References: <20260709085353.345957-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8BA8475DCE
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/9] syscalls: Add epoll_wait10
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

Functional test for EPOLLPRI using /proc/mounts that produces POLLPRI
when a filesystem is mounted/umounted.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait10.c | 103 ++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b78d565fb..08b31c9f5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -198,6 +198,7 @@ epoll_wait06 epoll_wait06
 epoll_wait07 epoll_wait07
 epoll_wait08 epoll_wait08
 epoll_wait09 epoll_wait09
+epoll_wait10 epoll_wait10
 
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
index f32ec535b..30139375d 100644
--- a/testcases/kernel/syscalls/epoll_wait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -7,3 +7,4 @@ epoll_wait06
 epoll_wait07
 epoll_wait08
 epoll_wait09
+epoll_wait10
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
new file mode 100644
index 000000000..fbc3c2ce8
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that :manpage:epoll_wait() with EPOLLPRI detects changes to
+ * /proc/mounts.
+ *
+ * The kernel generates a poll notification (POLLPRI/EPOLLERR) on
+ * /proc/mounts whenever the mount namespace changes. This test verifies
+ * that epoll can observe these notifications.
+ *
+ * [Algorithm]
+ *
+ * - Open /proc/mounts and register it with an epoll instance for EPOLLPRI.
+ * - Fork a child that mounts and then unmounts a tmpfs filesystem, using
+ *   checkpoints to synchronize with the parent.
+ * - After each mount namespace change the parent calls epoll_wait and verifies
+ *   it returns an event.
+ *
+ * Needs root to call mount/umount.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_epoll.h"
+
+#define MNTPOINT "mnt_epoll"
+
+static int efd = -1, mnt_fd = -1;
+
+static void setup(void)
+{
+	SAFE_MKDIR(MNTPOINT, 0777);
+
+	mnt_fd = SAFE_OPEN("/proc/mounts", O_RDONLY);
+
+	efd = SAFE_EPOLL_CREATE1(0);
+
+	struct epoll_event ev = {
+		.events = EPOLLPRI,
+		.data.fd = mnt_fd,
+	};
+
+	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, mnt_fd, &ev);
+}
+
+static void check_epoll_event(const char *desc)
+{
+	struct epoll_event ret_ev;
+	char buf[1024];
+
+	TEST(epoll_wait(efd, &ret_ev, 1, 1000));
+	if (TST_RET < 1) {
+		tst_res(TFAIL | TTERRNO,
+			"epoll_wait() after %s returned %li", desc, TST_RET);
+	} else {
+		TST_EXP_EXPR(ret_ev.events & EPOLLPRI);
+	}
+
+	/* Re-read /proc/self/mounts to clear the notification */
+	SAFE_LSEEK(mnt_fd, 0, SEEK_SET);
+	while (SAFE_READ(0, mnt_fd, buf, sizeof(buf)) > 0)
+		;
+}
+
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		SAFE_MOUNT("none", MNTPOINT, "tmpfs", 0, NULL);
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+		SAFE_UMOUNT(MNTPOINT);
+		TST_CHECKPOINT_WAKE(0);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+	check_epoll_event("mount");
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+	check_epoll_event("umount");
+}
+
+static void cleanup(void)
+{
+	if (efd != -1)
+		SAFE_CLOSE(efd);
+
+	if (mnt_fd != -1)
+		SAFE_CLOSE(mnt_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
