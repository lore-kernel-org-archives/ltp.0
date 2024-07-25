Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1552C3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4680F3D1CCE
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:24:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307703D0FA8
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:56 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83E1A100157F
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 819441F7F4;
 Thu, 25 Jul 2024 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te1i9yQSmZTcysXN9eYthZskH2hNABKThh5dAC2ldAU=;
 b=cg2fyhCtKlXlCudjAj81q6lwKJKztzit+kWwPgt8lzUx+2JYpI0ntBhHlmNlHnG9IrD35r
 8wvNUJzdHzwUQQL3HpE3MlE5QBWBvWwxLst1CAJvmJw9lqu7gOhHyGDB8dX2aegXF1pFAj
 dtZ6ENBNzEmSGRqrEudBjThFqBmgLkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te1i9yQSmZTcysXN9eYthZskH2hNABKThh5dAC2ldAU=;
 b=Jx9MCti/dO01fyEtFzF1wv+SB8SbmViHSb1+9QoxMlMj4ofilO7sCbcK6FeDn9a6LbKXIB
 FggL+QDWFNISTEBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te1i9yQSmZTcysXN9eYthZskH2hNABKThh5dAC2ldAU=;
 b=cg2fyhCtKlXlCudjAj81q6lwKJKztzit+kWwPgt8lzUx+2JYpI0ntBhHlmNlHnG9IrD35r
 8wvNUJzdHzwUQQL3HpE3MlE5QBWBvWwxLst1CAJvmJw9lqu7gOhHyGDB8dX2aegXF1pFAj
 dtZ6ENBNzEmSGRqrEudBjThFqBmgLkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te1i9yQSmZTcysXN9eYthZskH2hNABKThh5dAC2ldAU=;
 b=Jx9MCti/dO01fyEtFzF1wv+SB8SbmViHSb1+9QoxMlMj4ofilO7sCbcK6FeDn9a6LbKXIB
 FggL+QDWFNISTEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE2CF13927;
 Thu, 25 Jul 2024 09:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDZfL6kZombZNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jul 2024 09:23:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jul 2024 11:23:14 +0200
MIME-Version: 1.0
Message-Id: <20240725-landlock-v4-4-66f5a1c0c693@suse.com>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
In-Reply-To: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4095;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=qjcS9oXTsJzb+6qdr6YVA1thnLHOuzWBSr+7n7LzU/w=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmohmQw/8fgZPy+0KUH9dx73tEkGVqYrNxfvp+K
 jQaEKaH48aJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqIZkAAKCRDLzBqyILPm
 RsY8C/9G0+46cZrwQhqcUua24PM3rx3gfHQLWEyrwlS9fw87nYVNqMCYIOadYzZEfCmBzoCOTae
 yRsN58fM1ab3V3WVPE6nTvHQA/DZHSQlap0Qh3oI2GsNOa1g5OilcxYBCIyOu/+DT00bU+Dj0DN
 k9pgARHtdTEa7LTvzIZZO+opixvmWUO5h1kRFIZMFONIAeZsSqQu1acsnUNu9NLUVxc65yTGxgo
 j1j41ZPHihiF67QPuk9kRq+Q+EHmrJEkPN6O9G9cMsgDlSRJyiawylzM8IBHpkqflALJcySWKay
 0EChpJw4ORhP1u/R4c7/m55wf9/1XPOpQdrlHgMz1lih7zCyP9Ez3akGDebQKOMb1qu/4uMXVoe
 2da93XmN0t9mFEVv0XD2Ad7A9IydP/QFEdbjVZlPEIAt+bq8kYIIfVZLowrtDoFr0CUYYNFHkFL
 KowACrq+R9F/xDa3MPuHbp5VVg3xATc51sxw32u0effoJ3SVNDoTxAJ7BWqDXyM6bnOC8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/5] Add landlock05 test
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
Cc: mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test verifies LANDLOCK_ACCESS_FS_REFER access in the
landlock sandbox. The feature is available since kernel 5.19.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock05.c | 116 ++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 67b2e2758..6522f5bc7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -700,6 +700,7 @@ landlock01 landlock01
 landlock02 landlock02
 landlock03 landlock03
 landlock04 landlock04
+landlock05 landlock05
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index 4fe8d7cba..a7ea6be2e 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -3,3 +3,4 @@ landlock01
 landlock02
 landlock03
 landlock04
+landlock05
diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
new file mode 100644
index 000000000..6ad1fdb79
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies LANDLOCK_ACCESS_FS_REFER access in the
+ * landlock sandbox.
+ *
+ * [Algorithm]
+ *
+ * - apply LANDLOCK_ACCESS_FS_REFER in the folder1
+ * - apply LANDLOCK_ACCESS_FS_REFER in the folder2
+ * - create folder3
+ * - verify that file can be moved from folder1 to folder2
+ * - verify that file can't be moved from folder1 to folder3
+ */
+
+#include "landlock_common.h"
+
+#define MNTPOINT "sandbox"
+#define DIR1 MNTPOINT"/folder1"
+#define DIR2 MNTPOINT"/folder2"
+#define DIR3 MNTPOINT"/folder3"
+#define FILENAME1 DIR1"/file"
+#define FILENAME2 DIR2"/file"
+#define FILENAME3 DIR3"/file"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_path_beneath_attr *path_beneath_attr;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	TST_EXP_PASS(rename(FILENAME1, FILENAME2));
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_FAIL(rename(FILENAME2, FILENAME3), EXDEV);
+	TST_EXP_PASS(rename(FILENAME2, FILENAME1));
+
+	_exit(0);
+}
+
+static void setup(void)
+{
+	int ruleset_fd;
+
+	verify_landlock_is_enabled();
+
+	SAFE_MKDIR(DIR1, 0640);
+	SAFE_MKDIR(DIR2, 0640);
+	SAFE_MKDIR(DIR3, 0640);
+	SAFE_TOUCH(FILENAME1, 0640, NULL);
+
+	tst_res(TINFO, "Applying LANDLOCK_ACCESS_FS_REFER");
+
+	ruleset_attr->handled_access_fs =
+		LANDLOCK_ACCESS_FS_READ_FILE |
+		LANDLOCK_ACCESS_FS_WRITE_FILE |
+		LANDLOCK_ACCESS_FS_REFER;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	apply_landlock_rule(
+		path_beneath_attr,
+		ruleset_fd,
+		LANDLOCK_ACCESS_FS_REFER,
+		DIR1);
+
+	apply_landlock_rule(
+		path_beneath_attr,
+		ruleset_fd,
+		LANDLOCK_ACCESS_FS_REFER,
+		DIR2);
+
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "5.19",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+	.format_device = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"vfat",
+		"exfat",
+		NULL
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
