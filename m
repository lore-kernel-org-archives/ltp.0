Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EAEC3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 07:45:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 024F43C0169
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 09:45:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 408763C0746
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 09:44:13 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CBF92200B8A
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 09:44:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DB4F218FC;
 Thu, 11 Jul 2024 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720683851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFBMhviU1s9E+148oaI3B5T8XXeDf6iADu55xc4GtrM=;
 b=gShl566KkgiJhCWuhMTXXEHB0Ihmw7TsO/rZkTYT6Mh7bdNTx3lam07zqIsW8GE65bNJMj
 +niVzHRyVJlMxhw8utOHc8BGx3kiJe7/xJ8XeDlQeHNcfY0QXVe1+mNVmmt/HG1o3558PJ
 E+phP/Wdl9KiVRoSAlq4wpRGEdzRK/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720683851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFBMhviU1s9E+148oaI3B5T8XXeDf6iADu55xc4GtrM=;
 b=O02afHmSA3F1RRrsAGTw4+YgLcNrlOlYR0hb+C+GxyS13k0CbaEsBvFj20RvuR0yGEnAqo
 15WvjtH/qumAYrCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gShl566K;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O02afHmS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720683851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFBMhviU1s9E+148oaI3B5T8XXeDf6iADu55xc4GtrM=;
 b=gShl566KkgiJhCWuhMTXXEHB0Ihmw7TsO/rZkTYT6Mh7bdNTx3lam07zqIsW8GE65bNJMj
 +niVzHRyVJlMxhw8utOHc8BGx3kiJe7/xJ8XeDlQeHNcfY0QXVe1+mNVmmt/HG1o3558PJ
 E+phP/Wdl9KiVRoSAlq4wpRGEdzRK/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720683851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFBMhviU1s9E+148oaI3B5T8XXeDf6iADu55xc4GtrM=;
 b=O02afHmSA3F1RRrsAGTw4+YgLcNrlOlYR0hb+C+GxyS13k0CbaEsBvFj20RvuR0yGEnAqo
 15WvjtH/qumAYrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17984139E7;
 Thu, 11 Jul 2024 07:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNx1BEuNj2a3FQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 07:44:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 09:43:53 +0200
MIME-Version: 1.0
Message-Id: <20240711-stat04-v4-1-d30c26fdaf5a@suse.com>
References: <20240711-stat04-v4-0-d30c26fdaf5a@suse.com>
In-Reply-To: <20240711-stat04-v4-0-d30c26fdaf5a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4892;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=z92ZDQMOnsC6dbHBC11am3yMmgFThX6vi8MGuxCxSGA=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj40+484Yb+/CGDcmoGQEEVtH2RRBx5NLnLqoz
 /eYvFMggOiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+NPgAKCRDLzBqyILPm
 RgknDACp7S7T7gOcnlTmq4mhrF0PjMNvZ75/d5RHUZtnJWARKoij0IsMBkRGcU8YGuModfJvDql
 L75yn2oJMCa5wt3C6biVR4NQ+V8k24WN0u+N1pYj4Ynpjao8vu1mXkslJ9suhAs1XiPsYA6YXVx
 INg3DDPA5KNAdbcA2ougDws04VeKz8V+tsdbWPeGE5DpOPhCEhr6eVFJQcAdc8QOhmyoYlIbA2B
 H5rUh5STxtrWFMh6GcbwBuyHeFV+Fw9OOfjfE+82R5Ea0CVJhhQRYu1YRAdWrnH9u3FcEpIFAg6
 ONQMCo1YKcNP6Pf/l1plm3Q5s+en2umjB8dmKANeP7yn9smaIb1hf1irM5P2PRjxc2UMhk2kgWS
 OOgP09B1xlYlD7vzp3NhRRmYhWaq17YkeBjtiTuLyFkS2YmnrK7eOkw1PhPWe7w/zUJm9eDwQaC
 nSu7IvWtU/NsixHbvhdchx2KIx5qtivqQ0BnJiho0a0rjw6sX9KdFogb9/5QzparrLxVQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3DB4F218FC
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] Add stat04 test
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                         |   4 +-
 runtest/syscalls                          |   4 +-
 testcases/kernel/syscalls/stat/.gitignore |   2 +
 testcases/kernel/syscalls/stat/stat04.c   | 109 ++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index f6f14fd2b..aeb74c9ee 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -8,9 +8,7 @@ time01 time01
 wait02 wait02
 write01 write01
 symlink01 symlink01
-stat04 symlink01 -T stat04
-utime07 utime07
-rename01A symlink01 -T rename01
+stat04 stat04
 splice02 splice02 -s 20
 df01_sh df01.sh
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
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
index 000000000..8dbf58a1d
--- /dev/null
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -0,0 +1,109 @@
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
+#include "tst_safe_stdio.h"
+
+#define FILENAME "file.txt"
+#define MNTPOINT "mntpoint"
+#define SYMBNAME MNTPOINT"/file_symlink"
+
+static char *symb_path;
+static char *file_path;
+static struct stat *file_stat;
+static struct stat *symb_stat;
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
+	char *tmpdir;
+	const char *const fs_opts[] = {opt_bsize, NULL};
+	struct stat sb;
+	int pagesize;
+	int fd;
+
+	tmpdir = tst_get_tmpdir();
+	SAFE_ASPRINTF(&file_path, "%s/%s", tmpdir, FILENAME);
+	SAFE_ASPRINTF(&symb_path, "%s/%s", tmpdir, SYMBNAME);
+	free(tmpdir);
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
+	SAFE_SYMLINK(file_path, symb_path);
+}
+
+static void cleanup(void)
+{
+	if (file_path)
+		free(file_path);
+
+	if (symb_path)
+		free(symb_path);
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
