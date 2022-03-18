Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD2EC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 06:57:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA7703C94B3
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:57:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AC8E3C944E
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:56:40 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83C4C10007B9
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647586598; i=@fujitsu.com;
 bh=SFK9h3CUPmHQnCWZ3KLrZIhO84DKOMAcWQ2ZHqe48UA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Q28s/R3iM4mHtaI6rVqQRyBxBhdFs6iXBr9cL+zOSsbBd5CqDrRUkMhiZuYod0Tm2
 SULjGTkqWCs9RW1fETxaZiEDJbK+GV+6o/F6qeDvWK4pMgF+TabFbqY4usojWKctx1
 bfhSviNzSGp3n9dpyquXL87qz/iqw3V38MIJkhgNVrcV9Zo2fybKwqRwrZL2kYDE5z
 TKjskwQl0zoSy9SPU1Mxg4NMlLMD5dZjkg4tmXE7oq9ktrxpn9W8U+4I93bbeUfno4
 Dj6EjWa3LwYqd2TRHEAAmXLGdhZtQN6v3z5n2trBYXpUQ8swMQSKLKiMB0Cx/NBYge
 qoB1BrowFR6xw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8MxSVdV1yT
 JYOYWG4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP/srXsBfMUKj52f2drYFwu08XIxSEkcJZR
 ovH9SVYIZyeTxNuppxkhnP2MEucWt7F3MXJysAloSFx73M4MYosIyEvsndAMZjML2EjsuzoBz
 BYW0JdY3tcEZrMIqEpMnHaUEcTmFXCTmLKxnw3ElhBQkJjy8D1YDaeAu8Tye11MILaQQJrE2n
 O7WSHqBSVOznzCAjFfQuLgixfMEL2KEvv3bmSEsCskZszYBjVTTeLquU3MExgFZyFpn4WkfQE
 j0ypGi6SizPSMktzEzBxdQwMDXUNDU11DXSO9xCrdRL3UUt3y1OISXUO9xPJivdTiYr3iytzk
 nBS9vNSSTYzAEE4pZmTawbis76feIUZJDiYlUd5l6iZJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4l
 CR4U7SBcoJFqempFWmZOcB4gklLcPAoifC2qwKleYsLEnOLM9MhUqcYFaXEeftA+gRAEhmleX
 BtsBi+xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYdw/IFJ7MvBK46a+AFjMBLW4UMAJZXJK
 IkJJqYJqt43ltWnzO5XXLNNImiX7+eyK13yDl84foLxLZD6LUXhlUPjoedEf0q8ZHm9NFNT8e
 LWlqXXjp592OO/Mn1xVHMQrKhSxzFHFxmfTD4eDSnqXPpl3bV3bbeAq7SMiXmwvvGIqInJ0j3
 HTjvGaVz8GfKwT63gdnaWb6sSTyN0eans64c01CYvedI4cy2ewWddYzfpt88pslk4it15THot
 O++m88lGRb8Xd2Rla3YdZGpxsLVk1uufxfueYqR2b2RY7JF4tfqk3qjV8o9nViS5hA+Y75t16
 JifyIZ119ND/iyo357z4cP3758a9VMt5nzyzKfOm3+GTXX8Zn+V9/n5mexuwTufrLPBfJ/Uou
 WW9klFiKMxINtZiLihMBmiPXz1wDAAA=
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-15.tower-591.messagelabs.com!1647586597!6521!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15530 invoked from network); 18 Mar 2022 06:56:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-15.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Mar 2022 06:56:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 84131100466
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:56:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 76AE410045A
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:56:37 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 06:56:18 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <xuyang2018.jy@fujitsu.com>
Date: Fri, 18 Mar 2022 14:55:46 -0400
Message-ID: <1647629747-13405-2-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] Make use of SAFE_ACCESS
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1. quotactl01: Replace tst_brk(TFAIL) with TBROK
2. use SAFE_ACCESS

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/mem/tunable/max_map_count.c    | 4 +---
 testcases/kernel/syscalls/fanotify/fanotify17.c | 3 +--
 testcases/kernel/syscalls/getxattr/getxattr05.c | 3 +--
 testcases/kernel/syscalls/madvise/madvise08.c   | 3 +--
 testcases/kernel/syscalls/quotactl/quotactl01.c | 6 ++----
 testcases/kernel/syscalls/quotactl/quotactl06.c | 3 +--
 6 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index a4c3dbf..caf8972 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -58,9 +58,7 @@ static long old_overcommit = -1;
 
 static void setup(void)
 {
-	if (access(PATH_SYSVM "max_map_count", F_OK) != 0)
-		tst_brk(TBROK | TERRNO,
-			 "Can't support to test max_map_count");
+	SAFE_ACCESS(PATH_SYSVM "max_map_count", F_OK);
 
 	old_max_map_count = get_sys_tune("max_map_count");
 	old_overcommit = get_sys_tune("overcommit_memory");
diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
index 35beb53..7d74b25 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -159,8 +159,7 @@ static void do_unshare(int map_root)
 		 * uid_map file should exist since Linux 3.8 because
 		 * it is available on Linux 3.5
 		 */
-		if (access(UID_MAP, F_OK))
-			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
+		SAFE_ACCESS(UID_MAP, F_OK);
 
 		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
 	}
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index c0d339f..3e73cc5 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -100,8 +100,7 @@ static void do_unshare(int map_root)
 		/* uid_map file should exist since Linux 3.8 because
 		 * it is available on Linux 3.5
 		 */
-		if (access(UID_MAP, F_OK))
-			tst_brk(TBROK, "file %s didn't exist", UID_MAP);
+		SAFE_ACCESS(UID_MAP, F_OK);
 
 		SAFE_FILE_PRINTF(UID_MAP, "%d %d %d", 0, 0, 1);
 	}
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 30f3604..10549f4 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -110,8 +110,7 @@ static int find_sequence(int pid)
 
 	snprintf(dumpname, 256, "dump-%d", pid);
 	tst_res(TINFO, "Dump file should be %s", dumpname);
-	if (access(dumpname, F_OK))
-		tst_brk(TBROK | TERRNO, "Dump file was not found.");
+	SAFE_ACCESS(dumpname, F_OK);
 
 	dfd = SAFE_OPEN(dumpname, O_RDONLY);
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index c14228e..36ec93e 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -160,11 +160,9 @@ static void setup(void)
 	SAFE_CMD(cmd, NULL, NULL);
 	fmt_id = var->fmt_id;
 
-	if (access(USRPATH, F_OK) == -1)
-		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
+	SAFE_ACCESS(USRPATH, F_OK);
 
-	if (access(GRPPATH, F_OK) == -1)
-		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
+	SAFE_ACCESS(GRPPATH, F_OK);
 
 	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *) &res_ndq));
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index ae8d7fa..74a098a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -186,8 +186,7 @@ static void setup(void)
 	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
 	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
 
-	if (access(USRPATH, F_OK) == -1)
-		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
+	SAFE_ACCESS(USRPATH, F_OK);
 
 	SAFE_MKDIR(TESTDIR1, 0666);
 
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
