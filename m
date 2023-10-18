Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6920CDB47E
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 05:44:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A8353CD0B5
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 07:44:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852F13C84C3
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 07:44:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 31A98204714
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 07:44:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6785F21D1E;
 Wed, 18 Oct 2023 05:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1697607842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pDiNihpU/4yQfibyFm1aiKFjOZcYoNydxK4nw2UUXIk=;
 b=rzYTZn744+bn//StbwegN4rmDYOkWb1wwMYDdijMV5bFEfxK/qyy+aUbx7iBw42t9Hw5Yb
 PNfxGcwaie47rNn4y0WqyoxezEm9hgp7jfkl//eSWhZ1+ctCt2hjKqnp+SCXo+iYOL3/Vy
 mUjit12ZC6DKkgZAqtGfnWJ3otyGT7s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C12FA138EF;
 Wed, 18 Oct 2023 05:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A7LeJaFwL2X3MQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 18 Oct 2023 05:44:01 +0000
To: ltp@lists.linux.it
Date: Wed, 18 Oct 2023 01:43:57 -0400
Message-Id: <20231018054357.29035-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ioctl_fiemap01: New test for fiemap ioctl()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix: #535

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 107 ++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4152e1e5f..c7a0b2301 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -588,6 +588,8 @@ ioctl_ns07 ioctl_ns07
 
 ioctl_sg01 ioctl_sg01
 
+ioctl_fiemap01 ioctl_fiemap01
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 5fff7a61d..64adcdfe6 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -22,3 +22,4 @@
 /ioctl_ns06
 /ioctl_ns07
 /ioctl_sg01
+/ioctl_fiemap01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
new file mode 100644
index 000000000..e0511667e
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify basic fiemap ioctl
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/fiemap.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#define TESTFILE "testfile"
+#define NUM_EXTENT 2
+#define FILE_OFFSET ((rand() % 8 + 2) * getpagesize())
+
+static char *buf;
+
+static void print_extens(struct fiemap *fiemap)
+{
+
+	tst_res(TINFO, "File extent count: %u", fiemap->fm_mapped_extents);
+	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
+		tst_res(TINFO, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
+				i + 1,
+				fiemap->fm_extents[i].fe_logical,
+				fiemap->fm_extents[i].fe_physical,
+				fiemap->fm_extents[i].fe_flags,
+				fiemap->fm_extents[i].fe_length);
+	}
+}
+
+static void verify_ioctl(void)
+{
+	int fd;
+	struct fiemap *fiemap;
+
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
+	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0ULL;
+	fiemap->fm_extent_count = 1;
+
+	fiemap->fm_flags =  -1;
+	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
+
+	fiemap->fm_flags =  0;
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if (fiemap->fm_mapped_extents == 0)
+		tst_res(TPASS, "Check fiemap iotct step1 pass");
+
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, getpagesize());
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if ((fiemap->fm_mapped_extents == 1) && (fiemap->fm_extents[0].fe_physical == 0))
+		tst_res(TPASS, "Check fiemap iotct step2 pass");
+
+	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if ((fiemap->fm_extent_count == 1) &&
+		(fiemap->fm_extents[0].fe_flags == FIEMAP_EXTENT_LAST) &&
+		(fiemap->fm_extents[0].fe_physical > 0) &&
+		(fiemap->fm_extents[0].fe_length == (__u64)getpagesize()))
+		tst_res(TPASS, "Check fiemap iotct step3 pass");
+
+	fiemap->fm_extent_count = NUM_EXTENT;
+	srand(time(NULL));
+	SAFE_LSEEK(fd, FILE_OFFSET, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, getpagesize());
+	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
+	print_extens(fiemap);
+	if ((fiemap->fm_extent_count == NUM_EXTENT) &&
+		(fiemap->fm_extents[NUM_EXTENT - 1].fe_flags == FIEMAP_EXTENT_LAST) &&
+		(fiemap->fm_extents[NUM_EXTENT - 1].fe_physical > 0) &&
+		(fiemap->fm_extents[NUM_EXTENT - 1].fe_length == (__u64)getpagesize()))
+		tst_res(TPASS, "Check fiemap iotct step4 pass");
+
+	free(fiemap);
+	close(fd);
+}
+
+static void setup(void)
+{
+	buf = SAFE_MALLOC(getpagesize());
+}
+
+static void cleanup(void)
+{
+	free(buf);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
