Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023CC433F5
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758976103D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 758976103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAC623C3234
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:15:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A56263C3077
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:03 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0380D1A00886
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562902; i=@fujitsu.com;
 bh=q/UAH8YyGw5oOBs+DIWaZpi/7z8MVMMd3a2aOkAfdsE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=H2V5Po+1kM6lSELaYWn1f9KzqfCl1rXVX6v3WqxktkAy8IL+M+cBKi52SNO4x/VH2
 v5bZ1dQgEZBImDE9Z4EIXQQxjtrSAC2rxSPAb1oKFnSV5ElHIynGc6pkRji+wwIGyT
 rowYWONzyXhfQg4Asw2KgUQBDnPYHv268qIAoc9/fmp3dZX33S7dz6gQovibOETM3u
 36KfMyuXDeO1L5fMhBF104cNNCuDFeGr+rUODdLTZZntKOp+LTJe0rR4JqRI9zrAFQ
 tMLYe9+kyt96u8fcXtgkcsd2MdQ0P/IwUACKvXaFaDshx8TGvn6OiB/rHjMq5pu28T
 wJxl+dYIUIDsA==
Received: from [100.113.6.210] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 6F/61-01506-6537D616;
 Mon, 18 Oct 2021 13:15:02 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsViZ8MRqhtanJt
 o8OWnpsWK7zsYHRg99v1exxrAGMWamZeUX5HAmnHn2B7mgrX6FX9nzGJuYPyv3sXIxSEk0MIk
 sWLZNzYIZw+jxMPNZ1i6GDk52AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9Yupi5OAQFvCVa
 J1bDBJmEVCV2PZxA1gJr4CHxOVD0xlBbAkBBYkpD9+DjeEU8JRYfHweK4gtBFRzfttlJoh6QY
 mTM5+wQIyXkDj44gUzRK+ixKWOb1BzKiRmzWpjmsDIPwtJyywkLQsYmVYxWiYVZaZnlOQmZub
 oGhoY6BoaGuua6RpamOklVukm6aWW6ian5pUUJQJl9RLLi/WKK3OTc1L08lJLNjECAzKlkG3X
 DsbPrz/oHWKU5GBSEuXtV8pNFOJLyk+pzEgszogvKs1JLT7EKMPBoSTBezofKCdYlJqeWpGWm
 QOMDpi0BAePkghvVSFQmre4IDG3ODMdInWK0Zjj8vV5i5g5/mxYsohZiCUvPy9VSpyXtQCoVA
 CkNKM0D24QLGovMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmjQZZyJOZVwK37xXQKUxAp1x
 1zgE5pSQRISXVwBR7ddVy50fpzDJOTRMXVYs5fznzdMlNF6aJG6oe1TbFLHfjNEr9/TLf1ST5
 n8eJY4sOT+WeY1iyyjfq8oJ0H47/1d88ptwTamy/8PRLtj3r+p37//7+m/Gt/MAdg/SFzjVJq
 yNcsvff+fFWKj3Ck1uZRVXRpEB61/PXYZ/uN/7WPKcty7KNb5LF3hQ2DVs+0YInbl1f61bnLw
 zaeCpsemRYq3t/3O8mBYfVF80fGc/otFXv+bpzR42XD5dLPMOZIxuO2E01zU5Y4CxgvjB+/jq
 XwHOy7A2Srgu0vrW+YbeLKj4/vyU1XcVxwtXmzPwK7pu5PM5vLoncdNW14v0itqXq9+aXrwpY
 Nda0ie9IVGIpzkg01GIuKk4EADJROZtVAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-245.messagelabs.com!1634562901!299673!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8684 invoked from network); 18 Oct 2021 13:15:01 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
 by server-12.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:15:01 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19IDF1Oc015643
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:15:01 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:14:59 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:14:45 +0800
Message-ID: <1634562888-5987-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 08/11] syscalls/quotaclt02,
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl02.c     | 14 +++++++++++--
 .../kernel/syscalls/quotactl/quotactl02.h     | 20 ++++++++++---------
 .../kernel/syscalls/quotactl/quotactl05.c     | 14 +++++++++++--
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index ad81ee7e5..40bd5bd8b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -121,11 +121,19 @@ static struct t_case {
 
 static void setup(void)
 {
+	quotactl_info();
 	test_id = geteuid();
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
@@ -144,7 +152,7 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
 		return;
@@ -166,9 +174,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
-	.mntpoint = mntpoint,
+	.mntpoint = MNTPOINT,
 	.mnt_data = "usrquota,grpquota",
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = 2,
 };
 #else
 	TST_TEST_TCONF("System doesn't have <xfs/xqm.h>");
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
index 37f3d7eb7..5b7c5ab32 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -14,18 +14,20 @@
 #include <stdio.h>
 #include "tst_test.h"
 #include "lapi/quotactl.h"
+#include "quotactl_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
+#define MNTPOINT "mntpoint"
+#define TESTFILE MNTPOINT "/testfile"
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
@@ -37,12 +39,12 @@ void check_support_cmd(int quotatype)
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
@@ -53,7 +55,7 @@ void check_qoff(int subcmd, char *desp, int flag)
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off status");
@@ -73,7 +75,7 @@ void check_qon(int subcmd, char *desp, int flag)
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on status");
@@ -95,7 +97,7 @@ void check_qoffv(int subcmd, char *desp, int flag)
 		.qs_version = FS_QSTATV_VERSION1,
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off stav");
@@ -117,7 +119,7 @@ void check_qonv(int subcmd, char *desp, int flag)
 		.qs_version = FS_QSTATV_VERSION1
 	};
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota on statv");
@@ -139,7 +141,7 @@ void check_qlim(int subcmd, char *desp)
 
 	res_dquota.d_rtb_softlimit = 0;
 
-	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_dquota);
+	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_dquota);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs disk quota limits");
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index fbc7f5924..7306623a0 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -71,10 +71,18 @@ static struct t_case {
 
 static void setup(void)
 {
+	quotactl_info();
 	test_id = geteuid();
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
@@ -94,7 +102,7 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
 		return;
@@ -116,9 +124,11 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
-	.mntpoint = mntpoint,
+	.mntpoint = MNTPOINT,
 	.mnt_data = "prjquota",
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = 2,
 };
 
 #else
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
