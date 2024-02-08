Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57504C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386801; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=sl97hEf4E9h05gdM+CwR1jRFCk0RUimt40NUFSgppMg=;
 b=X3kWA2VQAWYiTF46At2Ohs3WUUvBQgdBWQdn+rtx+GPc6/ulwose8kmRDG49QqEBzJUFc
 BlEVM5lUtzysXMKHQd7jwwJC02T+f/fbBm6g8vMbbR7Db27mkKthv83YV1ssYmhfQKQGK02
 ELluearMerpsyg8XDGkRzscJndgT6+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A73F33CDEAB
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:06:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F56A3CE538
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:44 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54C5420B243
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386744; x=1738922744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mwun/td6J2vKl1zAAizbeEkl/1YILJqXhSY5LnvnoR4=;
 b=dxNitSnvBOpsJWsG+GccQrU+1yHgbs8bbt1+R2XMZA/+ca+DF2fS6rnm
 ZDqAzd300wgnCQjkAqFH5/3lxR7vaSAtDtP8BANsHZ21dm0xxOHbroK3F
 DVEOk8OBBB0fYf/Ew57M6qAWDdLT/4DyYWfBgBigbm51q6BlSNATuphaU
 OTjRVCEfRPo+uAXfZwZJxWWw38IhRBgxEp9nPD9GJcAVI3jka9uT5+tIj
 RsceyC0rZGOxRvUo5Cm6LDmNU/e2HKZgQdjI2eOmqo1vwtOkJ5Lms5bUs
 atM2WmGrd4F18ueFGY8+gVw0WRWvG9GVHn9tGoVP57Z7CN2ljK4MW53Mr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="128200584"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="128200584"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:42 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DEA34123045
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:39 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 29D67D5928
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9611041043
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:38 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 49C071A009A;
 Thu,  8 Feb 2024 18:05:38 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:13 -0500
Message-Id: <20240208100517.1974-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.003
X-TMASE-Result: 10--8.132900-10.000000
X-TMASE-MatchedRID: 90G6ca/P0SOe/kF8Pup4HKzGfgakLdjawTlc9CcHMZerwqxtE531VIPc
 XuILVCbak2rNDhoFVtmq5anvU2i8LHk5VN4DJHKIh2VzUlo4HVM2LwvzxRX0gEA6+2WeJ60F8/e
 HChOsjzqBx0ShwZLio0dHbFW6uX0ZNYwYTEoASsF1e7Xbb6Im2pRy1HDTPOXaT2ewVK0RXfKjxY
 yRBa/qJcFwgTvxipFajoczmuoPCq22ULtTyMM9Wtota5iZKohuhGR862+bRwKSXfyNyvbxKno5M
 nkQalgJ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/7] syscalls/swapon03: use tst_max_swapfiles() and
 GET_USED_SWAPFILES() api
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 43 +++++----------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 05fe2045f..e27d954a1 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -19,7 +19,6 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "swaponoff.h"
 #include "libswap.h"
 
 #define MNTPOINT	"mntpoint"
@@ -105,47 +104,20 @@ static void verify_swapon(void)
 static int setup_swap(void)
 {
 	pid_t pid;
-	int j, fd;
 	int status;
+	int j, max_swapfiles, used_swapfiles;
 	int res = 0;
 	char filename[FILENAME_MAX];
-	char buf[BUFSIZ + 1];
-
-	/* Find out how many swapfiles (1 line per entry) already exist */
-	swapfiles = 0;
 
 	if (seteuid(0) < 0)
 		tst_brk(TFAIL | TERRNO, "Failed to call seteuid");
 
-	/* This includes the first (header) line */
-	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
-		tst_brk(TFAIL | TERRNO,
-			"Failed to find out existing number of swap files");
-	}
-	do {
-		char *p = buf;
-		res = read(fd, buf, BUFSIZ);
-		if (res < 0) {
-			tst_brk(TFAIL | TERRNO,
-				 "Failed to find out existing number of swap files");
-		}
-		buf[res] = '\0';
-		while ((p = strchr(p, '\n'))) {
-			p++;
-			swapfiles++;
-		}
-	} while (BUFSIZ <= res);
-	close(fd);
-	if (swapfiles)
-		swapfiles--;	/* don't count the /proc/swaps header */
-
-	if (swapfiles < 0)
-		tst_brk(TFAIL, "Failed to find existing number of swapfiles");
-
 	/* Determine how many more files are to be created */
-	swapfiles = MAX_SWAPFILES - swapfiles;
-	if (swapfiles > MAX_SWAPFILES)
-		swapfiles = MAX_SWAPFILES;
+	max_swapfiles = tst_max_swapfiles();
+	used_swapfiles = tst_count_swaps();
+	swapfiles = max_swapfiles - used_swapfiles;
+	if (swapfiles > max_swapfiles)
+		swapfiles = max_swapfiles;
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
@@ -260,6 +232,9 @@ static void setup(void)
 	if (access("/proc/swaps", F_OK))
 		tst_brk(TCONF, "swap not supported by kernel");
 
+	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
+		tst_brk(TCONF, "swap not supported on tmpfs");
+
 	is_swap_supported(TEST_FILE);
 }
 
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
