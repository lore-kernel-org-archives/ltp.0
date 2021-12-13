Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5A8C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 05:46:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E15F3C892B
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 06:46:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA9893C0B90
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 06:46:28 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 883A11400B74
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 06:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639374386; i=@fujitsu.com;
 bh=zXDEmAS6yFnosFtlgtj3SeOq3/BNAT6YJ58zD3XUe5U=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=CDIG2jG8qNe0VQc46myCAA7l8Pixp1luw4kqSVpu8AiScrdIejPDr86NKUQdKkL2M
 ALVRWFyKBzJV2dbZReyQWGPZZtrHrZXc2gPmMdaZlgA+oZ8thlYNaUDqq6YFqtRMq3
 Lj4DOPY9PKiJH8+xlfvACvyFnOREuqIhlcM1Fm55k9OfsAufGcDUf16ZyrVgNSO8w3
 oA8nNG++mcHB5an7HGu0ajhRV3wEtYjVaN9x975AjdNhcAwDnjmXPb7vMyJYzZ4RR7
 B89DPMoER0S9pLFvOjbBeMgYJHcu2qUkqA1BrAClxM4iMvSaFSJOFaeQTgOvwNbVkr
 PMskfw5AGODHA==
Received: from [100.115.0.27] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 78/C1-10124-23ED6B16;
 Mon, 13 Dec 2021 05:46:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRWlGSWpSXmKPExsViZ8MxSdfw3rZ
 Eg6YdZhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aRW9IFU7wq3l51aGA8ZdvFyMUhJHCWUeLV
 p29MEM5OJomLO9+yQDh7GCV+zX/F3sXIycEmoCnxrHMBM4gtIiAh0dHwFizOLKAusXzSLyYQW
 1jAUuL29E4wm0VAVeJBw2I2EJtXwFPi488ZYHEJAQWJKQ/fM0PEBSVOznzCAjFHQuLgixfMED
 WKEpc6vjFC2BUSs2a1QfWqSVw9t4l5AiP/LCTts5C0L2BkWsVomVSUmZ5RkpuYmaNraGCga2h
 oqmuia2msl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGJApxSyxOxi39v3U
 O8QoycGkJMr7jXFrohBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3pZb2xKFBItS01Mr0jJzgNEBk
 5bg4FES4WW8C5TmLS5IzC3OTIdInWJUlBLnPXoHKCEAksgozYNrg0XkJUZZKWFeRgYGBiGegt
 Si3MwSVPlXjOIcjErCvAIg43ky80rgpr8CWswEsrhyM8jikkSElFQDk7ZKq5N8cgvPG/8fWXf
 XLuVv4erZOm2vyWaF02F+Z1jqRY8+4ubWX+bH4jLF/lRaYteySrsJKQXLYzk8diTOiZYxvtly
 J8fU8q/CRi7RZ2fkSn5mOv1i9UpWL/Jpn9v7Rr18fsO2B6/KxOVO9YodXuhx84G7wrI5EvKZI
 Z8371jsmM+8q375jldfw71aVgtpHQxRMrPN87r7UnvyQaZjpXo2l68wMtyYs+zhpan+bs8+9R
 jxKFevF3h/uH+GT8K841HTEitlOq4G19lN5TH6rfGPeaGDicM2xzXLjHdf591d8yVIdVfc+8Q
 DnWnmd0UFr1yqN/80iT/4mENersdHe+0/zQaO3ww2To1kFDmoxFKckWioxVxUnAgARfmX3EMD
 AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-585.messagelabs.com!1639374385!155233!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18395 invoked from network); 13 Dec 2021 05:46:25 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-19.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 05:46:25 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 6CEAB1000FC
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 05:46:25 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6019C100047
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 05:46:25 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 05:46:03 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 13:46:42 +0800
Message-ID: <1639374402-22947-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] zram/zram03: Convert into new api
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
 testcases/kernel/device-drivers/zram/zram03.c | 234 ++++++++----------
 1 file changed, 103 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 06995fd56..4466525bd 100644
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
@@ -231,3 +142,64 @@ static void dump_info(void)
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
+	SAFE_FCLOSE(file);
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
