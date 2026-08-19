Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC08AC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D8B33CDE35
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:27:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA70A3CD6B2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26DCF60084A
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2D0384D38;
 Wed, 19 Aug 2026 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2G3SQW4XY7N5hJs1gt6xPZn/WT6qrIR8snKlAIwEfY=;
 b=QCRnOYShtuEipgNCf6zEPZBD+bs0YP5KB6hFAaaOUN2YfSnovxb+6ycO4l321rt2/BgYgQ
 TdGIX3/VSQNeTevgQ7T4VsHiNGq8g2wVm8FmfgRdjOpyRgPezt89sac016DBQ/H0wuOKIJ
 2SbgTR9lXUovDX4/gAlP5gExAb/zIGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2G3SQW4XY7N5hJs1gt6xPZn/WT6qrIR8snKlAIwEfY=;
 b=9Y0Eqpoqv0y3NfHWmhcn43wfpo/q+KQnTypmOiFxdQ1+asDciG2d0TLv1+cKXYsVvUep6q
 2mnmQ4ri6pZ+jpBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M13Huaaw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0por9vVh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2G3SQW4XY7N5hJs1gt6xPZn/WT6qrIR8snKlAIwEfY=;
 b=M13HuaawnJZ40gNc1NQ1AzFwTbin6aoMIzWRD6RxOzPkX7PhK6trlu30RVs3obIHyVatL8
 b9lsDyOI+P4xgji+oAv1mt3+SVsXKFE73vt7zp+cMlJL3jtYYN5pB9OtM9y0W4P4Nl4NpP
 fUOHDjPNJLdqFNIbZQpenhtIq6ZcTf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2G3SQW4XY7N5hJs1gt6xPZn/WT6qrIR8snKlAIwEfY=;
 b=0por9vVhj6A67zl6svEGz88TKaL6lBK1EWNZ0reyVS9Ak3qWq+FjWmU1uRWc6zwNQIU6d0
 pMOexKLnzXPcMiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A8783686;
 Wed, 19 Aug 2026 21:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GNL5FgcfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:28 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-13-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=2677;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OxmbxWwBlWi8+Ry+UQQCnTiUKWUv+hEwKSaSgBeD46Y=;
 b=Cr6teaV0bQEG9y0AfBPa/R6QFffSMVndThOM0qAU1Vt4rHo+pdzGqji3iER63Ym3N2thfndwp
 030v9L12TxvD1aSMyb0wCiPd60/4KWWYdySYbqIWplA8YaMUOFB4DV+
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A2D0384D38
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 13/16] fchroot10: test failfs entry without
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

Verify that unprivileged fchroot() into failfs is refused without
no_new_privs: without it a setuid binary on a regular mount is still
reachable via an inherited directory fd, and executing it with an
unusable root directory is the classic confused deputy, so the kernel
refuses the syscall with EPERM.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot10.c | 49 +++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 23f6c6a20..9ec2a7897 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -9,3 +9,4 @@ fchroot06 fchroot06
 fchroot07 fchroot07
 fchroot08 fchroot08
 fchroot09 fchroot09
+fchroot10 fchroot10
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index e803fa2b7..570da2b98 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -7,3 +7,4 @@ fchroot06
 fchroot07
 fchroot08
 fchroot09
+fchroot10
diff --git a/testcases/kernel/syscalls/fchroot/fchroot10.c b/testcases/kernel/syscalls/fchroot/fchroot10.c
new file mode 100644
index 000000000..42b343f64
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot10.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * without no_new_privs.
+ *
+ * Without no_new_privs a setuid binary on a regular mount is still
+ * reachable via an inherited directory file descriptor, and executing it
+ * with an unusable root directory is the classic confused deputy, so the
+ * kernel refuses the syscall with EPERM.
+ *
+ * Root is required to drop to an unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+			ltpuser->pw_uid);
+
+		TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			EPERM, "unprivileged fchroot() without no_new_privs");
+
+		exit(0);
+	}
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
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
