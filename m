Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16701C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:55:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62C061178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B62C061178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CA4D3C07C0
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:55:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71E2A3C07BA
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:55:09 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 283181A014B5
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:55:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455308; i=@fujitsu.com;
 bh=WabrcnmiGqZzKqL5V1EwfJNGB2ozxT2qRWIRcSWfFyU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=BnSQls3Kbf2D7R5f1VgTo+bz6NrgfXLt2cYJAZrGfAKoelIes1QasSVSHf6/ujr/X
 FA/Smp4DvM3uJ/NvC1DkSoe98qQo5rOe0jRWsxPBe/0E7jg/x0ihELMEoDMCOSl4lI
 ARHWuGiOmnvjOUzOJRh/xH0iSeWqtzeaOPR4vj/fMfwmFa4qOzfulMKW3xX2RRMlAX
 w+DrO/GT1+4biOjE4OBE11yWky7lm2W4wbYBnzjXiLSYBZD49Q784Mbvv00W0JdACI
 Bw3IviSHHYsjxipriA5H+wPJCSJfIUAe6OdAIX89zEEFIXdg9YbgX7keBuiOFK3kd+
 1GgZzS4Lmsldg==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 7A/B0-30139-C835A816;
 Tue, 09 Nov 2021 10:55:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsViZ8MxSbc7uCv
 R4Oh8K4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNePtzCnsBY/0KrYtsm5gvKHexcjFISRwllHi
 3ZZ37BDOTiaJg0c/MEM4uxklNm06wNLFyMnBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXE
 4gtLOArsf3CBMYuRg4OFgEViZObdUDCvAIeEl/vNbGB2BICChJTHr4HG8Mp4Cmx98J/sPFCQD
 W3pp1khagXlDg58wkLxHgJiYMvXjBD9CpKXOr4xghhV0jMmtXGBGGrSVw9t4l5AqPgLCTts5C
 0L2BkWsVokVSUmZ5RkpuYmaNraGCga2horGsGZOklVukm6aWW6ian5pUUJQIl9RLLi/WKK3OT
 c1L08lJLNjECwzelkI1rB+PT1x/0DjFKcjApifJeFutKFOJLyk+pzEgszogvKs1JLT7EKMPBo
 STBm+APlBMsSk1PrUjLzAHGEkxagoNHSYRXzwcozVtckJhbnJkOkTrFaMxx+fq8RcwcfzYsWc
 QsxJKXn5cqJc6bEgRUKgBSmlGaBzcIFuOXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzfgo
 EmsKTmVcCt+8V0ClMQKcc/NIOckpJIkJKqoFp/TG/jS//zq5b/P6x1VexHffW5M9RWdh6Xy/u
 2RWWRZ4/CsrsPO2XHqu7fnUDz/X0WTa7Dyy3evaseO2p/W5vPild1rLO3/3T6CuvtYH3RpH9d
 Vf7zouuyNaXz87wnJ7H+/REUmr0q9XuApdubo6ZVztphXXUzMxjTyOF059t4JWaYBDU9yD5yY
 u9fHMOHlslLKNX4+7lN5dl91nRM2Xv2bukjQM/fPDcEJtXt2D/9Wm9DPENN6svym+9pPhm+ak
 Z5z547GPUertcYWW/vbRdX6jSMa2W7s9ZfW5N8l8O7DXins/kGpQypcjzZ8e2BecXTNr59dZD
 3XdTy5xrUj+9YOy8uCLvfkVi86/5txWOBiixFGckGmoxFxUnAgCa+JKPbAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-238.messagelabs.com!1636455307!632292!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3098 invoked from network); 9 Nov 2021 10:55:07 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-17.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:55:07 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 75928100465
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:55:07 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 688BE100359
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:55:07 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:54:45 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:54:44 +0800
Message-ID: <1636455285-8372-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 08/12] syscalls/quotactl02,
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

Also remove useless geteuid.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl02.c | 15 ++++++++++++---
 testcases/kernel/syscalls/quotactl/quotactl02.h | 17 ++++++++---------
 testcases/kernel/syscalls/quotactl/quotactl05.c | 15 ++++++++++++---
 3 files changed, 32 insertions(+), 15 deletions(-)

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
index 3351fb578..145ce7039 100644
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
@@ -24,7 +24,6 @@ static struct fs_disk_quota set_dquota = {
 static uint32_t test_id;
 static int x_getnextquota_nsup;
 static int x_getstatv_nsup;
-static const char mntpoint[] = "mnt_point";
 
 void check_support_cmd(int quotatype)
 {
@@ -36,12 +35,12 @@ void check_support_cmd(int quotatype)
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
@@ -52,7 +51,7 @@ void check_qoff(int subcmd, char *desp, int flag)
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off status");
@@ -72,7 +71,7 @@ void check_qon(int subcmd, char *desp, int flag)
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on status");
@@ -94,7 +93,7 @@ void check_qoffv(int subcmd, char *desp, int flag)
 		.qs_version = FS_QSTATV_VERSION1,
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off stav");
@@ -116,7 +115,7 @@ void check_qonv(int subcmd, char *desp, int flag)
 		.qs_version = FS_QSTATV_VERSION1
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on statv");
@@ -138,7 +137,7 @@ void check_qlim(int subcmd, char *desp)
 
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
