Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28378C47DB7
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 08:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863FF3CE2D1
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:56:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E46A3CBE8F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 09:56:25 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E77960073E
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 09:56:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F228921B54;
 Fri, 19 Jan 2024 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705654584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lcV3OK8TMFKenbllCXWyNHlhZ4Smo6Inng1iqeB8cOU=;
 b=SjRqbHzW4ih54ihXzpr0VpMFIAcb5xaOLk0s0ec6kPkSEqvxuIjFDKzc0cP8WFnnmlWiRs
 WqvPI8X+2CYFgjTJBBp9CGPdc4ffMyrx5COfZ057YKon8VX1vnGmiVAok9suqBOpYw5RlH
 3IdeFaNZ49OBP2cTzHxuIfhGhvGj1ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705654584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lcV3OK8TMFKenbllCXWyNHlhZ4Smo6Inng1iqeB8cOU=;
 b=DYlz44vIxWnNofP6WBqFifu1tnd0H6PdH87hwAA13k2cw5hJMMoT824MMZCPEZd4hVj2oV
 xNcK4KcwW2B86mAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705654583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lcV3OK8TMFKenbllCXWyNHlhZ4Smo6Inng1iqeB8cOU=;
 b=CT8ns9MWwD+NM8wpliIfaPyVtp1xCG+wfy2WZgIDiQJuo5TOAfxkyzkzxt44u1sv10POj/
 CI1wp+dwBHLw+4AFmNt31215PUAc1j5WmVvuIbslJJcGgaOyjQoHvj1UFintAUA/ai92fZ
 C4KhCRQxLcChAWYTyQ9DCOUXF8V54t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705654583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lcV3OK8TMFKenbllCXWyNHlhZ4Smo6Inng1iqeB8cOU=;
 b=B4TYyls5g2KSZ/fQilgzZVZEIDuA6Y9Wsn6Sdie90X93GCE5KjfVVEO/SR2txxrhfNviTa
 EO1h282uwldD2pCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE6B8136F5;
 Fri, 19 Jan 2024 08:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8tenKzc5qmX9SQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 08:56:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 09:56:22 +0100
Message-Id: <20240119085622.10743-1-andrea.cervesato@suse.de>
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
Subject: [LTP] [PATCH v1] Add rmdir04 test
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

This test has been extracted from symlink01 test and it verifies
rmdir() syscall functionalities on symlink generated file.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/rmdir/.gitignore |  1 +
 testcases/kernel/syscalls/rmdir/rmdir04.c  | 30 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/rmdir/rmdir04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..2c82a7f98 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1187,7 +1187,7 @@ request_key05 request_key05
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
-rmdir03A symlink01 -T rmdir03
+rmdir04 rmdir04
 
 rt_sigaction01 rt_sigaction01
 rt_sigaction02 rt_sigaction02
diff --git a/testcases/kernel/syscalls/rmdir/.gitignore b/testcases/kernel/syscalls/rmdir/.gitignore
index 1a1e18066..c68c174dc 100644
--- a/testcases/kernel/syscalls/rmdir/.gitignore
+++ b/testcases/kernel/syscalls/rmdir/.gitignore
@@ -1,3 +1,4 @@
 /rmdir01
 /rmdir02
 /rmdir03
+/rmdir04
diff --git a/testcases/kernel/syscalls/rmdir/rmdir04.c b/testcases/kernel/syscalls/rmdir/rmdir04.c
new file mode 100644
index 000000000..4c8f11d50
--- /dev/null
+++ b/testcases/kernel/syscalls/rmdir/rmdir04.c
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
+ * This test verifies that rmdir() can't overwrite symlink() generated files.
+ */
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	char *symname = "my_symlink0";
+
+	SAFE_SYMLINK(tst_get_tmpdir(), symname);
+	TST_EXP_FAIL(rmdir(symname), ENOTDIR);
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
