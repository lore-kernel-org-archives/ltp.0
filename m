Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93CAC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:21:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01E0B3C8CC5
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 19:21:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBAD93C8C94
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36DC9600F98
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86B1D21B33;
 Fri, 17 Jun 2022 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655486450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjkFWJfEbLWyQCr+cLwC1bAIgBIp5PUBT6CkVXsrexw=;
 b=YnXpcAi0reZ8YbKF8z0flpBrjVpXKH8ZHAS8/eb+C9n49FBeBqmzp+mlWgUMbs0ZCAwP10
 kki4+SFsk+pMxxYHVlMiXD9A1R4SbyO88Lxsc/SY+Jw3fYyp+O937S08WynYfC9ZF4lSf5
 9WbPy4AAZvRD/+TSPzq1A0RHWHA+JzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655486450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjkFWJfEbLWyQCr+cLwC1bAIgBIp5PUBT6CkVXsrexw=;
 b=lLuVZOZoIkhfbam9zizp/Oye49EpkcTYqwaZo384sS73ppeWi8YI7ghhfL2VhL1peugGZM
 6D+7mTawDZ7vzGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A5111348E;
 Fri, 17 Jun 2022 17:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ktA6N/G3rGKvcwAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 17 Jun 2022 17:20:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 17 Jun 2022 22:50:25 +0530
Message-Id: <20220617172025.23975-7-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617172025.23975-1-akumar@suse.de>
References: <20220617172025.23975-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] Rewrite utime06.c using new LTP API
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
 testcases/kernel/syscalls/utime/utime06.c | 196 ++++++----------------
 1 file changed, 53 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 6d80677e4..aad5268ca 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -1,174 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *	07/2001 John George
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) International Business Machines  Corp., 2001
+ *		07/2001 John George
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Description:
- * 1. Verify that the system call utime() fails to set the modification
- *    and access times of a file to the current time, under the following
- *    constraints,
- *	 - The times argument is null.
+/*\
+ * [Description]
+ * 1. Verify that the system call utime() fails to change the last access
+ *    and modification times of a file to the current time, and errno is
+ *    set to EACCES, when
+ *	 - The times argument is NULL.
+ *   - The user ID of the process does not match the owner of the file.
  *	 - The user ID of the process is not "root".
- * 2. Verify that the system call utime() fails to set the modification
- *    and access times of a file if the specified file doesn't exist.
- * 3. Verify that the system call utime() fails to set the modification
- *    and access times of a file to the current time, under the following
- *    constraints,
- *	 - The times argument is not null.
+ * 2. Verify that the system call utime() fails to change the last access
+ *    and modification times of a file, and the errno is set to ENOENT,
+ *    when
+ *    - The specified file does not exist.
+ * 3. Verify that the system call utime() fails to change the last access
+ *    and modification times of a file to the current time, and errno is
+ *    set to EPERM, when
+ *	 - The times argument is not NULL.
+ *   - The user ID of the process does not match the owner of the file.
  *	 - The user ID of the process is not "root".
- * 4. Verify that the system call utime() fails to set the modification
- *    and access times of a file that resides on a read-only file system.
+ * 4. Verify that the system call utime() fails to change the last access
+ *    and modification times of a file, and errno is set to EROFS, when
+ *   - The path resides on a read-only filesystem.
  */
 
-#include <errno.h>
-#include <fcntl.h>
 #include <pwd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <string.h>
-#include <unistd.h>
 #include <utime.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/mount.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEMP_FILE	"tmp_file"
 #define MNT_POINT	"mntpoint"
+#define FILE_MODE	0644
+#define TEST_USERNAME "nobody"
 
-char *TCID = "utime06";
-static struct passwd *ltpuser;
 static const struct utimbuf times;
-static const char *dev;
-static int mount_flag;
-static void setup_nobody(void);
-static void cleanup_nobody(void);
 
-struct test_case_t {
+static struct tcase {
 	char *pathname;
 	int exp_errno;
-	const struct utimbuf *times;
-	void (*setup_func)(void);
-	void (*cleanup_func)(void);
-} Test_cases[] = {
-	{TEMP_FILE, EACCES, NULL, setup_nobody, cleanup_nobody},
-	{"", ENOENT, NULL, NULL, NULL},
-	{TEMP_FILE, EPERM, &times, setup_nobody, cleanup_nobody},
-	{MNT_POINT, EROFS, NULL, NULL, NULL},
+	const struct utimbuf *utimbuf;
+	char *err_desc;
+} tcases[] = {
+	{TEMP_FILE, EACCES, NULL, "No write access"},
+	{"", ENOENT, NULL, "File not exist"},
+	{TEMP_FILE, EPERM, &times, "Not file owner"},
+	{MNT_POINT, EROFS, NULL, "Read-only filesystem"}
 };
 
-int TST_TOTAL = ARRAY_SIZE(Test_cases);
-static void setup(void);
-static void utime_verify(const struct test_case_t *);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			utime_verify(&Test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
 
 static void setup(void)
 {
-	const char *fs_type;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_TOUCH(cleanup, TEMP_FILE, 0644, NULL);
-
-	fs_type = tst_dev_fs_type();
-	dev = tst_acquire_device(cleanup);
-	if (!dev)
-		tst_brkm(TCONF, cleanup, "Failed to acquire test device");
-
-	tst_mkfs(cleanup, dev, fs_type, NULL, NULL);
+	struct passwd *pw;
 
-	SAFE_MKDIR(cleanup, MNT_POINT, 0644);
-	SAFE_MOUNT(cleanup, dev, MNT_POINT, fs_type, MS_RDONLY, NULL);
-	mount_flag = 1;
+	SAFE_TOUCH(TEMP_FILE, FILE_MODE, NULL);
 
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	pw = SAFE_GETPWNAM(TEST_USERNAME);
+	tst_res(TINFO, "Switching effective user ID to user: %s", pw->pw_name);
+	SAFE_SETEUID(pw->pw_uid);
 }
 
-static void utime_verify(const struct test_case_t *test)
+static void run(unsigned int i)
 {
-	if (test->setup_func != NULL)
-		test->setup_func();
+	struct tcase *tc = &tcases[i];
 
-	TEST(utime(test->pathname, test->times));
-
-	if (test->cleanup_func != NULL)
-		test->cleanup_func();
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "utime succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "utime failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "utime failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
-}
-
-static void setup_nobody(void)
-{
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-}
-
-static void cleanup_nobody(void)
-{
-	SAFE_SETEUID(cleanup, 0);
+	tst_res(TINFO, "running %s test", tc->err_desc);
+	TST_EXP_FAIL(utime(tc->pathname, tc->utimbuf),
+				tc->exp_errno, "%s", tc->err_desc);
 }
 
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MNT_POINT) < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", dev);
-
-	if (dev)
-		tst_release_device(dev);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MNT_POINT,
+	.needs_rofs = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
