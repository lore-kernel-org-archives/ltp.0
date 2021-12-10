Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD20C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A33B3C815D
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:41:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0C7B3C130C
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:41:07 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13C7360086C
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639136466; i=@fujitsu.com;
 bh=ZV1bhpbE8V0legvThtDXh7IzCmnKQhgzPcYx+kthAI8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=CBTZAetAG5ZYeARSCZhZj8UbiGpsY18tnjglYt2tu9JjOERn3fdUg+PHwa/ii19FE
 m4ZHm5gu5VUusBnwtXgVlHgvLYv3zFAA7E4od4hV/UH/xpSr3CGCQvmAau/6jgW0k1
 nR+Hh5wwshwtJgrIHVgdQx0B9W8EYYQyOpXNbTGydAwEX++Zyz37tNSSkc+IyVuWsr
 MoTzXHJ4E6fQcrFyzAvVJDOtWGA0ZOz0rHMGdUEKWpan/UH12MeMWjRqROmTdg2U5a
 d3Zq3dCywq69JWKdU/Sck9SlLOaQB572VvzNEwmO4ye9+uCpTK9pohWnqdrqZbMPHR
 5cadJGMxxngHw==
Received: from [100.115.67.185] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id 6A/A8-24146-2DC33B16;
 Fri, 10 Dec 2021 11:41:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsViZ8MxSfeizeZ
 Eg0PLLS1WfN/B6MDose/3OtYAxijWzLyk/IoE1oxV7w8xFTzwqlg5/zljA2OHXRcjJ4eQwFlG
 ickzZbsYuYDsnUwSB6atZ4dI7GGU2LiuDsRmE9CUeNa5gBnEFhGQkOhoeAtWwyygLrF80i8mE
 FtYwFKi99ECVhCbRUBVYsbl82A1vAIeEnf6zrCB2BICChJTHr4Hm8Mp4Cnxu3k3G8SuJInnu1
 YxQtQLSpyc+YQFYr6ExMEXL5ghehUlLnV8Y4SwKyRmzWpjgrDVJK6e28Q8gVFwFpL2WUjaFzA
 yrWK0SyrKTM8oyU3MzNE1NDDQNTQ01TU31DU0NtZLrNJN1Est1U1OzSspSgRK6yWWF+ulFhfr
 FVfmJuek6OWllmxiBIZySrF76w7Gy30/9Q4xSnIwKYnyiv3elCjEl5SfUpmRWJwRX1Sak1p8i
 FGGg0NJgpfRenOikGBRanpqRVpmDjCuYNISHDxKIrwbQdK8xQWJucWZ6RCpU4yKUuK8b0ASAi
 CJjNI8uDZYLF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMwrDUwMQjyZeSVw018BLWYCWuz
 csh5kcUkiQkqqgSlPLGN/SVG42KN3x+elykpVBb1Vf3oyTeP0ydL5+qvVF/OrbFjw6JNiy35/
 flNzj39fzm6LszuWZ6/443XvDzvOVmfZA5tc7n38UrREd55Yr17uV9WHS/+4ta9JKlH4+54po
 SIyMIp/URLnwb09176zyPNFdnpsWLp1IUPhf0/+yFqhpO4tBzLPWkw87PdNVDjkO9dBOZ/y35
 pJdb+ldwfsf7j+vBXbbMF5F8QLmGzdOT4qJjj8P2fKYlwWsljt5HyvQg6HaIHzKTGXnjRINMd
 /3/vq44nnHft/B6/blsFSk9NrvOh3ENfmg5xbNjSL/fGv5T7rEvzB7aOgtaouQ5Di+4nmWz15
 2Y6XZJxhUmIpzkg01GIuKk4EAEZs6dJgAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-528.messagelabs.com!1639136465!17673!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24966 invoked from network); 10 Dec 2021 11:41:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-8.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Dec 2021 11:41:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5C07B10046B
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:41:05 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 47353100459
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:41:05 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 10 Dec 2021 11:40:40 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 10 Dec 2021 19:40:48 +0800
Message-ID: <1639136448-2148-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YbJ3SKsLu7iNoqZc@pevik>
 <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] zram/zram03: Convert into new api
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

Also add removing zram module step in setup, so we can avoid the situation that
zram module is being used by zram-generator.

Fixes: #888
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
Not use lsmod to detect because tst_cmd doesn't support "lsmod |grep zram". Or
I miss something?
 testcases/kernel/device-drivers/zram/zram03.c | 233 ++++++++----------
 1 file changed, 102 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 06995fd56..4f8fb994f 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -1,43 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * zram: generic RAM based compressed R/W block devices
- * http://lkml.org/lkml/2010/8/9/227
- *
  * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+/*\
+ * [Description]
  *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
+ * zram: generic RAM based compressed R/W block devices
+ * http://lkml.org/lkml/2010/8/9/227
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * This case check whether data read from zram device is consistent with
+ * thoese are written.
  */
 
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "zram03";
-int TST_TOTAL = 1;
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
 
 #define PATH_ZRAM	"/sys/block/zram0"
 #define OBSOLETE_ZRAM_FILE	"/sys/block/zram0/num_reads"
@@ -47,44 +32,12 @@ int TST_TOTAL = 1;
 #define DEVICE		"/dev/zram0"
 
 static int modprobe;
-
-static void set_disksize(void);
-static void write_device(void);
-static void verify_device(void);
-static void reset(void);
-static void setup(void);
-static void cleanup(void);
-static void print(char *string);
-static void dump_info(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		set_disksize();
-
-		write_device();
-		dump_info();
-		verify_device();
-
-		reset();
-		dump_info();
-	}
-	cleanup();
-	tst_exit();
-}
+static const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};
 
 static void set_disksize(void)
 {
-	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
-	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/disksize", "%ld", SIZE);
+	tst_res(TINFO, "create a zram device with %ld bytes in size", SIZE);
+	SAFE_FILE_PRINTF(PATH_ZRAM "/disksize", "%ld", SIZE);
 }
 
 static void write_device(void)
@@ -92,17 +45,16 @@ static void write_device(void)
 	int fd;
 	char *s;
 
-	tst_resm(TINFO, "map this zram device into memory.");
-	fd = SAFE_OPEN(cleanup, DEVICE, O_RDWR);
-	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ | PROT_WRITE,
-		      MAP_SHARED, fd, 0);
+	tst_res(TINFO, "map this zram device into memory");
+	fd = SAFE_OPEN(DEVICE, O_RDWR);
+	s = SAFE_MMAP(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
-	tst_resm(TINFO, "write all the memory.");
+	tst_res(TINFO, "write all the memory");
 	memset(s, 'a', SIZE - 1);
 	s[SIZE - 1] = '\0';
 
-	SAFE_MUNMAP(cleanup, s, SIZE);
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_MUNMAP(s, SIZE);
+	SAFE_CLOSE(fd);
 }
 
 static void verify_device(void)
@@ -111,9 +63,9 @@ static void verify_device(void)
 	long i = 0, fail = 0;
 	char *s;
 
-	tst_resm(TINFO, "verify contents from device.");
-	fd = SAFE_OPEN(cleanup, DEVICE, O_RDONLY);
-	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+	tst_res(TINFO, "verify contents from device");
+	fd = SAFE_OPEN(DEVICE, O_RDONLY);
+	s = SAFE_MMAP(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
 
 	while (s[i] && i < SIZE - 1) {
 		if (s[i] != 'a')
@@ -121,59 +73,25 @@ static void verify_device(void)
 		i++;
 	}
 	if (i != SIZE - 1) {
-		tst_resm(TFAIL, "expect size: %ld, actual size: %ld.",
+		tst_res(TFAIL, "expect size: %ld, actual size: %ld.",
 			 SIZE - 1, i);
 	} else if (s[i] != '\0') {
-		tst_resm(TFAIL, "zram device seems not null terminated");
+		tst_res(TFAIL, "zram device seems not null terminated");
 	} else if (fail) {
-		tst_resm(TFAIL, "%ld failed bytes found.", fail);
+		tst_res(TFAIL, "%ld failed bytes found", fail);
 	} else {
-		tst_resm(TPASS, "data read from zram device is consistent "
+		tst_res(TPASS, "data read from zram device is consistent "
 			 "with those are written");
 	}
 
-	SAFE_MUNMAP(cleanup, s, SIZE);
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_MUNMAP(s, SIZE);
+	SAFE_CLOSE(fd);
 }
 
 static void reset(void)
 {
-	tst_resm(TINFO, "reset it.");
-	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/reset", "1");
-}
-
-static void setup(void)
-{
-	int retried = 0;
-
-	tst_require_root();
-
-retry:
-	if (access(PATH_ZRAM, F_OK) == -1) {
-		if (errno == ENOENT) {
-			if (retried) {
-				tst_brkm(TCONF, NULL,
-					 "system has no zram device.");
-			}
-			if (system("modprobe zram") == -1) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "system(modprobe zram) failed");
-			}
-			modprobe = 1;
-			retried = 1;
-			goto retry;
-		} else
-			tst_brkm(TBROK | TERRNO, NULL, "access");
-	}
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	if (modprobe == 1 && system("rmmod zram") == -1)
-		tst_resm(TWARN | TERRNO, "system(rmmod zram) failed");
+	tst_res(TINFO, "Reset zram");
+	SAFE_FILE_PRINTF(PATH_ZRAM "/reset", "1");
 }
 
 static void print(char *string)
@@ -181,20 +99,17 @@ static void print(char *string)
 	char filename[BUFSIZ], value[BUFSIZ];
 
 	sprintf(filename, "%s/%s", PATH_ZRAM, string);
-	SAFE_FILE_SCANF(cleanup, filename, "%s", value);
-	tst_resm(TINFO, "%s is %s", filename, value);
+	SAFE_FILE_SCANF(filename, "%s", value);
+	tst_res(TINFO, "%s is %s", filename, value);
 }
 
 static void print_stat(char *nread, char *nwrite)
 {
 	char nread_val[BUFSIZ], nwrite_val[BUFSIZ];
 
-	SAFE_FILE_SCANF(cleanup, PATH_ZRAM_STAT, "%s %*s %*s %*s %s",
-			nread_val, nwrite_val);
-	tst_resm(TINFO, "%s from %s is %s", nread, PATH_ZRAM_STAT,
-		 nread_val);
-	tst_resm(TINFO, "%s from %s is %s", nwrite, PATH_ZRAM_STAT,
-		 nwrite_val);
+	SAFE_FILE_SCANF(PATH_ZRAM_STAT, "%s %*s %*s %*s %s", nread_val, nwrite_val);
+	tst_res(TINFO, "%s from %s is %s", nread, PATH_ZRAM_STAT, nread_val);
+	tst_res(TINFO, "%s from %s is %s", nwrite, PATH_ZRAM_STAT, nwrite_val);
 }
 
 static void print_mm_stat(char *orig, char *compr, char *mem, char *zero)
@@ -202,16 +117,12 @@ static void print_mm_stat(char *orig, char *compr, char *mem, char *zero)
 	char orig_val[BUFSIZ], compr_val[BUFSIZ];
 	char mem_val[BUFSIZ], zero_val[BUFSIZ];
 
-	SAFE_FILE_SCANF(cleanup, PATH_ZRAM_MM_STAT, "%s %s %s %*s %*s %s",
+	SAFE_FILE_SCANF(PATH_ZRAM_MM_STAT, "%s %s %s %*s %*s %s",
 			orig_val, compr_val, mem_val, zero_val);
-	tst_resm(TINFO, "%s from %s is %s", orig, PATH_ZRAM_MM_STAT,
-		 orig_val);
-	tst_resm(TINFO, "%s from %s is %s", compr, PATH_ZRAM_MM_STAT,
-		compr_val);
-	tst_resm(TINFO, "%s from %s is %s", mem, PATH_ZRAM_MM_STAT,
-		 mem_val);
-	tst_resm(TINFO, "%s from %s is %s", zero, PATH_ZRAM_MM_STAT,
-		 zero_val);
+	tst_res(TINFO, "%s from %s is %s", orig, PATH_ZRAM_MM_STAT, orig_val);
+	tst_res(TINFO, "%s from %s is %s", compr, PATH_ZRAM_MM_STAT, compr_val);
+	tst_res(TINFO, "%s from %s is %s", mem, PATH_ZRAM_MM_STAT, mem_val);
+	tst_res(TINFO, "%s from %s is %s", zero, PATH_ZRAM_MM_STAT, zero_val);
 }
 
 static void dump_info(void)
@@ -231,3 +142,63 @@ static void dump_info(void)
 		print_stat("num_reads", "num_writes");
 	}
 }
+
+static void run(void)
+{
+	set_disksize();
+
+	write_device();
+	dump_info();
+	verify_device();
+
+	reset();
+	dump_info();
+}
+
+static void setup(void)
+{
+	const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
+	FILE *file;
+	char line[PATH_MAX];
+
+	file = SAFE_FOPEN("/proc/modules", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "zram")) {
+			modprobe = 1;
+			break;
+		}
+	}
+
+	if (modprobe) {
+		tst_res(TINFO, "rmmod zram before test");
+		if (tst_cmd(cmd_rmmod, NULL, NULL, TST_CMD_PASS_RETVAL))
+			tst_brk(TCONF, "zram module may being used!");
+		else
+			modprobe = 0;
+	}
+
+	SAFE_CMD(cmd_modprobe, NULL, NULL);
+	modprobe = 1;
+}
+
+static void cleanup(void)
+{
+	if (modprobe == 1)
+		SAFE_CMD(cmd_rmmod, NULL, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		"zram",
+		NULL
+	},
+	.needs_cmds = (const char *[]) {
+		"modprobe",
+		"rmmod",
+		NULL
+	}
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
