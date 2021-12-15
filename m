Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F6BC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:21:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7353C8E35
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:21:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE8A3C7FC9
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:52 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D40916011EC
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639552851; i=@fujitsu.com;
 bh=Wq61mqRh3Q2+9yqOtZ16/FsOdccLxWJdzmD7BTmFWfI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=yNOmsZEY1Q2NB65gND/IM5Z0xqFwRYQB3tHucmMD/mVlr2eio6pxGWbUr2XGx2qQI
 BDap+b4/VMg9L9MDBzB9aea86KTAaUuH0c7N3ZRUqkuhzLOFa7OLD2ZxbtSlXnSiVm
 mWplhoKy3GjSI8CnzNMDn7DQ8tXYKX2T4OXfhytOjmpQ8Ta99ieiOIE81Wtg7pfeoM
 TQzff4R8XXDwFfrVCj2MDQj4zcHeSOos+xAD/GKh05jbgVoeWumua/6orTMi3Ql64V
 HU0TwwymyZ5x5RYVKpWCPDQGpj0Q3n0PO940sxA1DpwH3uXpvAX3zfSzEe/FVyL83C
 niE206dZ6CS7A==
Received: from [100.115.68.153] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id 12/38-24146-35799B16;
 Wed, 15 Dec 2021 07:20:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8MxSTdo+s5
 EgycbdCxWfN/B6MDose/3OtYAxijWzLyk/IoE1owZL++zFNwKrjh3aR5LA+NCty5GLg4hgbOM
 Eiv77rJCODuZJC7cu8bexcgJ5OxhlHhwNwnEZhPQlHjWuYAZxBYRkJDoaHgLVsMsoC6xfNIvJ
 hBbWMBSYvrqj2A1LAKqEmvf3WUEsXkFPCSObXnGAmJLCChITHn4HqyGU8BT4gKULQRU82PaWj
 aIekGJkzOfsEDMl5A4+OIFM0SvosSljm+MEHaFxKxZbUwQtprE1XObmCcwCs5C0j4LSfsCRqZ
 VjHZJRZnpGSW5iZk5uoYGBrqGhqa6Zqa6hhZGeolVuol6qaW6yal5JUWJQGm9xPJivdTiYr3i
 ytzknBS9vNSSTYzAYE4pdty2g/FU30+9Q4ySHExKorxvy3cmCvEl5adUZiQWZ8QXleakFh9il
 OHgUJLgfTkRKCdYlJqeWpGWmQOMLJi0BAePkgjvsalAad7igsTc4sx0iNQpRkUpcd6tIAkBkE
 RGaR5cGyyaLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5rWZBDSFJzOvBG76K6DFTCCLc7e
 DLC5JREhJNTAJX9r3jnObYtxq6/tvTdPKcqWebMh/9K7/eEKr/YbPu8zmev0Nv5DU2HLe+IN8
 bPAjzuibnp0sfkVOzU8Mt3PtqQgRSzLXVWeT1k44s8hw+c8W38PmJ5rWb3wR6WrT/cezTSTST
 Z+xsfDI+XNqP7oa/RJ3NVeHlLIFPlFaed6oeEKX+q+UtkVud6atDT6gfywqdMUaLW4PCyOu1e
 rtK4WPCT95wlTHZp3wskpAUqj2/P4Z+9k9Wh16lc8nbnpuZ+l659XxJRNfrGPpbBLK4+s+GXJ
 syfOFz5fmLpff4Gl4YeH7Gxs610SINVjfFRflCFr68WPWV0FZFX3msiBZnpKXrL4crCEMhs8a
 SktmKLEUZyQaajEXFScCAFfFi2RhAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-532.messagelabs.com!1639552850!1038!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14463 invoked from network); 15 Dec 2021 07:20:50 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-9.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Dec 2021 07:20:50 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3E80910032A
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:20:50 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 3195C1000F6
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:20:50 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 07:20:27 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 15 Dec 2021 15:20:48 +0800
Message-ID: <1639552849-2251-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] zram/zram03: Convert into new api
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

Also add hot_add/hot_remove in setup/cleanup, so this case can adapt the situation that
zram module is being used by zram-generator or zram module is builtin.

Fixes: #888
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram03.c | 265 +++++++++---------
 1 file changed, 125 insertions(+), 140 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 06995fd56..6f6f1db77 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -1,90 +1,45 @@
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
+#include <stdlib.h>
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "zram03";
-int TST_TOTAL = 1;
-
-#define PATH_ZRAM	"/sys/block/zram0"
-#define OBSOLETE_ZRAM_FILE	"/sys/block/zram0/num_reads"
-#define PATH_ZRAM_STAT	"/sys/block/zram0/stat"
-#define PATH_ZRAM_MM_STAT	"/sys/block/zram0/mm_stat"
-#define SIZE		(512 * 1024 * 1024L)
-#define DEVICE		"/dev/zram0"
+#define ZRAM_CONTROL_PATH 	"/sys/class/zram-control"
+#define HOT_ADD_PATH      	ZRAM_CONTROL_PATH"/hot_add"
+#define HOT_REMOVE_PATH   	ZRAM_CONTROL_PATH"/hot_remove"
+#define SIZE                    (512 * 1024 * 1024L)
 
-static int modprobe;
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
+static char zram_block_path[100], zram_dev_path[100], buf[20];
+static int modprobe, dev_num, hot_add_flag;
 
 static void set_disksize(void)
 {
-	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
-	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/disksize", "%ld", SIZE);
+	char disksize_path[200];
+	tst_res(TINFO, "create a zram device with %ld bytes in size", SIZE);
+
+	sprintf(disksize_path, "%s/disksize", zram_block_path);
+	SAFE_FILE_PRINTF(disksize_path, "%ld", SIZE);
 }
 
 static void write_device(void)
@@ -92,17 +47,16 @@ static void write_device(void)
 	int fd;
 	char *s;
 
-	tst_resm(TINFO, "map this zram device into memory.");
-	fd = SAFE_OPEN(cleanup, DEVICE, O_RDWR);
-	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ | PROT_WRITE,
-		      MAP_SHARED, fd, 0);
+	tst_res(TINFO, "map this zram device into memory");
+	fd = SAFE_OPEN(zram_dev_path, O_RDWR);
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
@@ -111,9 +65,9 @@ static void verify_device(void)
 	long i = 0, fail = 0;
 	char *s;
 
-	tst_resm(TINFO, "verify contents from device.");
-	fd = SAFE_OPEN(cleanup, DEVICE, O_RDONLY);
-	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+	tst_res(TINFO, "verify contents from device");
+	fd = SAFE_OPEN(zram_dev_path, O_RDONLY);
+	s = SAFE_MMAP(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
 
 	while (s[i] && i < SIZE - 1) {
 		if (s[i] != 'a')
@@ -121,104 +75,73 @@ static void verify_device(void)
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
+	char reset_path[200];
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	if (modprobe == 1 && system("rmmod zram") == -1)
-		tst_resm(TWARN | TERRNO, "system(rmmod zram) failed");
+	tst_res(TINFO, "Reset zram");
+	sprintf(reset_path, "%s/reset", zram_block_path);
+	SAFE_FILE_PRINTF(reset_path, "1");
 }
 
 static void print(char *string)
 {
 	char filename[BUFSIZ], value[BUFSIZ];
-
-	sprintf(filename, "%s/%s", PATH_ZRAM, string);
-	SAFE_FILE_SCANF(cleanup, filename, "%s", value);
-	tst_resm(TINFO, "%s is %s", filename, value);
+	tst_res(TINFO, "%s",  zram_block_path);
+	sprintf(filename, "%s/%s", zram_block_path, string);
+	SAFE_FILE_SCANF(filename, "%s", value);
+	tst_res(TINFO, "%s is %s", filename, value);
 }
 
 static void print_stat(char *nread, char *nwrite)
 {
 	char nread_val[BUFSIZ], nwrite_val[BUFSIZ];
+	char zram_stat_path[100];
 
-	SAFE_FILE_SCANF(cleanup, PATH_ZRAM_STAT, "%s %*s %*s %*s %s",
-			nread_val, nwrite_val);
-	tst_resm(TINFO, "%s from %s is %s", nread, PATH_ZRAM_STAT,
-		 nread_val);
-	tst_resm(TINFO, "%s from %s is %s", nwrite, PATH_ZRAM_STAT,
-		 nwrite_val);
+	sprintf(zram_stat_path, "/sys/block/zram%d/stat", dev_num);
+	SAFE_FILE_SCANF(zram_stat_path, "%s %*s %*s %*s %s", nread_val, nwrite_val);
+	tst_res(TINFO, "%s from %s is %s", nread, zram_stat_path, nread_val);
+	tst_res(TINFO, "%s from %s is %s", nwrite, zram_stat_path, nwrite_val);
 }
 
 static void print_mm_stat(char *orig, char *compr, char *mem, char *zero)
 {
 	char orig_val[BUFSIZ], compr_val[BUFSIZ];
 	char mem_val[BUFSIZ], zero_val[BUFSIZ];
+	char zram_mm_stat_path[100];
 
-	SAFE_FILE_SCANF(cleanup, PATH_ZRAM_MM_STAT, "%s %s %s %*s %*s %s",
+	sprintf(zram_mm_stat_path, "/sys/block/zram%d/mm_stat", dev_num);
+	SAFE_FILE_SCANF(zram_mm_stat_path, "%s %s %s %*s %*s %s",
 			orig_val, compr_val, mem_val, zero_val);
-	tst_resm(TINFO, "%s from %s is %s", orig, PATH_ZRAM_MM_STAT,
-		 orig_val);
-	tst_resm(TINFO, "%s from %s is %s", compr, PATH_ZRAM_MM_STAT,
-		compr_val);
-	tst_resm(TINFO, "%s from %s is %s", mem, PATH_ZRAM_MM_STAT,
-		 mem_val);
-	tst_resm(TINFO, "%s from %s is %s", zero, PATH_ZRAM_MM_STAT,
-		 zero_val);
+	tst_res(TINFO, "%s from %s is %s", orig, zram_mm_stat_path, orig_val);
+	tst_res(TINFO, "%s from %s is %s", compr, zram_mm_stat_path, compr_val);
+	tst_res(TINFO, "%s from %s is %s", mem, zram_mm_stat_path, mem_val);
+	tst_res(TINFO, "%s from %s is %s", zero, zram_mm_stat_path, zero_val);
 }
 
 static void dump_info(void)
 {
+	char zram_obsolete_file_path[100];
+
+	sprintf(zram_obsolete_file_path, "/sys/block/zram%d/num_reads", dev_num);
 	print("initstate");
 	print("disksize");
-	if (!access(OBSOLETE_ZRAM_FILE, F_OK)) {
+	if (!access(zram_obsolete_file_path, F_OK)) {
 		print("orig_data_size");
 		print("compr_data_size");
 		print("mem_used_total");
@@ -231,3 +154,65 @@ static void dump_info(void)
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
+	int hot_add_fd;
+
+	if (!access(ZRAM_CONTROL_PATH, F_OK)) {
+		hot_add_fd = SAFE_OPEN(HOT_ADD_PATH, O_RDONLY);
+		SAFE_READ(0, hot_add_fd, &buf, 20);
+		dev_num = atoi(buf);
+		SAFE_CLOSE(hot_add_fd);
+		hot_add_flag = 1;
+	} else {
+		SAFE_CMD(cmd_modprobe, NULL, NULL);
+		modprobe = 1;
+	}
+	sprintf(zram_block_path, "/sys/block/zram%d", dev_num);
+	sprintf(zram_dev_path, "/dev/zram%d", dev_num);
+}
+
+static void cleanup(void)
+{
+	const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};
+	int hot_remove_fd;
+
+	if (hot_add_flag) {
+		hot_remove_fd = SAFE_OPEN(HOT_REMOVE_PATH, O_WRONLY);
+		SAFE_WRITE(0, hot_remove_fd, buf, 20);
+		SAFE_CLOSE(hot_remove_fd);
+	}
+
+	if (modprobe)
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
