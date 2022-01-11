Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68510C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:28:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FAE73C93F4
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:28:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A15773C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:28:17 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D2BF860067B
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641896896; i=@fujitsu.com;
 bh=tzj2SEOSEjJHrifcqBhB6qblI3CIZTF+w/rBIsCzB34=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=UYn+zKEFS4Zt3HgEzHfEtIM0agujzlmNee3zIPkdP4JEtLIZ9W68NdICCWVthjDdM
 UCP6lOQV8ryanIs2PIxvwBR7+pqweTemhn+R0neOnOc/ANFq0Rk+u0xOfvWVg2YE+E
 y+JgSuK4K1vC01E+98ZQ7+I/5sgd0wqGdTtN1EhlLQMHSVnp4xNgwigHBNo+ihSz3p
 4JEvU8WlFu1pg/b1O70Kqz32EaeUXDeKL00fZsq+zqxvVv85qak4tJG3TUnWqeaLfO
 iMyzEZybX0W6tlIUpCsj+UXSsCZCj+rgJ2NEwHpKEgYh0vyCklL9vHNS2HQoFVE8Fn
 cLEppRHxLgdJQ==
Received: from [100.115.37.212] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 91/71-27579-0CB5DD16;
 Tue, 11 Jan 2022 10:28:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsViZ8ORqLs/+m6
 iwYl5mhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b3/m9MBUtdK470bmZtYOy07mLk4hASOMso
 8fH8DlYIZyeTxK6+t1DOHkaJf1f/sXQxcnKwCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC0RLXF/4G6yGRUBVovvEGrBeXgEPiW0TT4HZEgIKElMevger4RTwlGha18YIYgsB1Zya9Q
 +qXlDi5MwnLBDzJSQOvnjBDNGrKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmMgrOQtM9C0r6AkWk
 Vo3VSUWZ6RkluYmaOrqGBga6hoamusZGuoYWlXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFecWVu
 ck6KXl5qySZGYCCnFCvs3cF4eeVPvUOMkhxMSqK8JyPuJgrxJeWnVGYkFmfEF5XmpBYfYpTh4
 FCS4HUFyQkWpaanVqRl5gCjCiYtwcGjJMK7JQQozVtckJhbnJkOkTrFqCglzjspCighAJLIKM
 2Da4NF8iVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrz2IFN4MvNK4Ka/AlrMBLQ4meM2yOK
 SRISUVANTZZ/OovlMHvnu585VLLm7Op5dzKWTJ2jGE4lImz0TT+9gPxFxwVZv79m+j6tl5he9
 uKaXPP/R3a/3BNVWHLr+xMvSRjtH8Nq/o6W8BxcqiAoo/ny7tlrb8Dbf8RjT3hNTz+0RZ2fdZ
 LGkODj/107xDYdNAsR3Fr9us/rYPn/3x/wMP+Z9ixqVf1YLsNZfnx8kwmd8kf/cV2HHu5uvT9
 0/j+N/G9OBrNq0ZTs3H9t0x15u18e92XO7i1JLOhWPlnBfcDw4d+dRSY2ke5aZN+/fEcx+ciH
 5ilYv0zJG+Xd+F0QfXV5gqFSUEb9tGUfvuuAeo3pnnd1sYS+CZjxeq7H08tNfMib3ZFVe8W9u
 nbHxsRJLcUaioRZzUXEiADYJDzJfAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-565.messagelabs.com!1641896895!7072!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14801 invoked from network); 11 Jan 2022 10:28:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-19.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 11 Jan 2022 10:28:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 0CCB4100181
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:28:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id C4947100188
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:28:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 10:28:10 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 18:28:39 +0800
Message-ID: <1641896919-5919-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641896919-5919-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1641896919-5919-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] syscalls/quotactl: Make use of
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl01.c     |  7 ++-
 .../kernel/syscalls/quotactl/quotactl02.c     |  7 ++-
 .../kernel/syscalls/quotactl/quotactl02.h     | 45 +++++++------------
 .../kernel/syscalls/quotactl/quotactl04.c     |  7 ++-
 .../kernel/syscalls/quotactl/quotactl05.c     |  7 ++-
 .../kernel/syscalls/quotactl/quotactl06.c     | 35 +++++----------
 6 files changed, 39 insertions(+), 69 deletions(-)

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
index 21a86ad1e..d2fadc895 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -112,11 +112,10 @@ static void verify_quotactl(unsigned int n)
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
 
@@ -126,27 +125,17 @@ static void verify_quotactl(unsigned int n)
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
