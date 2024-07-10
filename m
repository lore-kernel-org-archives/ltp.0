Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B745C3DA45
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:55:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 886CB3D3840
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 10:55:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2543C3D3822
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:46 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A14E61401237
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EFC61FE3D;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tTfB0QrErMvoUhqCi7SbNumTlRxqgf/Bk/9aVEmE9s=;
 b=jsu4WBYh+8Hp9/yXYlhsLM16OPidXHY6LUsygAueDUv8knbpxVExQVheIPWiisL0joZSJY
 iCs1fCOobSnm+nlrOgLTlKg2ovy/X6fZD8DYmqsWkzPemySecGm9NMN5EtkpI2Wf4C1T+B
 RnzNpeqQoSvwy+Wm8yDaCuAWCmF1Ju8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tTfB0QrErMvoUhqCi7SbNumTlRxqgf/Bk/9aVEmE9s=;
 b=dU+4OGatU7Fp2Etz6ofDepnvk9p/GT0VjzN3zqJqY6vKTaPO2qu5HbGWK9z+YduCiYGrM2
 XraKRX+61ek/mrAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tTfB0QrErMvoUhqCi7SbNumTlRxqgf/Bk/9aVEmE9s=;
 b=jsu4WBYh+8Hp9/yXYlhsLM16OPidXHY6LUsygAueDUv8knbpxVExQVheIPWiisL0joZSJY
 iCs1fCOobSnm+nlrOgLTlKg2ovy/X6fZD8DYmqsWkzPemySecGm9NMN5EtkpI2Wf4C1T+B
 RnzNpeqQoSvwy+Wm8yDaCuAWCmF1Ju8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tTfB0QrErMvoUhqCi7SbNumTlRxqgf/Bk/9aVEmE9s=;
 b=dU+4OGatU7Fp2Etz6ofDepnvk9p/GT0VjzN3zqJqY6vKTaPO2qu5HbGWK9z+YduCiYGrM2
 XraKRX+61ek/mrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4216B1369A;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iBbkDlRMjmbFTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 08:54:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 10:54:22 +0200
MIME-Version: 1.0
Message-Id: <20240710-stat04-v3-2-c68a2324ad94@suse.com>
References: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
In-Reply-To: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4520;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=QaCHJAfUm3bsdDU/n4uiIryo42Pb9tbm4o7FwEHeEVE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjkxHS7zT94ALYmlLPcpmU2A9v5shK00Bl9enT
 DL95ijWiHGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo5MRwAKCRDLzBqyILPm
 Rqu9C/9ChSb2mmztVU09DC3HTVGadcvqqws8KMIGTSbokWrxba6RNKROnJD6JJcPII9MXoteBR7
 kLYBuKaGZvSZVQ9pgVD38f/2s3Tx/mvLUxpLiWQn+FIKftjLRcMd/ik1MMb6gnZtK3d3d12s3w4
 217vZyIB85o6yHE46iIkO9z4V+PggUSh1ndpMhMaCnk8WUWvcQ3zDR9Ni+TepP7wzlinzjKRssA
 xpzh/4xnH5dvFcgZpn9Ruw0jtgPRxhkTGtrwhNhj9WqUfOFna1v0j0xYaxtjWGaUoWBfHRv70hZ
 2elGNbi+dWCwLEB+iolsYtnmqf9fwMQ6ARR3E6wThcSBEHWoC80JaqcGyZRB/ob2XBzzN0zkQy8
 4b79qKmUS3VH6/1brXNmuvTHckQWYi5t207I8LERT5K6jGgAVU4xczSd/sCQoQUI2p7qPZMyTd7
 tE8bnN7RxcNrcy7N1oHCXBEoazlDpuUP/vxGgTiogJN4YfHyIRDXgMEMCnHRtOjIQjZPk=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] Add lstat03 test
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
lstat() provides the right information, according with device, access
time, block size, ownership, etc.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |   4 +-
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 102 +++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 1e1203503..160725893 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -725,12 +725,12 @@ lseek02 lseek02
 lseek07 lseek07
 lseek11 lseek11
 
-lstat01A symlink01 -T lstat01
-lstat01A_64 symlink01 -T lstat01_64
 lstat01 lstat01
 lstat01_64 lstat01_64
 lstat02 lstat02
 lstat02_64 lstat02_64
+lstat03 lstat03
+lstat03_64 lstat03_64
 
 mallinfo02 mallinfo02
 
diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
index a497a445f..72cba871f 100644
--- a/testcases/kernel/syscalls/lstat/.gitignore
+++ b/testcases/kernel/syscalls/lstat/.gitignore
@@ -2,3 +2,5 @@
 /lstat01_64
 /lstat02
 /lstat02_64
+/lstat03
+/lstat03_64
diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
new file mode 100644
index 000000000..134efb471
--- /dev/null
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that lstat() provides correct information according
+ * with device, access time, block size, ownership, etc.
+ * The implementation provides a set of tests which are specific for each one
+ * of the `struct stat` used to read file and symlink information.
+ */
+
+#include "tst_test.h"
+
+#define FILENAME "file.txt"
+#define MNTPOINT "mntpoint"
+#define SYMBNAME MNTPOINT"/file_symlink"
+
+static struct stat *file_stat;
+static struct stat *symb_stat;
+
+static void run(void)
+{
+	SAFE_LSTAT(FILENAME, file_stat);
+	SAFE_LSTAT(SYMBNAME, symb_stat);
+
+	TST_EXP_EXPR(file_stat->st_dev != symb_stat->st_dev);
+	TST_EXP_EXPR(file_stat->st_mode != symb_stat->st_mode);
+	TST_EXP_EXPR(file_stat->st_nlink != symb_stat->st_nlink);
+	TST_EXP_EXPR(file_stat->st_ino != symb_stat->st_ino);
+	TST_EXP_EXPR(file_stat->st_uid != symb_stat->st_uid);
+	TST_EXP_EXPR(file_stat->st_gid != symb_stat->st_gid);
+	TST_EXP_EXPR(file_stat->st_size != symb_stat->st_size);
+	TST_EXP_EXPR(file_stat->st_blocks != symb_stat->st_blocks);
+	TST_EXP_EXPR(file_stat->st_blksize != symb_stat->st_blksize);
+	TST_EXP_EXPR(file_stat->st_atime != symb_stat->st_atime);
+	TST_EXP_EXPR(file_stat->st_mtime != symb_stat->st_mtime);
+	TST_EXP_EXPR(file_stat->st_ctime != symb_stat->st_ctime);
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
+	SAFE_SYMLINK(FILENAME, SYMBNAME);
+}
+
+static void cleanup(void)
+{
+	if (access(SYMBNAME, F_OK) != -1)
+		SAFE_UNLINK(SYMBNAME);
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
