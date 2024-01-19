Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F053C47DD6
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AD9C3CC8C0
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 10:16:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5DE3C8ADF
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:16:18 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 126FA7A62BF
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:16:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7AB421EC3;
 Fri, 19 Jan 2024 09:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705655776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yshkmnZg02VndgTQ/wEGgOylYGY94JJgdvgOn0qfYQ=;
 b=XOR2AdfKsDOMfjHXXme9gme/etqs1vu2RNFUCUDHsRMGz/uiS5ArAf6tKVJ9FARASfg+9j
 IwUbTOhKN+YF9z8BGjDWSGKhIhx5jZnZZhyS/pzxTeVoZuO/JKcT9J9TnzlSC2GJQdVjiE
 y0KNK/e0cwqwMzGdlH/wQvHuD7KwV/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705655776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yshkmnZg02VndgTQ/wEGgOylYGY94JJgdvgOn0qfYQ=;
 b=vwigcTHkojTT8gCUVE1qma/iKHAyFeIfh7c7xs4wLPpfLA+TlSW++k5GI8j5PCx3JVvydM
 NvTJzQSQ5Dh7GCDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705655774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yshkmnZg02VndgTQ/wEGgOylYGY94JJgdvgOn0qfYQ=;
 b=eFiYv/kJHOBkds0aBeiAkhS+3zHjsyfmfKEht0q1OCVU0zV8l1MD4vIrejPcUCSaW1s3IH
 ItcJqEpGdnBjtrGKiAmDE7F2c4kyJMYq3QFa7IGCWAXEPdS0ggZyaiL8FaFa1HjNmNvhqy
 VzlMINCrn75sbD3wPHv3lDBag0L/pDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705655774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yshkmnZg02VndgTQ/wEGgOylYGY94JJgdvgOn0qfYQ=;
 b=4X37xkJfQx0hsO/F4vV99dgIlMFaCoYhJKfgLOQ7Lcolh8yY4Q7K5g4UwB4N7pjXz+o4JW
 lNWrUGFf37r4Z0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66B411388C;
 Fri, 19 Jan 2024 09:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zOxjFd49qmVGUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 09:16:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 10:16:12 +0100
Message-Id: <20240119091612.17595-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,df01.sh:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add utime07 test
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

This test has been extracted from symlink01 test and it verifies that
utime() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                          |  2 +-
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/utime/.gitignore |  1 +
 testcases/kernel/syscalls/utime/utime07.c  | 78 ++++++++++++++++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/utime/utime07.c

diff --git a/runtest/smoketest b/runtest/smoketest
index 83eebfe7b..f6f14fd2b 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -9,7 +9,7 @@ wait02 wait02
 write01 write01
 symlink01 symlink01
 stat04 symlink01 -T stat04
-utime01A symlink01 -T utime01
+utime07 utime07
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 df01_sh df01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..5fd107e35 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1676,12 +1676,12 @@ ustat01 ustat01
 ustat02 ustat02
 
 utime01 utime01
-utime01A symlink01 -T utime01
 utime02 utime02
 utime03 utime03
 utime04 utime04
 utime05 utime05
 utime06 utime06
+utime07 utime07
 
 utimes01 utimes01
 
diff --git a/testcases/kernel/syscalls/utime/.gitignore b/testcases/kernel/syscalls/utime/.gitignore
index 94c0ae07c..403764521 100644
--- a/testcases/kernel/syscalls/utime/.gitignore
+++ b/testcases/kernel/syscalls/utime/.gitignore
@@ -4,3 +4,4 @@
 /utime04
 /utime05
 /utime06
+/utime07
diff --git a/testcases/kernel/syscalls/utime/utime07.c b/testcases/kernel/syscalls/utime/utime07.c
new file mode 100644
index 000000000..eaf832099
--- /dev/null
+++ b/testcases/kernel/syscalls/utime/utime07.c
@@ -0,0 +1,78 @@
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
+ * This test verifies that utime() is working correctly on symlink()
+ * generated files.
+ */
+
+#include <utime.h>
+#include "tst_test.h"
+
+static void test_utime(void)
+{
+	char *symname = "my_symlink0";
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_SYMLINK(tst_get_tmpdir(), symname);
+	SAFE_STAT(symname, &oldsym_stat);
+
+	struct utimbuf utimes = {
+		.actime = oldsym_stat.st_atime + 100,
+		.modtime = oldsym_stat.st_mtime + 100
+	};
+
+	TST_EXP_PASS(utime(symname, &utimes));
+	SAFE_STAT(symname, &newsym_stat);
+
+	time_t temp, diff;
+
+	temp = newsym_stat.st_atime - oldsym_stat.st_atime;
+	diff = newsym_stat.st_mtime - oldsym_stat.st_mtime - temp;
+
+	TST_EXP_EQ_LI(diff, 0);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_utime_no_path(void)
+{
+	char *symname = "my_symlink1";
+	struct utimbuf utimes;
+
+	SAFE_SYMLINK("bc+eFhi!k", symname);
+	TST_EXP_FAIL(utime(symname, &utimes), ENOENT);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_utime_loop(void)
+{
+	char *symname = "my_symlink2";
+	struct utimbuf utimes;
+
+	SAFE_SYMLINK(symname, symname);
+	TST_EXP_FAIL(utime(symname, &utimes), ELOOP);
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_utime();
+	test_utime_no_path();
+	test_utime_loop();
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
