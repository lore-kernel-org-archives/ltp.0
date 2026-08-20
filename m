Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26050C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:45:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C70283CDF83
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:45:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5B2D3C0224
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A25C10000E5
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE1383EBC;
 Thu, 20 Aug 2026 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeP68mvfEwezhYXxFp8Nsqxb1zdaXL2DgEspaOck6kk=;
 b=U0p0mSFpg+niX3SEI2bKV/2KrKJtbSw5jNkidb08nMU21BFyRag1dtjCZOhQltRu8RjeuJ
 QLwxV+KqmQdgm0vb53WV6ahiqiD7Yp6jhSeEtfjitjw96bXP7K7UJEmVPL1k7qMu4QQtO1
 54kTPSW/E/t6KOBZNM5Z/SCvRD6hKzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeP68mvfEwezhYXxFp8Nsqxb1zdaXL2DgEspaOck6kk=;
 b=SdWbq2iUL3+CT0JWOr0VaF9n0P5Es1qFBqU5uzweLh1oRO20P4tg4m7cOHBPIi/pI4IRk1
 1UOrKqJT53E6O3AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeP68mvfEwezhYXxFp8Nsqxb1zdaXL2DgEspaOck6kk=;
 b=EPyq6qRxQwO3y3hPF+NrqeTcqknlPHIiSLAWdfXR8dDCIXNJ1CLPoJloVuiZIv7HY4ubBd
 V7JV0WhEpBqrCDMttcZ0tcFQRF/iB+xkgNqHGN310G3hURsu2NVl+2vT3vAY1/xAB/gnQh
 nKYSsB3pqwT2M3vEIf+h3eUfzQnGU8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeP68mvfEwezhYXxFp8Nsqxb1zdaXL2DgEspaOck6kk=;
 b=ggvwmLmVND2pZDyCt80NygqrQnV+0qL1muoGB14EbYUXBoI7bgHt3DrIyn6DRa9tdveHqe
 BVtpvaBcaUwvvbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBE3A367B;
 Thu, 20 Aug 2026 07:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGvBKmywhmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:44 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-4-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3256;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=W3LmH5Iv+4DdrYI3b/gkQAKVGS/m5UsogwkhJFOPMm0=;
 b=abfcyPl85AMKQyanvqjuN3SMxfRVW/1vequyt0/6HvCFxSHDmUM50zTxNx0sQrxGn+jbz4o5A
 qHWcjC03QjlBYQQdHyC6ieAK0tqb94MDTpkOrVvpuwj+s125jw8ZXdH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 04/16] fchroot01: test fchroot() with a
 directory fd
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

Verify that fchroot() with a directory fd moves the process root to
the directory referenced by the fd.

fchroot() was introduced in Linux v7.3, so the test is added to the
staging runtest file.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  2 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/Makefile    |  7 ++++
 testcases/kernel/syscalls/fchroot/fchroot01.c | 59 +++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index ef1cdea15..733d5609a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -1 +1,3 @@
 # Tests for features that are not yet in the stable kernel ABI
+
+fchroot01 fchroot01
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
new file mode 100644
index 000000000..03ebdbe7a
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -0,0 +1 @@
+fchroot01
diff --git a/testcases/kernel/syscalls/fchroot/Makefile b/testcases/kernel/syscalls/fchroot/Makefile
new file mode 100644
index 000000000..137550149
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fchroot/fchroot01.c b/testcases/kernel/syscalls/fchroot/fchroot01.c
new file mode 100644
index 000000000..dc83c5b0d
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot01.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`fchroot(2)` with a regular directory fd moves the
+ * process root to the directory referenced by the fd.
+ *
+ * This is the fd-based counterpart of :manpage:`chroot(2)`, introduced in
+ * Linux v7.3. Root is required because :manpage:`fchroot(2)` with a regular
+ * directory fd requires ``CAP_SYS_CHROOT``.
+ *
+ * The syscall runs in a forked child so that the root of the parent
+ * process, which the test framework needs for its cleanup, is left
+ * untouched.
+ */
+
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define JAILDIR "jail"
+#define CANARY "/canary"
+#define CANARYDIR (JAILDIR CANARY)
+
+static void run(void)
+{
+	struct stat st;
+
+	if (SAFE_FORK())
+		return;
+
+	int dfd = SAFE_OPEN(JAILDIR, O_PATH | O_DIRECTORY);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, dfd, 0),
+		"fchroot() with a directory fd");
+
+	TST_EXP_PASS(stat(CANARY, &st),
+		"canary file visible under the new root");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(JAILDIR, 0755);
+	SAFE_TOUCH(CANARYDIR, 0644, NULL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
