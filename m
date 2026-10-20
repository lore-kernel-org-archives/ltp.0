Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FF606A321
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=K7I58ZTB;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XALCsoSl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZkEWEfdo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JwvglWgl
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C04D3EA613
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:17:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1CB33EA601
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1099C1000551
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4528D1F388;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHNCSz00CF80r8+zykyYu3AVIrmRaXx+jTKj5XtMhwk=;
 b=K7I58ZTBisjeVAPJWPkfavjf6yxIfyDy2LpktR3s5n7qSGAiFCWqw9p8M4MyXAM/s3w3DQ
 MaJUtMJmhhCZRQrVguoROT0k0tj2H5APQbVrx41OMQP03mXjp09Yfa3RdzURpMgmSsiTOu
 TJL3PfJMHVW5mcRI5Uf7o6DVl0IHbKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHNCSz00CF80r8+zykyYu3AVIrmRaXx+jTKj5XtMhwk=;
 b=XALCsoSlEJcxGp0NlC242h3TmF3B0SbfYkuIp0or+0UGSn7AxUpFxD2wNCQE6+xbPbFPhZ
 g2W1elkwBVByqJBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZkEWEfdo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JwvglWgl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHNCSz00CF80r8+zykyYu3AVIrmRaXx+jTKj5XtMhwk=;
 b=ZkEWEfdoiNUp+TbiSVcfM2wRXgN3UFrPBqVz2+1r85sEepM33vCwOvegG2lCFTmVvgbkKc
 WZMkbOqEtAOPkKxtOcfAD5yC0ajmE8fWDIPl7dcvjS+x8PuwDms+L4vO8RHG0TTacItTGg
 I9E7LpqtAuwkNku4UPTONRBDkRpZLiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHNCSz00CF80r8+zykyYu3AVIrmRaXx+jTKj5XtMhwk=;
 b=JwvglWgl+hWOPHN93RHKbvPNomcC3Wr5OBtOBDihHdfe1KJTP/lb33JmiHiX+DAJnlrV/5
 ZGZgKy6HwvD4AeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCFD3137DB;
 Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:31 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-2-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3208;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Ptj73JNdhFpqnqeqV8AN3vCGNT90YdwWvyP6Ak4Lw+4=;
 b=53MfVSzXv06Cxzrz7t8hpWQiaiEo42YsOFFp5R/OdH16FoNb1L2v8G+lId4u8tHLybTTguyvt
 3Fmlf+hVSpuCgQkLOtyCMxQQPzI8J6GHQTCxlSfxKx7VNgbFkD4vx8A
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 4528D1F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 02/14] fchroot01: test fchroot() with a directory fd
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify that fchroot() with a directory fd moves the process root to
the directory referenced by the fd.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  2 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/Makefile    |  7 ++++
 testcases/kernel/syscalls/fchroot/fchroot01.c | 56 +++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index accdf2df9..558ad1732 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -316,6 +316,8 @@ fchownat01 fchownat01
 fchownat02 fchownat02
 fchownat03 fchownat03
 
+fchroot01 fchroot01
+
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
 fcntl02 fcntl02
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
index 000000000..c43ba4a73
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot01.c
@@ -0,0 +1,56 @@
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
