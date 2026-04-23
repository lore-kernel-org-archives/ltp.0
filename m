Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C4F9937E
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:05:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7810E3E3039
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:05:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BCA23E5393
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 83EDB1A00807
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05F9B5BD73
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFXz+qZFJPupAxeZiS5Egq7xovhC3ftNqCkYB3fx/m0=;
 b=rDO3FIIUD+g99+Xj9Y9jYY8GFqBCrPAhp9ro8rnHUIsLJaHzG7u+Wd+/pS/PW6hxfMBB2z
 3XHo09stJlFgYJgnjsdW/obe2UK1kLBNH5nlazGaLrqNSOivWHkrfxNja0Om0BHuYCmMjZ
 /MBTWRxQKwFrcP3lcRM2WEJKfv6veag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFXz+qZFJPupAxeZiS5Egq7xovhC3ftNqCkYB3fx/m0=;
 b=GzNF/erEjjA81HpxWfEptOchyL3OhkZEHp2R+2vLU29FkMNUdqvuzali71bjKnWMrNo/Rk
 1HBAkp3FQYC1k6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFXz+qZFJPupAxeZiS5Egq7xovhC3ftNqCkYB3fx/m0=;
 b=m+znCgLXKEsVFm7i0HAu0+dU0jvO1zDlF2L7Yain6xZlE3/fQmfU8s1WSbkAoY8SwUe6M7
 KGxSBkWKO6sCM4TCSj9aaFWHvBx1qXXpQvrhmC8EqI4HpJc0QACmpNtIHi5hNVfrxUyv1B
 K0HPOaFEujZG7wkSuusE62hAOsvL0TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFXz+qZFJPupAxeZiS5Egq7xovhC3ftNqCkYB3fx/m0=;
 b=GbMpUscfw3uvQaE6gOuBvyR6WexOaw+f1FWuwXwJ4sQJOjn190l2PN62C2FTMdMMVnVFFR
 eCaV2XJQX9EtmFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4141593B2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E79INnoK6mnAUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:06 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 14:03:06 +0200
Message-ID: <20260423120309.18049-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423120309.18049-1-chrubis@suse.cz>
References: <20260423120309.18049-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] syscalls: Add epoll_wait10
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
index b302935d5..3fd61b814 100644
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
