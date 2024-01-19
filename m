Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D84C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 08:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 408913CE2D1
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:59:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60B8F3CBE8F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 09:59:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B31691BB8772
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 09:59:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA7C921C89;
 Fri, 19 Jan 2024 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705654781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OpYmR+ffAldPlrxGrFqLMcJYSS3PL5GhjYPIudb3wdM=;
 b=K8XeSgy1s0HcTDfaSiK9AuShaMchcFkR69REjAwhCx7BmZqZD092TVe89Zq79X3VwmcKd5
 TUnrvkjjGG2/1alRBoUwbO/p6QWntEhniQLXQnHi3Acl2QvMuYOsd9ZK7jvlOsDSj5wm+3
 Lvn7iiRbFl3eRblhoisfz6UB6etN3kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705654781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OpYmR+ffAldPlrxGrFqLMcJYSS3PL5GhjYPIudb3wdM=;
 b=FwFpOoWsnVvivmPxf24JhDESOgi5wp3keDyqwJmfyd+gSVUtyB+QVhasuxa9k/G/dTimF2
 3TroT3c2Yr96g/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705654780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OpYmR+ffAldPlrxGrFqLMcJYSS3PL5GhjYPIudb3wdM=;
 b=ZbfAlVtf2tozgWwzchvRl+yX/+XS84lk4AaKE95iU90jS8YUo5a397dI9fFXs7N79mfXEV
 CS2gS3zK/lB4lJN4ibtb8sOcDmqy3w8eK6JsuLKf9XBq1RwSuvKh95lppexn6qd0Afsv0l
 9n8DOCKMejekT4+EZ8l8yZUpWoYcn38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705654780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OpYmR+ffAldPlrxGrFqLMcJYSS3PL5GhjYPIudb3wdM=;
 b=jrAX+pjQ47ooNM/YwROu7UHYKTnTbNOyVRP94n8VK3ArSvpezkH7uXeACBN46zayxK5J8+
 I4/qXXyef/qO82Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1598136F5;
 Fri, 19 Jan 2024 08:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9hlGKPw5qmUESwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 08:59:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 09:59:39 +0100
Message-Id: <20240119085939.11801-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZbfAlVtf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jrAX+pjQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EA7C921C89
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add chdir05 test
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
chdir() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/chdir/.gitignore |  1 +
 testcases/kernel/syscalls/chdir/chdir05.c  | 58 ++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/chdir/chdir05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..68460de0b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -61,8 +61,8 @@ capset04 capset04
 cacheflush01 cacheflush01
 
 chdir01 chdir01
-chdir01A symlink01 -T chdir01
 chdir04 chdir04
+chdir05 chdir05
 
 chmod01 chmod01
 chmod01A symlink01 -T chmod01
diff --git a/testcases/kernel/syscalls/chdir/.gitignore b/testcases/kernel/syscalls/chdir/.gitignore
index 1b15eb6b9..96dc538f1 100644
--- a/testcases/kernel/syscalls/chdir/.gitignore
+++ b/testcases/kernel/syscalls/chdir/.gitignore
@@ -1,2 +1,3 @@
 /chdir01
 /chdir04
+/chdir05
diff --git a/testcases/kernel/syscalls/chdir/chdir05.c b/testcases/kernel/syscalls/chdir/chdir05.c
new file mode 100644
index 000000000..d9fa94a13
--- /dev/null
+++ b/testcases/kernel/syscalls/chdir/chdir05.c
@@ -0,0 +1,58 @@
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
+ * This test verifies that chdir() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+static void test_chdir(void)
+{
+	char *symname = "my_symlink0";
+
+	SAFE_SYMLINK(tst_get_tmpdir(), symname);
+	TST_EXP_PASS(chdir(symname));
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_chdir_no_path(void)
+{
+	char *symname = "my_symlink1";
+
+	SAFE_SYMLINK("bc+eFhi!k", symname);
+	TST_EXP_FAIL(chdir(symname), ENOENT);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_chdir_loop(void)
+{
+	char *symname = "my_symlink2";
+
+	TST_EXP_PASS(symlink(symname, symname));
+	TST_EXP_FAIL(chdir(symname), ELOOP);
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_chdir();
+	test_chdir_no_path();
+	test_chdir_loop();
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
