Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E458AC433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1433F3CA1B5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:41:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6EA83CA1C7
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:25 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EBB1160085F
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519283; i=@fujitsu.com;
 bh=olWu3b20Xh1eucVEUlqbMr0p35sJc7gQis9M1pkPIx4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=wCIPyP7dqaYvFg4DwX3SuqJJbjRXc3pD/H4qmWND70NgyMQlyV7q2iuNQDl0bTIl+
 hU9BlWVuOg0m2daBU8XlQvyZTztUG2O2psHDJcxPnpi47BMK+O13cnoBJPAHGCxmJT
 hyc093StkaKRzCdtLypiQcc/fj6bTtrqRS/AhxQV+GpzVj9lm/j8e5TW2rLARwNR0s
 uIpLXqq4N5woZl9TySt+7lXwDX4ITdMtYbm1N2Ll0cD49yi1wp4jNeAOVvDwl8FXBb
 +wtqeu4x+saCBhYhnGlm7yr7FzNcXR1Y5VmnEm128ByeLtYxraUvWa+6j+k79Yr6SZ
 72NojmvDqACtw==
Received: from [100.115.32.10] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 70/C3-29321-3B1A4126;
 Tue, 22 Feb 2022 08:41:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8MxRXfTQpE
 kg9mfDS1WfN/B6MDose/3OtYAxijWzLyk/IoE1owNF3exFSwRrlg6Yy9bA+M6gS5GTg4hgSYm
 iZfn+SHsPYwSdz9Yg9hsApoSzzoXMIPYIgISEh0Nb9lBbGYBdYnlk34xgdjCAh4SJ+4uB6thE
 VCVuP64BayGFyh+5d98sBoJAQWJKQ/fg9VwCnhKPJl3jxlil4fEk2O/mSHqBSVOznzCAjFfQu
 LgixfMEL2KEpc6vjFC2BUSs2a1MU1g5J+FpGUWkpYFjEyrGK2TijLTM0pyEzNzdA0NDHQNDU1
 1jY10DY3M9BKrdBP1Ukt1y1OLS3SN9BLLi/VSi4v1iitzk3NS9PJSSzYxAkMypVihbgfjtZU/
 9Q4xSnIwKYnyfp0ikiTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgnfpPKCcYFFqempFWmYOMD5g0
 hIcPEoivFtmA6V5iwsSc4sz0yFSpxgVpcR5BRYAJQRAEhmleXBtsJi8xCgrJczLyMDAIMRTkF
 qUm1mCKv+KUZyDUUmYN2w+0BSezLwSuOmvgBYzAS2ekiUEsrgkESEl1cDUEpY09/9b5idff51
 f0fc+IY7VdWXR/ftvI+rSZYTntCi/L7l+8bTNUu2tZk++zBY69qMwPEmgLXniXOeEv2+LVtjL
 ahu0bH1ZfcaeR11v5ZNT5+WvfKzZdN5ykvc8f58Kvai515XPSKcxfck4UyMo8q+ue6rq2sjAm
 LWrOUPbf19TdjBJ5rpgd5NBdIKEr4PRFYHbO5SVPZXmOsmE9tTv5RO187koyfzxL6dPc/8Byw
 JPm6AU29OK+vpfTqlodtzzX2T3KmPVPr4tXiujFZfLZT5RvXujxHii8df/wnL2KltYFn397ZM
 4wVVhZ9bdpLNszSXylyYz3T9ePm2P3K8HBfKrtuhXlPJcnyPd91KJpTgj0VCLuag4EQCVWSd2
 RAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-571.messagelabs.com!1645519282!3154!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13586 invoked from network); 22 Feb 2022 08:41:22 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-7.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:41:22 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21M8fGWE022422
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:22 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:41:19 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:41:10 +0800
Message-ID: <1645519272-2733-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/7] syscalls/pidfd_open01,
 04: Make use of SAFE_FCNTL
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
 .../kernel/syscalls/pidfd_open/pidfd_open01.c   | 17 ++++++++++++-----
 .../kernel/syscalls/pidfd_open/pidfd_open04.c   | 15 +++++++++++----
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index 6f1e95ba8..ce07e6717 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -16,18 +16,18 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 
+static int pidfd = -1;
+
 static void run(void)
 {
 	int flag;
 
 	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open(getpid(), 0)");
 
-	flag = fcntl(TST_RET, F_GETFD);
-
-	SAFE_CLOSE(TST_RET);
+	pidfd = TST_RET;
+	flag = SAFE_FCNTL(pidfd, F_GETFD);
 
-	if (flag == -1)
-		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
+	SAFE_CLOSE(pidfd);
 
 	if (!(flag & FD_CLOEXEC))
 		tst_brk(TFAIL, "pidfd_open(getpid(), 0) didn't set close-on-exec flag");
@@ -35,7 +35,14 @@ static void run(void)
 	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
 }
 
+static void cleanup(void)
+{
+	if (pidfd > -1)
+		SAFE_CLOSE(pidfd);
+}
+
 static struct tst_test test = {
 	.setup = pidfd_open_supported,
+	.cleanup = cleanup,
 	.test_all = run,
 };
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
index 60080c0c8..0e8ab6956 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
@@ -21,9 +21,11 @@
 #define P_PIDFD  3
 #endif
 
+static int pidfd = -1;
+
 static void run(void)
 {
-	int flag, pid, pidfd, ret;
+	int flag, pid, ret;
 	siginfo_t info;
 
 	pid = SAFE_FORK();
@@ -36,9 +38,7 @@ static void run(void)
 				"pidfd_open(%d,  PIDFD_NONBLOCK)", pid);
 
 	pidfd = TST_RET;
-	flag = fcntl(pidfd, F_GETFL);
-	if (flag == -1)
-		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFL) failed");
+	flag = SAFE_FCNTL(pidfd, F_GETFL);
 
 	if (!(flag & O_NONBLOCK))
 		tst_brk(TFAIL, "pidfd_open(%d, O_NONBLOCK) didn't set O_NONBLOCK flag", pid);
@@ -77,10 +77,17 @@ static void setup(void)
 	SAFE_CLOSE(TST_RET);
 }
 
+static void cleanup(void)
+{
+	if (pidfd > -1)
+		SAFE_CLOSE(pidfd);
+}
+
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = run,
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
