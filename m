Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6523AC433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 09:08:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AE163CA74A
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 11:08:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D3AD3C562F
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 11:08:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 966AD140114C
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 11:08:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 721661F924;
 Tue,  4 Oct 2022 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664874494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2wpyR+0qEXxMn7qQo8QR1ddjXDdjrlL7Xnz9La7C3nM=;
 b=PDfC+VI8ZxWnKPk0WbGClPxWtvhS5EPcm0YwLBlEajhJYVqMlLMvy+xMmVuUgRz7BnGXjQ
 6YpLG1SQDEyNfPT1NLI+JvB2zJlG/7W8yhw1s3J0awRBK282nK8nGLWms7ZXUwmjaqpylq
 +wcq4hlavpz+Qfcc/PEC5XEeGDeLMuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664874494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2wpyR+0qEXxMn7qQo8QR1ddjXDdjrlL7Xnz9La7C3nM=;
 b=mQj1wvdfdFBtbPjMqa+OkC3xT2aqbuqyduQyp1Olgumjp9zeQi+barK6qA6DcRXquSObnE
 X1LxrsVvmu4+MLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30290139D2;
 Tue,  4 Oct 2022 09:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Xe3xCf73O2MUYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Oct 2022 09:08:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  4 Oct 2022 11:08:10 +0200
Message-Id: <20221004090810.9023-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] df01.sh: Use own fsfreeze implementation for XFS
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
Cc: linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

df01.sh started to fail on XFS on certain configuration since mkfs.xfs
and kernel 5.19. Implement fsfreeze instead of introducing external
dependency. NOTE: implementation could fail on other filesystems
(EOPNOTSUPP on exfat, ntfs, vfat).

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

FYI the background of this issue:
https://lore.kernel.org/ltp/Yv5oaxsX6z2qxxF3@magnolia/
https://lore.kernel.org/ltp/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/

@LTP developers: not sure if the consensus is to avoid LTP API
completely (even use it just with TST_NO_DEFAULT_MAIN), if required I
can rewrite to use it just to get SAFE_*() macros (like
testcases/lib/tst_checkpoint.c) or even with tst_test workarounds
(testcases/lib/tst_get_free_pids.c).

Kind regards,
Petr

 testcases/commands/df/Makefile        |  4 +-
 testcases/commands/df/df01.sh         |  3 ++
 testcases/commands/df/df01_fsfreeze.c | 55 +++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 testcases/commands/df/df01_fsfreeze.c

diff --git a/testcases/commands/df/Makefile b/testcases/commands/df/Makefile
index 2787bb43a..1e0b4283a 100644
--- a/testcases/commands/df/Makefile
+++ b/testcases/commands/df/Makefile
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021-2022
 # Copyright (c) 2015 Fujitsu Ltd.
-# Author:Zhang Jin <jy_zhangjin@cn.fujitsu.com>
+# Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
 
 top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= df01.sh
+MAKE_TARGETS			:= df01_fsfreeze
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index ae0449c3c..c59d2a01d 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -46,6 +46,9 @@ df_test()
 
 	ROD_SILENT rm -rf $TST_MNTPOINT/testimg
 
+	# ensure free space change can be seen by statfs
+	[ "$fs" = "xfs" ] && ROD_SILENT df01_fsfreeze $TST_MNTPOINT
+
 	# flush file system buffers, then we can get the actual sizes.
 	sync
 }
diff --git a/testcases/commands/df/df01_fsfreeze.c b/testcases/commands/df/df01_fsfreeze.c
new file mode 100644
index 000000000..d47e1b01a
--- /dev/null
+++ b/testcases/commands/df/df01_fsfreeze.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2010 Hajime Taira <htaira@redhat.com>
+ * Copyright (c) 2010 Masatake Yamato <yamato@redhat.com>
+ * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/fs.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#define err_exit(...) ({ \
+	fprintf(stderr, __VA_ARGS__); \
+	if (errno) \
+		fprintf(stderr, ": %s (%d)", strerror(errno), errno); \
+	fprintf(stderr, "\n"); \
+	exit(EXIT_FAILURE); \
+})
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	struct stat sb;
+
+	if (argc < 2)
+		err_exit("USAGE: df01_fsfreeze <mountpoint>");
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		err_exit("open '%s' failed", argv[1]);
+
+	if (fstat(fd, &sb) == -1)
+		err_exit("stat of '%s' failed", argv[1]);
+
+	if (!S_ISDIR(sb.st_mode))
+		err_exit("%s: is not a directory", argv[1]);
+
+	if (ioctl(fd, FIFREEZE, 0) < 0)
+		err_exit("ioctl FIFREEZE on '%s' failed", argv[1]);
+
+	usleep(100);
+
+	if (ioctl(fd, FITHAW, 0) < 0)
+		err_exit("ioctl FITHAW on '%s' failed", argv[1]);
+
+	close(fd);
+
+	return EXIT_SUCCESS;
+}
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
