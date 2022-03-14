Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5699C433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 04:29:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CAD43C91CE
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 05:29:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 291BE3C1879
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 05:29:13 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 982012002B5
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 05:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647232150; i=@fujitsu.com;
 bh=aa9AEW3ouAD4qRXgXpDjWZLaa4Vdp9RaoKFi9maM+3c=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=vSSeEJuUBoVPJsNDJneE20XpS92mOzkrxPzeBspbLpgoHVnal3OkuM9UcR7+Xcrwl
 CXXKGeq6IqMTn/oXYLLK8x3ewYA+EnBnhUoiq7kKUVBKIpVqrgr2kqZIjazE/VceHX
 bxkghx42mG2u81BfsKEwsEfD0F52cjbj8HD6vH4bW2ccQBlJBQ1A5E1cAPjztY5+o6
 EachAJ2/Q0xi45+x0xzd0AIdjh/LSlEgcjp5+/mQV9ZtoVzBVIb8Lueu3U66yaow+i
 IhWnAhXM3xqkrgD6B1W/XZlp8GUrnK3LEZMxh+57qP3o1wdZVfXqf6on6sufwNE79g
 IPVgLOZz0jVPw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsViZ8MRojvtiF6
 Swa89bBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0bz0kVMBYtUK27d2cfewPhUoYuRi0NIoIlJ
 4snBR+wQzn5GieXf3gI5nBxsAhoS1x63M4PYIgISEh0NEHFmATWJ3VePsYHYwgI6Eq/n3WECs
 VkEVCXWvF7DCmLzCrhJXN51BqxGQkBBYsrD92BzOAXcJR40vgSrEQKqmXv7OlS9oMTJmU9YIO
 ZLSBx88YIZoldRYv/ejYwQdoXEjBnb2CYw8s9C0jILScsCRqZVjHZJRZnpGSW5iZk5uoYGBrq
 Ghqa6Zua6hmZmeolVuol6qaW6yal5JUWJQGm9xPJivdTiYr3iytzknBS9vNSSTYzA4Ewpdl62
 g/Fd30+9Q4ySHExKorwHN+smCfEl5adUZiQWZ8QXleakFh9ilOHgUJLgPbRfL0lIsCg1PbUiL
 TMHGCkwaQkOHiUR3pf7gNK8xQWJucWZ6RCpU4y6HA8W7t3LLMSSl5+XKiXOe/gQUJEASFFGaR
 7cCFjUXmKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzBsPMoUnM68EbtMroCOYgI6YJw12REk
 iQkqqgWnBAfv9CXwvDU5ZtZ1NvX+tbt5T34xTqua/UpkKDi1cfuiKe9zKe8q5SxPXsTzgkNK+
 f0yP5TLfh3bNJdOf2/ZMYnJbWb9T2/7XjWlnNkxrjn7gy9mzvdMoIuSrVOFDva8/vX5zWFzc8
 b/1qOcjbgVda+b/p/aUrCz1WBTuFXP+3bErO17ZuR4Qmbp7Ru3azYslrs797VgT9ezaLZX9VV
 bOgRpJLAkHU+w2AlPrr8RLr1j/T9De/Fxw7cnNByYaT3l2+orh+QmzZd2fn79vyGN/Qf/WLYa
 uFQ8zJJa9jm8/pLfl1vEjhSc3XJ5p3GDwt++x5keneb8Cntzm2WB1v2ZZ9LryX4n8kR9Cn514
 uOlwoRJLcUaioRZzUXEiADEIaHZVAwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-14.tower-528.messagelabs.com!1647232149!8156!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5160 invoked from network); 14 Mar 2022 04:29:10 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-14.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Mar 2022 04:29:10 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 22E4T32N019011
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 04:29:09 GMT
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Mon, 14 Mar 2022 04:29:04 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 14 Mar 2022 13:28:19 -0400
Message-ID: <1647278899-29461-2-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647278899-29461-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1647278899-29461-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Make use of SAFE_ACCESS
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

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/mem/tunable/max_map_count.c    | 4 +---
 testcases/kernel/syscalls/fanotify/fanotify17.c | 3 +--
 testcases/kernel/syscalls/getxattr/getxattr05.c | 3 +--
 testcases/kernel/syscalls/madvise/madvise08.c   | 3 +--
 testcases/kernel/syscalls/quotactl/quotactl01.c | 6 ++----
 testcases/kernel/syscalls/quotactl/quotactl06.c | 3 +--
 testcases/kernel/syscalls/umount2/umount2_02.c  | 6 ++----
 7 files changed, 9 insertions(+), 19 deletions(-)

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
index 561e503..3382d7b 100644
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
 
 	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 8771523..839c6ed 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -186,8 +186,7 @@ static void setup(void)
 	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
 	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
 
-	if (access(USRPATH, F_OK) == -1)
-		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
+	SAFE_ACCESS(USRPATH, F_OK);
 
 	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 7d558fa..9dad4d5 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -128,10 +128,8 @@ static void setup(void)
 static void test_umount2(int i)
 {
 	/* a new access removes the expired mark of the mount point */
-	if (test_cases[i].do_access) {
-		if (access(MNTPOINT, F_OK) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
-	}
+	if (test_cases[i].do_access)
+		SAFE_ACCESS(cleanup, MNTPOINT, F_OK);
 
 	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
 
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
