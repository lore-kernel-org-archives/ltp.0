Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FFCD3EE74
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 15:04:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD4413CB8AA
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 16:04:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70A4A3CB5A1
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 16:04:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D90BE600CD1
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 16:04:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 382E55BCD2;
 Thu, 22 Jan 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769094263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8DlhoHmcL5U5LxF5x+uEDPIUJULKjddP+pUcCqNqJW8=;
 b=Usryd3nJg9v6Uwr0YU0AWAgFVryCi0qbDcx8ctGT0i8m40gB4PT6prZgXUl3wLcZAgpCSK
 30qc39PFnvsTkaWHLmeR2J1flT4iVbAvFXks+Fan47l1bPrtiVsGJFGYWzsjVae/7TU2h/
 OHShjPtJzZ9nh0UVPP0oLiuKhrr1/0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769094263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8DlhoHmcL5U5LxF5x+uEDPIUJULKjddP+pUcCqNqJW8=;
 b=dkkdqNTAZLBoYum7LJRj6TaecdWj1uXbEmYWbqlhzafNuXs6oZtCXMmimv1001feOfj+6F
 lRbxeNau7HF+c2Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Usryd3nJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dkkdqNTA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769094263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8DlhoHmcL5U5LxF5x+uEDPIUJULKjddP+pUcCqNqJW8=;
 b=Usryd3nJg9v6Uwr0YU0AWAgFVryCi0qbDcx8ctGT0i8m40gB4PT6prZgXUl3wLcZAgpCSK
 30qc39PFnvsTkaWHLmeR2J1flT4iVbAvFXks+Fan47l1bPrtiVsGJFGYWzsjVae/7TU2h/
 OHShjPtJzZ9nh0UVPP0oLiuKhrr1/0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769094263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8DlhoHmcL5U5LxF5x+uEDPIUJULKjddP+pUcCqNqJW8=;
 b=dkkdqNTAZLBoYum7LJRj6TaecdWj1uXbEmYWbqlhzafNuXs6oZtCXMmimv1001feOfj+6F
 lRbxeNau7HF+c2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DC5313533;
 Thu, 22 Jan 2026 15:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WSwgBnc8cmldSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Jan 2026 15:04:23 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 16:05:40 +0100
Message-ID: <20260122150540.28343-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Queue-Id: 382E55BCD2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: chdir02: Add test for valid buffer lenghts
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
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test tests all buffer lenghts shorter than PATH_MAX and expect the
chdir() syscall to succeed.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/chdir/.gitignore |  1 +
 testcases/kernel/syscalls/chdir/chdir02.c  | 38 ++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 testcases/kernel/syscalls/chdir/chdir02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 05bb3ceb1..2f629e4e4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -68,6 +68,7 @@ cachestat03 cachestat03
 cachestat04 cachestat04
 
 chdir01 chdir01
+chdir02 chdir02
 chdir04 chdir04
 
 chmod01 chmod01
diff --git a/testcases/kernel/syscalls/chdir/.gitignore b/testcases/kernel/syscalls/chdir/.gitignore
index 1b15eb6b9..3475c5e54 100644
--- a/testcases/kernel/syscalls/chdir/.gitignore
+++ b/testcases/kernel/syscalls/chdir/.gitignore
@@ -1,2 +1,3 @@
 /chdir01
+/chdir02
 /chdir04
diff --git a/testcases/kernel/syscalls/chdir/chdir02.c b/testcases/kernel/syscalls/chdir/chdir02.c
new file mode 100644
index 000000000..fc1f80136
--- /dev/null
+++ b/testcases/kernel/syscalls/chdir/chdir02.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Tests that all paths shorter than PATH_MAX work fine.
+ */
+
+#include "tst_test.h"
+
+static char *path;
+
+static void verify_chdir(void)
+{
+	int i, fails = 0;
+
+	memset(path, 0, PATH_MAX);
+
+	for (i = 1; i < PATH_MAX; i++) {
+		memset(path, '/', i);
+
+		TST_EXP_PASS_SILENT(chdir(path), "chdir('/' * %i)", i);
+
+		fails += !TST_PASS;
+	}
+
+	if (!fails)
+		tst_res(TPASS, "Path lenghts <1,%i> worked correctly", PATH_MAX);
+}
+
+static struct tst_test test = {
+	.test_all = verify_chdir,
+	.bufs = (struct tst_buffers []) {
+		{&path, .size = PATH_MAX},
+		{}
+	}
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
