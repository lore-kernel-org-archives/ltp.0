Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF38C3DA41
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:47:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4EB33D3963
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:47:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FDB43D121E
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 681CD600D6B
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B658821BAB;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2JNGeb3KSz0yVuxNtyOABw8gMNpGGgriVPteDBZufM=;
 b=tlpKw80yNO/uj/3XwPfJv90LEMbV9XoWLnNx13n16gUoz1yclfBiqYepIzlHzWmYBZy8gJ
 S8IbkDtlauxTABpqvZNyhXQdhTZ3TmQvcO83bb+LA7vYZBaScvpSvkMTdWi3sT+DyI5GEi
 naUE8x8ydlLgTYBPJDqmqZYKjUlao6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2JNGeb3KSz0yVuxNtyOABw8gMNpGGgriVPteDBZufM=;
 b=blbLm+GbD61ZLbEBG/bms7XSCqWqv1bKb872cAKqkODfqOIV44eaz66XbJPAH1qp+uolDf
 3FSeOm22Nb5UYyDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tlpKw80y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=blbLm+Gb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2JNGeb3KSz0yVuxNtyOABw8gMNpGGgriVPteDBZufM=;
 b=tlpKw80yNO/uj/3XwPfJv90LEMbV9XoWLnNx13n16gUoz1yclfBiqYepIzlHzWmYBZy8gJ
 S8IbkDtlauxTABpqvZNyhXQdhTZ3TmQvcO83bb+LA7vYZBaScvpSvkMTdWi3sT+DyI5GEi
 naUE8x8ydlLgTYBPJDqmqZYKjUlao6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2JNGeb3KSz0yVuxNtyOABw8gMNpGGgriVPteDBZufM=;
 b=blbLm+GbD61ZLbEBG/bms7XSCqWqv1bKb872cAKqkODfqOIV44eaz66XbJPAH1qp+uolDf
 3FSeOm22Nb5UYyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9872013A7B;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SE0uI+QUjWaBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jul 2024 10:45:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 12:45:33 +0200
MIME-Version: 1.0
Message-Id: <20240709-stat04-v2-3-2693a473a2ab@suse.com>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4440;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=LaGt2BQHjIwl+Pya3HlMjp0ptTvYuxjkRvHIeIquZBQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjRTXxCbmvUaekm/bbGctxI431BIVw/lrA5dsH
 8oUFQVqhs2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo0U1wAKCRDLzBqyILPm
 Rs9AC/9JWBC7D5NsTJAseggIXji2RSlUuaiv97wuqOWSgLh8R1kOsPQ2eNAWexdch7MxYMfarVQ
 qlTRUN0sWglxMcPxccO798qKkvNqZye1Ldnli2KSqYri08yE/dMOfAn5/KJ9fWAkRbC3uPxo0KN
 jFmasFEIKJqIPcJ765wX2VsGsmH2c6KN6JRB5I37BJqDy5n+sqU5Kb0Ly/wbhN0yIlM/sfJLwuF
 cSWrSQXVQ1DH7ubkGpUVNCrJM/iSFPYzHOkL0pkq32hkLlD/MTUTpBJMSByfS/4tdEkrmWGiGSK
 yVHK9ywb7mIkMpmaBRgEWX8oulZbzcyYGAzRGXUV3Pr4Z2uCya0ASgu7R+vpQB9r1yTqQgxUiCP
 oAU9qVzW+soDLgv2BqpqwmRMU3Trl4ikC5eBkPS0U0ZDBo8SPLVyszcxh3DdfUH2qkEZw0Q0ePa
 0QAioR69ORDX+kKGAmAGARJ+ooKBZ/5kOPMtHtoWaVVD2iHpLJWselaQsfc9sIQCuGH3I=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B658821BAB
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] Add lstat03 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |   4 +-
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 101 +++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 2 deletions(-)

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
index 000000000..b13fe9d80
--- /dev/null
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -0,0 +1,101 @@
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
