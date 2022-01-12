Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5FFC433F5
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 07:48:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C88D73C94D1
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 08:48:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114033C8BBB
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 08:48:08 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 895726008C8
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 08:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641973685; i=@fujitsu.com;
 bh=VqZMPNklwapwr6vA3eTLMpss3+B1smwTddN2h5szmmA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=iMQPeQRia4U5ETfYyUH2ZVo1RNHQeG4nCK0I4BpMRChyOSwBHIJmKBtF+NB5HMF/M
 WwxpXvgszts2dOgutOncjr8WZwcLtLwLmqXNiPKw4a8m9nzBSpVxG66euUPPs50HyE
 yTOdmRU7PtTN/yaj52ktIU8+bjCTZoHz316miksuQcnfnP+An1ZMahchXJxLws6Jlg
 7Sgv5D4w0/Gd+DikhVrHyOLO4lgH7VoEC4Czc1FSq3NDbdfD9NHEkwHl8Ip+7zAfSJ
 CZqPmK1OhIVhWsPjTHsf68jV1HjGb7PDeTRoFg8Efq5Yb4IfBVa0JlZuZXE5wI6ISw
 uByfgjXXhwuQw==
Received: from [100.115.70.1] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id CE/E5-06990-5B78ED16;
 Wed, 12 Jan 2022 07:48:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8ORqLul/V6
 iQe8JM4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNeP51+3MBbMSK3Z8m8/awLgiqIuRi0NI4Cyj
 xOd5DxghnJ1MEgfn3GWFcPYwStw9uRMow8nBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXE
 4gtLBAt8WztAjYQm0VAVWLxm90sIDavgKfEgbdNYL0SAgoSUx6+B7M5BbwkDhy+BtYrBFSzt6
 +HCaJeUOLkzCcsEPMlJA6+eAHVqyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjIKzkLTPQtK+gJF
 pFaNtUlFmekZJbmJmjq6hgYGuoaGprpmlrrmJXmKVbqJeaqlucmpeSVEiUFYvsbxYL7W4WK+4
 Mjc5J0UvL7VkEyMwmFOKXb12MB7p+6l3iFGSg0lJlHdW271EIb6k/JTKjMTijPii0pzU4kOMM
 hwcShK8ds1AOcGi1PTUirTMHGBkwaQlOHiURHizQVp5iwsSc4sz0yFSpxgVpcR5c0ESAiCJjN
 I8uDZYNF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzrCTKFJzOvBG76K6DFTECLkzlugyw
 uSURISTUwVW/tVd3SGrfgtYNxnuGBHoM6D6ELLxbZRhwLEm8T8GUVnfhDQG/xmXaOBTuOnjq9
 Unqd66mEsqcMnl9s5X865k0q59MIa/jm9l30qWv/O45UBsu9QZcdEhh0z/LumXvNLFxD/Ymch
 XKii3CZSNK1tcU/jzMoKRxZcfX4jcaZxVb/8j5vfOvavSz46HUf4fKHZnmmJpYHkrYe/tyqkp
 0146agVsYC1oNd96dselWw3oV98QXjv6ZSWhfOPk7N+vAlf0JI25PfIm8UMl+EXb6bZpl3Q/G
 9XolWa5FmTdH0Y1tbr73euktb2Til1dHT596sqN6Zz9ziL0gfK2RjWux0ozA037mxv6Sw2s7l
 /z4lluKMREMt5qLiRABTMXO0YQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-532.messagelabs.com!1641973684!77836!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19237 invoked from network); 12 Jan 2022 07:48:04 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-7.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Jan 2022 07:48:04 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5E4B910018C
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:48:04 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4F45B100184
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:48:04 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 07:47:48 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 12 Jan 2022 15:48:11 +0800
Message-ID: <1641973691-22981-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/3] syscalls/quotactl: Make use of
 TST_EXP_PASS_SILENT and TST_EXP_FAIL
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

Also, add some description and make check happy for quotactl06.c.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl01.c     |  7 +-
 .../kernel/syscalls/quotactl/quotactl02.c     |  7 +-
 .../kernel/syscalls/quotactl/quotactl02.h     | 45 ++++------
 .../kernel/syscalls/quotactl/quotactl04.c     |  7 +-
 .../kernel/syscalls/quotactl/quotactl05.c     |  7 +-
 .../kernel/syscalls/quotactl/quotactl06.c     | 90 +++++++++++--------
 6 files changed, 80 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 1e0f5da70..561e5030f 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -196,11 +196,10 @@ static void verify_quota(unsigned int n)
 		tst_res(TCONF, "current system doesn't support this cmd");
 		return;
 	}
-	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
+	TST_EXP_PASS_SILENT(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr),
+			"quotactl to %s", tc->des);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
 		tst_res(TFAIL, "quotactl failed to %s", tc->des);
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index c16e0a3f8..d9c4f9b2e 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -130,11 +130,10 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
+	TST_EXP_PASS_SILENT(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr),
+		"do_quotactl()");
+	if (!TST_PASS)
 		return;
-	}
 
 	if (tc->flag)
 		tc->func_check(tc->check_subcmd, tc->des, *(int *)(tc->addr));
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
index 28b632646..a5683ae7d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -49,15 +49,12 @@ static void check_support_cmd(int quotatype)
 
 static void check_qoff(int subcmd, char *desp, int flag)
 {
-	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs quota off status");
+	TST_EXP_PASS_SILENT(do_quotactl(fd, subcmd, tst_device->dev, test_id,
+			(void *) &res_qstat), "do_quotactl() to %s", desp);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (res_qstat.qs_flags & flag) {
 		tst_res(TFAIL, "xfs quota enforcement was on unexpectedly");
@@ -69,15 +66,12 @@ static void check_qoff(int subcmd, char *desp, int flag)
 
 static void check_qon(int subcmd, char *desp, int flag)
 {
-	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstat);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs quota on status");
+	TST_EXP_PASS_SILENT(do_quotactl(fd, subcmd, tst_device->dev, test_id,
+			(void *) &res_qstat), "do_quotactl() to %s", desp);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (!(res_qstat.qs_flags & flag)) {
 		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
@@ -89,17 +83,14 @@ static void check_qon(int subcmd, char *desp, int flag)
 
 static void check_qoffv(int subcmd, char *desp, int flag)
 {
-	int res;
 	struct fs_quota_statv res_qstatv = {
 		.qs_version = FS_QSTATV_VERSION1,
 	};
 
-	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs quota off stav");
+	TST_EXP_PASS_SILENT(do_quotactl(fd, subcmd, tst_device->dev, test_id,
+			(void *) &res_qstatv), "do_quotactl() to %s", desp);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (res_qstatv.qs_flags & flag) {
 		tst_res(TFAIL, "xfs quota enforcement was on unexpectedly");
@@ -111,17 +102,14 @@ static void check_qoffv(int subcmd, char *desp, int flag)
 
 static void check_qonv(int subcmd, char *desp, int flag)
 {
-	int res;
 	struct fs_quota_statv res_qstatv = {
 		.qs_version = FS_QSTATV_VERSION1
 	};
 
-	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs quota on statv");
+	TST_EXP_PASS_SILENT(do_quotactl(fd, subcmd, tst_device->dev, test_id,
+			(void *) &res_qstatv), "do_quotactl() to %s", desp);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (!(res_qstatv.qs_flags & flag)) {
 		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
@@ -133,17 +121,14 @@ static void check_qonv(int subcmd, char *desp, int flag)
 
 static void check_qlim(int subcmd, char *desp)
 {
-	int res;
 	static struct fs_disk_quota res_dquota;
 
 	res_dquota.d_rtb_softlimit = 0;
 
-	res = do_quotactl(fd, subcmd, tst_device->dev, test_id, (void *) &res_dquota);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs disk quota limits");
+	TST_EXP_PASS_SILENT(do_quotactl(fd, subcmd, tst_device->dev, test_id,
+			(void *) &res_dquota), "do_quotactl() to %s", desp);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (res_dquota.d_id != test_id) {
 		tst_res(TFAIL, "quotactl() got unexpected user id %u, expected %u",
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 44273c35d..55da28270 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -145,11 +145,10 @@ static void verify_quota(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
+	TST_EXP_PASS_SILENT(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr),
+			"do_quotactl to %s", tc->des);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
 		tst_res(TFAIL, "quotactl failed to %s", tc->des);
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index 541007e97..ac75cee31 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -93,11 +93,10 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
+	TST_EXP_PASS_SILENT(do_quotactl(fd, tc->cmd, tst_device->dev, test_id, tc->addr),
+		"do_quotactl()");
+	if (!TST_PASS)
 		return;
-	}
 
 	if (tc->flag)
 		tc->func_check(tc->check_subcmd, tc->des, *(int *)(tc->addr));
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 21a86ad1e..9206cc3e4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -12,7 +12,7 @@
  *
  * - EACCES when cmd is Q_QUOTAON and addr existed but not a regular file
  * - ENOENT when the file specified by special or addr does not exist
- * - EBUSTY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed
+ * - EBUSY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed
  * - EFAULT when addr or special is invalid
  * - EINVAL when cmd or type is invalid
  * - ENOTBLK when special is not a block device
@@ -68,13 +68,13 @@ static struct dqblk set_dqmax = {
 	.dqb_valid = QIF_BLIMITS
 };
 
-struct tst_cap dropadmin = {
+static struct tst_cap dropadmin = {
 	.action = TST_CAP_DROP,
 	.id = CAP_SYS_ADMIN,
 	.name = "CAP_SYS_ADMIN",
 };
 
-struct tst_cap needadmin = {
+static struct tst_cap needadmin = {
 	.action = TST_CAP_REQ,
 	.id = CAP_SYS_ADMIN,
 	.name = "CAP_SYS_ADMIN",
@@ -86,18 +86,44 @@ static struct tcase {
 	void *addr;
 	int exp_err;
 	int on_flag;
+	char *des;
 } tcases[] = {
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir1, EACCES, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir2, ENOENT, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EBUSY, 1},
-	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1},
-	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, usrpath, EINVAL, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, ENOTBLK, 0},
-	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, ESRCH, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_invalid, usrpath, ESRCH, 0},
-	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_invalid, usrpath, ESRCH, 0},
-	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EPERM, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir1, EACCES, 0,
+	"EACCES when cmd is Q_QUOTAON and addr existed but not a regular file"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir2, ENOENT, 0,
+	"ENOENT when the file specified by special or addr does not exist"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EBUSY, 1,
+	"EBUSY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed"},
+
+	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1,
+	"EFAULT when addr or special is invalid"},
+
+	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, usrpath, EINVAL, 0,
+	"EINVAL when cmd or type is invalid"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, ENOTBLK, 0,
+	"ENOTBLK when special is not a block device"},
+
+	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, ESRCH, 0,
+	"ESRCH when no disk quota is found for the indicated user and quotas "
+	"have not been turned on for this fs"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_invalid, usrpath, ESRCH, 0,
+	"ESRCH when cmd is Q_QUOTAON, but the quota format was not found"},
+
+	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_invalid, usrpath, ESRCH, 0,
+	"ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or "
+	"equal to id that has an active quota"},
+
+	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1,
+	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of "
+	"the range allowed by the quota format"},
+
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EPERM, 0,
+	"EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) "
+	"for the specified operation"},
 };
 
 static void verify_quotactl(unsigned int n)
@@ -106,17 +132,17 @@ static void verify_quotactl(unsigned int n)
 	int quota_on = 0;
 	int drop_flag = 0;
 
+	tst_res(TINFO, "Testing %s", tc->des);
 	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) && getnextquota_nsup) {
 		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
 		return;
 	}
 
 	if (tc->on_flag) {
-		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
-			fmt_id, usrpath));
-		if (TST_RET == -1)
-			tst_brk(TBROK,
-				"quotactl with Q_QUOTAON returned %ld", TST_RET);
+		TST_EXP_PASS_SILENT(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
+					fmt_id, usrpath), "quotactl with Q_QUOTAON");
+		if (!TST_PASS)
+			return;
 		quota_on = 1;
 	}
 
@@ -126,27 +152,17 @@ static void verify_quotactl(unsigned int n)
 	}
 
 	if (tc->exp_err == ENOTBLK)
-		TEST(quotactl(tc->cmd, "/dev/null", *tc->id, tc->addr));
+		TST_EXP_FAIL(quotactl(tc->cmd, "/dev/null", *tc->id, tc->addr),
+			ENOTBLK, "quotactl()");
 	else
-		TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
-	if (TST_RET == -1) {
-		if (tc->exp_err == TST_ERR) {
-			tst_res(TPASS | TTERRNO, "quotactl failed as expected");
-		} else {
-			tst_res(TFAIL | TTERRNO,
-				"quotactl failed unexpectedly; expected %s, but got",
-				tst_strerrno(tc->exp_err));
-		}
-	} else {
-		tst_res(TFAIL, "quotactl returned wrong value: %ld", TST_RET);
-	}
+		TST_EXP_FAIL(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr),
+			tc->exp_err, "quotactl()");
 
 	if (quota_on) {
-		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
-			fmt_id, usrpath));
-		if (TST_RET == -1)
-			tst_brk(TBROK,
-				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
+		TST_EXP_PASS_SILENT(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
+					fmt_id, usrpath), "quotactl with Q_QUOTAOFF");
+		if (!TST_PASS)
+			return;
 		quota_on = 0;
 	}
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
