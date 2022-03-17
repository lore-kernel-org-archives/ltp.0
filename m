Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B69C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 09:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 208933C943D
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 10:01:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 027063C1B81
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 10:00:51 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA07A614AC2
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 10:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647507649; i=@fujitsu.com;
 bh=/Fl+oAif04MtVyL7O8bcWVp6TFKnnnBLpj2JU4txe+0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=mAK1fBlsE7w9P6RwhddR8aqOADDXtXaofI4Y7nRSEcBEpIsNs8JFIG504biZ0f7V8
 eiW++kL6QWtAec45wZCAVeO3IgOm/F2GHqmYYT38s5v2GneGnR4vYg0yYIi3+aNj4R
 PB5zKvGybAu6wa/GDRaeVNNIkYhQQ/7XBfjSDsXDLIvMdeZ6ofEsMQ7F6MSTxc25qv
 HPgZQwzkTcH98yZVYmrK26ZgX+cbUIaYxNDOfSf8ROCWEn7DoVp58BwWTeY3dSrF+A
 7ABuyewWKeDi2+ZUORQqsOr8qRivKwcdSs2mw9/dj58BYghnrXF6ydcyk8mQ41867O
 w08sVxcCKb7qg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRWlGSWpSXmKPExsViZ8MxRffgD6M
 kg093JCxWfN/B6MDose/3OtYAxijWzLyk/IoE1oxtm3eyFdyUrzh4bC5TA+MH6S5GLg4hgSYm
 iYU3brNDOPsZJY4/2s7axcjJwSagIXHtcTsziC0iIC+xd0IzmM0sYCOx7+oEMFtYQF/iSOcvR
 hCbRUBVon/yfDYQm1fAVWJrXws7iC0hoCAx5eF7oHoODk4BN4mX35lAwkICqRIdR+6wQpQLSp
 yc+YQFYryExMEXL5ghWhUl9u/dyAhhV0jMmLGNbQIj/ywkLbOQtCxgZFrFaJ1UlJmeUZKbmJm
 ja2hgoGtoaKprbKRraGGpl1ilm6iXWqpbnlpcomukl1herJdaXKxXXJmbnJOil5dasokRGJQp
 xQp7dzBeXvlT7xCjJAeTkijv2q9GSUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeDd/B8oJFqWmp
 1akZeYAIwQmLcHBoyTCa/wRKM1bXJCYW5yZDpE6xagoJc777j1QQgAkkVGaB9cGi8pLjLJSwr
 yMDAwMQjwFqUW5mSWo8q8YxTkYlYR5r4Fs58nMK4Gb/gpoMRPQ4kYBsMUliQgpqQam1O22NbV
 v3Kq7RKqfNR6/msmmc+P0rrMa2xRX10owK1QwNb5Rl/i56uBqudVyKVeVWRasWPI537tjlsx/
 /ndBCod2vb42ma10uYuklcLjU51vijUyAj5m7krdKltyhzdYbYH7LK0jJWpizSq8LUz7uWKr+
 c++WyfA3VV+2vLxkaqbNvMmcq6+nnjwjdxtk18TV/65oBlfdCrd6XNuRfznA//MCy9d0N57lz
 dpbWjKiQLDwE8ZIjxp31Z7mNfL+ptbbbsqoS0ZNqe1XfTSurr7m64oPxROjTRWlVO4+S/1meL
 05R7NOfEbLnwPdF7J+LaP61ZqwUyJHREFL2z2JMhu4vvfmPalv0n95srlHxOUWIozEg21mIuK
 EwGwSHCvRQMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-13.tower-548.messagelabs.com!1647507649!66699!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10550 invoked from network); 17 Mar 2022 09:00:49 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-13.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 17 Mar 2022 09:00:49 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 22H90gl5016121
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 09:00:49 GMT
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 09:00:46 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <xuyang2018.jy@fujitsu.com>
Date: Thu, 17 Mar 2022 17:00:12 -0400
Message-ID: <1647550813-1958-2-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
References: <622EE434.4000400@fujitsu.com>
 <1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] Make use of SAFE_ACCESS
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
index 63f6e91..56c4f2f 100644
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
index feb4750..0ac099b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -186,8 +186,7 @@ static void setup(void)
 	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
 	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
 
-	if (access(USRPATH, F_OK) == -1)
-		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
+	SAFE_ACCESS(USRPATH, F_OK);
 
 	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
 
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
