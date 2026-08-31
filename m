Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D135C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2143E9482
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7E43E9478
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DCBFD1A009A3
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1525C1FBA2;
 Mon, 31 Aug 2026 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jm+c5QZh4TtCZ6iDKx33kRMIp95zDsBcYiAISr9onB8=;
 b=GADwnTvqAC/8cGP63CwJ8WiKJN1gZxS7LVRkdrn1AtbA06Djt6pu+217AX4C0f8oOni2wH
 4Sj/P/CDtCiE8/n/raKSSCC0Zv8mpX9QFJUWSAHn9MsgdQ3eBXzP6xvuMq7zipjxZgCYXQ
 5ohgHoevu9ID8bN1zi9Shzow2Yy2FRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jm+c5QZh4TtCZ6iDKx33kRMIp95zDsBcYiAISr9onB8=;
 b=pthFZIrcYG3bNapeP3+XEFDgUh6voRtrmeb3sC49nVNRedMBFZWxpgcB2f923T8w+9+V5n
 tp/OvWbMfYR0eSAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jm+c5QZh4TtCZ6iDKx33kRMIp95zDsBcYiAISr9onB8=;
 b=igYwhjQMTcbetVkBFY3Bu1K4x2XL9fYcztupyud3HrH0LLfbEjechS6YytrBycLi3r4K07
 jOgZ2WVQ4MSZVpGmctyzqiXAmNryszBWk2F4v3K4LxnuQ5+2YdlJvn0SfHb8c1naZcbvAC
 mYhxjt5Fx5TfFCkC1Rd90I/mJwJlxhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jm+c5QZh4TtCZ6iDKx33kRMIp95zDsBcYiAISr9onB8=;
 b=WaGfDIf1CJNXAdi6kcxqvYVTDpJdUWH5GSx5vGSD/44Wuj7zr0KozxnSqmnFsAJWcrbI93
 4xdFAEP1xC6YJkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB067137FB;
 Mon, 31 Aug 2026 08:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sCPyL4c0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:14 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-13-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=2828;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KH7k4rNQRWFFY8BZ05AHHTsWCgqM56Yc8gEjNn2bpss=;
 b=CJQMtb0fnJITze6yBkIRcSpoB2hnuYoqgNnSIcmbd3S+KsbilFjbbDFiakl9l+CVmgC65l3zQ
 QrHOSHCHInYCIOJRG03YhqqRLdGUM1wAjN1wkwij60cD2vmeaZVGTA2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 13/16] fchroot10: test failfs entry without
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
 testcases/kernel/syscalls/fchroot/fchroot10.c | 54 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index b577da61f..53a1fa1d0 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -8,3 +8,4 @@ fchroot07
 fchroot07_child
 fchroot08
 fchroot09
+fchroot10
diff --git a/testcases/kernel/syscalls/fchroot/fchroot10.c b/testcases/kernel/syscalls/fchroot/fchroot10.c
new file mode 100644
index 000000000..effc07bdc
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot10.c
@@ -0,0 +1,54 @@
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
+ * kernel refuses the syscall with ``EPERM``.
+ *
+ * Root is required to drop to an unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/syscalls.h"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		EPERM, "unprivileged fchroot() without no_new_privs");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	if (SAFE_PRCTL(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0))
+		tst_brk(TCONF, "PR_GET_NO_NEW_PRIVS is already set");
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
