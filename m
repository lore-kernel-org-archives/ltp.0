Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACACC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:48:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34E4D3CE11E
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:48:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C98F3CE420
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BB6F6000F5
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DECD43EEF;
 Thu, 20 Aug 2026 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg5Z2jBhOjgvCcV+R/Bf8V1j8V4EXWNH2H6Ysn4inHo=;
 b=LMmXqplPwMlA69K6TGxAU3xm4rWeChX+PrqLNQvcQFRs12XPUj/ioCthZZc3+6p+e8ZJtU
 bxYIjxWvuGQ9X3xozASLJrrkC8vvuWIVxdpQpFIRfSL3HQQgRpBni/yzVGDRHClpDXJHjl
 fmhN7ZLOBtUo/DtpJguEGHlwHdrn2WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg5Z2jBhOjgvCcV+R/Bf8V1j8V4EXWNH2H6Ysn4inHo=;
 b=+0otSvnsH8v6WCiH4D4VT33Qoc2maLP8lKcG4JGQmlkKpE4n7PDmJ8+73Rfi2cp9L7UWDz
 ofiFh3ZnBG02daDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vntkLBUx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nZ00tjxZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg5Z2jBhOjgvCcV+R/Bf8V1j8V4EXWNH2H6Ysn4inHo=;
 b=vntkLBUx6xPGVCODtwISi/7fruWYuQdmcLuegrs4zbC8SKbfHzDvTboAUywt62NevmqXKG
 cT+Pq4KaQJGWyCeSZCzsD0j06p5cYk6l7fHvE9WtWqSEDTL4wl+ofSmb0/9e/1ChGCtprd
 ydiBi1Ljc1RdsmfAedUAxqFn7fYT01w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg5Z2jBhOjgvCcV+R/Bf8V1j8V4EXWNH2H6Ysn4inHo=;
 b=nZ00tjxZDy5PTEbB7COhVb97XoBoY/Z4WtHPPgtO3/UV8OpuIIt/7UUU3z2XfQ94IlbVVJ
 M5Tik+ddmz222KAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 570493682;
 Thu, 20 Aug 2026 07:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMImEm6whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:50 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-10-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3239;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=RqJY9SIz8u42KPQ0xDULfzQH8SSBeNjWRr5Xb3Gq9FA=;
 b=rrwLIiM4k96VpjbdOgTAetiYz+WUtulGfrN6VY8154u4TWlLAiYL3XitWfxjD4ta4IvOGf7GJ
 LGS/r3QpICyCfM7wXKibhUqATaOlqZuecEmMlJnGI0uUfC18eLjq6n/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DECD43EEF
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 10/16] fchroot07: test execve blocked by
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

Verify that after fchroot() moved the root into failfs, loading a
binary by absolute path fails with EOPNOTSUPP. The exec runs in a
grandchild so a wrongly successful exec is still detected through
the exit code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot07.c | 72 +++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 8b6b1ecd9..b8954bb5a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -6,3 +6,4 @@ fchroot03 fchroot03
 fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
+fchroot07 fchroot07
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 12151270a..b68069d9a 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -4,3 +4,4 @@ fchroot03
 fchroot04
 fchroot05
 fchroot06
+fchroot07
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
new file mode 100644
index 000000000..d5ebfc576
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`execve(2)` is blocked under the failfs root.
+ *
+ * After :manpage:`fchroot(2)` moved the process root into failfs, loading
+ * a binary by absolute path fails with ``EOPNOTSUPP``.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * The exec runs in a grandchild: a wrongly successful exec would replace
+ * the test image, so the outcome can only be reported when the exec call
+ * returns, and the grandchild exit code tells the parent whether the
+ * image was replaced.
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+/* Marker exit code proving the grandchild image was not replaced. */
+#define EXEC_NOT_REPLACED 42
+
+static void check_exec_blocked(void)
+{
+	pid_t pid = SAFE_FORK();
+	int status;
+
+	if (!pid) {
+		TST_EXP_FAIL(execl("/bin/true", "true", NULL), EOPNOTSUPP,
+			"absolute exec blocked by the failfs root");
+
+		exit(EXEC_NOT_REPLACED);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != EXEC_NOT_REPLACED)
+		tst_res(TFAIL, "exec replaced the test image");
+}
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	check_exec_blocked();
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	if (access("/bin/true", X_OK))
+		tst_brk(TCONF | TERRNO, "/bin/true is not available");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
