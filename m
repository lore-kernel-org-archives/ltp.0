Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F95EC433F5
	for <ltp@archiver.kernel.org>; Thu, 25 Nov 2021 09:35:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDB463C810E
	for <ltp@archiver.kernel.org>; Thu, 25 Nov 2021 10:35:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC9DC3C3349
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 10:35:20 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 198802013BC
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 10:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637832915; i=@fujitsu.com;
 bh=1LfN+IImbbM/mkXTpSvCPy7EK47Rhb0QBx6IbBBVYkk=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=cwmExiNTEbvBJVF/RHgzzW1/1R4aJcWdcKlsCJbVZ5uGcAtGgG4yIlRFPIDazijKp
 wF8SdOvXFa3DQUGY2ShoDF3KgWPOujt6QFDBaG50XDIHF9xRG/qp7bA+IwDKEgo87v
 HJgBBnUHT0rfh5TbYwNYug6cZLyII7qqqWvVbnAPpCUitnhfTKJXK/7WG/gJBOJido
 L4QO1NJ7Fp3I7B8ZpMFX/ZJ1Iy5dK+si9jF0JAn63SMINY9WhHoTThZib73PyMZ9r1
 6QO8bnFZfnm3yttPaoDiN3w2iRq7ZrzK3FEXcDeHpWRCXiKP5Fk+qTxe7jONBj1sLa
 dpYCDuCNcQgdw==
Received: from [100.115.38.114] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 7B/15-16121-3D85F916;
 Thu, 25 Nov 2021 09:35:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8ORqHspYn6
 iwalH2hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aLKQtZCm7JV0z5pt7A2CfdxcjFISRwllFi
 +9QPzBDOTiaJBYfXMUI4exglfn5uZ+9i5ORgE9CUeNa5gBnEFhGQkOhoeAsWZxZQl1g+6RdTF
 yMHh7CAuUTnKw8Qk0VAVeLq9wKQCl4BD4mHU/aygdgSAgoSUx6+Z4aIC0qcnPmEBWKKhMTBFy
 +YIWoUJS51fGOEsCskZs1qY4Kw1SSuntvEPIGRfxaS9llI2hcwMq1itE4qykzPKMlNzMzRNTQ
 w0DU0NNU1NtY1NLPUS6zSTdRLLdUtTy0u0TXSSywv1kstLtYrrsxNzknRy0st2cQIDMmUYsWV
 OxiXfv2hd4hRkoNJSZT3eMD8RCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvPEhQDnBotT01Iq0z
 BxgfMCkJTh4lER4T4QDpXmLCxJzizPTIVKnGBWlxHmDQRICIImM0jy4NlhMXmKUlRLmZWRgYB
 DiKUgtys0sQZV/xSjOwagkzPscZApPZl4J3PRXQIuZgBb37pkNsrgkESEl1cCkr+oaemYZ55e
 335sWuNzO6qoKE3wn9mB9w6ro+SF/V/zpfOM+bT3LnWTeCZPLSvh5HM5N+MA9UeQ/d+NRR3fL
 lfUfZ+32XXnHOqH6QdqKq9pKj/7FxOo93c/49+IBz8Lvu8p9jtreWbNfpMmnxOuc8sccrekXG
 t/JP49vkpwVM0kkryV16nnHft3+wpPzJIu5U/edVlFSkfBfc+uh00377WZ/NkhmR4mmG0r+OT
 nf7qbHq54wjd8luoXf7rb1vf+oOfVOiMH3x1M9vjVU/0mxWd7d1Ww9Pe61ZqSGGndlrmvTd9a
 bjGF52iUanDd9VRd///t/2oUpFYF7jXgmrTVWXilpH3pyvfrLZttlc7qUWIozEg21mIuKEwGj
 +E34RAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-548.messagelabs.com!1637832914!2868!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5546 invoked from network); 25 Nov 2021 09:35:14 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-11.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Nov 2021 09:35:14 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 37C8610024C
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 09:35:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 1F9ED100239
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 09:35:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 09:35:02 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 25 Nov 2021 17:35:00 +0800
Message-ID: <1637832900-4753-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statx01: Add stx_mnt_id check
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

This member was added since linux 5.8. We compare this value with the value in two places.
1.the mount_id filed in /proc/self/mountinfo
2.the mnt_id field in /proc/pid/fdinfo/fd

Reference url:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa2fcf4
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=728009a47497b6

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                              |  4 ++
 testcases/kernel/syscalls/statx/statx01.c | 55 +++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9101617ea..4751b14d2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,6 +152,10 @@ AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
+AC_CHECK_MEMBERS([struct statx.stx_mnt_id],,,[
+#define _GNU_SOURCE
+#include <sys/stat.h>
+])
 
 AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index bf7d21c5d..6d0e7d590 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -17,6 +17,7 @@
  * 4) blocks
  * 5) size
  * 6) nlink
+ * 7) mnt_id
  *
  * A file is created and metadata values are set with
  * predefined values.
@@ -39,9 +40,11 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/sysmacros.h>
+#include <unistd.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "lapi/stat.h"
+#include "tst_safe_stdio.h"
 #include <string.h>
 #include <inttypes.h>
 
@@ -54,6 +57,43 @@
 #define MAJOR 8
 #define MINOR 1
 
+static int file_fd = -1;
+
+#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
+static void test_mnt_id(struct statx *buf)
+{
+	FILE *file;
+	char line[PATH_MAX];
+	int pid;
+	unsigned int line_mjr, line_mnr, mnt_id;
+
+	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (sscanf(line, "%d %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
+			continue;
+
+		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
+			break;
+	}
+
+	SAFE_FCLOSE(file);
+
+	if (buf->stx_mnt_id == mnt_id)
+		tst_res(TPASS,
+			"statx.stx_mnt_id equals to mount_id(%d) in /proc/self/mountinfo",
+			mnt_id);
+	else
+		tst_res(TFAIL,
+			"statx.stx_mnt_id(%d) is different from mount_id(%d) in /proc/self/mountinfo",
+			buf->stx_mnt_id, mnt_id);
+
+	pid = getpid();
+	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
+	TST_ASSERT_FILE_INT(line, "mnt_id:", buf->stx_mnt_id);
+}
+#endif
+
 static void test_normal_file(void)
 {
 	struct statx buff;
@@ -106,6 +146,11 @@ static void test_normal_file(void)
 		tst_res(TFAIL, "stx_nlink(%u) is different from expected(1)",
 			buff.stx_nlink);
 
+#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
+	test_mnt_id(&buff);
+#else
+	tst_res(TCONF, "stx_mnt_id was not supported until linux 5.8.");
+#endif
 }
 
 static void test_device_file(void)
@@ -137,7 +182,6 @@ static void test_device_file(void)
 			buff.stx_rdev_minor, MINOR);
 }
 
-
 struct tcase {
 	void (*tfunc)(void);
 } tcases[] = {
@@ -153,7 +197,6 @@ static void run(unsigned int i)
 static void setup(void)
 {
 	char data_buff[SIZE];
-	int file_fd;
 
 	umask(0);
 
@@ -161,15 +204,21 @@ static void setup(void)
 
 	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR|O_CREAT, MODE);
 	SAFE_WRITE(1, file_fd, data_buff, sizeof(data_buff));
-	SAFE_CLOSE(file_fd);
 
 	SAFE_MKNOD(DEVICEFILE, S_IFBLK | 0777, makedev(MAJOR, MINOR));
 }
 
+static void cleanup(void)
+{
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
+}
+
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
+	.cleanup = cleanup,
 	.min_kver = "4.11",
 	.needs_devfs = 1,
 	.mntpoint = MNTPOINT,
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
