Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C82C433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:22:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50473CADFE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:22:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAFFA3CAE05
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:26 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 06CEA200DC2
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:26 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 c12-20020a170903234c00b0017f695bf8f0so3225032plh.6
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=ua6Op1leeBLDsamZR7vS7csPM92hqpSo1BZRkldJMqA=;
 b=i6Zo20LO6j7aDIDLWddNPdEEuUnczPjXWpzTwrvy2IoT2fUcAhB5mhIbkTrWM9l0YT
 BTe5IUn15mj3JLOMxxxgpehqkpwsM6wTb7gZx1wLKkQTppf2YlN0NGdUM+Y/Z6yvRPMq
 +ui8HrnF/U1ALKhVg5HeKq+jgNUaxZb4Ev7e/1rrmJ0VSEix3xG3p+f5revgGwgIDEkx
 OfdC3sQLeiZrEmP0cOdP0PB49hWG+Y2BdgkFm57gb29BEIphb79qp7SOKZrxKJmWbiwX
 sCCNIZ6OJZGzfzw1YWXLP+SdLYUEZ95bonO+xAIeWO50zLa69Z/YRW5mWdIMHNeDB/U6
 33AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=ua6Op1leeBLDsamZR7vS7csPM92hqpSo1BZRkldJMqA=;
 b=oE4Wn7Ah9TB0Qx1RoxOEqGa8bV9CzpjEZX4GP3UyrO2oV3dBk74Odh5xypPho2IQUa
 ms/m85B/bYAxxkjChnB+T01Ys3SnasTJSdpmFn7QAXkgkFU1mvpxY3p1UwQQGPBulTIm
 aWdRoMlucKADv2ntH9xsPYuM47uw5cnpMMbzJkemf3AZZjb+1Ql2UyEqPyq6wu171Xsh
 Silq6iQzHFwSoY0xoCMMqwBgfOpwsbRFjm99o2tRqfGH+aKxehqNE+AU3hlXaJclBn5Y
 wwcO9TldGpDzHsdbKCugCMapOJpW67wTIQS+Z6z5ioMEakf25zfAmxEtptxmp+vQYwpf
 BWEA==
X-Gm-Message-State: ACrzQf0bOLTqU0trXG0+gpt3so8mJmXWfX+D7zSOekA91vyJoZwmKOFX
 NQ5MzKz1ONoJCswX3iV18Ud1b6ILgWzWXu7pP1Aa4KT33EbgQs4LKTVOSOlXwCo7b2uXztaVGPS
 qxGkUw8JfK6v3hxMQgoPioTvSICzBQ3ypjzQbXVlu1rynLXc5D2WelKkK
X-Google-Smtp-Source: AMsMyM72noztDXSefe91AnL7jOOaz8XYRCdaZp9VQgqmKmRmyyqyhQt6+shGEt/MJK2Bpjw4hdyt5CNY/qc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1747:b0:55c:b475:5f74 with SMTP id
 j7-20020a056a00174700b0055cb4755f74mr22179046pfc.68.1664907684511; Tue, 04
 Oct 2022 11:21:24 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:37 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-7-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/9] mmapstress01: refactor cleanup and drop
 leavefile option
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/mem/mmapstress/mmapstress01.c      | 84 ++++++-------------
 1 file changed, 25 insertions(+), 59 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 165db2b81..7e8226700 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -89,11 +89,9 @@
 static unsigned int initrand(void);
 static void finish(int sig);
 static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
-static int fileokay(char *file, unsigned char *expbuf);
-static int finished;
+static void fileokay(char *file, unsigned char *expbuf);
 
 static char *debug;
-static char *leavefile;
 static char *do_sync;
 static char *do_offset;
 static char *randloops;
@@ -102,21 +100,17 @@ static char *opt_nprocs;
 static char *opt_sparseoffset;
 static char *opt_alarmtime;
 
+static int fd;
 static float alarmtime;
 static int nprocs;
 static long long filesize = FILESIZE;
 static long long sparseoffset;
 static unsigned int pattern;
-
-static pid_t *pidarray;
-static int wait_stat;
-static int check_for_sanity;
-static unsigned char *buf;
+static int finished;
 
 static struct tst_option options[] = {
 	{"d", &debug, "Enable debug output"},
 	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
-	{"l", &leavefile, "Don't remove the output file on program exit"},
 	{"m", &do_sync, "Do random msync/fsyncs as well"},
 	{"o", &do_offset, "Randomize the offset of file to map"},
 	{"p:", &opt_nprocs, "Number of mapping children to create (required)"},
@@ -175,7 +169,6 @@ static void setup(void)
 
 static void run(void)
 {
-	int fd;
 	int c;
 	int procno;
 	pid_t pid;
@@ -187,6 +180,9 @@ static void run(void)
 	unsigned char data;
 	off_t bytes_left;
 	sigset_t set_mask;
+	pid_t *pidarray = NULL;
+	int wait_stat;
+	unsigned char *buf;
 
 	seed = initrand();
 	pattern = seed & 0xff;
@@ -298,40 +294,22 @@ static void run(void)
 		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
 	}
 
-	/*
-	 *  Finished!  Check the file for sanity, then kill all
-	 *  the children and done!.
-	 */
-
 	SAFE_SIGEMPTYSET(&set_mask);
 	SAFE_SIGADDSET(&set_mask, SIGALRM);
 	SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
 	(void)alarm(0);
-	check_for_sanity = 1;
-	tst_res(TPASS, "finished, cleaning up");
+
+	/*
+	 *  Finished!  Check the file for sanity.
+	 */
+	fileokay(TEST_FILE, buf);
+	tst_res(TPASS, "file has expected data");
 }
 
 static void cleanup(void)
 {
-	for (int i = 0; i < nprocs; i++)
-		(void)kill(pidarray[i], SIGKILL);
-
-	while (wait(&wait_stat) != -1 || errno != ECHILD)
-		continue;
-
-	if (check_for_sanity) {		/* only check file if no errors */
-		if (!fileokay(TEST_FILE, buf)) {
-			tst_res(TINFO, "  leaving file <%s>", TEST_FILE);
-			tst_brk(TFAIL, "file data incorrect");
-		} else {
-			tst_res(TINFO, "file data okay");
-			if (!leavefile)
-				SAFE_UNLINK(TEST_FILE);
-			tst_res(TPASS, "test passed");
-		}
-	} else {
-		tst_res(TINFO, "  leaving file <%s>", TEST_FILE);
-	}
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 /*
@@ -341,7 +319,7 @@ static void cleanup(void)
  *  determined based on nprocs & procno).  After a specific number of
  *  iterations, it exits.
  */
-void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
+static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 {
 	struct stat statbuf;
 	off_t filesize;
@@ -349,7 +327,6 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	size_t validsize;
 	size_t mapsize;
 	char *maddr = NULL, *paddr;
-	int fd;
 	size_t pagesize = sysconf(_SC_PAGE_SIZE);
 	unsigned int randpage;
 	unsigned int seed;
@@ -432,14 +409,13 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 /*
  *  Make sure file has all the correct data.
  */
-int fileokay(char *file, unsigned char *expbuf)
+static void fileokay(char *file, unsigned char *expbuf)
 {
 	struct stat statbuf;
 	size_t mapsize;
 	unsigned int mappages;
 	unsigned int pagesize = sysconf(_SC_PAGE_SIZE);
 	unsigned char readbuf[pagesize];
-	int fd;
 	int cnt;
 	unsigned int i, j;
 
@@ -455,45 +431,35 @@ int fileokay(char *file, unsigned char *expbuf)
 	mappages = roundup(mapsize, pagesize) / pagesize;
 
 	for (i = 0; i < mappages; i++) {
-		cnt = read(fd, readbuf, pagesize);
-		if (cnt == -1) {
-			tst_brk(TFAIL, "read error");
-		} else if ((unsigned int)cnt != pagesize) {
+		cnt = SAFE_READ(0, fd, readbuf, pagesize);
+		if ((unsigned int)cnt != pagesize) {
 			/*
 			 *  Okay if at last page in file...
 			 */
-			if ((i * pagesize) + cnt != mapsize) {
-				tst_res(TINFO, "read %d of %ld bytes",
+			if ((i * pagesize) + cnt != mapsize)
+				tst_brk(TFAIL, "missing data: read %d of %ld bytes",
 					(i * pagesize) + cnt, (long)mapsize);
-				SAFE_CLOSE(fd);
-				return 0;
-			}
 		}
 		/*
 		 *  Compare read bytes of data.
 		 */
 		for (j = 0; j < (unsigned int)cnt; j++) {
-			if (expbuf[j] != readbuf[j]) {
-				tst_res(TINFO,
+			if (expbuf[j] != readbuf[j])
+				tst_brk(TFAIL,
 					"read bad data: exp %c got %c, pg %d off %d, (fsize %lld)",
 					expbuf[j], readbuf[j], i, j,
 					(long long)statbuf.st_size);
-				SAFE_CLOSE(fd);
-				return 0;
-			}
 		}
 	}
 	SAFE_CLOSE(fd);
-
-	return 1;
 }
 
-void finish(int sig LTP_ATTRIBUTE_UNUSED)
+static void finish(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	finished++;
 }
 
-unsigned int initrand(void)
+static unsigned int initrand(void)
 {
 	unsigned int seed;
 
@@ -514,9 +480,9 @@ unsigned int initrand(void)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.test_all = run,
 	.setup = setup,
 	.options = options,
 	.cleanup = cleanup,
+	.needs_tmpdir = 1,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
