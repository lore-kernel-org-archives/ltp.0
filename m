Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ABAC48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 15:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91AED3D13A9
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 16:49:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B943F3D0476
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:49:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59ACF200384
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:49:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BE0222084;
 Mon, 19 Feb 2024 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708357751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cw/uWDvquiaMHRNVMV8LGfqvu5k4j02J7ET/eZpNs3o=;
 b=q7UPRi1EQp8KNHBuAbMP5Xqj6R/gxO2cDA4VA9nUe9+HKcbquMWl7qtQwjrnVtQJ5ihOhN
 Zkbkfzbah2uRaX7Bx5K95WF0kmmDkwHz+lpplVPxtAMmLmPDpoj70EUpLNludfjiIQUSAk
 ocnXdV4xPSjOuZshQGLx+sDTgQGJM/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708357751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cw/uWDvquiaMHRNVMV8LGfqvu5k4j02J7ET/eZpNs3o=;
 b=gGiHXUj4kMaX2LIjBIOvD4OO3Z4FoW4mvImaleoXKomnkj5hfx27ainvDBmoYfZDjt/4Aq
 omoOmXjRb/rwD6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708357751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cw/uWDvquiaMHRNVMV8LGfqvu5k4j02J7ET/eZpNs3o=;
 b=q7UPRi1EQp8KNHBuAbMP5Xqj6R/gxO2cDA4VA9nUe9+HKcbquMWl7qtQwjrnVtQJ5ihOhN
 Zkbkfzbah2uRaX7Bx5K95WF0kmmDkwHz+lpplVPxtAMmLmPDpoj70EUpLNludfjiIQUSAk
 ocnXdV4xPSjOuZshQGLx+sDTgQGJM/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708357751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cw/uWDvquiaMHRNVMV8LGfqvu5k4j02J7ET/eZpNs3o=;
 b=gGiHXUj4kMaX2LIjBIOvD4OO3Z4FoW4mvImaleoXKomnkj5hfx27ainvDBmoYfZDjt/4Aq
 omoOmXjRb/rwD6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F34413647;
 Mon, 19 Feb 2024 15:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jVG/DHd402XqdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 19 Feb 2024 15:49:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 19 Feb 2024 16:49:09 +0100
Message-Id: <20240219154909.22937-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q7UPRi1E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gGiHXUj4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 7BE0222084
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add lstat03 test
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

This test has been extracted from symlink01 test and it checks that
lstat() executed on file provide the same information of symlink
linking to it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Remove test_lstat_no_path() test
TST_EXP_PASS for lstat() and SAFE_SYMLINK for symlink()
Removed memory leak using tst_get_tmpdir()

 runtest/syscalls                           |  4 +-
 testcases/kernel/syscalls/lstat/.gitignore |  2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 50 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/lstat/lstat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7794f1465..a7f22d907 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -723,12 +723,12 @@ lseek02 lseek02
 lseek07 lseek07
 lseek11 lseek11
 
-lstat01A symlink01 -T lstat01
-lstat01A_64 symlink01 -T lstat01_64
 lstat01 lstat01
 lstat01_64 lstat01_64
 lstat02 lstat02
 lstat02_64 lstat02_64
+lstat03 lstat03
+lstat03_64 lstat03_64
 
 mallinfo02 mallinfo02
 
diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
index a497a445f..72cba871f 100644
--- a/testcases/kernel/syscalls/lstat/.gitignore
+++ b/testcases/kernel/syscalls/lstat/.gitignore
@@ -2,3 +2,5 @@
 /lstat01_64
 /lstat02
 /lstat02_64
+/lstat03
+/lstat03_64
diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
new file mode 100644
index 000000000..30932f1fa
--- /dev/null
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test checks that lstat() executed on file provide the same information
+ * of symlink linking to it.
+ */
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	char *symname = "my_symlink0";
+	char *tmpdir = tst_get_tmpdir();
+
+	SAFE_SYMLINK(tmpdir, symname);
+
+	struct stat path_stat;
+	struct stat link_stat;
+
+	TST_EXP_PASS(lstat(tmpdir, &path_stat));
+	TST_EXP_PASS(lstat(symname, &link_stat));
+
+	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
+	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
+	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
+	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
+	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
+	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
+	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
+
+	TST_EXP_EXPR(path_stat.st_mode != link_stat.st_mode,
+		"object and symbolic link have different st_mode");
+	TST_EXP_EXPR(path_stat.st_size != link_stat.st_size,
+		"object and symbolic link have different st_size");
+
+	SAFE_UNLINK(symname);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
