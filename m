Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D9C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0947160F5A
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0947160F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 807133C6AAD
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:29:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06B923C68DE
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:01 +0200 (CEST)
Received: from mail3.bemta25.messagelabs.com (mail3.bemta25.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 483BB10004A2
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337740; i=@fujitsu.com;
 bh=qvV5plxkux3/ch6hYilEF28juBEOn+EPU63tmgn4KKw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=YBWVBlRKKBHpahG7eWaInAG79BHM64ZSsz7C+XR+ZU82AkEsLhJStUnh14aqY8nLl
 BtHsKi5byio4tDNEBomHiC61pUX1F2XXVM2y28gtK5suZ19Rh5Knbqv6UOFon8GBXe
 /IotnnZXDdGxX3LBMCORZ7YftT5bmGTI3lCBtq35ZV9qADucqQzn3fahx6fJzaHpGv
 JrGfsv4Qt+S7cqHQ+TQou/eH2t8o+f2pGd+3QyryH2moR6HIDPomREVuV7DVj0JkzC
 vbPJSzuST22h4XMROhz3RpOPUd3mhS/xVVYgYxFs740585PapB9oFSoJEZiP1KEA5H
 H5I0RMs9u6KUA==
Received: from [100.112.196.123] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-west-1.aws.symcld.net id BF/0C-24823-C0649716;
 Wed, 27 Oct 2021 12:29:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsViZ8ORqMvtVpl
 oMO2mtcWK7zsYHRg99v1exxrAGMWamZeUX5HAmrGy9z5TwTSDioU7FzA1MD7S6GLk4hASOMso
 cWjXHaYuRk4gZyeTxJy1RhCJPYwSC/99ZQdJsAloSjzrXMAMYosISEh0NLwFizMLqEssn/QLr
 FlYwE/i2fwzYHEWAVWJI/N+gtm8Ah4S/+/eZQOxJQQUJKY8fA82h1PAU+LJmh0sXYwcQMs8JG
 atLYEoF5Q4OfMJC8R4CYmDL14wQ7QqSlzq+MYIYVdIzJrVxgRhq0lcPbeJeQKj4Cwk7bOQtC9
 gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKRraGmua2RiqZdYpZukl1qqW55aXKJrqJdYXqxXXJmb
 nJOil5dasokRGL4pBUd/7mB8+PqD3iFGSQ4mJVHeAJ3KRCG+pPyUyozE4oz4otKc1OJDjDIcH
 EoSvJkuQDnBotT01Iq0zBxgLMGkJTh4lER4c1yB0rzFBYm5xZnpEKlTjMYcl6/PW8TM8WfDkk
 XMQix5+XmpUuK8yiClAiClGaV5cINgMX6JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvFMg
 Unsy8Erh9r4BOYQI6hVmpAuSUkkSElFQDU1TS1he7t0+P51ro0f+MPeDl7U/LJq3cHFd6hi/y
 535X5q+8kj3/04OFsyruC753i0i/+uvWl4kflJ73/MhoDHq16vXLqxdyfH60BWa298vu8jGLK
 Z2/KWiahhSrUKzl/Jq9JveN7Nd+/NO4TTpezHfhkg07TutdlM7w+vFm1+f3Pd2zj+w7lyJe0S
 pjUZ1wVci+fka07Mxr96PD3CdzGDxsfJ0m17j4qNG1kP/X3A+vqfL9I8i6fImtb4draFOATrn
 zqX+xWRO22c5K4JsvEqP8y0CEf6PnP+4CsezpMbJ3847GOX+es+hHzT19zv27JU9bKXyasu20
 8Nre/5NOygXKO9k5WjSfC9k385rDWyWW4oxEQy3mouJEAEuTT4VsAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-285.messagelabs.com!1635337739!1297392!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9026 invoked from network); 27 Oct 2021 12:28:59 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-16.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:28:59 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7B355100237
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:28:59 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6F6CD10022B
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:28:59 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:28:38 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:28:25 +0800
Message-ID: <1635337706-4788-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337706-4788-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/13] syscalls/quotactl02,
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

Also remove useless geteuid

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl02.c     | 15 ++++++++++---
 .../kernel/syscalls/quotactl/quotactl02.h     | 22 ++++++++++---------
 .../kernel/syscalls/quotactl/quotactl05.c     | 15 ++++++++++---
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 55a6a8906..a8d6dea83 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -99,11 +99,18 @@ static struct t_case {
 
 static void setup(void)
 {
-	test_id = geteuid();
+	quotactl_info();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
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
index 3351fb578..faee5d282 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -12,19 +12,21 @@
 #include <unistd.h>
 #include <stdio.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
+#define MNTPOINT "mntpoint"
+#define TESTFILE MNTPOINT "/testfile"
+
 static struct fs_disk_quota set_dquota = {
 	.d_rtb_softlimit = 1000,
 	.d_fieldmask = FS_DQ_RTBSOFT
 };
 static uint32_t test_id;
-static int x_getnextquota_nsup;
+static int x_getnextquota_nsup, fd = -1;
 static int x_getstatv_nsup;
-static const char mntpoint[] = "mnt_point";
 
 void check_support_cmd(int quotatype)
 {
@@ -36,12 +38,12 @@ void check_support_cmd(int quotatype)
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
@@ -52,7 +54,7 @@ void check_qoff(int subcmd, char *desp, int flag)
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off status");
@@ -72,7 +74,7 @@ void check_qon(int subcmd, char *desp, int flag)
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on status");
@@ -94,7 +96,7 @@ void check_qoffv(int subcmd, char *desp, int flag)
 		.qs_version = FS_QSTATV_VERSION1,
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off stav");
@@ -116,7 +118,7 @@ void check_qonv(int subcmd, char *desp, int flag)
 		.qs_version = FS_QSTATV_VERSION1
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on statv");
@@ -138,7 +140,7 @@ void check_qlim(int subcmd, char *desp)
 
 	res_dquota.d_rtb_softlimit = 0;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_dquota);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_dquota);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs disk quota limits");
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index 15a6c1e67..00a9242bc 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -62,10 +62,17 @@ static struct t_case {
 
 static void setup(void)
 {
-	test_id = geteuid();
+	quotactl_info();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
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
