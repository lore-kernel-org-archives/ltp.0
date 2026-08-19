Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FAEC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:27:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143CF3CD722
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:27:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 822333CDE8B
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13D9A600849
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8ACE84D32;
 Wed, 19 Aug 2026 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw4yHOL+FH/srMP+MHuR55J3KJa4bhIS3QBQ1ruRPmA=;
 b=mDDlEquTlCW5MV6NZ6T+yNs8s52FWDrnM2nGj1fcqMEO8OCn4pKSfXOe4ie4zpCLIm5TdX
 as2MVO5YX6DUex9KJpEyj3Q8RJEbog/AV4MhRXzhMkDJkM4xYkdtcfQ30IWnoA/lYV31QT
 gmVdtdewfkJhRhU5GyMEXIWW9asb6v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw4yHOL+FH/srMP+MHuR55J3KJa4bhIS3QBQ1ruRPmA=;
 b=nAgXBZz1DJZhX5wb0KDG6nZqVSAGyrI8pK6X0TJK/KCal37XeLYJhZSACdwuQ2XmcK/7i6
 9FOgqDBhMax+9PAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m4NYK5f9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tV2wS/UB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw4yHOL+FH/srMP+MHuR55J3KJa4bhIS3QBQ1ruRPmA=;
 b=m4NYK5f9kasz73ds7PnHoIyeCgS0pANcKP45UN77IjwL+TFNH9Y0kaAy7yP2A7NnGCDK1S
 rtVf4DBA5XDa0snlAujdox+2s94Al5Lubt8ZGbhQwv/PHRU4Uc+4vUGBIHzS1QoMB5osDH
 /BFDpSH+74NYyvAsVSNxKPx5qG5lb4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw4yHOL+FH/srMP+MHuR55J3KJa4bhIS3QBQ1ruRPmA=;
 b=tV2wS/UBauTLJd/0oqINJcgEASXYs12+iKKxiCPr8mv1vkSba2IyqKUAFW/mejG2rIOvcs
 mN2ghzLdWUqIPmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2D10367E;
 Wed, 19 Aug 2026 21:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mIdfMAUfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:22 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-7-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3366;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=j4R9XunGrd3xUZyDO4lj/5Ofw0RREh+/dXHEQDktMOE=;
 b=BiuCOdwNu2m8I0F0O2i0BgFIiQ8dnFW4vosP9OlszFc9P4SyKjofx3LqU4c8WBsCvBZ+VJoi2
 KeqcHPj2+3+A7N/qRNIVPRt4XDZ1wzUz+uiXP8cjqtaCOfTdZsSXAId
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A8ACE84D32
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 07/16] fchroot04: test fchroot() into failfs
 as root
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

Verify that entering failfs with the FD_FAILFS_ROOT sentinel succeeds
with CAP_SYS_CHROOT and that every absolute path lookup then fails
with EOPNOTSUPP, while the working directory is reported as
unreachable by getcwd().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot04.c | 66 +++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 13635037b..91dfdba08 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -3,3 +3,4 @@
 fchroot01 fchroot01
 fchroot02 fchroot02
 fchroot03 fchroot03
+fchroot04 fchroot04
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 235befd99..9270c1408 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1,3 +1,4 @@
 fchroot01
 fchroot02
 fchroot03
+fchroot04
diff --git a/testcases/kernel/syscalls/fchroot/fchroot04.c b/testcases/kernel/syscalls/fchroot/fchroot04.c
new file mode 100644
index 000000000..5a56e84bd
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot04.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test :manpage:`fchroot(2)` with the FD_FAILFS_ROOT sentinel as a
+ * privileged process.
+ *
+ * fchroot() was introduced in Linux v7.3 together with failfs, a kernel
+ * internal filesystem where every operation fails with EOPNOTSUPP. The
+ * FD_FAILFS_ROOT sentinel moves the process root there without needing a
+ * file descriptor: it is the ``fs_struct`` equivalent of RESOLVE_BENEATH.
+ *
+ * The test verifies that entering failfs succeeds with CAP_SYS_CHROOT and
+ * that every absolute path lookup then fails with EOPNOTSUPP. The working
+ * directory, left behind in the real filesystem, is consequently reported
+ * as unreachable by :manpage:`getcwd(2)`.
+ *
+ * The syscall runs in a forked child because leaving failfs requires a
+ * mount namespace file descriptor and the parent needs its root for the
+ * test framework cleanup.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		char buf[PATH_MAX];
+
+		TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+		TST_EXP_FAIL2(open("/etc/passwd", O_RDONLY), EOPNOTSUPP,
+			"absolute file open");
+
+		TST_EXP_FAIL(mkdir("/foo", 0700), EOPNOTSUPP,
+			"absolute directory creation");
+
+		/*
+		 * The libc getcwd() wrapper rejects the "(unreachable)"
+		 * prefix produced by the kernel, so call the raw syscall.
+		 */
+		TEST(tst_syscall(__NR_getcwd, buf, sizeof(buf)));
+		if (TST_RET > 0)
+			TST_EXP_EQ_STRN(buf, "(unreachable)", 13);
+		else
+			tst_res(TFAIL | TTERRNO, "getcwd() failed");
+
+		exit(0);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
