Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5074C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:16:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27BF83D1C10
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:16:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EE323D0C66
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 18016601627
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2232021BB8;
 Tue, 23 Jul 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ9X/15gGlO9X/ac88LXlwOSpVa8MQtMD1Hb4UKO6Cg=;
 b=fAq8/JDcuYbqBojr7I0om9JRgmUz+hWHxP+PRsrrZe9n4qx2T1avptfGZrByfxjOUB2L+l
 NBPTRALTCL7JfLuXcXNlSJh2rsPW6qeQPzemambfpNODj7ShRHb181cXgbX+sSaNC09g5g
 z0AHkzJoBwgOyCZqemvC6dIOE3l/GxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ9X/15gGlO9X/ac88LXlwOSpVa8MQtMD1Hb4UKO6Cg=;
 b=BoSF8rV9qAsZx/RXuldDxBaNXQc8ejAvuRkD2GVHS9T444dEFN6VoGcjmp9UguIWKiDF6c
 2vn5cSHYqwk8+WBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ9X/15gGlO9X/ac88LXlwOSpVa8MQtMD1Hb4UKO6Cg=;
 b=fAq8/JDcuYbqBojr7I0om9JRgmUz+hWHxP+PRsrrZe9n4qx2T1avptfGZrByfxjOUB2L+l
 NBPTRALTCL7JfLuXcXNlSJh2rsPW6qeQPzemambfpNODj7ShRHb181cXgbX+sSaNC09g5g
 z0AHkzJoBwgOyCZqemvC6dIOE3l/GxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ9X/15gGlO9X/ac88LXlwOSpVa8MQtMD1Hb4UKO6Cg=;
 b=BoSF8rV9qAsZx/RXuldDxBaNXQc8ejAvuRkD2GVHS9T444dEFN6VoGcjmp9UguIWKiDF6c
 2vn5cSHYqwk8+WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0497C13874;
 Tue, 23 Jul 2024 07:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0HDFOpNYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:02 +0200
MIME-Version: 1.0
Message-Id: <20240723-ioctl_ficlone-v2-2-33075bbc117f@suse.com>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
In-Reply-To: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=A3aY+2ROZ8UGIaCslI7NxXQ2Y8xnhQkfcQoAXoeBqz8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h+pvCFio9U+psVAF/zueps+SZoV2rvG/7a2
 s3nen/xMXOJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YfgAKCRDLzBqyILPm
 RmSPC/4hqjYsuPqz2Dk6BpsXm/IQv/Cbpf/xeQKPQKwMy50vdfagyOG9weOqao/8DdFrvm6s0qm
 d79POBBtOSy/6/vKklW9PlWy/miEkXFXk5qRbVo2IFHI1oh/6ER1m1RijBJgf1dN/jbONz8zpUj
 QGYSBtuPxbq0zDItmvKrah1dlP+0h8jUKWahySEyO2nkbqZ5+BCZEhXJCwW7IALeJIJkijgnjLk
 NUQtlNiA6104DyYR8RRuMqotTTU+IjxFynvNiBQPl7K8XRxTJFTpdEoHVAWTFmO3u0FPXFkM/g+
 k7z8+5GsgdvDdGUIDPpzYoUpXyRPlwHV9HHRURfrqEmc1OCdPwX5fEminx1+idSJqYtlinK4Z04
 DSHqVDv7Tj85beJNCuqnQBr4g8s4JFa6S908Zp7xbdE1ZG3DBmDe9oiJTKWJZFX0U/ApFKuCUgn
 TJU6n0GCMc93k2V9IWrRNoirmPPiCOXfCc9DIbalooTab+wngz/RxAb7Cdo+WMDwcCHAc=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] Add ioctl_ficlone01 test
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
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore        |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c | 122 ++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 27eb9a86b..f05386ba2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -592,6 +592,8 @@ ioctl_ns07 ioctl_ns07
 
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
index 000000000..bb3dc8c6c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -0,0 +1,122 @@
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
+ * - populate source file
+ * - clone source content inside destination file
+ * - verify that source content has been cloned inside destination file
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
+	SAFE_LSEEK(dst_fd, 0, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, dst_fd, "+", 1);
+	SAFE_FSYNC(dst_fd);
+
+	tst_res(TINFO, "Verifing that src file content didn't change");
+
+	SAFE_FSTAT(src_fd, &src_stat);
+	SAFE_FSTAT(dst_fd, &dst_stat);
+
+	TST_EXP_EQ_LI(dst_stat.st_size, src_stat.st_size);
+
+	SAFE_READ(0, src_fd, buff, FILESIZE);
+
+	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
+		"src file content didn't change");
+
+	SAFE_CLOSE(src_fd);
+	SAFE_CLOSE(dst_fd);
+
+	SAFE_UNLINK(SRCPATH);
+	SAFE_UNLINK(DSTPATH);
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
+	.filesystems = (struct tst_fs []) {
+		{.type = "btrfs"},
+		{
+			.type = "xfs",
+			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
+		},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
