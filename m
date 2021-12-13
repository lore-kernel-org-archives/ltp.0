Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4FEC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:26:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA1043C8C07
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:26:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 611193C2242
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:26:36 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 437A01000D0B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639380394; i=@fujitsu.com;
 bh=nrkO/izFIfKtTaNwDLYLEojUpaQ1f7umLu7TMgN8rhQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=XyEBTzD2W6RcJCewmGKwVdkQJBktqSy1p4OXof8w4uOte8WG+k4t8AHiayPAj4qRI
 NScTYwi+rlIjhFXowvDpeG/WM9r6vsQO+JMkWmpZQtMZuD25jW2DK/U178OqD7NMxk
 MugLMAR14fjuhtLzUjF5uso9VxtnbxaCkYmntaxmTiTjnryMwpl1+ZRsE6A0tRNFCi
 i0c3kBYaP8T5DBzhzO2b/k+HPoGlvETeTJeOwwrK+178akEiG2GqjpcCY1M3INzPxW
 NL6CdODbw+aB4lBegTzTvXZXkTX4slSOwc6GxoANFXYY8ehYvjN4FHLffQ+O1J0R+i
 cm1C22smr64UQ==
Received: from [100.115.71.165] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id 57/AC-06990-AA5F6B16;
 Mon, 13 Dec 2021 07:26:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsViZ8MxSXfl122
 JBicOm1qs+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBltiyYzFdwxq2haPYG5gXGaXhcjJ4eQwFlG
 iWM3o7sYuYDsnUwSf/7+YYZw9jBKrOjrYgGpYhPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0i
 wnEFhbwkfjS/R2shkVAVeLI7NWsIDavgKfEyY0zwGokBBQkpjx8D1bDKeAl8e7CfUaIK5IkJr
 TOZoKoF5Q4OfMJC8R8CYmDL14wQ/QqSlzq+MYIYVdIzJrVBjVTTeLquU3MExgFZyFpn4WkfQE
 j0ypGu6SizPSMktzEzBxdQwMDXUNDU11zQ11DY2O9xCrdRL3UUt3k1LySokSgtF5iebFeanGx
 XnFlbnJOil5easkmRmAwpxS7t+5gvNz3U+8QoyQHk5Io7zfGrYlCfEn5KZUZicUZ8UWlOanFh
 xhlODiUJHi9vmxLFBIsSk1PrUjLzAFGFkxagoNHSYTXFSTNW1yQmFucmQ6ROsVozHH5+rxFzB
 x/NixZxCzEkpeflyolzpsFUioAUppRmgc3CBbxlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCo
 J8waATOHJzCuB2/cK6BQmoFMYKzeDnFKSiJCSamA6wyrocnfKPzMr5e2r5Q99FXb6s/uT5Zss
 7S1n3r49Mas2jXf3luryR433Tvfw2a/easX5yXv79po5E10FlLVvVejfdS021Ht/aspEDo+Pj
 Xym8g37r8QEvY5eosFtcjHEP8Gz6Z7jnN8zk177qyXkKjx4cU8wrrhF+1rf5Fyjkqh1CxiqVe
 wjPT9cztowLfRcZW6WWGH1hYA3fxvm7N/BohoWvFQ8QXlSsM6iD4v6HZINT8s0CYdL+jprplV
 9EFlTdWJzCvuB4CPh0dVaNqkS14slc0tUJl/5GnJ5U0LTI8taU7WkIgYH0VelSR8Db7/cPU0x
 cXcUr/jV1f0pDavF1lq4pdx4ZXsxOHuukBJLcUaioRZzUXEiAJxwpw5zAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-545.messagelabs.com!1639380393!179926!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28842 invoked from network); 13 Dec 2021 07:26:33 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-19.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 07:26:33 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 607F4100353
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:26:33 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 533171000FC
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:26:33 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 07:26:25 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 15:26:50 +0800
Message-ID: <1639380414-24390-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/6] syscalls/quotactl02,
 5: Add quotactl_fd test variant
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

Also remove useless geteuid and add static prefix.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl02.c     | 15 ++++++++--
 .../kernel/syscalls/quotactl/quotactl02.h     | 30 +++++++++----------
 .../kernel/syscalls/quotactl/quotactl05.c     | 15 ++++++++--
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 55a6a8906..56fa23b9d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -99,11 +99,18 @@ static struct t_case {
 
 static void setup(void)
 {
-	test_id = geteuid();
+	quotactl_info();
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 	check_support_cmd(USRQUOTA);
 	check_support_cmd(GRPQUOTA);
 }
 
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
 static void verify_quota(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
@@ -122,7 +129,7 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
 		return;
@@ -144,9 +151,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
-	.mntpoint = mntpoint,
+	.mntpoint = MNTPOINT,
 	.mnt_data = "usrquota,grpquota",
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 };
 #else
 	TST_TEST_TCONF("System doesn't have <xfs/xqm.h>");
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
index 3351fb578..28b632646 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -12,7 +12,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
@@ -24,9 +24,8 @@ static struct fs_disk_quota set_dquota = {
 static uint32_t test_id;
 static int x_getnextquota_nsup;
 static int x_getstatv_nsup;
-static const char mntpoint[] = "mnt_point";
 
-void check_support_cmd(int quotatype)
+static void check_support_cmd(int quotatype)
 {
 	struct fs_disk_quota resfs_dquota;
 	struct fs_quota_statv resfs_qstatv = {
@@ -36,23 +35,24 @@ void check_support_cmd(int quotatype)
 	x_getnextquota_nsup = 0;
 	x_getstatv_nsup = 0;
 
-	TEST(quotactl(QCMD(Q_XGETNEXTQUOTA, quotatype), tst_device->dev,
+	TEST(do_quotactl(fd, QCMD(Q_XGETNEXTQUOTA, quotatype), tst_device->dev,
 		      test_id, (void *) &resfs_dquota));
 	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
 		x_getnextquota_nsup = 1;
 
-	TEST(quotactl(QCMD(Q_XGETQSTATV, quotatype), tst_device->dev, test_id,
+	TEST(do_quotactl(fd, QCMD(Q_XGETQSTATV, quotatype), tst_device->dev, test_id,
 		      (void *) &resfs_qstatv));
 	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
 		x_getstatv_nsup = 1;
 
 }
-void check_qoff(int subcmd, char *desp, int flag)
+
+static void check_qoff(int subcmd, char *desp, int flag)
 {
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off status");
@@ -67,12 +67,12 @@ void check_qoff(int subcmd, char *desp, int flag)
 	tst_res(TPASS, "quotactl() succeeded to %s", desp);
 }
 
-void check_qon(int subcmd, char *desp, int flag)
+static void check_qon(int subcmd, char *desp, int flag)
 {
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on status");
@@ -87,14 +87,14 @@ void check_qon(int subcmd, char *desp, int flag)
 	tst_res(TPASS, "quotactl() succeeded to %s", desp);
 }
 
-void check_qoffv(int subcmd, char *desp, int flag)
+static void check_qoffv(int subcmd, char *desp, int flag)
 {
 	int res;
 	struct fs_quota_statv res_qstatv = {
 		.qs_version = FS_QSTATV_VERSION1,
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off stav");
@@ -109,14 +109,14 @@ void check_qoffv(int subcmd, char *desp, int flag)
 	tst_res(TPASS, "quotactl() succeeded to %s", desp);
 }
 
-void check_qonv(int subcmd, char *desp, int flag)
+static void check_qonv(int subcmd, char *desp, int flag)
 {
 	int res;
 	struct fs_quota_statv res_qstatv = {
 		.qs_version = FS_QSTATV_VERSION1
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on statv");
@@ -131,14 +131,14 @@ void check_qonv(int subcmd, char *desp, int flag)
 	tst_res(TPASS, "quotactl() succeeded to %s", desp);
 }
 
-void check_qlim(int subcmd, char *desp)
+static void check_qlim(int subcmd, char *desp)
 {
 	int res;
 	static struct fs_disk_quota res_dquota;
 
 	res_dquota.d_rtb_softlimit = 0;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_dquota);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_dquota);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs disk quota limits");
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index 15a6c1e67..e56e191df 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -62,10 +62,17 @@ static struct t_case {
 
 static void setup(void)
 {
-	test_id = geteuid();
+	quotactl_info();
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 	check_support_cmd(PRJQUOTA);
 }
 
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
 static void verify_quota(unsigned int n)
 {
 	struct t_case *tc = &tcases[n];
@@ -85,7 +92,7 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
 		return;
@@ -107,9 +114,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
-	.mntpoint = mntpoint,
+	.mntpoint = MNTPOINT,
 	.mnt_data = "prjquota",
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 };
 
 #else
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
