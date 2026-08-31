Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69C1C624C2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:01:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41DEC3E9481
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:01:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5FE53E59C9
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75BA91400B6E
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA1D51FAB2;
 Mon, 31 Aug 2026 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avrAx1ro4i80KPG8/6NCJS9TxGbBj8w6h1CVPr9zjM8=;
 b=Bf6CdpHTOnCyLCPRr89IB64ixREQR0ml0wydkGYkiPlm04YLbkjknUB8eZ+YBBYBk67azh
 Lpr00tZthDlj1u1a59NrDRlgvR28fwpBrFE1iyggC7UnU3UyA43mOADZOarDpWjViSHHTy
 dBYaH1Z/Y0Ew4Fdc0B6bbxi8Eh2UsiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avrAx1ro4i80KPG8/6NCJS9TxGbBj8w6h1CVPr9zjM8=;
 b=poAmFxU1WWDfCtVx4jXq/B0Fds3UJZk4pE7UfLlErxaKupq57N83qGVHS9jnZUI5OD3yKA
 V+tF0WTRKE0WWVAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rSpev7AW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gCOUrhvx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avrAx1ro4i80KPG8/6NCJS9TxGbBj8w6h1CVPr9zjM8=;
 b=rSpev7AW4o//yB2mdPi9zqWlq5B03PuzzlBBtvB+4FhZt5GDlmoXTfopsuG7exdcmxd0f7
 A4Krsa5XIcjxR/E9rQYjK1dIA6QXp1yXSjy7/p6JcGvffm8DYIiUaed5wGkg8AT8RuJmuh
 1kt3p27c90iKLKsNffWRip/jewA3HtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avrAx1ro4i80KPG8/6NCJS9TxGbBj8w6h1CVPr9zjM8=;
 b=gCOUrhvxXv1fHd8ibsmPUGeXkhdouO8qOZm57JeOzMV5TI+ZSkKa+5TEj6vGq33shOvxei
 Dx2q5ub3S4yQbdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81EF136DC;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wMo2L4Y0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:07 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-6-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3042;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OwG9cifFDBVyIeuZTxCH0jiaJxAMybsgunB7iUU3IwM=;
 b=G8w39Pe6yLdo5Alv9wh/emI3eSlAYq7l4BeP0KOSLdFh87V6mfn9SzdqgdPK8e2UJ3iO8HA7e
 ZbjJXUOLtCICOn1WWMEpPw5dgmvgRFXAy4IrETq5/6eM2NGfnbMsui4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: DA1D51FAB2
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 06/16] fchroot03: test fchroot() permission
 checks
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

Verify that with a regular directory fd the kernel first checks the
execute permission on the directory and then CAP_SYS_CHROOT: an
unprivileged process with an accessible directory fails with EPERM and
a process without execute permission fails with EACCES.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot03.c | 72 +++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index e12230218..13635037b 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -2,3 +2,4 @@
 
 fchroot01 fchroot01
 fchroot02 fchroot02
+fchroot03 fchroot03
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index fb3287612..235befd99 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1,2 +1,3 @@
 fchroot01
 fchroot02
+fchroot03
diff --git a/testcases/kernel/syscalls/fchroot/fchroot03.c b/testcases/kernel/syscalls/fchroot/fchroot03.c
new file mode 100644
index 000000000..5ec5c9241
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot03.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the :manpage:`fchroot(2)` permission checks with a regular directory
+ * fd:
+ *
+ * - an unprivileged process with an accessible directory fails with ``EPERM``
+ * - a process without execute permission on the directory fails with ``EACCES``
+ *
+ * Root is required to open the directory file descriptors before dropping
+ * to an unprivileged user in forked children.
+ */
+
+#include <fcntl.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static struct tcase {
+	const char *dir;
+	mode_t mode;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{"pubdir", 0755, EPERM, "no CAP_SYS_CHROOT"},
+	{"privdir", 0600, EACCES, "no execute permission"},
+};
+
+static struct passwd *ltpuser;
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (SAFE_FORK())
+		return;
+
+	int dfd = SAFE_OPEN(tc->dir, O_PATH | O_DIRECTORY);
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, dfd, 0),
+		tc->exp_errno, "fchroot() with %s", tc->desc);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	unsigned int i;
+
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		SAFE_MKDIR(tcases[i].dir, tcases[i].mode);
+		SAFE_CHMOD(tcases[i].dir, tcases[i].mode);
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
