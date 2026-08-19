Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14597C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4246E3CD722
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:26:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFEAE3CD74F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C7611A00902
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40B7B3EEB;
 Wed, 19 Aug 2026 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUbFL3e6cZA5uTed0w3+FKVv2n3znEmB8czRmQGInyo=;
 b=R67SqNAtZum2kS+QWn7EpSW92rF1AuPL43gxJBqn9ZKF5p7IgoK+ViaPAo+8S1yA2/+YbT
 xjDBFUbpHo+WyhA7NELx1ppaJqSWQw21/xRM19KSHoyAmMWvlmn32xFZXAN0L4SCKcx6RC
 2uGNxk6ptKoKwCdL+P/7u0Jw0eJMNXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUbFL3e6cZA5uTed0w3+FKVv2n3znEmB8czRmQGInyo=;
 b=vF4yq/xr93ucJs0z5rBZWbadVIGJySJQZJ8y71jeameWSNk3Bfm/WnenD9G3cq+RqI4x+w
 YY1CaAzqjC9Um4Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUbFL3e6cZA5uTed0w3+FKVv2n3znEmB8czRmQGInyo=;
 b=J6b6TxZ3JQOP1+am6z7eY8tdFe9gMp/FejYATJ/xRzzl0JJ4W6Ynwm8sAdHk3zOzft8v8l
 bNr9OEYHIQK2CBlUw+JkDAtPSkI6//+P5m2S8cv3Ml60+wrBAHz0877X+9JkiSRNVmRCKI
 IV/QjlRGBQDXvv0ipmechO6nev7dBmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUbFL3e6cZA5uTed0w3+FKVv2n3znEmB8czRmQGInyo=;
 b=gBf5ME6dbxVMVU/x6/SJhVUECRW1TAvfVlQIINp4wALlsNE0QOlWeiQyZXWkcJkFleqffB
 aAY9alpfeTxpPzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BE1367D;
 Wed, 19 Aug 2026 21:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UEC4IAUfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:21 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-6-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3315;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xO34xWPTTjQJWfpZGlhCCZeCINXbH+tIwjlZY+UCHMA=;
 b=DlBM7rD2RR8+mvavomFtBrz5U4wXuqpxH7TUjae9PKtDpBKiAj30sWzGZj2dBcUk+ZJqDXepi
 LCGJSkvmJ6FC4dN0T4XsR5WU2/UTOVabwqdAyqvfT4o/2csp1y1oDY/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 06/16] fchroot03: test fchroot() permission
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
 testcases/kernel/syscalls/fchroot/fchroot03.c | 77 +++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

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
index 000000000..4c1350e21
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot03.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the :manpage:`fchroot(2)` permission checks with a regular directory
+ * fd.
+ *
+ * fchroot() was introduced in Linux v7.3. With a regular directory fd the
+ * kernel first checks that the caller has execute permission on the
+ * directory, then that it holds CAP_SYS_CHROOT:
+ *
+ * - an unprivileged process with an accessible directory fails with EPERM
+ * - a process without execute permission on the directory fails with
+ *   EACCES, proving the permission check comes before the capability
+ *   check
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
+	if (!SAFE_FORK()) {
+		int dfd = SAFE_OPEN(tc->dir, O_PATH | O_DIRECTORY);
+
+		SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+			ltpuser->pw_uid);
+
+		TST_EXP_FAIL(tst_syscall(__NR_fchroot, dfd, 0),
+			tc->exp_errno, "fchroot() with %s", tc->desc);
+
+		exit(0);
+	}
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
