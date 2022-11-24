Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EBFC43217
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 15:42:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 168373CC937
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 16:42:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1E43CA2DA
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 16:42:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D086100095E
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 16:42:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 916FE210E3
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669304532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yYHRDYbrhEI+D1Wn28XgBqZSY+PN5YqOGRv78c+7b0A=;
 b=GDWh04cVAxmfriduICUr17j90aMDndMjd4PfPqzAKfAYwx8nmLm5FfiJzIC2224fzSkLms
 AVVnfMFA428+Y2apQGb1MMFPCrTSo+MAkIQSL5WeLjzag0G6yjP0a+enUPhbEG9vaEA/m3
 MBqH6IduKNbH8O+EGFZ+DY7JCVyf4V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669304532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yYHRDYbrhEI+D1Wn28XgBqZSY+PN5YqOGRv78c+7b0A=;
 b=wHZ6rdTYCbJ0IxJ8lwt8VRF9kNhkm0sqjIKXkW1QEN4QR5QeBDmT01fRVlScd2raQAhBkE
 5ljkL7+bhQdGxzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12A7213B4F
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 15:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TvzVMdOQf2P9cQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 15:42:11 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Nov 2022 21:12:09 +0530
Message-Id: <20221124154209.14541-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statvfs02: Convert to new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/statvfs/statvfs02.c | 117 +++++-------------
 1 file changed, 34 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/syscalls/statvfs/statvfs02.c b/testcases/kernel/syscalls/statvfs/statvfs02.c
index 927cedc6e..8aaa47318 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs02.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs02.c
@@ -1,119 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
-/*
- * Test Description:
- *  Verify that,
- *   1. path is NULL, EFAULT would return.
- *   2. Too many symbolic links were encountered in translating path,
- *	ELOOP would return.
- *   3. path is too long, ENAMETOOLONG would return.
- *   4. The file referred to by path does not exist, ENOENT would return.
- *   5. A component of the path prefix of path is not a directory,
- *	ENOENT would return.
+
+/*\
+ * [Description]
+ *
+ * Verify that statvfs() fails with:
+ * - EFAULT when path points to an invalid address.
+ * - ELOOP when too many symbolic links were encountered in translating path.
+ * - ENAMETOOLONG when path is too long.
+ * - ENOENT when the file referred to by path does not exist.
+ * - ENOTDIR a component of the path prefix of path is not a directory.
  */
 
-#include <errno.h>
 #include <sys/statvfs.h>
-#include <sys/mman.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEST_SYMLINK	"statvfs_symlink"
 #define TEST_FILE	"statvfs_file"
 
-char *TCID = "statvfs02";
-
 static struct statvfs buf;
 static char nametoolong[PATH_MAX+2];
-static void setup(void);
-static void cleanup(void);
 
-static struct test_case_t {
+static struct tcase {
 	char *path;
 	struct statvfs *buf;
 	int exp_errno;
-} test_cases[] = {
-	{NULL, &buf, EFAULT},
+} tcases[] = {
+	{(char *)-1, &buf, EFAULT},
 	{TEST_SYMLINK, &buf, ELOOP},
 	{nametoolong, &buf, ENAMETOOLONG},
 	{"filenoexist", &buf, ENOENT},
 	{"statvfs_file/test", &buf, ENOTDIR},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void statvfs_verify(const struct test_case_t *);
-
-int main(int argc, char **argv)
-{
-	int i, lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			statvfs_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	unsigned int i;
 
-	tst_tmpdir();
-
-	SAFE_SYMLINK(cleanup, TEST_SYMLINK, "statfs_symlink_2");
-	SAFE_SYMLINK(cleanup, "statfs_symlink_2", TEST_SYMLINK);
+	SAFE_SYMLINK(TEST_SYMLINK, "symlink_2");
+	SAFE_SYMLINK("symlink_2", TEST_SYMLINK);
 
 	memset(nametoolong, 'a', PATH_MAX+1);
+	SAFE_TOUCH(TEST_FILE, 0644, NULL);
 
-	SAFE_TOUCH(cleanup, TEST_FILE, 0644, NULL);
-
-	test_cases[0].path = SAFE_MMAP(cleanup, NULL, 1, PROT_NONE,
-	                               MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		if (tcases[i].path == (char *)-1)
+			tcases[i].path = tst_get_bad_addr(NULL);
+	}
 }
 
-static void statvfs_verify(const struct test_case_t *test)
+static void run(unsigned int i)
 {
-	TEST(statvfs(test->path, test->buf));
+	struct tcase *tc = &tcases[i];
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "statvfs() succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "statvfs() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "statvfs() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	TST_EXP_FAIL(statvfs(tc->path, tc->buf), tc->exp_errno);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1
+};
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
