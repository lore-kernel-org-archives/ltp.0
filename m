Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C53C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 15:08:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 246863CFCD0
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 16:08:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E11A3C62C0
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:07:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A2CC20A6DD
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:07:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6EEF21D23;
 Thu, 18 Jan 2024 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705590466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWgzuUaUtMlMzgEW4wBSjcHebUGGOJxJggq7WDbOsFk=;
 b=1FkQUmBukamdh6hwLOo0eP388fHFP1XqOHNPZDY2hlxlk50uTQnpkpAlZy6WziXKfSOC1i
 ctWK3n7cGuSUV947d1dHQmyfJcfwD2tIJFae2ZZ/Wh4vALoLErtBav75n550gf1w8CF+/S
 q2lXj4i4gOwk5sQjx4WDBCJyUnaL8n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705590466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWgzuUaUtMlMzgEW4wBSjcHebUGGOJxJggq7WDbOsFk=;
 b=Acqs50MWQTr7JqYV6CtWaI9/LaCZO5/r95xPlS3gotlbHSpzgtiYM0L2tFun8PIuP/je12
 708d/AiN74cDokAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705590465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWgzuUaUtMlMzgEW4wBSjcHebUGGOJxJggq7WDbOsFk=;
 b=aRSf4y/yZbIj/2C5tQH5BOjqqVDWomyCukXeH4vDkGTbHpY+IVvH/SeHpT7xanS5pm7zmZ
 Utr/z4OO9kiRqsdEERVRLXrSnAGp/Oxp+95R2d78NzFWaO71Dk5G3aeQBHc46C0jatJwD/
 S3/02bMeArLWob/8E1x40MxDqkPu1+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705590465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWgzuUaUtMlMzgEW4wBSjcHebUGGOJxJggq7WDbOsFk=;
 b=Kz8teioAj/Ow1Zi84Xzmi2lWDr5jf1M22BBwAFXOHJLrCwLbbzHVOms0uexMmRzmXGZPiS
 Vy5ggkqD4SD7n7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9238713874;
 Thu, 18 Jan 2024 15:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0v/YIME+qWUMKQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jan 2024 15:07:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 16:07:42 +0100
Message-Id: <20240118150742.10792-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="aRSf4y/y";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Kz8teioA
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C6EEF21D23
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add readlink04 test
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

This test has been extracted from symlink01 and it verifies that
readlink() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  2 +-
 testcases/kernel/syscalls/readlink/.gitignore |  1 +
 .../kernel/syscalls/readlink/readlink04.c     | 57 +++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/readlink/readlink04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..339697533 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1125,9 +1125,9 @@ readahead02 readahead02
 readdir01 readdir01
 readdir21 readdir21
 
-readlink01A symlink01 -T readlink01
 readlink01 readlink01
 readlink03 readlink03
+readlink04 readlink04
 
 #readlinkat test cases
 readlinkat01 readlinkat01
diff --git a/testcases/kernel/syscalls/readlink/.gitignore b/testcases/kernel/syscalls/readlink/.gitignore
index 307817f4d..53e65eb5b 100644
--- a/testcases/kernel/syscalls/readlink/.gitignore
+++ b/testcases/kernel/syscalls/readlink/.gitignore
@@ -1,2 +1,3 @@
 /readlink01
 /readlink03
+/readlink04
diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
new file mode 100644
index 000000000..8d7d038bb
--- /dev/null
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that readlink() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+static void test_readlink(void)
+{
+	char *symname = "my_symlink0";
+
+	SAFE_SYMLINK(tst_get_tmpdir(), symname);
+
+	char path[PATH_MAX];
+	struct stat path_link;
+
+	SAFE_READLINK(symname, path, PATH_MAX);
+	TST_EXP_PASS(lstat(path, &path_link));
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_readlink_no_path(void)
+{
+	char *symname = "my_symlink1";
+
+	SAFE_SYMLINK("bc+eFhi!k", symname);
+
+	char path[PATH_MAX];
+	struct stat path_link;
+
+	SAFE_READLINK(symname, path, PATH_MAX);
+	TST_EXP_FAIL(lstat(path, &path_link), ENOENT);
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_readlink();
+	test_readlink_no_path();
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
