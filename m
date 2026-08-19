Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF0BC5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F5013CD69F
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:27:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C843E3CD699
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AE307200964
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5313584D36;
 Wed, 19 Aug 2026 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQuT+/OHFoYhDOR8Ib24SkYZkJamVXjaf0rVFT3RJbM=;
 b=bbKMDL23mLYLe1tvViRTYslv/9aM2YJ55meO5BoCfjKIJRQZ0PYuxWYrj2UKHeLLzGqaIR
 VhL2qRR7kV3mms+6Ruy1GwzpQRXZDM43wcqp5p/ht7DnM6khGypSBSO+n956Wi18t+YBRM
 NzK9jJc7mzqtUpZJYOQeIp3TDp4RzfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQuT+/OHFoYhDOR8Ib24SkYZkJamVXjaf0rVFT3RJbM=;
 b=1rk4NlaP/HD+FBYGpEkXvILl+I7n8tbZ8SrPGpBPyXiQTQLwW4RxBiyd3wzAY3apLPwmfx
 F7+bik71wzwHiJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQuT+/OHFoYhDOR8Ib24SkYZkJamVXjaf0rVFT3RJbM=;
 b=NIVaDwuwTOctEHOehdlJjY1A9zURt/YP4p0hy67n2OjYB+l1f3J87xJt8Wzop0NxUaMp8J
 8Ka4Meh/9rh98tnjcI9zIrwZrBLTCZ9eKdVGg/JSDddTTEOGh73PFKqpKlUuyyno8z8rqn
 iThzrjCaTT1pvv64g7Uy4z7dpsB9+HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQuT+/OHFoYhDOR8Ib24SkYZkJamVXjaf0rVFT3RJbM=;
 b=rcIAnHEQYwqOMW/B6r2fifVgo+PMjnFY+C5TYbeZ3Ar3AcZE8wh00gEDrlpCqKl20FV5Es
 hHpst6l+jXax8NDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9903683;
 Wed, 19 Aug 2026 21:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eOZFMwYfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:26 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-11-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=2656;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=UdKiYvEf2FxxJWxC7OxLXmZ9n607Us0WwraBygY4wu8=;
 b=lpkR+cAv5B/IUJUzW02sU3hvVry/RndRSBV0LLDlZnoqLx2fLUiaMEgjHLjPXWoTBKzb6GhKo
 G4BflKZ6J+4BGEvLZjzV/oVcKh1mitvByAK+CCpmcW4B3Jog8aPBPq1
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 11/16] fchroot08: test failfs root fork
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
 testcases/kernel/syscalls/fchroot/fchroot08.c | 52 +++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

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
index 000000000..4593a24d3
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot08.c
@@ -0,0 +1,52 @@
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
+ * failfs root also fails every absolute path lookup with EOPNOTSUPP.
+ *
+ * Root is required because entering failfs with the FD_FAILFS_ROOT
+ * sentinel requires CAP_SYS_CHROOT.
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
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		pid_t pid;
+
+		TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			TST_EXP_FAIL2(open("/etc", O_PATH), EOPNOTSUPP,
+				"absolute lookup in a forked child");
+			exit(0);
+		}
+
+		SAFE_WAITPID(pid, NULL, 0);
+
+		exit(0);
+	}
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
