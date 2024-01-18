Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AB1C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 15:35:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E648F3CFCC5
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 16:35:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FD3E3C1DC2
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:35:17 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37882201101
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:35:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 619931F78C;
 Thu, 18 Jan 2024 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705592115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sXK6kvIKFKmIbMdiaAj3KygQouHu3N8dKAgFC4VS2PY=;
 b=McNk0894ZjHvfrtaXjUbgJhw+xx/z8NuWlOXvhYZBjf1dPKKsfvC634vrr7v9kpPhVw3Zk
 X2unqHIFS9y2w6mJXNJbVgnOjbzhRAD0DyfHLKqmoyRCrtFXUDRV6TzQZeS9Y3pACVXitF
 VgakKiB+vIXL8RqrFE4Ir+oIuhYsYK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705592115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sXK6kvIKFKmIbMdiaAj3KygQouHu3N8dKAgFC4VS2PY=;
 b=hAk56HShny3j4rKYAIHIu11nfl0ycNmMpHII2HepLhF9Af0unXey5Sgr1a8wvYxnPa8QOY
 9MceqzbGGnCpJ9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705592115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sXK6kvIKFKmIbMdiaAj3KygQouHu3N8dKAgFC4VS2PY=;
 b=McNk0894ZjHvfrtaXjUbgJhw+xx/z8NuWlOXvhYZBjf1dPKKsfvC634vrr7v9kpPhVw3Zk
 X2unqHIFS9y2w6mJXNJbVgnOjbzhRAD0DyfHLKqmoyRCrtFXUDRV6TzQZeS9Y3pACVXitF
 VgakKiB+vIXL8RqrFE4Ir+oIuhYsYK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705592115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sXK6kvIKFKmIbMdiaAj3KygQouHu3N8dKAgFC4VS2PY=;
 b=hAk56HShny3j4rKYAIHIu11nfl0ycNmMpHII2HepLhF9Af0unXey5Sgr1a8wvYxnPa8QOY
 9MceqzbGGnCpJ9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D92713874;
 Thu, 18 Jan 2024 15:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x/kdCDNFqWXBMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jan 2024 15:35:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 16:35:14 +0100
Message-Id: <20240118153514.2436-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add mkdir10 test
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
mkdir() can't overwrite symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/mkdir/.gitignore |  1 +
 testcases/kernel/syscalls/mkdir/mkdir10.c  | 30 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/mkdir/mkdir10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8dd8a49ca..e62e793e3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -757,8 +757,8 @@ mkdir02 mkdir02
 mkdir03 mkdir03
 mkdir04 mkdir04
 mkdir05 mkdir05
-mkdir05A symlink01 -T mkdir05
 mkdir09 mkdir09
+mkdir10 mkdir10
 
 #mkdirat test cases
 mkdirat01 mkdirat01
diff --git a/testcases/kernel/syscalls/mkdir/.gitignore b/testcases/kernel/syscalls/mkdir/.gitignore
index 880ff50c0..416fbbd7c 100644
--- a/testcases/kernel/syscalls/mkdir/.gitignore
+++ b/testcases/kernel/syscalls/mkdir/.gitignore
@@ -3,3 +3,4 @@
 /mkdir04
 /mkdir05
 /mkdir09
+/mkdir10
diff --git a/testcases/kernel/syscalls/mkdir/mkdir10.c b/testcases/kernel/syscalls/mkdir/mkdir10.c
new file mode 100644
index 000000000..b0c0993ba
--- /dev/null
+++ b/testcases/kernel/syscalls/mkdir/mkdir10.c
@@ -0,0 +1,30 @@
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
+ * This test verifies that mkdir() can't overwrite symlink() generated files.
+ */
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	char *symname = "my_symlink0";
+
+	SAFE_SYMLINK(tst_get_tmpdir(), symname);
+	TST_EXP_FAIL(mkdir(symname, 0777), EEXIST);
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
