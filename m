Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCF4C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 07:12:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF9E93C57F0
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 08:12:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3AF23C4E29
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 08:11:51 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09DBB600F4D
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 08:11:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638256306; i=@fujitsu.com;
 bh=y/9ieloQHay/qTip9/AT161ROixWU0WvsuYqsogjMqE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=cztjyOu96F3OoOODTdlGMEdqPO8vRqKPFAZsierQF65MhSjbaEDKepd91tXLsty1Z
 npDbMTXXPRZDAwKcG1t33CEOAcSW0CL0KdMXk5Cs2i6hwmxY/mUbtVGoQLdASKPsqW
 L9uk8mZKvWCfKvnRYcXodoyz+QehIaUbPgMdvSRcWgTfOgKpbJSXgKwBPUCM7lVul1
 acIS2KOjk/a/eTK360dcFai7oqpfbmpdORsAUk16Lo2hHoZh+uvDpxLeIuCz/OpFgI
 WLoT7alOobT3wUT6ZRD+gLDjvefY11OGju5CRjfRZfWXG1tNEiyagJYPa21Yk4hW7Z
 eNCZ8V8hE9oQg==
Received: from [100.113.0.193] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 70/26-32197-2BEC5A16;
 Tue, 30 Nov 2021 07:11:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8MxSXfjuaW
 JBpfeClis+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBmvP+9jLHihWvHg5SbWBsb5Cl2MXBxCAmcZ
 JY7+PMEE4exkknjz4wwbhLOHUeLbx8/MXYycHGwCmhLPOheA2SICEhIdDW/ZQWxmAXWJ5ZN+M
 YHYwgJ2EhOXPACLswioSvz5uBjM5hXwkHhzaCsbiC0hoCAx5eF7sDmcAioSly5NBbOFBJQlPu
 /dwghRLyhxcuYTFoj5EhIHX7xghuhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/
 AyLSK0TKpKDM9oyQ3MTNH19DAQNfQ0FjXEEia6yVW6SbqpZbqJqfmlRQlAmX1EsuL9Yorc5Nz
 UvTyUks2MQKDOKWQsXQH47Q3H/QOMUpyMCmJ8jZvXpooxJeUn1KZkVicEV9UmpNafIhRhoNDS
 YK35xRQTrAoNT21Ii0zBxhRMGkJDh4lEd73Z4DSvMUFibnFmekQqVOMilLivK1ngRICIImM0j
 y4NlgUX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzGsCMoUnM68EbvoroMVMQIvfLl0Msrg
 kESEl1cBUunlG3MKuGTOjj61UVfWYsXzNyaM1qpOrj/8VTZzoISlZf4CdU99NoMLmQ+sbr1Om
 Ft1Su8sV5izrvvTvpfru90kH97tfSD1zjv2u1RtXvn+H13fkLLrP+b9BTWJ98nV26aOHKzW+x
 8d/tPhzSXSl+ZPkD4vsvr/9s+l06sv3P7lff87acFZDrMOINUhN5aGlj9Ds6tVOJoWlca/Sf2
 zdVLHX9dn8rLcJ2xUOHAjcvz6y4efXpxrybVZuW5uuxd6KfSxybc4CS35TIaEPWi82Cmov8P5
 rclv0074n8qVvVvOUltpsUHvzPeWe2FVmVZ53PIH/80uDzn54UiwvdFcn8N3Php2Hr8470OQm
 cLF8sxJLcUaioRZzUXEiACaYv1hdAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-228.messagelabs.com!1638256305!61855!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22788 invoked from network); 30 Nov 2021 07:11:45 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-20.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 30 Nov 2021 07:11:45 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 25BE023693C
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 07:11:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1885F22CAAE
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 07:11:45 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 07:11:20 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 30 Nov 2021 15:11:12 +0800
Message-ID: <1638256273-5208-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YaSYuLV+XPW/pQ5/@yuki>
References: <YaSYuLV+XPW/pQ5/@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/statx01: Add stx_mnt_id check
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
 include/lapi/stat.h                       |  4 ++
 testcases/kernel/syscalls/statx/statx01.c | 61 +++++++++++++++++++++--
 3 files changed, 66 insertions(+), 3 deletions(-)

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
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 69162a72b..d59605887 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -176,6 +176,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_BTIME		0x00000800U
 #endif
 
+#ifndef STATX_MNT_ID
+# define STATX_MNT_ID		0x00001000U
+#endif
+
 #ifndef STATX_ALL
 # define STATX_ALL		0x00000fffU
 #endif
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index b6f52c66a..524acd273 100644
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
@@ -38,10 +39,12 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <sys/types.h>
+#include <unistd.h>
 #include <sys/sysmacros.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "lapi/stat.h"
+#include "tst_safe_stdio.h"
 #include <string.h>
 #include <inttypes.h>
 
@@ -54,6 +57,49 @@
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
+	unsigned int line_mjr, line_mnr;
+	uint64_t mnt_id;
+
+	if (!(buf->stx_mask & STATX_MNT_ID)) {
+		tst_res(TCONF, "stx_mnt_id is not supported until linux 5.8");
+		return;
+	}
+
+	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (sscanf(line, "%ld %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
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
+			"statx.stx_mnt_id equals to mount_id(%"PRIu64") in /proc/self/mountinfo",
+			mnt_id);
+	else
+		tst_res(TFAIL,
+			"statx.stx_mnt_id(%"PRIu64") is different from mount_id(%"PRIu64") in /proc/self/mountinfo",
+			(uint64_t)buf->stx_mnt_id, mnt_id);
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
@@ -92,7 +138,6 @@ static void test_normal_file(void)
 		tst_res(TFAIL, "stx_mode(%u) is different from expected(%u)",
 			buff.stx_mode, MODE);
 
-
 	if (buff.stx_blocks <= buff.stx_blksize/512 * 2)
 		tst_res(TPASS, "stx_blocks(%"PRIu64") is valid",
 			(uint64_t)buff.stx_blocks);
@@ -106,6 +151,11 @@ static void test_normal_file(void)
 		tst_res(TFAIL, "stx_nlink(%u) is different from expected(1)",
 			buff.stx_nlink);
 
+#ifdef HAVE_STRUCT_STATX_STX_MNT_ID
+	test_mnt_id(&buff);
+#else
+	tst_res(TCONF, "stx_mnt_id is not defined in struct statx");
+#endif
 }
 
 static void test_device_file(void)
@@ -153,7 +203,6 @@ static void run(unsigned int i)
 static void setup(void)
 {
 	char data_buff[SIZE];
-	int file_fd;
 
 	umask(0);
 
@@ -161,15 +210,21 @@ static void setup(void)
 
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
