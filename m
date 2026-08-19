Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB600C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:25:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3DFC3CD6FB
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:25:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09E523CD674
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E7EB1A00902
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4224F84D2C;
 Wed, 19 Aug 2026 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLj9ZTX129rMzLbSc89h0JYJDfmbX2JtL/AEtnG3uLw=;
 b=dpKeviBLLbz5iSyDmZiwZVjyWhiGpLUcVNY8/FoylhkKNNwoJFKr1BcooD+IoWqd+hiuVf
 RBgbp0JJnJbmZbkoJt45SNraSwQLeoHCRfHYYmexf6NdKSSVa8z1QuyWmd7kJCrVvSwGC/
 iTp/vLh82BlJtb+mQddUUvxK8hO8uZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLj9ZTX129rMzLbSc89h0JYJDfmbX2JtL/AEtnG3uLw=;
 b=tSvphhNTdGByamuNE1aiit1Hb/3Rtb5qiMgmjml7ogm1gWFuERujNegYg/MREAV+Mw775u
 E3cGvN55OrcST1CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vw0prWIi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HPiapFxp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLj9ZTX129rMzLbSc89h0JYJDfmbX2JtL/AEtnG3uLw=;
 b=vw0prWIi8np8i/40pkJFuKzTfdv+wZUuS0LOMRtImGHsHuWaSY2Q0KH6WGfuAyduEW7oV6
 kKVx33UE6DlRjtDlsZINBZWe8nwu5IvdeXf5TA0RaEhflOCibdQebEcNT58mlxnom7kiKf
 sU1GrpIcatrrfgEXTJO23wzo3D+79P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLj9ZTX129rMzLbSc89h0JYJDfmbX2JtL/AEtnG3uLw=;
 b=HPiapFxpXofQAwlviXZVVs+7zZ0/hdFhFbMIzDv4HPqPy0PehHf8Z0AiTGn2YrnSd6UcJa
 CeTdMlstfKjfMoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 102C0367B;
 Wed, 19 Aug 2026 21:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +JznAAUfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:19 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-4-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3210;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WpkfKZiy6ecA5P2Hrd5rXHdOhk+pr11+UEgXORPLMGM=;
 b=qj2K7cdVPhV8inUqLi83Ut5eXvYOALdyNVC6iBH5YTAKqcc1buzMhsjgwVrD9NC6KyzVUiNkz
 t4ViE6CUXrACLWpe8xr4KNpa+zVVg1vEbiENbiREV0MV84iaqxVgGsR
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4224F84D2C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 04/16] fchroot01: test fchroot() with a
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
 testcases/kernel/syscalls/fchroot/fchroot01.c | 57 +++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

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
index 000000000..fb4894519
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot01.c
@@ -0,0 +1,57 @@
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
+ * Linux v7.3. Root is required because fchroot() with a regular directory
+ * fd requires CAP_SYS_CHROOT.
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
+#define CANARY JAILDIR "/canary"
+
+static void run(void)
+{
+	struct stat st;
+
+	if (!SAFE_FORK()) {
+		int dfd = SAFE_OPEN(JAILDIR, O_PATH | O_DIRECTORY);
+
+		TST_EXP_PASS(tst_syscall(__NR_fchroot, dfd, 0),
+			"fchroot() with a directory fd");
+
+		TST_EXP_PASS(stat("/canary", &st),
+			"canary file visible under the new root");
+
+		exit(0);
+	}
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(JAILDIR, 0755);
+	SAFE_TOUCH(CANARY, 0644, NULL);
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
