Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC036C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 06:57:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B5A53C94CC
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:57:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC3EE3C9447
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:56:40 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CCA61400C5F
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647586598; i=@fujitsu.com;
 bh=2ZswBrKmajsywdsYipwHdDhhCZpRnMl/GnCUZYC9nQI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=cO4YmGB+5IbcESPCeNCqH9GLrv8IWza1Tj4cV6UKBfoRkkKq0nWmgAxLwDXqEsTyX
 VoEv+LWNC/GWQF2e3teuRt8pAlUPTfM7V2E6AISLjUS6yKcdg2q1olRXaUOb+qPF7I
 wvgO6yl7BEQVEk8W6yxulYI0S1uqe0azuQ5/IhiTQCa485WCahp58eTDjKLDn8ER1w
 k1vxCHkkTpmhx/SiZJoMTCVFmHFy6vaNKQU9ujE7l8gghcjof8j8BrIhBYr+oOygNW
 PcKMU2OmcWSuwNvVBtpT4kc5m3MTAINXI29RMdkO2/+s09XSug+jNIhOnzCgNScYxR
 1HAQgPriYwzrQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8MxSVdV1yT
 JYF2/jcWK7zsYHRg99v1exxrAGMWamZeUX5HAmvHgeSdrwd/UihPTp7I2MK4P7WLk4hASOMso
 0fH/FzOEs5NJYsnxY2wQzn5Gid1vp7N3MXJysAloSFx73M4MYosIyEvsndAMZjML2EjsuzoBy
 ObgEBYIkFj+QRwkzCKgKjHvyxtWEJtXwE3i4NX5YLaEgILElIfvwVo5Bdwllt/rYgKxhQTSJN
 ae2w1VLyhxcuYTFojxEhIHX7xghuhVlNi/dyMjhF0hMWPGNjYIW03i6rlNzBMYBWchaZ+FpH0
 BI9MqRuukosz0jJLcxMwcXUMDA11DQ1NdYwtdQyNzvcQq3US91FLd8tTiEl0jvcTyYr3U4mK9
 4src5JwUvbzUkk2MwDBOKVar38H4YuVPvUOMkhxMSqK8y9RNkoT4kvJTKjMSizPii0pzUosPM
 cpwcChJ8KZoA+UEi1LTUyvSMnOAMQWTluDgURLhbVcFSvMWFyTmFmemQ6ROMSpKifNu1AFKCI
 AkMkrz4NpgcXyJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvAcgUnsy8Erjpr4AWMwEtbhQ
 wAllckoiQkmpgijhWwySj3+tTfZddKyTvnddV3Y9dNiIHZnc8V84tWXh/9hvex5YHbZwEw32m
 v3p4qOkps0ip8E3p2uSXJunPZZfl9bMsKf2zskGui/Hk+W8NQXcSukVtzf2dgubsuznp7cYLv
 b855t3WSBf3CAsuerbxanQ990eGk8deSlln+Gt4lEtaOktuvv/HXafjntxuRWHZ7d+v129a9/
 PVurpVH0PXJ7+x7dl0gH/JGxlj0zlavuevdu7pTXBfwskXe7BbRERab9q+ttnfHvFaOOzuM1u
 zIiIvLz2Ye++id25/M2MTWhrFn+1ODWV6yLw55NSbTQ+nt1+9y5ppvoXVuk3xgkxHoZdd4FuR
 6KqsX+pKLMUZiYZazEXFiQBNCsX9XgMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-19.tower-571.messagelabs.com!1647586597!20615!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6624 invoked from network); 18 Mar 2022 06:56:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-19.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Mar 2022 06:56:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 93A16100464
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:56:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 79CC410045E
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:56:37 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 06:56:27 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <xuyang2018.jy@fujitsu.com>
Date: Fri, 18 Mar 2022 14:55:47 -0400
Message-ID: <1647629747-13405-3-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1. use TST_EXP_FAIL and TST_EXP_PASS macro
2. use SAFE macro
3. simplify verify operations
4. merge umount2_03 to umount2_02

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 runtest/syscalls                               |   1 -
 testcases/kernel/syscalls/umount2/.gitignore   |   1 -
 testcases/kernel/syscalls/umount2/umount2.h    |   5 +-
 testcases/kernel/syscalls/umount2/umount2_02.c | 209 ++++++++-----------------
 testcases/kernel/syscalls/umount2/umount2_03.c | 167 --------------------
 5 files changed, 71 insertions(+), 312 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/umount2/umount2_03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6186bfc..0eea946 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1647,7 +1647,6 @@ umount03 umount03
 
 umount2_01 umount2_01
 umount2_02 umount2_02
-umount2_03 umount2_03
 
 userfaultfd01 userfaultfd01
 
diff --git a/testcases/kernel/syscalls/umount2/.gitignore b/testcases/kernel/syscalls/umount2/.gitignore
index 1d6a0e8..e2056bf 100644
--- a/testcases/kernel/syscalls/umount2/.gitignore
+++ b/testcases/kernel/syscalls/umount2/.gitignore
@@ -1,3 +1,2 @@
 /umount2_01
 /umount2_02
-/umount2_03
diff --git a/testcases/kernel/syscalls/umount2/umount2.h b/testcases/kernel/syscalls/umount2/umount2.h
index 65e4c24..d1e486e 100644
--- a/testcases/kernel/syscalls/umount2/umount2.h
+++ b/testcases/kernel/syscalls/umount2/umount2.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  *
@@ -28,13 +29,13 @@ static inline int umount2_retry(const char *target, int flags)
 		if (ret == 0 || errno != EBUSY)
 			return ret;
 
-		tst_resm(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
+		tst_res(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
 			 target, flags, i);
 
 		usleep(100000);
 	}
 
-	tst_resm(TWARN, "Failed to umount('%s', %i) after 50 retries",
+	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
 	         target, flags);
 
 	errno = EBUSY;
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 7d558fa..8ac63a4 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -1,182 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) 2015-2022 FUJITSU LIMITED. All rights reserved
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
  */
 
 /*
- * DESCRIPTION
+ * [Description]
+ *
  *  Test for feature MNT_EXPIRE of umount2().
- *  "Mark the mount point as expired.If a mount point is not currently
- *   in use, then an initial call to umount2() with this flag fails with
- *   the error EAGAIN, but marks the mount point as expired. The mount
- *   point remains expired as long as it isn't accessed by any process.
- *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
- *   mount point. This flag cannot be specified with either MNT_FORCE or
- *   MNT_DETACH. (fails with the error EINVAL)"
+ *
+ * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
+ * - EAGAIN when initial call to umount2(2) with MNT_EXPIRE
+ * - EAGAIN when umount2(2) with MNT_EXPIRE after access(2)
+ * - succeed when second call to umount2(2) with MNT_EXPIRE
+ *
+ *  Test for feature UMOUNT_NOFOLLOW of umount2().
+ *
+ * - EINVAL when target is a symbolic link
+ * - succeed when target is a mount point
  */
 
-#include <errno.h>
 #include <sys/mount.h>
-
-#include "test.h"
-#include "safe_macros.h"
 #include "lapi/mount.h"
-
+#include "tst_test.h"
 #include "umount2.h"
 
-#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
-#define MNTPOINT	"mntpoint"
-
-static void setup(void);
-static void test_umount2(int i);
-static void verify_failure(int i);
-static void verify_success(int i);
-static void cleanup(void);
-
-static const char *device;
-static const char *fs_type;
+#define MNTPOINT        "mntpoint"
+#define SYMLINK	"symlink"
 
 static int mount_flag;
 
-static struct test_case_t {
+static struct tcase {
+	const char *mntpoint;
 	int flag;
 	int exp_errno;
 	int do_access;
 	const char *desc;
-} test_cases[] = {
-	{MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
-		"umount2(2) with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
-	{MNT_EXPIRE | MNT_DETACH, EINVAL, 0,
-		"umount2(2) with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
-	{MNT_EXPIRE, EAGAIN, 0,
-		"initial call to umount2(2) with MNT_EXPIRE expected EAGAIN"},
-	{MNT_EXPIRE, EAGAIN, 1,
-		"umount2(2) with MNT_EXPIRE after access(2) expected EAGAIN"},
-	{MNT_EXPIRE, 0, 0,
-		"second call to umount2(2) with MNT_EXPIRE expected success"},
-};
+} tcases[] = {
+	{MNTPOINT, MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
+		"umount2() with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
 
-char *TCID = "umount2_02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
+	{MNTPOINT, MNT_EXPIRE | MNT_DETACH, EINVAL, 0,
+		"umount2() with MNT_EXPIRE | MNT_DETACH expected EINVAL"},
 
-int main(int ac, char **av)
-{
-	int lc;
-	int tc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	{MNTPOINT, MNT_EXPIRE, EAGAIN, 0,
+		"initial call to umount2() with MNT_EXPIRE expected EAGAIN"},
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	{MNTPOINT, MNT_EXPIRE, EAGAIN, 1,
+		"umount2() with MNT_EXPIRE after access() expected EAGAIN"},
 
-		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
-		mount_flag = 1;
-
-		for (tc = 0; tc < TST_TOTAL; tc++)
-			test_umount2(tc);
+	{MNTPOINT, MNT_EXPIRE, 0, 0,
+		"second call to umount2() with MNT_EXPIRE expected success"},
 
-		if (mount_flag) {
-			if (tst_umount(MNTPOINT))
-				tst_brkm(TBROK, cleanup, "umount() failed");
-			mount_flag = 0;
-		}
-	}
+	{SYMLINK, UMOUNT_NOFOLLOW, EINVAL, 0,
+		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
 
-	cleanup();
-	tst_exit();
-}
+	{MNTPOINT, UMOUNT_NOFOLLOW, 0, 0,
+		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
+};
 
-static void setup(void)
+static void test_umount2(unsigned int n)
 {
-	tst_require_root();
-
-	if ((tst_kvercmp(2, 6, 8)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			 "that are 2.6.8 or higher");
-	}
+	struct tcase *tc = &tcases[n];
 
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-
-	TEST_PAUSE;
-}
-
-static void test_umount2(int i)
-{
-	/* a new access removes the expired mark of the mount point */
-	if (test_cases[i].do_access) {
-		if (access(MNTPOINT, F_OK) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
+	if (!mount_flag) {
+		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+		mount_flag = 1;
 	}
 
-	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
-
-	if (test_cases[i].exp_errno != 0)
-		verify_failure(i);
-	else
-		verify_success(i);
-}
+	tst_res(TINFO, "Testing %s", tc->desc);
 
-static void verify_failure(int i)
-{
-	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
-		mount_flag = 0;
-		return;
-	}
+	if (tc->do_access)
+		SAFE_ACCESS(MNTPOINT, F_OK);
 
-	if (TEST_ERRNO != test_cases[i].exp_errno) {
-		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
-			 test_cases[i].desc);
-		return;
+	if (tc->exp_errno) {
+		TST_EXP_FAIL(umount2_retry(tc->mntpoint, tc->flag), tc->exp_errno,
+			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
+		if (!TST_PASS)
+			mount_flag = 0;
+	} else {
+		TST_EXP_PASS(umount2_retry(tc->mntpoint, tc->flag),
+			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
+		if (TST_PASS)
+			mount_flag = 0;
 	}
-
-	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
 }
 
-static void verify_success(int i)
+static void setup(void)
 {
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
-			 test_cases[i].desc);
-		return;
-	}
-
-	tst_resm(TPASS, "umount2(2) succeeded as expected");
-	mount_flag = 0;
+	SAFE_SYMLINK(MNTPOINT, SYMLINK);
 }
 
 static void cleanup(void)
 {
-	if (mount_flag && tst_umount(MNTPOINT))
-		tst_resm(TWARN | TERRNO, "Failed to unmount");
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
+	if (mount_flag)
+		SAFE_UMOUNT(MNTPOINT);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = cleanup,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_device = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.test = test_umount2,
+};
diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c b/testcases/kernel/syscalls/umount2/umount2_03.c
deleted file mode 100644
index a8fddf6..0000000
--- a/testcases/kernel/syscalls/umount2/umount2_03.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Copyright (c) 2015 Fujitsu Ltd.
- * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
- */
-
-/*
- * DESCRIPTION
- *  Test for feature UMOUNT_NOFOLLOW of umount2().
- *  "Don't dereference target if it is a symbolic link,
- *   and fails with the error EINVAL."
- */
-
-#include <errno.h>
-#include <sys/mount.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/mount.h"
-
-#include "umount2.h"
-
-#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
-#define MNTPOINT	"mntpoint"
-#define SYMLINK	"symlink"
-
-static void setup(void);
-static void test_umount2(int i);
-static void verify_failure(int i);
-static void verify_success(int i);
-static void cleanup(void);
-
-static const char *device;
-static const char *fs_type;
-
-static int mount_flag;
-
-static struct test_case_t {
-	const char *mntpoint;
-	int exp_errno;
-	const char *desc;
-} test_cases[] = {
-	{SYMLINK, EINVAL,
-		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
-	{MNTPOINT, 0,
-		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
-};
-
-char *TCID = "umount2_03";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int tc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (tc = 0; tc < TST_TOTAL; tc++)
-			test_umount2(tc);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-
-	if ((tst_kvercmp(2, 6, 34)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			 "that are 2.6.34 or higher");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-
-	SAFE_SYMLINK(cleanup, MNTPOINT, SYMLINK);
-
-	TEST_PAUSE;
-}
-
-static void test_umount2(int i)
-{
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
-	mount_flag = 1;
-
-	TEST(umount2_retry(test_cases[i].mntpoint, UMOUNT_NOFOLLOW));
-
-	if (test_cases[i].exp_errno != 0)
-		verify_failure(i);
-	else
-		verify_success(i);
-
-	if (mount_flag) {
-		if (tst_umount(MNTPOINT))
-			tst_brkm(TBROK, cleanup, "umount() failed");
-		mount_flag = 0;
-	}
-}
-
-static void verify_failure(int i)
-{
-	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
-		mount_flag = 0;
-		return;
-	}
-
-	if (TEST_ERRNO != test_cases[i].exp_errno) {
-		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
-			 test_cases[i].desc);
-		return;
-	}
-
-	tst_resm(TPASS | TTERRNO, "umount2(2) failed as expected");
-}
-
-static void verify_success(int i)
-{
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
-			 test_cases[i].desc);
-		return;
-	}
-
-	tst_resm(TPASS, "umount2(2) succeeded as expected");
-	mount_flag = 0;
-}
-
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MNTPOINT))
-		tst_resm(TWARN | TERRNO, "Failed to unmount");
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
