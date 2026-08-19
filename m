Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFBCC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:28:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49BD93CE2A0
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:28:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E80B3CDA31
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B1D501A00902
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E47D84D35;
 Wed, 19 Aug 2026 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laPixFIum8D+aJEzmtsTGBiPH7KWX9IewtS1cyYmr9g=;
 b=QOgrKBPDd/e7JFzHMoxEtXe7+k7lG1BqdC4eejODNCeW/ojL7LoxKt19azDIOQ9dG3GrHt
 iZnZN9UybG64HLNn+rjzSfa70ubzy2lYs/nbm+WCBhpDxKQUUd1Jlyg19TrMeA3jOU6xcZ
 GGE7o95GTeTENRrshn4PMxcp+Ak/UWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laPixFIum8D+aJEzmtsTGBiPH7KWX9IewtS1cyYmr9g=;
 b=bukMs8OC1H5W3iX3qV5QB8RTJeA/sakizzxmmTggYvex/jY/p+YYm7O/l+JtFGdF0chUEI
 NVPOStoknZOz5sAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laPixFIum8D+aJEzmtsTGBiPH7KWX9IewtS1cyYmr9g=;
 b=dZJU7xgOinv4mZJqsmbplDd5JKOTY3RkqMUD66Wp4aq9YR4KA/rmNGVz63ah7FNn+ixHAK
 wDtX15CX+xgdwTRCvcjNFdWZNFKIeb24wtjTOTM2bl3EAuyFjCI0fpvAESGDF6bQvGMUuQ
 mXV43kYq6pzlM5KBlN7eJtGdAvyaBiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laPixFIum8D+aJEzmtsTGBiPH7KWX9IewtS1cyYmr9g=;
 b=WF+SeR1VNR98WxfkMCCLXOJUuh8Zk14OfcuPvBRSpGtBh/CjCvqxlWE3uE3OonIehMhtSE
 VJvAZgDxN8AscbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D93E3682;
 Wed, 19 Aug 2026 21:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SBtgIwYfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:25 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-10-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3224;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=thr55J8JE1MZQhAGjkGpUZVwYw1QsP5aTPKI32Z7gNQ=;
 b=lMCSPEYOQDpQJoYGHJTGT1bqWgcgYMqa9VNvt6UXxJ9jbqgXuTiE0ExiH3fx1e7/5gwS5Buf6
 fh1oLaqlohSBbnVceDoV/B8IrkuWtvJbPxXOEu9rKOjGGonIFseBh/3
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
Subject: [LTP] [PATCH STAGING 10/16] fchroot07: test execve blocked by
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
 testcases/kernel/syscalls/fchroot/fchroot07.c | 71 +++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

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
index 000000000..d7b5d159b
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`execve(2)` is blocked under the failfs root.
+ *
+ * After :manpage:`fchroot(2)` moved the process root into failfs, loading
+ * a binary by absolute path fails with EOPNOTSUPP.
+ *
+ * Root is required because entering failfs with the FD_FAILFS_ROOT
+ * sentinel requires CAP_SYS_CHROOT.
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
+	if (!SAFE_FORK()) {
+		TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+		check_exec_blocked();
+
+		exit(0);
+	}
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
