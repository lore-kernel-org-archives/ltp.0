Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C38BC79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:56:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A863E86D8
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 10:56:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE273E5368
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:55:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 423F3200900
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 10:55:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D46D31F7B0;
 Mon,  7 Sep 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788771326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7DxFhescqVs/gbeZ+8Ci70xYORXZOwV3rYEpcFTqAU=;
 b=qM8hHxzzu5HkJ0NYAtFuxi6fDPddi9+N+CyLz+xHYcPW3hbyS1ccQ0LJ4efCNSYRQmTLPL
 n2Mqh5sF/T3bPBnow2iayejd2kwUoNbIafGwuGiknHOL4TCDFbxmhBcw3tAOIRaGlUpExp
 LPu62f4f4nGhYwRUmLP5Mzaw20RB2zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788771326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7DxFhescqVs/gbeZ+8Ci70xYORXZOwV3rYEpcFTqAU=;
 b=MuKuPrgUntC/OFcoVr+xJCglllNwOMXxP/Vgi6ilYGfQDEIIJfcNXZliQFHRmXzgY+mJQw
 xQJz5nr+P/RBRcDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I7DpMIV+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UV0odm41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788771322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7DxFhescqVs/gbeZ+8Ci70xYORXZOwV3rYEpcFTqAU=;
 b=I7DpMIV+NboTPRrxICWJB/2HVcfi/58BTlB6BJhkEaJ369sqCrA3y4phjrPOkUkLHayW/l
 88tVKklV5ENsVS2Gy2NSkqc6bOzbGYxgn2zrD2y1aDk3bFwNtNxtN5de2AyqYLe0rYX8PR
 mA2GxyUfll6MQ5FUnNDabNJYG1HfmDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788771322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7DxFhescqVs/gbeZ+8Ci70xYORXZOwV3rYEpcFTqAU=;
 b=UV0odm41yF6mFi2SjxV1LlQQtYCEZlY5mdmrHWLp9n0BHtA1lkHW1yqcCruBkHjjOVdIKs
 VUwI76q8gIW1f+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A256013793;
 Mon,  7 Sep 2026 08:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6C/lJfp7nmr3WwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Sep 2026 08:55:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Sep 2026 10:55:17 +0200
MIME-Version: 1.0
Message-Id: <20260907-process_mrelease-v3-2-03bde3e5d77c@suse.com>
References: <20260907-process_mrelease-v3-0-03bde3e5d77c@suse.com>
In-Reply-To: <20260907-process_mrelease-v3-0-03bde3e5d77c@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788771322; l=3731;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=HygQlN/aWUjbv3OZyUJtIaCXQnCd+96c6/I333yLUF4=;
 b=ynbJIpV8rtjNGRTehkPeIimSl9sHKlzkl/nMf/QNeKpFan4TjYx3sPbkNtrgyiBmPipneUce2
 l80rdraxDqbCcJDoDknVXVvw+dKApSI5Vtb9hy7aHwsxAb84cBb6G8N
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: D46D31F7B0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add process_mrelease02 test
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

Verify that process_mrelease() returns expected error codes on
invalid file descriptors, non-zero flags, alive processes without
pending exit, and terminated processes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
 .../syscalls/process_mrelease/process_mrelease02.c | 90 ++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index cfe76efca..b456afe20 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1152,6 +1152,7 @@ preadv203_64 preadv203_64
 profil01 profil01
 
 process_mrelease01 process_mrelease01
+process_mrelease02 process_mrelease02
 
 process_vm_readv01 process_vm01 -r
 process_vm_readv02 process_vm_readv02
diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
index 673983858..f1e7a8fea 100644
--- a/testcases/kernel/syscalls/process_mrelease/.gitignore
+++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
@@ -1 +1,2 @@
 /process_mrelease01
+/process_mrelease02
diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
new file mode 100644
index 000000000..d48aba623
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test verifies error codes for :manpage:`process_mrelease(2)`:
+ *
+ * - EBADF when invalid file descriptor is passed
+ * - EINVAL when flags parameter is not zero
+ * - EINVAL when target process is still alive and not dying
+ * - ESRCH when target process has terminated
+ *
+ * [Algorithm]
+ *
+ * - Call process_mrelease() with bad fd (-1) to expect EBADF
+ * - Spawn child, call process_mrelease() with invalid flags (-1) to expect EINVAL
+ * - Call process_mrelease() on running child without pending exit to expect EINVAL
+ * - Wait for child exit, call process_mrelease() on dead child to expect ESRCH
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int badfd = -1;
+static int pidfd;
+
+enum {
+	NO_CHILD,
+	EXIT_CHILD,
+	WAIT_CHILD,
+};
+
+static struct tcase {
+	int child_type;
+	int *fd;
+	int flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{NO_CHILD, &badfd, 0, EBADF, "bad file descriptor"},
+	{WAIT_CHILD, &pidfd, -1, EINVAL, "flags is not 0"},
+	{WAIT_CHILD, &pidfd, 0, EINVAL, "task memory cannot be released"},
+	{EXIT_CHILD, &pidfd, 0, ESRCH, "child is not running"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int status;
+	pid_t pid = -1;
+
+	if (tc->child_type != NO_CHILD) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			if (tc->child_type == WAIT_CHILD)
+				TST_CHECKPOINT_WAIT(0);
+
+			exit(0);
+		}
+
+		tst_res(TINFO, "Spawned waiting child with pid=%d", pid);
+
+		pidfd = SAFE_PIDFD_OPEN(pid, 0);
+
+		if (tc->child_type == EXIT_CHILD)
+			SAFE_WAITPID(pid, &status, 0);
+	}
+
+	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
+		tc->exp_errno,
+		"%s", tc->msg);
+
+	if (tc->child_type != NO_CHILD) {
+		if (tc->child_type == WAIT_CHILD) {
+			TST_CHECKPOINT_WAKE(0);
+			SAFE_WAITPID(pid, &status, 0);
+		}
+
+		SAFE_CLOSE(pidfd);
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.min_kver = "5.15",
+	.needs_checkpoints = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
