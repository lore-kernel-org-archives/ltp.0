Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3F0C25B78
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 07:16:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ED4A3D06F5
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 09:16:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64A613D00C3
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:52 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01BA0100C1F5
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5FA52071F;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/KPdCoQwzDrdQOO9KV7KHxfAsMjcCDAt65O1TsMiyA=;
 b=FH0risWKMvPpPplgkWSD1mhltzLVqRI9dOcU3Jzbia3CJJMhDNOUfTAZzn8SZsuSuxjj/+
 rLqEh1JNLIzp4dquLSRGfSohqHJKU2EZKx0kv38IXnQvs8syE2ALqUcnPSScztCvfOh7CK
 nmXUXfAAhk5SoGYoYWe+dhYOwmORLjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/KPdCoQwzDrdQOO9KV7KHxfAsMjcCDAt65O1TsMiyA=;
 b=VY+V2Wkg5d6eI2YTmpDWA1upeNL7NvENWodRLLLxubnYAujcYID8DSNk3qY06k81QVXysg
 3l5oVe70J78aLDAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FH0risWK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VY+V2Wkg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/KPdCoQwzDrdQOO9KV7KHxfAsMjcCDAt65O1TsMiyA=;
 b=FH0risWKMvPpPplgkWSD1mhltzLVqRI9dOcU3Jzbia3CJJMhDNOUfTAZzn8SZsuSuxjj/+
 rLqEh1JNLIzp4dquLSRGfSohqHJKU2EZKx0kv38IXnQvs8syE2ALqUcnPSScztCvfOh7CK
 nmXUXfAAhk5SoGYoYWe+dhYOwmORLjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/KPdCoQwzDrdQOO9KV7KHxfAsMjcCDAt65O1TsMiyA=;
 b=VY+V2Wkg5d6eI2YTmpDWA1upeNL7NvENWodRLLLxubnYAujcYID8DSNk3qY06k81QVXysg
 3l5oVe70J78aLDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD45C13A8D;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QKIDKaYnWGYfdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 May 2024 07:15:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 May 2024 09:15:20 +0200
MIME-Version: 1.0
Message-Id: <20240530-ioctl_ficlone-v1-1-fa96f07d0fca@suse.com>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
In-Reply-To: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4554;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=sbcUmUwpLGDKhGJW/UXLHiJbR1KIBgJE3djRS+V/cIs=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmWCem6MJ6Gv8iF28OHyX4nuRm+QCgA9YXvsL6x
 wKtQ5DKMiWJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlgnpgAKCRDLzBqyILPm
 RowZC/sHKjRafkJGsAvx2uS7+y4X+0X8i6iUprvVCcEfyrIiJZO0CpLcEPH37ywHq1v2Y6eG6pd
 5XDEdvMvCkoGNmeiHxf948e1f2iyr0uTHjqAxHv/1UvH3tFcvF2t9beqqfuhWcJc3XI5wSCV2hN
 Ay4+43j6jhpiLrkOM5dx0hC7ebRhy3UfO+zneE8UuhsQ3XD89dFBKI2hXb3gf7nZo6Dkx5EItBn
 nXIlO5qOW38KLWNl0X5d79qYckFMJ19OMX+uPBjQAOSMnvxsyIVaM4pEahoBg/LwL/XUnI15uol
 fEfSgbAUIFO9hA0bl+pqNfCdgVIe6wxjPbUA9iVmSAsnRfdN87l0wRCMtd5G9sQXcb0b093lZi1
 +GvwHqKLl/5d21WpAxS0YhqbP7BOLK8w1FR6jW2l2bKcjD9dWKSp87Tatn3jY7T0N5N3a8ecmCi
 qDynEfdEOxNUHQc8gF8LyGSIzfwW+BiqnTcg+UJMFU9j/1xLBsCyOmJTrEIMVOZ4oZGTI=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C5FA52071F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Add ioctl_ficlone01 test
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

This test verifies that ioctl() FICLONE feature clones file content
from one file to an another.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/fs.h                                 |   4 +
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore        |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c | 116 ++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 635979b02..cc3b7636c 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -48,6 +48,10 @@
 # define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
 #endif
 
+#ifndef FICLONE
+# define FICLONE		_IOW(0x94, 9, int)
+#endif
+
 /*
  * Helper function to get MAX_LFS_FILESIZE.
  * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..07e940f8c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -591,6 +591,8 @@ ioctl_ns07 ioctl_ns07
 
 ioctl_sg01 ioctl_sg01
 
+ioctl_ficlone01 ioctl_ficlone01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 5fff7a61d..5404aa93f 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -22,3 +22,4 @@
 /ioctl_ns06
 /ioctl_ns07
 /ioctl_sg01
+/ioctl_ficlone01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
new file mode 100644
index 000000000..29c1eb848
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE feature clones file content from
+ * one file to an another.
+ *
+ * [Algorithm]
+ *
+ * * populate source file
+ * * clone source content inside destination file
+ * * verify that source content has been cloned inside destination file
+ * * write a single byte inside destination file
+ * * verify that source content didn't change while destination did
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+#define SRCPATH MNTPOINT "/file0"
+#define DSTPATH MNTPOINT "/file1"
+
+#define FILEDATA "qwerty"
+#define FILESIZE sizeof(FILEDATA)
+
+static int src_fd = -1;
+static int dst_fd = -1;
+
+static void run(void)
+{
+	char buff[FILESIZE];
+	struct stat src_stat;
+	struct stat dst_stat;
+
+	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
+	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
+
+	tst_res(TINFO, "Writing data inside src file");
+
+	SAFE_WRITE(1, src_fd, FILEDATA, FILESIZE);
+	SAFE_FSYNC(src_fd);
+
+	TST_EXP_PASS(ioctl(dst_fd, FICLONE, src_fd));
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
+	TST_EXP_EQ_LI(src_stat.st_size, dst_stat.st_size);
+
+	SAFE_READ(0, dst_fd, buff, FILESIZE);
+
+	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
+		"dst file has the src file content (\"%s\" - %ld bytes)",
+		buff,
+		FILESIZE);
+
+	tst_res(TINFO, "Writing a byte inside dst file");
+
+	SAFE_WRITE(SAFE_WRITE_ALL, dst_fd, "a", 1);
+	SAFE_FSYNC(dst_fd);
+
+	tst_res(TINFO, "Verifing that src file content didn't change");
+
+	SAFE_FSTAT(src_fd, &src_stat);
+	SAFE_FSTAT(dst_fd, &dst_stat);
+
+	TST_EXP_EQ_LI(dst_stat.st_size, src_stat.st_size + 1);
+
+	SAFE_READ(0, src_fd, buff, FILESIZE);
+
+	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
+		"src file content didn't change");
+
+	SAFE_CLOSE(src_fd);
+	SAFE_CLOSE(dst_fd);
+	src_fd = -1;
+	dst_fd = -1;
+
+	remove(SRCPATH);
+	remove(DSTPATH);
+}
+
+static void cleanup(void)
+{
+	if (src_fd != -1)
+		SAFE_CLOSE(src_fd);
+
+	if (dst_fd != -1)
+		SAFE_CLOSE(dst_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_fs_type = "btrfs",
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
