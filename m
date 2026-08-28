Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93BBC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36A043E9A5D
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:12:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BFE93CD537
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7DDF60048D
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE661FEE1;
 Fri, 28 Aug 2026 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8126Grn1lAXpvh2KnSKLiPWrQpWu0un27q9QqbElE+8=;
 b=xUUNFlDFMLKXNz2rN21ILuCMJJ7WzkdXqxukfUG7E7V7ulyT1yjZ0sQgyESabItL8aKJCw
 xLDY0PZQzHL8z3vYomxpPDkyN5+bo7QF8zxa1ewz10OyBgRneDIOJ+HoZhdqvPBhjvRJk3
 3dSy4+7umNfIyDiDdcBfYPBXoc56TQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8126Grn1lAXpvh2KnSKLiPWrQpWu0un27q9QqbElE+8=;
 b=HIoL+fecwzTA4jocvmfhW8iqgOqE2LSQ+sFV7UbkB2Pbp/COalWorEiQ75QGKrrRS1MnAE
 RyAYNjdHR+2Qz2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8126Grn1lAXpvh2KnSKLiPWrQpWu0un27q9QqbElE+8=;
 b=CUf65negAamRUZWDeO/rJPCOd+FF8MNo8yy32OYDfZIovCFczRWAcrWFdD+lyp0LyCed/B
 nfZHAtGnMRXApe6ZZsLA8u8jjyF0KgvpA6hhLK37SWqsKMvEmp+sY2x6NHHR8AFiYFnst/
 nEkJhVQQfzxqA+7y78mlYILVeaEJR2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8126Grn1lAXpvh2KnSKLiPWrQpWu0un27q9QqbElE+8=;
 b=gFjEZDThwbbAl/Mum6tM5n432qKvRHUhG6kGh0g9iAiyh9KoIOlA/cvcCQKNe8zexhKyyK
 QBgSc0/h6M0V1YAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF3613687;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLU4MSCXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:38 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-4-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=3194;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=JPJ3dX8D0X1+Z12wWffdxXrpRVF1+rIn/oZKm2Xrfrs=;
 b=tIWXzS3cqHkU3rG/YF9aT7ZZ8mbG7rxQ9cYCe+AECOmvU5HTlNeZ3HDFPox8spGJxILx/eGxz
 5X/uvinuLHWDNBa0kh1Hi2lQO+X934wCPuGlr/MOskzwPTYeLEGwSCk
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 04/15] fchroot01: test fchroot() with a
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
 testcases/kernel/syscalls/fchroot/fchroot01.c | 58 +++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

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
index 000000000..1914b4c31
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot01.c
@@ -0,0 +1,58 @@
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
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
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
