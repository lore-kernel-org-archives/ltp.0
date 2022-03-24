Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DAFC433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 03:36:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E5FA3C97CE
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 04:36:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1800C3C90D8
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 04:36:00 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E09121000481
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 04:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1648092958; i=@fujitsu.com;
 bh=px+NzdY2HiWVV2emDoR6FiORrFQrYtXKB/L/R5YElzU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=VKHyztTdWvcvKLKAD0oTc+MnJDVvLdDQE9RJ2+zMdEFSFzGQLplogTpnY7cdnXq2w
 HQ0JxVw3IZyovvNdNl2vfEKr1FmdfdrEutyktTcmaodsG/jwcSALnfTJcGASR9DXBI
 SW/XrMUsIfr+YZYFRBAExoAt0jtpCYY9bPo2kIdhKEhWvRoOWK3hc8GR+cKyjqMcIr
 j0ZfNDsMD62WbUFWUshcj9zxaeT30ZevjgSi+ZEO2109+R7V08gIif8TVCHg8xhixN
 yveVDRul8A9sZRiV/fahKnws7nJRduSsnOzvHmqi5hC1GAqITw7+uedFDLfRtDkuV4
 veayCX0Mw0mBg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsViZ8MRoiv73Dr
 J4NB8ZosV33cwWvy4dYPFgclj3+91rB5nFhxhD2CKYs3MS8qvSGDNOLZ5E2vBnOyKA+vnsDQw
 XojsYuTiEBJ4ySjR27CSDcLZzygx+eI5xi5GTg42AQ2Ja4/bmUFsEQERiRf9H1i6GDk4mAWSJ
 JZ/jwAJCwv4SGzoX8MEYrMIqEo8vHsKrJVXwE1iytufYLaEgILElIfvwcZwAtWcv3WNCWSMkI
 CKxPWDOhDlghInZz5hAbGZBSQkDr54wQzRqiixf+9GqDEVEjNmbGObwMg/C0nLLCQtCxiZVjF
 aJRVlpmeU5CZm5ugaGhjoGhqa6prqGpma6iVW6SbqpZbqlqcWl+ga6iWWF+ulFhfrFVfmJuek
 6OWllmxiBAZpSjHr/x2M3X0/9Q4xSnIwKYnybphmnSTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJg
 lf3MVBOsCg1PbUiLTMHGDEwaQkOHiUR3jXXgdK8xQWJucWZ6RCpU4zGHFtuH9jLzLFzy+W9zE
 Isefl5qVLivG+fApUKgJRmlObBDYJF8iVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwryKz4C
 m8GTmlcDtewV0ChPQKc9/WoKcUpKIkJJqYMp/PEfFdMXP1Q8MIh1a/vg4tp36v+ehuNKNSWol
 OoY8C991Pgtj5WE6Fdzx4Knw8d2SJ5Nut57j7di8Q/xw04k6x+A7c/hOi9mz+stO2aq9RUGr3
 GgxY/xZu+uWR8/Wmx/0OVVycOPSJyEZs9penVKMXBPjnX5EX7UgLPmavlf+yr+rz779J1/OWO
 9g3B2+Oz+B5/an++FvH4aEXfo6VW93dH7KM97Qpt/Hj1/0Wr31T/ej116Gmx69V+1heC0WaLA
 jIzP/tSLjhKNfs9bGWph+3/bDICo3pKmI8e+vSNFc7l2T68443BAJui2+IOU8u7vEi2MZW5at
 NyiRDxRYxZEeqsu365DmyrdW+W/+bFZiKc5INNRiLipOBADh7eeyXwMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-13.tower-587.messagelabs.com!1648092956!80788!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15517 invoked from network); 24 Mar 2022 03:35:57 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-13.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 24 Mar 2022 03:35:57 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 22O3Zkl0025303
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
 Thu, 24 Mar 2022 03:35:51 GMT
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 24 Mar 2022 03:35:43 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <pvorel@suse.cz>
Date: Thu, 24 Mar 2022 11:35:16 -0400
Message-ID: <1648136116-22026-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Yjt21XFn+8n78gZ7@pevik>
References: <Yjt21XFn+8n78gZ7@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/umount2: Convert to new API and use
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
 testcases/kernel/syscalls/umount2/umount2.h    |  18 +--
 testcases/kernel/syscalls/umount2/umount2_02.c | 210 ++++++++-----------------
 testcases/kernel/syscalls/umount2/umount2_03.c | 167 --------------------
 5 files changed, 71 insertions(+), 326 deletions(-)
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
index 65e4c24..22df8c6 100644
--- a/testcases/kernel/syscalls/umount2/umount2.h
+++ b/testcases/kernel/syscalls/umount2/umount2.h
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef UMOUNT2_H__
@@ -28,13 +16,13 @@ static inline int umount2_retry(const char *target, int flags)
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
index 7d558fa..8d893c0 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -1,182 +1,108 @@
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
 
-/*
- * DESCRIPTION
+/*\
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
