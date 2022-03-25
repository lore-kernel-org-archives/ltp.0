Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97432C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 05:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C358A3C882C
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 06:30:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19E163C1FF3
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 06:30:21 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 942B11A0061A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 06:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1648186218; i=@fujitsu.com;
 bh=q6z/3opcAJPsYafDNAMGqvnR03B1PCRtfay1xohi4To=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Gi1Tb/kda2UR+oo4DEZTLz1aaGz+6Ilq+prim6QC9Iu3UUGcQKpiOVkZHjhFfCpYN
 ZptOhtHJQ3mnoDBchY86yWSLgERm1Voy8ZBcu03y+HzsLL3daBBPaX/OBxy1NVgzfv
 B5DXdlJz57MeWTf2s825CdFQl9jQ9F58AQ/B446FYcGau+7KDr0+ctdBRv1UWsIHGb
 Ir9SaVNlG2DNJbMKvyUHwYo+lqkUYVwUw41bIRtTYbaYrzj7GBcuhu0Z2i+krt98oc
 sYQFW3TUqvGYBdRW7211BZv3RjjTlStNK7Y+rW2grZD9KoQAII1TzguEBupeopSOXJ
 nv2ykuGpLP6Yw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8MxSTcz2Db
 J4M0pc4sV33cwWvy4dYPFgclj3+91rB5nFhxhD2CKYs3MS8qvSGDNmHOlnbHgeEHFjf5elgbG
 xrguRi4OIYEtjBJb7q5lh3AWMEksPf2GFcLZzyjx+vA+xi5GTg42AQ2Ja4/bmUFsEQERiRf9H
 1hAbGaBKInnBxaCxYUFfCQWzJsAFOfgYBFQlTh7XB/E5BVwlbh8oACkQkJAQWLKw/dg1ZxAFT
 P2bGAFsYUEVCRudz0Ai/MKCEqcnPkEarqExMEXL5ghehUl9u/dyAhhV0jMmLGNDcJWk7h6bhP
 zBEbBWUjaZyFpX8DItIrRKqkoMz2jJDcxM0fX0MBA19DQVNdE18jYUi+xSjdRL7VUtzy1uETX
 UC+xvFgvtbhYr7gyNzknRS8vtWQTIzCsU4pZ3u9gbOr7qXeIUZKDSUmUV93HNkmILyk/pTIjs
 Tgjvqg0J7X4EKMMB4eSBK+HPVBOsCg1PbUiLTMHGGMwaQkOHiURXuNAoDRvcUFibnFmOkTqFK
 Mxx5bbB/Yyc+zccnkvsxBLXn5eqpQ4r08QUKkASGlGaR7cIFjsX2KUlRLmZWRgYBDiKUgtys0
 sQZV/xSjOwagkzHsDZCFPZl4J3L5XQKcwAZ3y/KclyCkliQgpqQam4AWCX+R2ae/x2zfR3dc+
 ftUjZc8nnyb4hvXqt2kvnPt0Q/HcYsvZrZ89jvUK83xVLVm4/uaB4rqrXXlH50rPP79wzpxdD
 79NT9bsy2mcOPeaQ6/XiT26HkmGDuVtpW/s8+arVnHss2HvKUgoZzxeMvHJ67rW5IP3C+Oq7e
 +8tL+Zb+Sppbhs2SH2tf4HpkzKrog09HZgKDUv3fRpWcCp1WnMLeUa6fo3vono675eyfxxIuP
 aBW8ubtgcprduikD6g/+rd8+2LBXqnljmeuVIR+eqnfK/r1xu+rP2r03qnVuVPI3OsgqRqZ+2
 uaRnuTns2dK5457m4/4fvjbiKbLB29btNH8ravVwygLn+cYlSizFGYmGWsxFxYkAhjx253gDA
 AA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-10.tower-587.messagelabs.com!1648186217!179458!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4999 invoked from network); 25 Mar 2022 05:30:17 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-10.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Mar 2022 05:30:17 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 73E8D1000FC;
 Fri, 25 Mar 2022 05:30:17 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 66CC01000F6;
 Fri, 25 Mar 2022 05:30:17 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 25 Mar 2022 05:29:55 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <pvorel@suse.cz>
Date: Fri, 25 Mar 2022 13:29:27 -0400
Message-ID: <1648229367-3124-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Yjw13F9Tc2m8Hz6k@pevik>
References: <Yjw13F9Tc2m8Hz6k@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] syscalls/umount2: Convert to new API and use
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

1. use SAFE macro
2. use TST_EXP_FAIL and TST_EXP_PASS macro
3. simplify verify operations
4. merge umount2_03 and umount2.h to umount2_02

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
v4->v5:
  - Add changelog from previous version
  - Make commit message order more reasonable
  - Fix description format
  - Merge umount2.h into umount2_02
  - Use macro to not repeat flag and exp_errno
  - Make test_umount2() more compact

 runtest/syscalls                               |   1 -
 testcases/kernel/syscalls/umount2/.gitignore   |   1 -
 testcases/kernel/syscalls/umount2/umount2.h    |  44 -----
 testcases/kernel/syscalls/umount2/umount2_02.c | 212 +++++++++----------------
 testcases/kernel/syscalls/umount2/umount2_03.c | 167 -------------------
 5 files changed, 77 insertions(+), 348 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/umount2/umount2.h
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
deleted file mode 100644
index 65e4c24..0000000
--- a/testcases/kernel/syscalls/umount2/umount2.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
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
- */
-
-#ifndef UMOUNT2_H__
-#define UMOUNT2_H__
-
-static inline int umount2_retry(const char *target, int flags)
-{
-	int i, ret;
-
-	for (i = 0; i < 50; i++) {
-		ret = umount2(target, flags);
-
-		if (ret == 0 || errno != EBUSY)
-			return ret;
-
-		tst_resm(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
-			 target, flags, i);
-
-		usleep(100000);
-	}
-
-	tst_resm(TWARN, "Failed to umount('%s', %i) after 50 retries",
-	         target, flags);
-
-	errno = EBUSY;
-	return -1;
-}
-
-#endif	/* UMOUNT2_H__ */
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 7d558fa..06cb36b 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -1,182 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) 2015-2022 FUJITSU LIMITED. All rights reserved
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * Test for feature MNT_EXPIRE of umount2().
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
+ * - EAGAIN when initial call to umount2(2) with MNT_EXPIRE
+ * - EAGAIN when umount2(2) with MNT_EXPIRE after access(2)
+ * - succeed when second call to umount2(2) with MNT_EXPIRE
  *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
- */
-
-/*
- * DESCRIPTION
- *  Test for feature MNT_EXPIRE of umount2().
- *  "Mark the mount point as expired.If a mount point is not currently
- *   in use, then an initial call to umount2() with this flag fails with
- *   the error EAGAIN, but marks the mount point as expired. The mount
- *   point remains expired as long as it isn't accessed by any process.
- *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
- *   mount point. This flag cannot be specified with either MNT_FORCE or
- *   MNT_DETACH. (fails with the error EINVAL)"
+ * Test for feature UMOUNT_NOFOLLOW of umount2().
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
+#include "tst_test.h"
 
-#include "umount2.h"
-
-#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
-#define MNTPOINT	"mntpoint"
-
-static void setup(void);
-static void test_umount2(int i);
-static void verify_failure(int i);
-static void verify_success(int i);
-static void cleanup(void);
+#define MNTPOINT        "mntpoint"
+#define SYMLINK	"symlink"
 
-static const char *device;
-static const char *fs_type;
+#define FLAG_DESC(x, y) .flag = x, .exp_errno = 0, .desc = "umount2("y") with "#x" expected success"
+#define FLAG_EXP_ERRNO_DESC(x, y, z) .flag = x, .exp_errno = y, \
+				     .desc = "umount2("z") with "#x" expected "#y
 
 static int mount_flag;
 
-static struct test_case_t {
+static struct tcase {
 	int flag;
 	int exp_errno;
-	int do_access;
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
-
-char *TCID = "umount2_02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int tc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	const char *mntpoint;
+	int do_access;
+} tcases[] = {
+	{FLAG_EXP_ERRNO_DESC(MNT_EXPIRE | MNT_FORCE, EINVAL, ""), MNTPOINT, 0},
 
-	setup();
+	{FLAG_EXP_ERRNO_DESC(MNT_EXPIRE | MNT_DETACH, EINVAL, ""), MNTPOINT, 0},
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	{FLAG_EXP_ERRNO_DESC(MNT_EXPIRE, EAGAIN, "initial call"), MNTPOINT, 0},
 
-		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
-		mount_flag = 1;
+	{FLAG_EXP_ERRNO_DESC(MNT_EXPIRE, EAGAIN, "after access"), MNTPOINT, 1},
 
-		for (tc = 0; tc < TST_TOTAL; tc++)
-			test_umount2(tc);
+	{FLAG_DESC(MNT_EXPIRE, "second call"), MNTPOINT, 0},
 
-		if (mount_flag) {
-			if (tst_umount(MNTPOINT))
-				tst_brkm(TBROK, cleanup, "umount() failed");
-			mount_flag = 0;
-		}
-	}
+	{FLAG_EXP_ERRNO_DESC(UMOUNT_NOFOLLOW, EINVAL, "symlink"), SYMLINK, 0},
 
-	cleanup();
-	tst_exit();
-}
+	{FLAG_DESC(UMOUNT_NOFOLLOW, "mntpoint"), MNTPOINT, 0},
+};
 
-static void setup(void)
+static inline int umount2_retry(const char *target, int flags)
 {
-	tst_require_root();
+	int i;
 
-	if ((tst_kvercmp(2, 6, 8)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			 "that are 2.6.8 or higher");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-	tst_tmpdir();
+	for (i = 0; i < 50; i++) {
+		TEST(umount2(target, flags));
+		if (TST_RET == 0 || TST_ERR != EBUSY)
+			return TST_RET;
 
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+		tst_res(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
+			target, flags, i);
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+		usleep(100000);
+	}
 
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
+		target, flags);
 
-	TEST_PAUSE;
+	TST_ERR = EBUSY;
+	return -1;
 }
 
-static void test_umount2(int i)
+static void test_umount2(unsigned int n)
 {
-	/* a new access removes the expired mark of the mount point */
-	if (test_cases[i].do_access) {
-		if (access(MNTPOINT, F_OK) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
+	struct tcase *tc = &tcases[n];
+
+	if (!mount_flag) {
+		SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+		mount_flag = 1;
 	}
 
-	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
+	tst_res(TINFO, "Testing %s", tc->desc);
+
+	if (tc->do_access)
+		SAFE_ACCESS(MNTPOINT, F_OK);
 
-	if (test_cases[i].exp_errno != 0)
-		verify_failure(i);
+	if (tc->exp_errno)
+		TST_EXP_FAIL(umount2_retry(tc->mntpoint, tc->flag), tc->exp_errno,
+			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
 	else
-		verify_success(i);
-}
+		TST_EXP_PASS(umount2_retry(tc->mntpoint, tc->flag),
+			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
 
-static void verify_failure(int i)
-{
-	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "%s passed unexpectedly", test_cases[i].desc);
+	if (!!tc->exp_errno ^ !!TST_PASS)
 		mount_flag = 0;
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
