Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2BCC3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:17:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 415833D1C30
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:17:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78B8E3D1143
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A6B1060098C
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A316321BBD;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s82fvEmHWwImPW7A3P+OEd8PtNxfY0qWZ5EiW0WVRXc=;
 b=EzEhi9EeUQMEfLchuiHzVaw12IqT6oQ0Ptwapnd43FVGZl70bVCeQhzCOP1GN7sU8TfZ5j
 bU/hvXzCjoZ7Na0fRM41qsnwTP0DBDzmzDFybA1w2zbH7npJ1VYicVjmdtFfvUmTLSPVfQ
 v1bBk8+RDwbtWxz4LoIOg2u9QnCqaPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s82fvEmHWwImPW7A3P+OEd8PtNxfY0qWZ5EiW0WVRXc=;
 b=jIsGXWrNjuIMYn412O84r5XA0vQ4Rm5iUU0PRZm6jkcMuO6KIbJSrLxhXOouLPVoC2Vm9J
 On8RlYzEmJy2c2BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EzEhi9Ee;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jIsGXWrN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s82fvEmHWwImPW7A3P+OEd8PtNxfY0qWZ5EiW0WVRXc=;
 b=EzEhi9EeUQMEfLchuiHzVaw12IqT6oQ0Ptwapnd43FVGZl70bVCeQhzCOP1GN7sU8TfZ5j
 bU/hvXzCjoZ7Na0fRM41qsnwTP0DBDzmzDFybA1w2zbH7npJ1VYicVjmdtFfvUmTLSPVfQ
 v1bBk8+RDwbtWxz4LoIOg2u9QnCqaPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s82fvEmHWwImPW7A3P+OEd8PtNxfY0qWZ5EiW0WVRXc=;
 b=jIsGXWrNjuIMYn412O84r5XA0vQ4Rm5iUU0PRZm6jkcMuO6KIbJSrLxhXOouLPVoC2Vm9J
 On8RlYzEmJy2c2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8624E1393E;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MO2vHpRYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:05 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-5-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5272;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=iAYBO/nfeDi0f0SF6T2VXBMazXDxaTF+OKQQKdSgUZ8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h++fseYSwJlZ7uP91GTfJ32eHM6TVM8HGXL
 1XTCgHn2j6JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 Rgc6C/9ADD8YweYyIwkKUkY5MBrWW2rjSN74ngXftoPNP/zmLMFPRHSkv6+/OYOMCkRqEywjUBM
 Ziq67DzxamJpg2h128lyRzVLHP/OFld/2HVunnYjLAYCG7yphdOp6lsnutC81O1V4Q4WfysJFmw
 MyKrC5pSAzQMfPkITWMcgbsBKZZ3vaf+2SWRuhvrDuTHKiXUBDKa5qXe+BN1oYnx4PVbeKHMWOZ
 3N01/0at28hK12Hx25GVO9Q3DIHzQXuzF9FmBZlbES2eVZG1PipsFEfJi6OBds4IzpeXv7wnq4f
 zDKw8gOWUHxDuAvuI/QERUVsxSF/QfoPuAPPub/TWEln3+C8zv/SmFTgj8paRtCqgbd0WAbaSF8
 zNkwjBO2t4vYOm5sBO9MlH77w24LPJ/A73laBpOpu+os5Y1o2z5jdQHTpb5fRUAGroSUJQNgkDo
 yX4BirqunwgvLjW8YmR93djhwodZOPjObg6aqsoSBIcJDigrBgJ46M88dnBGrESpHoPMg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A316321BBD
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/7] Add ioctl_ficlonerange01 test
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

This test verifies that ioctl() FICLONERANGE feature clones file
content from one file to an another.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore         |   1 +
 .../kernel/syscalls/ioctl/ioctl_ficlonerange01.c   | 162 +++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 5aef2b97e..1f050c5f5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -595,6 +595,7 @@ ioctl_sg01 ioctl_sg01
 ioctl_ficlone01 ioctl_ficlone01
 ioctl_ficlone02 ioctl_ficlone02
 ioctl_ficlone03 ioctl_ficlone03
+ioctl_ficlonerange01 ioctl_ficlonerange01
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index d0b470714..08c015928 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -25,3 +25,4 @@
 /ioctl_ficlone01
 /ioctl_ficlone02
 /ioctl_ficlone03
+/ioctl_ficlonerange01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
new file mode 100644
index 000000000..122b7656f
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONERANGE feature clones file content from
+ * one file to an another.
+ *
+ * [Algorithm]
+ *
+ * - populate source file
+ * - clone a portion of source content inside destination file
+ * - verify that source content portion has been cloned inside destination file
+ * - write a single byte inside destination file
+ * - verify that source content didn't change while destination did
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+#define SRCPATH MNTPOINT "/file0"
+#define DSTPATH MNTPOINT "/file1"
+#define CHUNKS 64
+
+static struct file_clone_range *clone_range;
+static int filesize;
+static int offset;
+static int leftsize;
+static int src_fd = -1;
+static int dst_fd = -1;
+static char *data;
+static char *buff;
+
+static void run(void)
+{
+	struct stat src_stat;
+	struct stat dst_stat;
+
+	for (int i = 0; i < filesize; i++)
+		data[i] = 'a' + (rand() % 21);
+
+	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
+	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
+
+	tst_res(TINFO, "Writing data inside src file");
+
+	SAFE_WRITE(SAFE_WRITE_ALL, src_fd, data, filesize);
+	SAFE_FSYNC(src_fd);
+
+	clone_range->src_fd = src_fd;
+	TST_EXP_PASS(ioctl(dst_fd, FICLONERANGE, clone_range));
+	if (TST_RET == -1)
+		return;
+
+	SAFE_FSYNC(dst_fd);
+
+	tst_res(TINFO, "Verifing that data is cloned between files");
+
+	SAFE_FSTAT(src_fd, &src_stat);
+	SAFE_FSTAT(dst_fd, &dst_stat);
+
+	TST_EXP_EXPR(src_stat.st_ino != dst_stat.st_ino,
+		"inode is different. %lu != %lu",
+		src_stat.st_ino,
+		dst_stat.st_ino);
+
+	TST_EXP_EQ_LI(src_stat.st_size, filesize);
+	TST_EXP_EQ_LI(dst_stat.st_size, leftsize);
+
+	SAFE_READ(0, dst_fd, buff, leftsize);
+
+	TST_EXP_EXPR(!strncmp(buff, data + offset, leftsize),
+		"dst file has been cloned (%d bytes)",
+		leftsize);
+
+	tst_res(TINFO, "Writing a byte inside dst file");
+
+	SAFE_LSEEK(dst_fd, 0, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, dst_fd, "!", 1);
+	SAFE_FSYNC(dst_fd);
+
+	tst_res(TINFO, "Verifing that src file content didn't change");
+
+	SAFE_FSTAT(src_fd, &src_stat);
+	SAFE_FSTAT(dst_fd, &dst_stat);
+
+	TST_EXP_EQ_LI(src_stat.st_size, filesize);
+	TST_EXP_EQ_LI(dst_stat.st_size, leftsize);
+
+	SAFE_LSEEK(src_fd, 0, SEEK_SET);
+	SAFE_READ(0, src_fd, buff, filesize);
+
+	TST_EXP_EXPR(!strncmp(buff, data, filesize),
+		"src file content didn't change");
+
+	SAFE_CLOSE(src_fd);
+	SAFE_CLOSE(dst_fd);
+
+	SAFE_UNLINK(SRCPATH);
+	SAFE_UNLINK(DSTPATH);
+}
+
+static void setup(void)
+{
+	struct stat sb;
+
+	SAFE_STAT(MNTPOINT, &sb);
+
+	filesize = sb.st_blksize * CHUNKS;
+	offset = filesize / 4;
+	leftsize = filesize - offset;
+
+	clone_range->src_offset = offset;
+	clone_range->src_length = leftsize;
+	clone_range->dest_offset = 0;
+
+	data = (char *)SAFE_MALLOC(filesize);
+	buff = (char *)SAFE_MALLOC(filesize);
+
+	srand(time(NULL));
+}
+
+static void cleanup(void)
+{
+	if (buff)
+		free(buff);
+
+	if (data)
+		free(data);
+
+	if (src_fd != -1)
+		SAFE_CLOSE(src_fd);
+
+	if (dst_fd != -1)
+		SAFE_CLOSE(dst_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.filesystems = (struct tst_fs []) {
+		{.type = "btrfs"},
+		{
+			.type = "xfs",
+			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
+		},
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&clone_range, .size = sizeof(struct file_clone_range)},
+		{},
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
