Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6FEC87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:05:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45A073C5355
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 15:05:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5ECB3C2C78
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A0FD6008C5
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D89D8211CB;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iOiVuiJrZ0dGPOQTEQbs3YKF3/mI2SzXfnh4ycNtII=;
 b=y6Am+t/KVEkSFodSglP44DVJmyArFZK00uEwZwM2cPVF/eixq+7TpTNX2aInKz/qpop3Is
 tB8P00Bg2Grpq2VKS9EUEOxFF1/qJMk6VlkAG+0ribZI7JYwycZk6MV/sHs11FRlJgeSuW
 CUd6tAghYMAY2mQBnzixyzcLRd+CaH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iOiVuiJrZ0dGPOQTEQbs3YKF3/mI2SzXfnh4ycNtII=;
 b=WBA2PBM8XBQO60CA6Of22q0AAr8+7Zn6XzJBxwcU1BI3RNQY/wO2AkZ7ZyLzH4em8hS/7F
 PLcoqPabFmxOw6CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y6Am+t/K";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WBA2PBM8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iOiVuiJrZ0dGPOQTEQbs3YKF3/mI2SzXfnh4ycNtII=;
 b=y6Am+t/KVEkSFodSglP44DVJmyArFZK00uEwZwM2cPVF/eixq+7TpTNX2aInKz/qpop3Is
 tB8P00Bg2Grpq2VKS9EUEOxFF1/qJMk6VlkAG+0ribZI7JYwycZk6MV/sHs11FRlJgeSuW
 CUd6tAghYMAY2mQBnzixyzcLRd+CaH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iOiVuiJrZ0dGPOQTEQbs3YKF3/mI2SzXfnh4ycNtII=;
 b=WBA2PBM8XBQO60CA6Of22q0AAr8+7Zn6XzJBxwcU1BI3RNQY/wO2AkZ7ZyLzH4em8hS/7F
 PLcoqPabFmxOw6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAE0313A9F;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFCQJhoBkmhpFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 13:03:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 15:03:19 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v4-6-08e23354abc8@suse.com>
References: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754399000; l=3536;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Ud//BaXlk6yJ5YpbLNBe8mGLoMx3bFDoSOcXWHd9Wag=;
 b=78Jg7wyCkl0iE0XUpnHQsA15Qe4WCcb+95S332SQL/bBPiurQEzSCX7tcsuhtutMu5ndxlhfZ
 i4IuUi46sQNAgQQhcGyKoZbx+RawdfCY6A/PymEQ6b90FGZTC/y64oP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D89D8211CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/7] Add file_attr03 test
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

Verify that `file_setattr` is correctly setting filesystems additional
attributes. We are running test on XFS only, since it's the only filesystem
currently implementing the features we need.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr03.c | 76 +++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b69e474a6a596359bb1ace30312b55d6bf2b65cc..c33987328d3d6ec96660260aaee4f9ca8c4f0aee 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -248,6 +248,7 @@ fsetxattr02 fsetxattr02
 
 file_attr01 file_attr01
 file_attr02 file_attr02
+file_attr03 file_attr03
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
index afe9c2fc9a4218dc032f044c1d317355a784a525..b79a340b733f7407dc135c5c3b0a9cd0e003e6c9 100644
--- a/testcases/kernel/syscalls/file_attr/.gitignore
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -1,2 +1,3 @@
 file_attr01
 file_attr02
+file_attr03
diff --git a/testcases/kernel/syscalls/file_attr/file_attr03.c b/testcases/kernel/syscalls/file_attr/file_attr03.c
new file mode 100644
index 0000000000000000000000000000000000000000..9ad7790411a87f72bb0bd41a01063c3a0eccff2f
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr03.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_setattr` is correctly setting filesystems additional
+ * attributes. We are running test on XFS only, since it's the only filesystem
+ * currently implementing the features we need.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mntpoint"
+#define FILEPATH (MNTPOINT "/ltp_file")
+#define BLOCKS 1024
+#define PROJID 16
+
+static int fd = -1;
+static int block_size;
+static struct fsxattr xattr;
+static struct file_attr *attr;
+
+static void run(void)
+{
+	fd = SAFE_CREAT(FILEPATH, 0777);
+
+	TST_EXP_PASS(file_setattr(AT_FDCWD, FILEPATH,
+			   attr, FILE_ATTR_SIZE_LATEST, 0));
+
+	SAFE_IOCTL(fd, FS_IOC_FSGETXATTR, &xattr);
+	SAFE_CLOSE(fd);
+
+	TST_EXP_EQ_LI(xattr.fsx_xflags & FS_XFLAG_EXTSIZE, FS_XFLAG_EXTSIZE);
+	TST_EXP_EQ_LI(xattr.fsx_xflags & FS_XFLAG_COWEXTSIZE, FS_XFLAG_COWEXTSIZE);
+	TST_EXP_EQ_LI(xattr.fsx_extsize, BLOCKS * block_size);
+	TST_EXP_EQ_LI(xattr.fsx_cowextsize, BLOCKS * block_size);
+	TST_EXP_EQ_LI(xattr.fsx_projid, PROJID);
+
+	SAFE_UNLINK(FILEPATH);
+}
+
+static void setup(void)
+{
+	block_size = tst_dev_block_size(MNTPOINT);
+
+	attr->fa_xflags |= FS_XFLAG_EXTSIZE;
+	attr->fa_xflags |= FS_XFLAG_COWEXTSIZE;
+	attr->fa_extsize = BLOCKS * block_size;
+	attr->fa_cowextsize = BLOCKS * block_size;
+	attr->fa_projid = PROJID;
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.mntpoint = MNTPOINT,
+	.needs_root = 1,
+	.mount_device = 1,
+	.filesystems = (struct tst_fs []) {
+		{.type = "xfs"},
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&attr, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
