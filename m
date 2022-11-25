Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507BAC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9152B3CC89D
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:31:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B033C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:30:53 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2C7F51000D0B
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1669372250; i=@fujitsu.com;
 bh=mWD7MdQ0fOGWM+QEoFkwzj3j0QXwU6jVoQrFMFQnAKA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ObmMx5BwJlz14MZG5ab+2Lr5rsZ45dyhlyNSE0Bf7TWbnnITSca4CeKmJDsZpvmKK
 hWyjcKa7iBw+vYn6oWbhcSj8jwA4uisEQ2xNOdxudRSgIn6kgpFIu5e7Fb1bkKH6T2
 2uuTD/igVTKfbqNNSBVoWWshHL4FhWmVR2jQxDbTZCOxUXPOyM8UX6TKsI5RACETuZ
 nFg9Fv+/FMPGCSiVd7mtajiAzQl40yBB4Ut7PrO1qZDdQ/zaIcEq76WxS1EG1Sizu7
 D8Zvg0YT5Kzdja8xNh+asj7r1ynaBTOnEgKxY2pvCx9KAAyxvbgQ2Sy2JRbrJPWNBR
 YG6PzjNorON2w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsViZ8ORqBs1syH
 ZYHe/vMWK7zsYHRg99v1exxrAGMWamZeUX5HAmnH5y0T2gnkSFSvaVzM3MJ4W6WLk4hASOMso
 Ma3tAWMXIweQc4BJ4hgrRHwPo8TmnrMsXYycHGwCmhLPOhcwg9giAhISHQ1v2UFsZgF1ieWTf
 jGB2MICzhJr734Eq2cRUJW4Nf0BmM0r4CHx4/4VsBoJAQWJKQ/fM0PEBSVOznzCAjFHQuLgix
 fMEDWKEpc6vjFC2BUSs2a1QfWqSVw9t4l5AiP/LCTts5C0L2BkWsVoVpxaVJZapGtoopdUlJm
 eUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGIopxWyrdjD+WvZH
 7xCjJAeTkijvje/1yUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeE9NbUgWEixKTU+tSMvMAcYFT
 FqCg0dJhDdvGlCat7ggMbc4Mx0idYpRUUqc99t0oIQASCKjNA+uDRaLlxhlpYR5GRkYGIR4Cl
 KLcjNLUOVfMYpzMCoJ804GGc+TmVcCN/0V0GImoMVPdepAFpckIqSkGphEuqtnP9WW/x2p4VA
 y1U9EzuOYvKPG++XvDPo6u1UNRJ6fNma+qPF9xVHfTX/W32FmXaTqFiPCaH2r8R5Txp55PCq3
 F6zKfv9VQbtlPfu6t5tbvJ7k7dI8GRy958Glf5oFfO3XZm421j3NNsFEZn5tGROnyZbPXtoP1
 77T9wpOOtprVqC78O3F6t8RHblTnD/XnGnYc22HzlKDrkd3cjQN7xyrCD6bUfn0s5nEA1tH7j
 Lr5zxn7+m+TuoU3Hdd4c96h7ceWr8qv+83Ovfy95IZlheb4276nlly9ebjrOWOVdV1nhPU7Xb
 b7VxhpXNqXe+6nz3Rtxoq5DRWeofPV8nRFXXe0L8s0C/8aMG7CjslluKMREMt5qLiRAAukC0X
 QAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-587.messagelabs.com!1669372250!30750!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10100 invoked from network); 25 Nov 2022 10:30:50 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Nov 2022 10:30:50 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 18A18100197
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 10:30:50 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0C824100195
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 10:30:50 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 25 Nov 2022 10:30:48 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 25 Nov 2022 19:31:14 +0800
Message-ID: <1669375875-1943-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] syscalls/mount03: Add MS_NODIRATIME subcase
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

From mount(2) man-page, it means don't update access times for directories
on this filesystem. Also, test file and directory' atime for
noatime and nodiratime mount option.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 59 +++++++++++++++++++++--
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 397c1bf81..31a858c35 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -18,6 +18,7 @@
  * - MS_REMOUNT - alter flags of a mounted FS
  * - MS_NOSUID - ignore suid and sgid bits
  * - MS_NOATIME - do not update access times
+ * - MS_NODIRATIME - only update access_time for directory instead of all types
  */
 
 #include <stdio.h>
@@ -40,6 +41,7 @@
 
 static int otfd;
 static char file[PATH_MAX];
+static char dir[PATH_MAX];
 static uid_t nobody_uid;
 static gid_t nobody_gid;
 
@@ -95,23 +97,71 @@ static void test_nosuid(void)
 	tst_reap_children();
 }
 
-static void test_noatime(void)
+static void test_file_dir_noatime(int update_fatime, int update_datime)
 {
-	time_t atime;
-	struct stat st;
+	time_t atime, dir_atime;
+	struct stat st, dir_st;
 	char readbuf[20];
+	DIR *test_dir;
 
 	snprintf(file, PATH_MAX, "%s/noatime", MNTPOINT);
 	TST_EXP_FD_SILENT(otfd = open(file, O_CREAT | O_RDWR, 0700));
 
+	snprintf(dir, PATH_MAX, "%s/nodiratime", MNTPOINT);
+	if (access(dir, F_OK) == -1 && errno == ENOENT)
+		SAFE_MKDIR(dir, 0700);
+
 	SAFE_WRITE(1, otfd, TEST_STR, strlen(TEST_STR));
 	SAFE_FSTAT(otfd, &st);
 	atime = st.st_atime;
+
+	test_dir = SAFE_OPENDIR(dir);
+	SAFE_STAT(dir, &dir_st);
+	SAFE_READDIR(test_dir);
+	SAFE_CLOSEDIR(test_dir);
+	dir_atime = dir_st.st_atime;
+
 	sleep(1);
 
 	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
 	SAFE_FSTAT(otfd, &st);
-	TST_EXP_EQ_LI(st.st_atime, atime);
+
+	test_dir = SAFE_OPENDIR(dir);
+	SAFE_READDIR(test_dir);
+	SAFE_CLOSEDIR(test_dir);
+	SAFE_STAT(dir, &dir_st);
+
+	if (update_fatime) {
+		if (st.st_atime > atime)
+			tst_res(TPASS, "st.st_atime(%ld) > atime(%ld)",
+					st.st_atime, atime);
+		else
+			tst_res(TFAIL, "st.st_atime(%ld) < atime(%ld)",
+					st.st_atime, atime);
+	} else {
+		TST_EXP_EQ_LI(st.st_atime, atime);
+	}
+
+	if (update_datime) {
+		if (dir_st.st_atime > dir_atime)
+			tst_res(TPASS, "dir_st.st_atime(%ld) > dir_atime(%ld)",
+					dir_st.st_atime, dir_atime);
+		else
+			tst_res(TFAIL, "dir_st.st_atime(%ld) < dir_atime(%ld)",
+					dir_st.st_atime, dir_atime);
+	} else {
+		TST_EXP_EQ_LI(dir_st.st_atime, dir_atime);
+	}
+}
+
+static void test_noatime(void)
+{
+	test_file_dir_noatime(0, 0);
+}
+
+static void test_nodiratime(void)
+{
+	test_file_dir_noatime(1, 0);
 }
 
 #define FLAG_DESC(x) .flag = x, .flag2 = x, .desc = #x
@@ -128,6 +178,7 @@ static struct tcase {
 	{MS_RDONLY, FLAG_DESC2(MS_REMOUNT), test_remount},
 	{FLAG_DESC(MS_NOSUID), test_nosuid},
 	{FLAG_DESC(MS_NOATIME), test_noatime},
+	{FLAG_DESC(MS_NODIRATIME), test_nodiratime},
 };
 
 static void setup(void)
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
