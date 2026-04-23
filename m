Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99158F9935A
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:00:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 463AE3E5393
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:00:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96DF43E5399
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA1881A00980
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 811586A848
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBPY5yGfBEDFdmk+0cFDX1fS02dOAqrMOoEuieuziLk=;
 b=xJVzlDFdcTbgu2cVMgbmkC1aog8gaq9khGxTPRspvxDLzp7m4N8uGpmxF60r5F5QD4ngqO
 dnm5wO9q/nqUwS3ZQJChQgNqbDkj9++m+65IFFB6SuF4DWGX/0jaLhzyy7AKuLoOuXM5sT
 CUAbOXgSalb3+uPvbhLycBx1ybYkItg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBPY5yGfBEDFdmk+0cFDX1fS02dOAqrMOoEuieuziLk=;
 b=ozs6hHE4YmWWDiYmLC+FJ1A2fqzG3jRR66rPrldylOMxjX3sSNER5vAiNeLN8Knxju4kVH
 uBQ0nJt2iG+SNODw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xJVzlDFd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ozs6hHE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBPY5yGfBEDFdmk+0cFDX1fS02dOAqrMOoEuieuziLk=;
 b=xJVzlDFdcTbgu2cVMgbmkC1aog8gaq9khGxTPRspvxDLzp7m4N8uGpmxF60r5F5QD4ngqO
 dnm5wO9q/nqUwS3ZQJChQgNqbDkj9++m+65IFFB6SuF4DWGX/0jaLhzyy7AKuLoOuXM5sT
 CUAbOXgSalb3+uPvbhLycBx1ybYkItg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBPY5yGfBEDFdmk+0cFDX1fS02dOAqrMOoEuieuziLk=;
 b=ozs6hHE4YmWWDiYmLC+FJ1A2fqzG3jRR66rPrldylOMxjX3sSNER5vAiNeLN8Knxju4kVH
 uBQ0nJt2iG+SNODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70E0F593A3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8nmfGjzt6WlzUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:20 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 11:58:31 +0200
Message-ID: <20260423095834.11932-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423095834.11932-1-chrubis@suse.cz>
References: <20260423095834.11932-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 ret_ev.events:url, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 811586A848
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/8] syscall: Add epoll_wait10
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
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait10.c | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 148a4dd0e..06948d8ad 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -197,6 +197,7 @@ epoll_wait05 epoll_wait05
 epoll_wait06 epoll_wait06
 epoll_wait07 epoll_wait07
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
index 000000000..82cd8b15e
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that epoll_wait with EPOLLPRI detects changes to /proc/mounts.
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
+	} else if (!(ret_ev.events & (EPOLLPRI | EPOLLERR))) {
+		tst_res(TFAIL,
+			"after %s: events %x, expected EPOLLPRI or EPOLLERR",
+			desc, ret_ev.events);
+	} else {
+		tst_res(TPASS,
+			"epoll_wait() reported event after %s", desc);
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
