Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C90D41C3E
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 13:02:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAF413D66A8
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 14:02:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 302753C7457
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 14:02:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1FAB927443D
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 14:02:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A97691F399
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731502939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tVy8Xmi9QGLUMXRYNNh30PngZUzenpnK1/fgBqcbMg=;
 b=ia/KrzwVIQ+Qs2A/ysc+NZsiCb8XhLUXP0uI3SBZDKfca1BYvmbf8+ZDk0U7nFVK4sgJpp
 C2MSpA5xuacJdTBEpOuz9B2cM1eOe/1nllmhgbZaKuPgxyxWm3r9bO/KdaGObyJuZr7Yzq
 MgdgDBEge8WfTtUC4/YdpgYuaDa7ESs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731502939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tVy8Xmi9QGLUMXRYNNh30PngZUzenpnK1/fgBqcbMg=;
 b=LOLzEjfHLJ/zw6TWLzfHj2tXGULQIa5f0v8jRQ0CmkM4x2PhccZHeespnJaUgjHpdQj5U6
 jDKByLq4EORIRsBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731502939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tVy8Xmi9QGLUMXRYNNh30PngZUzenpnK1/fgBqcbMg=;
 b=ia/KrzwVIQ+Qs2A/ysc+NZsiCb8XhLUXP0uI3SBZDKfca1BYvmbf8+ZDk0U7nFVK4sgJpp
 C2MSpA5xuacJdTBEpOuz9B2cM1eOe/1nllmhgbZaKuPgxyxWm3r9bO/KdaGObyJuZr7Yzq
 MgdgDBEge8WfTtUC4/YdpgYuaDa7ESs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731502939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tVy8Xmi9QGLUMXRYNNh30PngZUzenpnK1/fgBqcbMg=;
 b=LOLzEjfHLJ/zw6TWLzfHj2tXGULQIa5f0v8jRQ0CmkM4x2PhccZHeespnJaUgjHpdQj5U6
 jDKByLq4EORIRsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9316413301
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gK9IHlujNGfrPgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 Nov 2024 14:02:12 +0100
MIME-Version: 1.0
Message-Id: <20241113-setresgid_refactoring-v1-2-b6d07400e374@suse.com>
References: <20241113-setresgid_refactoring-v1-0-b6d07400e374@suse.com>
In-Reply-To: <20241113-setresgid_refactoring-v1-0-b6d07400e374@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731502939; l=3817;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=D0+FAhQ8aid55KCaPaNBEKrqBNYlVJsMxPgvRAJ9Hj0=;
 b=WhIGil9d9ggGcLTQErmo1EGjWwHLd6651EGgDPyPswyi6WevUl0ePP/zDCt+xx/jIVZCZLBSn
 P7WOAJk0PO8BAS5IHBghNV6FeWUC+w2U3LMOTx6CPVCaYoYzFg5x3Bd
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Refactor setresgit04 test
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

Simplify the overall structure using newest LTP API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setresgid/setresgid04.c | 104 ++++++----------------
 1 file changed, 25 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/syscalls/setresgid/setresgid04.c b/testcases/kernel/syscalls/setresgid/setresgid04.c
index 4d8e9685efac4fd5f53358ed29a603d0fb01702a..46c0ca341568cd8de2c590af248ad0db5916b815 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid04.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid04.c
@@ -1,101 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * Copyright (c) Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/*
- * Test Description:
- *  Verify that,
- *	File system GID is always set to the same value as the (possibly new)
- *	effective GID.
+
+/*\
+ * [Description]
+ *
+ * Verify that setresgid() syscall always sets the file system GID to the same
+ * value as the new effective GID.
  */
 
 #define _GNU_SOURCE
 
-#include <errno.h>
-#include <unistd.h>
 #include <pwd.h>
-#include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(setresgid04);
-int TST_TOTAL = 1;
 static struct passwd *ltpuser;
-static void setup(void);
-static void setresgid_verify(void);
-static void cleanup(void);
 
-int main(int argc, char **argv)
+static void run(void)
 {
-	int i, lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct stat buf;
 
-	setup();
+	TST_EXP_PASS(setresgid(-1, ltpuser->pw_gid, -1));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			setresgid_verify();
-	}
+	SAFE_TOUCH("test_file", 0644, NULL);
+	SAFE_STAT("test_file", &buf);
 
-	cleanup();
-	tst_exit();
+	TST_EXP_EQ_LI(ltpuser->pw_gid, buf.st_gid);
 }
 
 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	ltpuser = SAFE_GETPWNAM("nobody");
 
-	GID16_CHECK(ltpuser->pw_gid, "setresgid", cleanup)
+	GID16_CHECK(ltpuser->pw_gid, "setresgid");
 }
 
-static void setresgid_verify(void)
-{
-	struct stat buf;
-
-	TEST(SETRESGID(cleanup, -1, ltpuser->pw_gid, -1));
-
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "setresgid failed unexpectedly");
-		return;
-	}
-
-	SAFE_TOUCH(cleanup, "test_file", 0644, NULL);
-
-	SAFE_STAT(cleanup, "test_file", &buf);
-
-	if (ltpuser->pw_gid == buf.st_gid) {
-		tst_resm(TPASS, "setresgid succeeded as expected");
-	} else {
-		tst_resm(TFAIL,
-			 "setresgid failed unexpectedly; egid(%d) - st_gid(%d)",
-			 ltpuser->pw_gid, buf.st_gid);
-	}
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
