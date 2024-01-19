Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FF7C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:23:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C02A23CE2CE
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 10:23:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD3753CBD8D
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:23:11 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9BA0F103AAC8
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:23:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D62A21F57;
 Fri, 19 Jan 2024 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705656189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vu/etRDOVyYwCsM3WFOd2FSocUBMUs37Lq4fL21GPe8=;
 b=k8TLUrpE0ota6OsYTX3zf6AczpqQdVqvN599lxm3EZeJBNw9/dUbn66OeSsVvbV6YuqPxG
 bo4MeqvQJ+YC0XlTAcDG/YWLKpHXaoMP2li0sZMp9bLwYhmERAGRXyw3/2gr4UjBxmskNu
 Zwa17NgyEQInuzzVWBdRZjc533enMpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705656189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vu/etRDOVyYwCsM3WFOd2FSocUBMUs37Lq4fL21GPe8=;
 b=g1c5LrnYbhUAEWHhUxZQxJKNjmsG9R5qGL0dPefpFq80pp6D2GHGnYwft56LU1/AuW80DY
 UJCGBNY1WI3+iBBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705656189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vu/etRDOVyYwCsM3WFOd2FSocUBMUs37Lq4fL21GPe8=;
 b=k8TLUrpE0ota6OsYTX3zf6AczpqQdVqvN599lxm3EZeJBNw9/dUbn66OeSsVvbV6YuqPxG
 bo4MeqvQJ+YC0XlTAcDG/YWLKpHXaoMP2li0sZMp9bLwYhmERAGRXyw3/2gr4UjBxmskNu
 Zwa17NgyEQInuzzVWBdRZjc533enMpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705656189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vu/etRDOVyYwCsM3WFOd2FSocUBMUs37Lq4fL21GPe8=;
 b=g1c5LrnYbhUAEWHhUxZQxJKNjmsG9R5qGL0dPefpFq80pp6D2GHGnYwft56LU1/AuW80DY
 UJCGBNY1WI3+iBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3937D1388C;
 Fri, 19 Jan 2024 09:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qq1zCX0/qmU0UgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 09:23:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 10:23:08 +0100
Message-Id: <20240119092308.20337-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k8TLUrpE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g1c5LrnY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,df01.sh:url,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 6D62A21F57
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add rename15 test
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
rename() is working correctly on symlink() generated files, renaming
symbolic link and checking if stat() information are preserved.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                           |  2 +-
 runtest/syscalls                            |  2 +-
 testcases/kernel/syscalls/rename/.gitignore |  1 +
 testcases/kernel/syscalls/rename/rename15.c | 41 +++++++++++++++++++++
 4 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/rename/rename15.c

diff --git a/runtest/smoketest b/runtest/smoketest
index 83eebfe7b..19fa257d6 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -10,7 +10,7 @@ write01 write01
 symlink01 symlink01
 stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
-rename01A symlink01 -T rename01
+rename15 rename15
 splice02 splice02 -s 20
 df01_sh df01.sh
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..ae058153b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1158,7 +1158,6 @@ removexattr01 removexattr01
 removexattr02 removexattr02
 
 rename01 rename01
-rename01A symlink01 -T rename01
 rename03 rename03
 rename04 rename04
 rename05 rename05
@@ -1171,6 +1170,7 @@ rename11 rename11
 rename12 rename12
 rename13 rename13
 rename14 rename14
+rename15 rename15
 
 #renameat test cases
 renameat01 renameat01
diff --git a/testcases/kernel/syscalls/rename/.gitignore b/testcases/kernel/syscalls/rename/.gitignore
index f95cf7d21..d17b80f09 100644
--- a/testcases/kernel/syscalls/rename/.gitignore
+++ b/testcases/kernel/syscalls/rename/.gitignore
@@ -11,3 +11,4 @@
 /rename12
 /rename13
 /rename14
+/rename15
diff --git a/testcases/kernel/syscalls/rename/rename15.c b/testcases/kernel/syscalls/rename/rename15.c
new file mode 100644
index 000000000..ae7f330b6
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename15.c
@@ -0,0 +1,41 @@
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
+ * This test verifies that rename() is working correctly on symlink()
+ * generated files, renaming symbolic link and checking if stat() information
+ * are preserved.
+ */
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	char *oldname = "my_symlink0";
+	char *newname = "asymlink";
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_SYMLINK(tst_get_tmpdir(), oldname);
+	SAFE_STAT(oldname, &oldsym_stat);
+
+	SAFE_RENAME(oldname, newname);
+	SAFE_STAT(newname, &newsym_stat);
+
+	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
+	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);
+
+	SAFE_UNLINK(newname);
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
