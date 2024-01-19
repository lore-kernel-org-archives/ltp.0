Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E4EC4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:07:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 892953CE2CB
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 10:07:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D4543C8ADF
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:07:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 877D2602BBD
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:07:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F01E21E22;
 Fri, 19 Jan 2024 09:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705655235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ReBwMbgl3s95MxH+TDqMzqIRvYgs+DDEi+wsFd29fJY=;
 b=wplKJ6VqDBjjfE+8nXpvBbnDBNzbz0nnotYpHxx8E1cUbVoulF4LkSOOymHoosTArzet/2
 YKZCxTIRU3XS5yhW8PAOnzZj8mClWUI/N2sGocXKzgtU3zaRli2pG0ljhZyVh8JLzPVwwh
 aUrG05Uq2USghCEVyr/gWfn+rxT+Q1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705655235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ReBwMbgl3s95MxH+TDqMzqIRvYgs+DDEi+wsFd29fJY=;
 b=prmlyXQu8QghR4hD/LMDl/4YnhpozSLEqIcHl/GrCaJgzVuZ7JrY4YNvGc1DMpEhzNTlvy
 cYA3EeHPuuDEbTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705655235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ReBwMbgl3s95MxH+TDqMzqIRvYgs+DDEi+wsFd29fJY=;
 b=wplKJ6VqDBjjfE+8nXpvBbnDBNzbz0nnotYpHxx8E1cUbVoulF4LkSOOymHoosTArzet/2
 YKZCxTIRU3XS5yhW8PAOnzZj8mClWUI/N2sGocXKzgtU3zaRli2pG0ljhZyVh8JLzPVwwh
 aUrG05Uq2USghCEVyr/gWfn+rxT+Q1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705655235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ReBwMbgl3s95MxH+TDqMzqIRvYgs+DDEi+wsFd29fJY=;
 b=prmlyXQu8QghR4hD/LMDl/4YnhpozSLEqIcHl/GrCaJgzVuZ7JrY4YNvGc1DMpEhzNTlvy
 cYA3EeHPuuDEbTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A0B136F5;
 Fri, 19 Jan 2024 09:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YfFuBsM7qmV5TQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 09:07:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 10:07:13 +0100
Message-Id: <20240119090713.13753-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add link01 test
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

This test verifies that link() is working correctly on symlink()
generated files, renaming the symbolic link and checking that
stat() information are preserved.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                        |  2 +-
 testcases/kernel/syscalls/link/link01.c | 47 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/link/link01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 68460de0b..00a0dd87e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -692,7 +692,7 @@ lchown03_16 lchown03_16
 lgetxattr01 lgetxattr01
 lgetxattr02 lgetxattr02
 
-link01 symlink01 -T link01
+link01 link01
 link02 link02
 link04 link04
 link05 link05
diff --git a/testcases/kernel/syscalls/link/link01.c b/testcases/kernel/syscalls/link/link01.c
new file mode 100644
index 000000000..e1cda7054
--- /dev/null
+++ b/testcases/kernel/syscalls/link/link01.c
@@ -0,0 +1,47 @@
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
+ * This test verifies that link() is working correctly on symlink()
+ * generated files, renaming the symbolic link and checking that
+ * stat() information are preserved.
+ */
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	struct stat oldlink_stat;
+	struct stat newlink_stat;
+	char *symname0 = "my_symlink0";
+	char *symname1 = "my_symlink1";
+
+	SAFE_SYMLINK(tst_get_tmpdir(), symname0);
+	SAFE_STAT(symname0, &oldlink_stat);
+
+	SAFE_LINK(symname0, symname1);
+	SAFE_STAT(symname1, &newlink_stat);
+
+	TST_EXP_EQ_LI(oldlink_stat.st_ino, newlink_stat.st_ino);
+	TST_EXP_EQ_LI(oldlink_stat.st_nlink, newlink_stat.st_nlink);
+
+	if (TST_RET == -1) {
+		SAFE_UNLINK(symname0);
+		remove(symname1);
+	} else {
+		SAFE_UNLINK(symname1);
+		remove(symname0);
+	}
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
