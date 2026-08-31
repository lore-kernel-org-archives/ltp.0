Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17620C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:03:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 536D03E5A95
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:03:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C062B3E5ABF
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB95E1400B6A
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BAFE8223CD;
 Mon, 31 Aug 2026 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=BC9yUWjoIWBIe0PIUj2Xv+r5WuoPMPv5RwVhWrL9+13/5cl2TthXUmo7FckAqBm/EDRG6W
 kRi6xWNtZlvvwhOq8FhTm7Xg5sFsYa78uQ8LO+vayP9a/B+WVUFHqBlDcU90pq3ytY50HL
 TlWsMwc5FvZRssnZp7oiaeMdGkQXfaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=G2ue2YYJgBM8XvcDe6V3fK2L4QtVhH1KxPAikqh1XLyeurBBCvs9/2RMTJjzxVH8Jxtccj
 jF5pF/Wo2veE9RCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=UeEnxYcFG3zlMHSu2fe7ZFKoGScSc4Y/wHhCsX2DPlJMs4vmsmJ+MvZADuj4YYD2dk4Kvi
 tycenQMdBGB20rLhidxF4x99wLvIgaHMSOiyojX86Vwt7KPuTswk4RLhONu13z30smR4K1
 5dNfSVBhoNGdza4j0JeVF8tQjjbAW48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB2pBwTaCtXSs7CqfiOApGe4ewPJUGu2VS5fbwZIMWE=;
 b=ENMqDjZUdnEd/7AizAaRnWDOR5B2ihYZjsJD6XXffQ6HW3bawRxlZ1CIC69Ba8Yzxfr3wR
 39Lh8MgMeqHvXODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C6913736;
 Mon, 31 Aug 2026 08:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2N+iBIc0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:09 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-8-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3641;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=tbK0jKt/233h5y5TPGqUeJEBmJ0+2HPHBhbZjrLEL7E=;
 b=u2XeZpyF4l5qkDldfpZySLlO+CNOucVE62EDtozZysexsbgnqTe6pJBC6JeRmTcPOSUMSQ66Y
 dnSt3gSpG3ECL8PiLNj+NdydPV96fRkcMLTerUtmh9LQnAAt5RRf+xC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 08/16] fchroot05: test failfs root can not
 be referenced
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

Verify that once fchroot() moved the root into failfs, the root
directory can not be opened anymore, not even with O_PATH, nor pinned
by following the /proc/self/root magic link, although readlink()
still names it as "failfs:/" since it does not follow the link.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot05.c | 75 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 91dfdba08..49f51d637 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -4,3 +4,4 @@ fchroot01 fchroot01
 fchroot02 fchroot02
 fchroot03 fchroot03
 fchroot04 fchroot04
+fchroot05 fchroot05
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 9270c1408..0697f10eb 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -2,3 +2,4 @@ fchroot01
 fchroot02
 fchroot03
 fchroot04
+fchroot05
diff --git a/testcases/kernel/syscalls/fchroot/fchroot05.c b/testcases/kernel/syscalls/fchroot/fchroot05.c
new file mode 100644
index 000000000..f183d749c
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot05.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that the failfs root can not be referenced once it is the process
+ * root.
+ *
+ * After :manpage:`fchroot(2)` moved the root into failfs, the root
+ * directory can not be opened anymore, not even with ``O_PATH``, because the
+ * walk lands on the failfs root as its terminal. The root also can not
+ * be pinned by following the /proc/self/root magic link into it, although
+ * :manpage:`readlink(2)` still names it as "failfs:/" since it does not
+ * follow the link.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * /proc must be opened before entering failfs because every absolute path
+ * lookup fails once the root is unreachable. The test runs in a forked
+ * child so the root of the parent process is left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	char buf[PATH_MAX];
+	struct stat st;
+	int procfd, len;
+
+	procfd = SAFE_OPEN("/proc", O_PATH | O_DIRECTORY);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	TST_EXP_FAIL2(open("/", O_RDONLY | O_DIRECTORY), EOPNOTSUPP,
+		"open() of the failfs root");
+
+	TST_EXP_FAIL2(open("/", O_PATH), EOPNOTSUPP,
+		"O_PATH open() of the failfs root");
+
+	TST_EXP_FAIL2(openat(procfd, "self/root", O_PATH), EOPNOTSUPP,
+		"pin of the root via /proc/self/root");
+
+	TST_EXP_FAIL(fstatat(procfd, "self/root", &st, 0), EOPNOTSUPP,
+		"stat of the root via /proc/self/root");
+
+	len = readlinkat(procfd, "self/root", buf, sizeof(buf) - 1);
+	if (len < 0) {
+		tst_res(TFAIL | TTERRNO, "readlinkat() of /proc/self/root");
+	} else {
+		buf[len] = '\0';
+		TST_EXP_EQ_STR(buf, "failfs:/");
+	}
+
+	exit(0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
