Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A4C38142
	for <ltp@archiver.kernel.org>; Tue, 31 Jan 2023 09:13:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 218813CC588
	for <ltp@archiver.kernel.org>; Tue, 31 Jan 2023 10:13:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFAF43C4AF6
 for <ltp@lists.linux.it>; Tue, 31 Jan 2023 10:13:19 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC6D5200960
 for <ltp@lists.linux.it>; Tue, 31 Jan 2023 10:13:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1675156397; i=@fujitsu.com;
 bh=yuXBpSWqykBteoDGCvaA8yw78VUdHdrYTXHD2NUfd/4=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=qIPrAsLIa+YtqjMcQRps2OZXJjni1mg7KTywcm0rmswC1Ud5EBM9PP8btNlohSyNn
 5H87pGcl0LV4zJ+f3S0YzkDExi9EWRcuIacIwIISLo4znia8L8MJrUnmHdnkPvYFBz
 O961vIrSqHE2FhnfC0jQMM++mGyMLE89/CsfzBSEr97Am0WjeT4/tesvVCkGiKTj2Y
 AVu6DQ8nvEX41WXvnnmBrZtNoPaYe3HaVdkRRTw/w8fqywJm/WerPpAPsf873/zcpu
 TUhnNonFYwikxmkbGtg19XoZG4D9jORqtiTx1tO4ZPvTHxqEzY1Tth0xQuGFYF/dPQ
 RsStcFcvP7/mg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRWlGSWpSXmKPExsViZ8MxSXf17Rv
 JBlO7rCxWfN/B6MDose/3OtYAxijWzLyk/IoE1oxNd68zFbzRrtg58wFjA+MR1S5GLg4hgbOM
 EtMebmKCcA4ySWzefZgNwtnLKPH5QgtrFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX
 0wgtrCAl8Sb+f+A6jk4WARUJfZuDwMJ8wp4Sqz81w42RkJAQWLKw/fMEHFBiZMzn7BAjJGQOP
 jiBTNEjaLE/13PoOorJVo//GKBsNUkrp7bxDyBkX8WkvZZSNoXMDKtYjQrTi0qSy3StdRLKsp
 MzyjJTczM0Uus0k3USy3VzcsvKsnQNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAgMxpTi9NwdjJeW
 /dE7xCjJwaQkyjv3/fVkIb6k/JTKjMTijPii0pzU4kOMMhwcShK8m6/dSBYSLEpNT61Iy8wBR
 gZMWoKDR0mEt/YGUJq3uCAxtzgzHSJ1ilFRSpxX+zJQQgAkkVGaB9cGi8ZLjLJSwryMDAwMQj
 wFqUW5mSWo8q8YxTkYlYR5O24BTeHJzCuBm/4KaDET0GJN96sgi0sSEVJSDUx8pxOi34q+0dg
 rYdqe1ig3z7f41Z7Alu+6a0zzj3+KV+rdEqH1dL1m1QY33zlHD3Yc/pnK+XLhXpmby+ewvfwS
 8VKy08tG8mi405P616Ze0x6ff1Rk+urKF4b24tJze7jq5zSEnXI9OPVjlWxozbpun9c2iU16T
 zMTd81i+bBTZ1rIhFsqLFMl91x4sXGb5c5DEzW/fLzu/uJzkNvHd6tmrd13Umfdmu3z5W2Do5
 6J/jFelfkkZe6lSdHv/9a9+3j9m639o+1ds3aFRilcL4z69fTSigOn/qlO2nekxtFXZuVBYxG
 tnsSP5tZ7izvUVIXyZwvK8EdM5V/ZIKCqtLn+6BbmyqsPrK7avcp6rMbJocRSnJFoqMVcVJwI
 AAuTMGdBAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-732.messagelabs.com!1675156395!1241701!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29960 invoked from network); 31 Jan 2023 09:13:15 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 31 Jan 2023 09:13:15 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5B9AB1000E9
 for <ltp@lists.linux.it>; Tue, 31 Jan 2023 09:13:15 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 4F6D71000E7
 for <ltp@lists.linux.it>; Tue, 31 Jan 2023 09:13:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.99) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 31 Jan 2023 09:13:13 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 31 Jan 2023 04:11:58 -0500
Message-ID: <1675156318-14860-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.99]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/mount07: Add new test case for
 MS_NOSYMFOLLOW
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

Fixes:#960
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/mount.h                       |   4 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/mount/.gitignore |   1 +
 testcases/kernel/syscalls/mount/mount07.c  | 177 +++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount/mount07.c

diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index 66e1d1319..c1af944fe 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -33,4 +33,8 @@
 # define UMOUNT_NOFOLLOW 8
 #endif
 
+#ifndef MS_NOSYMFOLLOW
+# define MS_NOSYMFOLLOW 256
+#endif
+
 #endif /* LAPI_MOUNT_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192..81c30402b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -804,6 +804,7 @@ mount03 mount03
 mount04 mount04
 mount05 mount05
 mount06 mount06
+mount07 mount07
 
 mount_setattr01 mount_setattr01
 
diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
index f92600d36..80885dbf0 100644
--- a/testcases/kernel/syscalls/mount/.gitignore
+++ b/testcases/kernel/syscalls/mount/.gitignore
@@ -5,3 +5,4 @@
 /mount04
 /mount05
 /mount06
+/mount07
diff --git a/testcases/kernel/syscalls/mount/mount07.c b/testcases/kernel/syscalls/mount/mount07.c
new file mode 100644
index 000000000..eb3fb55a0
--- /dev/null
+++ b/testcases/kernel/syscalls/mount/mount07.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for MS_NOSYMFOLLOW mount option and is copied
+ * from kernel selftests nosymfollow-test.c.
+ *
+ * It tests to make sure that symlink traversal fails with ELOOP when
+ * 'nosymfollow' is set, but symbolic links can still be created, and
+ * readlink(2) and realpath(3) still work properly. It also verifies
+ * that statfs(2) correctly returns ST_NOSYMFOLLOW.
+ */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <stdbool.h>
+#include "tst_test.h"
+#include "lapi/mount.h"
+
+#ifndef ST_NOSYMFOLLOW
+# define ST_NOSYMFOLLOW 0x2000
+#endif
+
+#define MNTPOINT "mntpoint"
+
+static char test_file[PATH_MAX];
+static char link_file[PATH_MAX];
+static char temp_link_file[PATH_MAX];
+static int flag;
+
+static void setup_symlink(void)
+{
+	int fd;
+
+	fd = SAFE_CREAT(test_file, O_RDWR);
+	SAFE_SYMLINK(test_file, link_file);
+	SAFE_CLOSE(fd);
+	flag = 1;
+}
+
+static void test_link_traversal(bool nosymfollow)
+{
+	if (nosymfollow) {
+		TST_EXP_FAIL2(open(link_file, 0, O_RDWR), ELOOP,
+				"open(%s, 0, O_RDWR)", link_file);
+	} else {
+		TST_EXP_FD(open(link_file, 0, O_RDWR));
+	}
+
+	if (TST_RET > 0)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void test_readlink(void)
+{
+	char buf[4096];
+
+	memset(buf, 0, 4096);
+	TST_EXP_POSITIVE(readlink(link_file, buf, sizeof(buf)),
+			"readlink(%s, buf, %ld)", link_file, sizeof(buf));
+	if (strcmp(buf, test_file) != 0) {
+		tst_res(TFAIL, "readlink strcmp failed, %s, %s",
+				buf, test_file);
+	} else {
+		tst_res(TPASS, "readlink strcmp succeeded");
+	}
+}
+
+static void test_realpath(void)
+{
+	TESTPTR(realpath(link_file, NULL));
+
+	if (!TST_RET_PTR) {
+		tst_res(TFAIL | TERRNO, "realpath failed");
+		return;
+	}
+
+	if (strcmp(TST_RET_PTR, test_file) != 0) {
+		tst_res(TFAIL, "realpath strcmp failed, %s, %s",
+				(char *)TST_RET_PTR, test_file);
+	} else {
+		tst_res(TPASS, "realpath strcmp succeeded");
+	}
+}
+
+static void test_cycle_link(void)
+{
+	TST_EXP_PASS(symlink(test_file, temp_link_file), "symlink(%s, %s)",
+			test_file, temp_link_file);
+	TST_EXP_PASS(unlink(temp_link_file));
+}
+
+static void test_statfs(bool nosymfollow)
+{
+	struct statfs buf;
+
+	SAFE_STATFS(MNTPOINT, &buf);
+	if (buf.f_flags & ST_NOSYMFOLLOW) {
+		tst_res(nosymfollow ? TPASS : TFAIL, "ST_NOSYMFOLLOW set on %s",
+				MNTPOINT);
+	} else {
+		tst_res(nosymfollow ? TFAIL : TPASS, "ST_NOSYMFOLLOW not set on %s",
+				MNTPOINT);
+	}
+}
+
+static void setup(void)
+{
+	char *tmpdir = tst_get_tmpdir();
+
+	snprintf(test_file, PATH_MAX, "%s/%s/test_file", tst_get_tmpdir(),
+			MNTPOINT);
+	snprintf(link_file, PATH_MAX, "%s/%s/link_file", tst_get_tmpdir(),
+			MNTPOINT);
+	snprintf(temp_link_file, PATH_MAX, "%s/%s/temp_link_file",
+			tst_get_tmpdir(), MNTPOINT);
+	free(tmpdir);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static void run_tests(bool nosymfollow)
+{
+	test_link_traversal(nosymfollow);
+	test_readlink();
+	test_realpath();
+	test_cycle_link();
+	test_statfs(nosymfollow);
+}
+
+static void run(void)
+{
+	tst_res(TINFO, "Testing behaviour when not setting MS_NOSYMFOLLOW");
+
+	TST_EXP_PASS_SILENT(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		0, NULL));
+	if (!flag || !strcmp(tst_device->fs_type, "tmpfs"))
+		setup_symlink();
+	run_tests(false);
+
+	tst_res(TINFO, "Testing behaviour when setting MS_NOSYMFOLLOW");
+	TST_EXP_PASS_SILENT(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		MS_REMOUNT | MS_NOSYMFOLLOW, NULL));
+	run_tests(true);
+
+	SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.min_kver = "5.10",
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []){
+		"exfat",
+		"vfat",
+		"ntfs",
+		NULL
+	},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
