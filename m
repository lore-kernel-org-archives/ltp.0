Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731ABC5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786649233; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=wp4k009lSOtY6C4RJ4EHcbLEEeRrcHESJPSStd0Fm90=;
 b=grWmkii/9OFrSO6ZiejqFyuYh+kzq27ip6zNw1/nl5L1biYUWVBeSg39n5W0czioAdC6h
 UPs8UwyTzZ90Npw5HrZqWaa2h//ti+RC0ijuIZn+SfWKDVsvdajEMHFqiQn1Owngd/ZNAMg
 vhI4X775YxxE3fa7ljXak5CKgCoyfiw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C13B3C6F2C
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 21:27:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C02EF3C5E58
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:26:52 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 030481A003C0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:26:51 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso2114305e9.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786649211; x=1787254011; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JWmePVES48qNI12cRU4dNkpf4gJJ/yn2Pemjdw5kEdU=;
 b=NVZVQutK/6jwiEICiF01O35/K6nkRj3gNe5wUkeqRQkWkYCLgUm8PgeAZCScQPp0BQ
 TLJSHZdJlVSmhypFR/UmYOl/NUHrVUczmhY+4hxz4H7uZbq75P8ZpSFj+vG8c3lBojwy
 X/fCKA8Z8z4K7kQdkfE5xShz/ef6JFMx5NERp2zHrG6utCZiaKVFhkZByP0BBgkOzaLD
 mz6jjJlD00yLE9E0DFfpEAR62cmEzZXK6XqwaRwoRtBhVT/InDdMPfl5ddh7QsOF91VP
 IoiG/dHnsIVeT13IjH6Xd03f7BF5xy2UTir9PqVqoKkAfRgwCF/K/Kl4AA14OaHzNNav
 EHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786649211; x=1787254011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JWmePVES48qNI12cRU4dNkpf4gJJ/yn2Pemjdw5kEdU=;
 b=r2vE60MiCsByBjkKWI8zASJVqRwaepksR8zcfsmaAALVzddRU0DwX2AP6W/uvXeK+N
 5SK+bfVBC02q47H219V8hS6z605V5AW1WQ46DJFRiRF4NqGJonsH8Xkpl3NXmAEwQQEj
 MfBLHd93Ki/bVXQoaTCsb8NIWReqosZI9kCY0h/3P/pVReuclLgk6IDRvH6wm4o0h22N
 2KC2Sii2b/ZVkyscrJ8ZcxSKdRO6OtiEc3F8Qjm7U4R1ac1kWrxyeNj5IygkUft3IYW0
 gdIni7i0cjG5OdCNIsVbZTRxTEztCYiTouKJD2R+EXJA9ptMyqvqwIi3OwRwb8GFPE2B
 xiIw==
X-Gm-Message-State: AOJu0YzZzSiclfLlCfsziApe3Xt0fTWf0EWHXhKwvDDjmVuMYfAvd5j8
 5ZdKFxn8HqvjdwgvxmYY5PvVR7QMNNmVBebxEUJM4pjEN5jy5oRDnYkbbcBY2Ldb11bw/juARdf
 KvoFQuI0=
X-Gm-Gg: AR+sD12rM6aFgNBy2FsrJ6lkji864pUbDGI7xUzQF2syqZrlyMjL/rZCV9oQb5xlpHu
 Z43v577/F8LBOG8Bw7ZZl7YKLNyRrO4gOG0PbO2fPo0a7mN3b27rhTwFmXLcHpVOa9JBKBy2CXS
 QfLF8bYSxcnJVwdxMsz5tzW4rhwIpNJZXt8HhAGhN/WIrhYtF1eRdSnv5QyWOtMxLBsNkQBsc+y
 JNOd56x1QcktVkpTpyrkfK4cqwrdePPGYnpBv9VlJuuQ9kMVcJVzwSYjdM2q3lQDCvdipEIvLlo
 OjYCJH2ShYc6mM7QP+Vj2Qto5sdWpHQfpIXbCDEYsg0s6Rpg6Ppce3MN/Da1o0EFEYWWp280Ycp
 RkJeX3tYQkbtsW37ERNd64oQIRh0zCoXF73DVRjP4FB2CMwkX4KVlsjuAXI1oCVMlJLcscAj1wU
 BmLYStq6iIvW7RDhgui8NY03seQIXHwZE/L+eQBVUGOr3wJAQ=
X-Received: by 2002:a05:600c:6a10:b0:499:79ba:a754 with SMTP id
 5b1f17b1804b1-49987973094mr7183885e9.11.1786649211105; 
 Thu, 13 Aug 2026 12:26:51 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20059asm1477465f8f.5.2026.08.13.12.26.50
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:26:50 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 13 Aug 2026 21:26:48 +0200
Message-ID: <20260813192649.192136-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: rename11: Convert test to new API
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/rename/rename11.c | 215 +++++++-------------
 1 file changed, 71 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 26e324d646db..88dd7e2a86c7 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -1,187 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
+ * Copyright (c) 2026 Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Description:
- *  Verify that,
- *   1. rename() fails with -1 return value and sets errno to ELOOP, if too
- *      many symbolic links were encountered in resolving oldpath or newpath.
- *   2. rename() fails with -1 return value and sets errno to EROFS,
- *      if the file is on a read-only file system.
- *   3. rename() fails with -1 return value and sets errno to EMLINK,
- *	if the file named by old is a directory and the link count of
- *	the parent directory of new would exceed {LINK_MAX}.
+/*\
+ * Verify that :manpage:`rename(2)` fails with:
+ *
+ * - ``ELOOP`` when too many symbolic links are encountered while resolving
+ *   oldpath or newpath.
+ * - ``EROFS`` when the file is on a read-only file system.
+ * - ``EMLINK`` when oldpath is a directory and the link count of the parent
+ *   directory of newpath would exceed ``LINK_MAX``.
  */
 
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 #include <sys/mount.h>
 
-#include "test.h"
-#include "tso_safe_macros.h"
-
-char *TCID = "rename11";
+#include "tst_test.h"
 
 #define MNTPOINT	"mntpoint"
-#define TEST_EROFS	"mntpoint/test_erofs"
-#define TEST_NEW_EROFS	"mntpoint/new_test_erofs"
+#define TEST_EROFS	MNTPOINT "/test_erofs"
+#define TEST_NEW_EROFS	MNTPOINT "/new_test_erofs"
 
 #define TEST_EMLINK	"test_emlink"
 #define TEST_NEW_EMLINK	"emlink_dir/testdir"
 
 #define TEST_NEW_ELOOP	"new_test_eloop"
-#define ELOPFILE	"/test_eloop"
-static char elooppathname[sizeof(ELOPFILE) * 43] = ".";
-static int max_subdirs;
+#define ELOOPFILE	"/test_eloop"
 
-static const char *device;
-static const char *fs_type;
-static int mount_flag;
-
-static void cleanup(void);
-static void setup(void);
-static void test_eloop(void);
-static void test_erofs(void);
-static void test_emlink(void);
-
-static void (*testfunc[])(void) = { test_eloop, test_erofs, test_emlink };
-
-int TST_TOTAL = ARRAY_SIZE(testfunc);
+static char elooppathname[sizeof(ELOOPFILE) * 43] = ".";
+static int max_subdirs;
 
-int main(int ac, char **av)
+static void test_eloop(void)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	TST_EXP_FAIL(rename(elooppathname, TEST_NEW_ELOOP), ELOOP);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
+	if (!TST_RET)
+		SAFE_UNLINK(TEST_NEW_ELOOP);
 }
 
-static void setup(void)
+static void test_erofs(void)
 {
-	int i;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	TEST_PAUSE;
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		   MS_REMOUNT | MS_RDONLY, NULL);
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+	TST_EXP_FAIL(rename(TEST_EROFS, TEST_NEW_EROFS), EROFS);
 
-	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
-	mount_flag = 1;
-	SAFE_TOUCH(cleanup, TEST_EROFS, 0644, NULL);
+	if (!TST_RET)
+		SAFE_UNLINK(TEST_NEW_EROFS);
 
-	SAFE_MKDIR(cleanup, TEST_EMLINK, 0755);
-	max_subdirs = tst_fs_fill_subdirs(cleanup, "emlink_dir");
-	/*
-	 * NOTE: the ELOOP test is written based on that the consecutive
-	 * symlinks limits in kernel is hardwired to 40.
-	 */
-	SAFE_MKDIR(cleanup, "test_eloop", 0644);
-	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
-	for (i = 0; i < 43; i++)
-		strcat(elooppathname, ELOPFILE);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		   MS_REMOUNT, NULL);
 }
 
-static void check_and_print(int expected_errno)
+static void test_emlink(void)
 {
-	if (TEST_RETURN == -1) {
-		if (TEST_ERRNO == expected_errno) {
-			tst_resm(TPASS | TTERRNO, "failed as expected");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "failed unexpectedly; expected - %d : %s",
-				 expected_errno, strerror(expected_errno));
-		}
-	} else {
-		tst_resm(TFAIL, "rename succeeded unexpectedly");
+	if (!max_subdirs) {
+		tst_res(TCONF, "EMLINK test is not appropriate");
+		return;
 	}
-}
 
-static void test_eloop(void)
-{
-	TEST(rename(elooppathname, TEST_NEW_ELOOP));
-	check_and_print(ELOOP);
+	TST_EXP_FAIL(rename(TEST_EMLINK, TEST_NEW_EMLINK), EMLINK);
 
-	if (TEST_RETURN == 0)
-		SAFE_UNLINK(cleanup, TEST_NEW_ELOOP);
+	if (!TST_RET)
+		SAFE_RMDIR(TEST_NEW_EMLINK);
 }
 
-static void test_erofs(void)
-{
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
-		   NULL);
-
-	TEST(rename(TEST_EROFS, TEST_NEW_EROFS));
-	check_and_print(EROFS);
-
-	if (TEST_RETURN == 0)
-		SAFE_UNLINK(cleanup, TEST_NEW_EROFS);
+static struct tcase {
+	void (*run)(void);
+	const char *tname;
+} tcases[] = {
+	{test_eloop, "eloop"},
+	{test_erofs, "erofs"},
+	{test_emlink, "emlink"},
+};
 
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT, NULL);
-}
-
-static void test_emlink(void)
+static void run(unsigned int n)
 {
-	if (max_subdirs == 0) {
-		tst_resm(TCONF, "EMLINK test is not appropriate");
-		return;
-	}
-
-	TEST(rename(TEST_EMLINK, TEST_NEW_EMLINK));
-	check_and_print(EMLINK);
+	struct tcase *tc = &tcases[n];
 
-	if (TEST_RETURN == 0)
-		SAFE_RMDIR(cleanup, TEST_NEW_EMLINK);
+	tst_res(TINFO, "Testing %s", tc->tname);
+	tc->run();
 }
 
-static void cleanup(void)
+static void setup(void)
 {
-	if (mount_flag && tst_umount(MNTPOINT) < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+	unsigned int i;
+
+	SAFE_TOUCH(TEST_EROFS, 0644, NULL);
 
-	if (device)
-		tst_release_device(device);
+	SAFE_MKDIR(TEST_EMLINK, 0755);
+	max_subdirs = tst_fs_fill_subdirs("emlink_dir");
 
-	tst_rmdir();
+	/*
+	 * The ELOOP test assumes the kernel's consecutive symlink resolution
+	 * limit (MAXSYMLINKS) is hardcoded to 40.
+	 */
+	SAFE_MKDIR("test_eloop", 0644);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(elooppathname, ELOOPFILE);
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
