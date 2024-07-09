Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8BFC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:46:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 453DB3D395A
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:46:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0772B3D121E
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5CFF01A00CC5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF5621B17;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuYV/9ax/bcGqOis70BCXnINXEIkrvtAVNGaDDauJPs=;
 b=H6k8v3JxS/k6gnLt8q7p+Y+eaWd+sMt+jpBiGjHBew0d6NdJ9XeHhf6w79uk3G1YkV0rx+
 H2/oz5mYu2xOZelnBbBdqW8IBv9sBEpyUHml/QPle9TSMah/v7KbvHhV3fSPk1qrQc0dav
 r+28Wk/J/dWq2/C9aO8OWSz5FZdf09Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuYV/9ax/bcGqOis70BCXnINXEIkrvtAVNGaDDauJPs=;
 b=xaY/W2AGXzHoFHckBC7+TmquCCy9UHL7HEOPbXeFpa8Q62mbSELIB3cGZ/JsRoRJCqeXs0
 q7hSHRst8I8o6mDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H6k8v3Jx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xaY/W2AG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuYV/9ax/bcGqOis70BCXnINXEIkrvtAVNGaDDauJPs=;
 b=H6k8v3JxS/k6gnLt8q7p+Y+eaWd+sMt+jpBiGjHBew0d6NdJ9XeHhf6w79uk3G1YkV0rx+
 H2/oz5mYu2xOZelnBbBdqW8IBv9sBEpyUHml/QPle9TSMah/v7KbvHhV3fSPk1qrQc0dav
 r+28Wk/J/dWq2/C9aO8OWSz5FZdf09Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuYV/9ax/bcGqOis70BCXnINXEIkrvtAVNGaDDauJPs=;
 b=xaY/W2AGXzHoFHckBC7+TmquCCy9UHL7HEOPbXeFpa8Q62mbSELIB3cGZ/JsRoRJCqeXs0
 q7hSHRst8I8o6mDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B0A613A7B;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iOJpCOQUjWaBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jul 2024 10:45:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 12:45:31 +0200
MIME-Version: 1.0
Message-Id: <20240709-stat04-v2-1-2693a473a2ab@suse.com>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5146;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=shTyqVrEs8Mw5kHNITcCwdiwko0yR9XosgP1R/UQwII=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjRTXnexjpKaShH479W8/jmThetn1I6dHqHfIE
 aTpDRmE8aKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo0U1wAKCRDLzBqyILPm
 Ru6GDACms3iPDVPW+Y70gaDFw6PoteuTaOlTcs8abw11f7w/RIjf8R52UXBPxPekjDh0DYLf0rS
 2gjzX2dvmk+VgChkl0ch71hnTKPb1qnqy/56R4mEOLYGXORRNmWG447Rhp6aPDOIn8kLWyoWOrJ
 FRjr9hBR7TL49H9tKhpcCS7y4pXVYBhBtzjxPTtEs/WwutKY+LjMTq166IiKkeJQ2sv5SRD8k0i
 /Swt+XA1tkDaaAMgOXjf16EPoyl/Br3TrDIzDybkbuuNPXGs1uEacYwD/yTzBsxIb/qc8lqgxNC
 Ds0nFhPznN1rJ1lPFJEft0DBTkmCGDsqkUEd9P3dtYKyI+w/AGDb0FlmfnSDmSIbbe9QAaIt9FH
 NwlrE5wIDz8OQaXzyw9oMQ5Hjm3kkwvSH0zgQobiQ1W9Z7TodSvMUTOC6tt0MSqDNuH5rl+VJrk
 MJVcmw9MbfVe98ce/IVQ7SV1NxSFsTVoz0ZTbxZ87yCUsvr7+JtMxfpK8paq4b2S3cNnA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5AF5621B17
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] Add stat04 test
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
stat() executed on file provide the same information of symlink linking
to it.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                         |   4 +-
 runtest/syscalls                          |   4 +-
 testcases/kernel/syscalls/stat/.gitignore |   2 +
 testcases/kernel/syscalls/stat/stat04.c   | 120 ++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index f6f14fd2b..5608417f9 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -8,8 +8,8 @@ time01 time01
 wait02 wait02
 write01 write01
 symlink01 symlink01
-stat04 symlink01 -T stat04
-utime07 utime07
+stat04 stat04
+utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 df01_sh df01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index b6cadb2df..1e1203503 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1535,8 +1535,8 @@ stat02 stat02
 stat02_64 stat02_64
 stat03 stat03
 stat03_64 stat03_64
-stat04 symlink01 -T stat04
-stat04_64 symlink01 -T stat04_64
+stat04 stat04
+stat04_64 stat04_64
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
index fa0a4ce9f..0a62dc6ee 100644
--- a/testcases/kernel/syscalls/stat/.gitignore
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -4,3 +4,5 @@
 /stat02_64
 /stat03
 /stat03_64
+/stat04
+/stat04_64
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
new file mode 100644
index 000000000..4609f02d8
--- /dev/null
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test checks that stat() executed on file provide the same information
+ * of symlink linking to it.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define FILENAME "file.txt"
+#define MNTPOINT "mntpoint"
+#define SYMBNAME MNTPOINT"/file_symlink"
+
+static char symb_path[PATH_MAX];
+static char file_path[PATH_MAX];
+static struct stat *file_stat;
+static struct stat *symb_stat;
+static char *tmpdir;
+
+static void run(void)
+{
+	SAFE_STAT(file_path, file_stat);
+	SAFE_STAT(symb_path, symb_stat);
+
+	TST_EXP_EQ_LI(file_stat->st_dev, symb_stat->st_dev);
+	TST_EXP_EQ_LI(file_stat->st_mode, symb_stat->st_mode);
+	TST_EXP_EQ_LI(file_stat->st_nlink, symb_stat->st_nlink);
+	TST_EXP_EQ_LI(file_stat->st_uid, symb_stat->st_uid);
+	TST_EXP_EQ_LI(file_stat->st_gid, symb_stat->st_gid);
+	TST_EXP_EQ_LI(file_stat->st_size, symb_stat->st_size);
+	TST_EXP_EQ_LI(file_stat->st_atime, symb_stat->st_atime);
+	TST_EXP_EQ_LI(file_stat->st_mtime, symb_stat->st_mtime);
+	TST_EXP_EQ_LI(file_stat->st_ctime, symb_stat->st_ctime);
+}
+
+static void setup(void)
+{
+	char opt_bsize[32];
+	const char *const fs_opts[] = {opt_bsize, NULL};
+	struct stat sb;
+	int pagesize;
+	int fd;
+
+	tmpdir = tst_get_tmpdir();
+
+	if (strlen(tmpdir) >= (PATH_MAX - strlen(FILENAME))) {
+		tst_brk(TCONF, "Temporary folder name is too long. "
+			"Can't create file");
+	}
+
+	if (strlen(tmpdir) >= (PATH_MAX - strlen(SYMBNAME))) {
+		tst_brk(TCONF, "Temporary folder name is too long. "
+			"Can't create symbolic link");
+	}
+
+	/* change st_blksize / st_dev */
+	SAFE_STAT(".", &sb);
+	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
+
+	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
+
+	SAFE_TOUCH(FILENAME, 0777, NULL);
+
+	/* change st_nlink */
+	SAFE_LINK(FILENAME, "linked_file");
+
+	/* change st_uid and st_gid */
+	SAFE_CHOWN(FILENAME, 1000, 1000);
+
+	/* change st_size */
+	fd = SAFE_OPEN(FILENAME, O_WRONLY, 0777);
+	tst_fill_fd(fd, 'a', TST_KB, 500);
+	SAFE_CLOSE(fd);
+
+	/* change st_atime / st_mtime / st_ctime */
+	usleep(1001000);
+
+	memset(file_path, 0, PATH_MAX);
+	snprintf(file_path, PATH_MAX, "%s/%s", tmpdir, FILENAME);
+
+	memset(symb_path, 0, PATH_MAX);
+	snprintf(symb_path, PATH_MAX, "%s/%s", tmpdir, SYMBNAME);
+
+	SAFE_SYMLINK(file_path, symb_path);
+}
+
+static void cleanup(void)
+{
+	free(tmpdir);
+
+	SAFE_UNLINK(SYMBNAME);
+
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.mntpoint = MNTPOINT,
+	.bufs = (struct tst_buffers []) {
+		{&file_stat, .size = sizeof(struct stat)},
+		{&symb_stat, .size = sizeof(struct stat)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
