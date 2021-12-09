Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C14C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 07:44:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 775BA3C7DBF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 08:44:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96FBC3C7883
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 08:43:41 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C909D201026
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 08:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639035820; i=@fujitsu.com;
 bh=w/1GYJC8P49G60e0CfINlPkqCPbIeWfgzPBVkOfubfE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=CKo46DUPqcdejkSN0cmMusAyWw/EwYr3ugteKOCay59ZZxH2bX0Jz9kYh031BI6HG
 5V0LHOCTUcv8TBqrlLOUwurZ9Y9f9D0dfIQy/xOpdLz/Q6tbjcgnGiyCvHkASEgpkT
 1zMOUPdkKsAvMcBlFwziOOc5TX5WCEMEWK0qQgdupJr/iXNIakwf7HbI7Yns4ouRIi
 N456qcJ+xHhV5EvfvyDt5xCVYWH1cbhmFZ5fnTmG5F7rZAaPTapsImgu4HOLgmCGMu
 P+Af4BncRi1HE2IrBlb6M1Cg8u2sATYaAG9VGT01JcaeOe1B7NgYa1tVtAWlJOQZrw
 j7D0S2VrVKAjw==
Received: from [100.115.34.229] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 21/2D-16537-BA3B1B16;
 Thu, 09 Dec 2021 07:43:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8MxSXfl5o2
 JBpvXaFqs+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBlHd25gLtjjXrF26SW2BsYl1l2MXBxCAmcZ
 JSa/mM8M4exkkljx9gwjhLObUeL9oVNsXYycHGwCmhLPOhcwg9giAhISHQ1v2UFsZgF1ieWTf
 jF1MXJwCAuYSZw/rgoSZhFQkdi28x8jiM0r4CGx6tRKMFtCQEFiysP3YGM4BTwlmlacZQKxhY
 BqFq3bA1UvKHFy5hMWiPESEgdfvGCG6FWUuNTxDWpOhcSsWW1MELaaxNVzm5gnMArOQtI+C0n
 7AkamVYzWSUWZ6RkluYmZObqGBga6hoamusZGukYGhnqJVbqJeqmluuWpxSW6RnqJ5cV6qcXF
 esWVuck5KXp5qSWbGIFhnFKscHIH4+9L3/QOMUpyMCmJ8t5YvDFRiC8pP6UyI7E4I76oNCe1+
 BCjDAeHkgRv/0agnGBRanpqRVpmDjCmYNISHDxKIrySm4DSvMUFibnFmekQqVOMilLivC4gCQ
 GQREZpHlwbLI4vMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmdQCZwpOZVwI3/RXQYiagxc4
 t60EWlyQipKQamCbueNT+IHgW/yMnn6dWeseX5D0SsBA9K+bvG5WwsCa297KHR/I5zwlOqwR+
 L/j9jlsyeVnOwtelM2oXT7hyQu9GwvWYDVK556PquvZF+ZZHRPHPX/jUWWelzE6OufrZWxaJ8
 864ay8l7ZrKdX1Ns3Sz9podUjvl7U+Xsl/YvedgxvIZMmdapn3UnsXGFJmqd7V9ufneJwau11
 gm5QUp2SXfmfix4KGkQO3d+JoDBy+FrGaZZVsq/+dDkuZ6LTPXN9d5xZp291TOmvnx5af/dW9
 6S2UmqOxIfujlmxZ5prHL8/ulmFUGvInpwULJ/YX3Vm9pMeiZJ7jhWLhR4cxi/jPn+z3Lz6+7
 ceV2r3bSCiWW4oxEQy3mouJEAL0wzmheAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-548.messagelabs.com!1639035817!72855!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29546 invoked from network); 9 Dec 2021 07:43:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-21.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Dec 2021 07:43:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 55AC410033A
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 07:43:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 44DBE100457
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 07:43:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 9 Dec 2021 07:43:25 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 9 Dec 2021 15:43:43 +0800
Message-ID: <1639035823-5786-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
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
 testcases/kernel/device-drivers/zram/zram03.c | 221 +++++++-----------
 1 file changed, 90 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 06995fd56..0cc6200a1 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -1,29 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (C) 2010  Red Hat, Inc.
+ */
+
+/*\
+ * [Description]
+ * 
  * zram: generic RAM based compressed R/W block devices
  * http://lkml.org/lkml/2010/8/9/227
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * 
+ * This case check whether data read from zram device is consistent with 
+ * thoese are written.
  */
 
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -32,12 +22,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "zram03";
-int TST_TOTAL = 1;
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
+	tst_res(TINFO, "create a zram device with %ld bytes in size.", SIZE);
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
+	tst_res(TINFO, "map this zram device into memory.");
+	fd = SAFE_OPEN(DEVICE, O_RDWR);
+	s = SAFE_MMAP(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
-	tst_resm(TINFO, "write all the memory.");
+	tst_res(TINFO, "write all the memory.");
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
+	tst_res(TINFO, "verify contents from device.");
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
+		tst_res(TFAIL, "%ld failed bytes found.", fail);
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
+	tst_res(TINFO, "%s...", __func__);
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
@@ -231,3 +142,51 @@ static void dump_info(void)
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
+
+	if (tst_cmd(cmd_rmmod, NULL, NULL, TST_CMD_PASS_RETVAL)) {
+		if (errno == EBUSY)
+			tst_brk(TCONF, "zram module may being used!");
+	}
+	if (errno == ENOENT)
+		SAFE_CMD(cmd_modprobe, NULL, NULL);
+
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
