Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC62C32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 18:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C79833CADDE
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 20:27:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F41DD3CAE00
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:44 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E24561400BFD
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:43 +0200 (CEST)
Received: by mail-pf1-x449.google.com with SMTP id
 be18-20020a056a001f1200b00543d4bac885so4472195pfb.13
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=EPEBjE0Dg+WclKiHPTqvTsnLillyI7gDlBikDgui+B8=;
 b=tbLV+Q4A1JK6W3iaSU1wEfDFWeMWAefUqKDboQ60LJKVC5hMKR0OsumXLEaa0tBEA7
 CiC3zQVpZw47ewkNIdtaVChS8w/8Ip6Tt2RFuuaGNNrBlhojXyV1k5I1svT7WwgA3xQF
 NeJRXwti/FcOe4qwJwmLcVPpzxXgn/DRfTJSQyHpsxoB38FUkj/CjC5QNB+7gwjWvMhG
 mHVB9V6KbD282ZrTswlrtChgWplzoOgol5CoLJxxvKdNkEuRoBWbEpFL0Wi1CGRHeSnH
 QdFXaaAMbXlqsZ2J49Zv3AW+r5DcawrmEoFmN+VnS9PaWJxtdlwvcuGqDH+o5pCO1f7v
 0igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=EPEBjE0Dg+WclKiHPTqvTsnLillyI7gDlBikDgui+B8=;
 b=klTjbGYC6lvwRw/Ng7vtSAsQQz74WrIeq6YFNn3W9yskM15I/zuMeClhEOMQ9+7mHz
 WwQyShsBBoag9ayrqnbqY3q+KWZkC1CPO9DfwnjD1l4Lf7HDLMgpAr0wa7/BueyPK336
 gMSrqFHKFx/bn/hQvrBPKSlLF5uB6MjqIrSaB1D7ROoAkoHeMp/LwaFcwKpQpSHNGa3Z
 O8JE6GIrQQmW0FJXeI9jsQYWFY1EDL7v51QEGv7CyR5VrM0WKzBdAGzZqgwUVnPqTuwH
 6p+LfFJEDVSUAExk2ahxZESlEJlbk7f6dmc1hcg2OxU3AsKn5qPWHw2l5SmIAbnjqovq
 kybQ==
X-Gm-Message-State: ACrzQf3uXmDJZJaBoCD2x814L8mwHs1ZDLySoucKM49s1jO2TzbmXO/O
 NbD2/ucVif4PGaNTuyEmgxZ4pirBQx9RX7XY/kOY1DCgUbzD6b9m/ePwErWZEBRAXCZlWEG+taG
 PCT7kiKX/y8IkQKsBndfEL2V55pZJJ4DbOh7sKraHfChBwwET2XGitkI8
X-Google-Smtp-Source: AMsMyM6P7g90gz2jPUB1eMeL2mpCd+K+P6/Kxjhoa5iax/3C5w1Vhjqgu+gSPtkY1kjfKt350m9eRDoVt2w=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr2119pju.0.1664216801642; Mon, 26 Sep
 2022 11:26:41 -0700 (PDT)
Date: Mon, 26 Sep 2022 18:26:23 +0000
In-Reply-To: <20220926182625.103275-1-edliaw@google.com>
Mime-Version: 1.0
References: <20220926182625.103275-1-edliaw@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926182625.103275-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/4] mmapstress01: refactor options
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 180 ++++++++----------
 1 file changed, 78 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 23e4f5bc8..aad4ba942 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -74,7 +74,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <limits.h>
-#define TST_NO_DEFAULT_MAIN
+#include <float.h>
 #include "tst_test.h"
 
 #define MAXLOOPS	500	/* max pages for map children to write */
@@ -93,52 +93,97 @@ extern long lrand48(void);
 extern void srand(unsigned int);
 extern void srand48(long);
 extern int rand(void);
-extern int atoi(const char *);
-
-static char *usage =
-    "-p nprocs [-t minutes -f filesize -S sparseoffset -r -o -m -l -d]";
 
 static unsigned int initrand(void);
 static void finish(int sig);
 static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
 static int fileokay(char *file, unsigned char *expbuf);
 static int finished = 0;
-static int leavefile = 0;
+
+static char *debug;
+static char *leavefile;
+static char *do_sync;
+static char *do_offset;
+static char *randloops;
+static char *opt_filesize;
+static char *opt_nprocs;
+static char *opt_sparseoffset;
+static char *opt_alarmtime;
 
 static float alarmtime = 0;
-static unsigned int nprocs = 0;
+static int nprocs = 0;
+static long long filesize = FILESIZE;
+static long long sparseoffset = 0;
+static unsigned int pattern = 0;
 
 static pid_t *pidarray = NULL;
 static int wait_stat;
 static int check_for_sanity;
 static unsigned char *buf = NULL;
 
+static struct tst_option options[] = {
+	{"d", &debug, "Enable debug output"},
+	{"l", &leavefile, "Don't remove the output file on program exit"},
+	{"m", &do_sync, "Do random msync/fsyncs as well"},
+	{"o", &do_offset, "Randomize the offset of file to map"},
+	{"r", &randloops, "Randomize number of pages map children check (random % MAXLOOPS), otherwise each child checks MAXLOOPS pages"},
+	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
+	{"p:", &opt_nprocs, "Number of mapping children to create (required)"},
+	{"S:", &opt_sparseoffset, "When non-zero, causes the sparse area to be left before the data, so that the actual initial filesize is sparseoffset + filesize (default 0)"},
+	{"t:", &opt_alarmtime, "Number of minutes to run (default 0)"},
+};
+
+static void setup(void)
+{
+	int pagesize = sysconf(_SC_PAGE_SIZE);
+
+	if (!opt_nprocs)
+		tst_brk(TBROK, "missing number of mapping children, specify with -p nprocs");
 
-static int debug = 0;
 #ifdef LARGE_FILE
-static off64_t filesize = FILESIZE;
-static off64_t sparseoffset = 0;
-#else /* LARGE_FILE */
-static off_t filesize = FILESIZE;
-static off_t sparseoffset = 0;
-#endif /* LARGE_FILE */
-static unsigned int randloops = 0;
-static unsigned int dosync = 0;
-static unsigned int do_offset = 0;
-static unsigned int pattern = 0;
+	if (tst_parse_filesize(opt_filesize, &filesize, 0, LONG_MAX))
+#else
+	if (tst_parse_filesize(opt_filesize, &filesize, 0, INT_MAX))
+#endif
+		tst_brk(TBROK, "invalid initial filesize '%s'", opt_filesize);
+
+#ifdef LARGE_FILE
+	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, LONG_MIN, LONG_MAX))
+#else
+	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, INT_MIN, INT_MAX))
+#endif
+		tst_brk(TBROK, "invalid sparse offset '%s'", opt_sparseoffset);
+	if (sparseoffset % pagesize != 0)
+		tst_brk(TBROK, "sparseoffset must be pagesize multiple");
+
+	if (tst_parse_int(opt_nprocs, &nprocs, 0, 255))
+		tst_brk(TBROK, "invalid number of mapping children '%s'", opt_nprocs);
 
-int main(int argc, char *argv[])
+	if (tst_parse_float(opt_alarmtime, &alarmtime, 0, FLT_MAX / 60))
+		tst_brk(TBROK, "invalid minutes to run '%s'", opt_alarmtime);
+
+	if (debug) {
+		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
+			     TEST_FILE, filesize, pattern);
+		if (alarmtime)
+			tst_res(TINFO, "running for %f minutes",
+				     alarmtime);
+		else
+			tst_res(TINFO, "running with no time limit");
+	}
+	alarmtime *= 60;
+}
+
+static void run(void)
 {
-	char *progname;
 	int fd;
 	int c;
-	extern char *optarg;
-	unsigned int procno;
+	int procno;
 	pid_t pid;
 	unsigned int seed;
 	int pagesize = sysconf(_SC_PAGE_SIZE);
 	struct sigaction sa;
-	unsigned int i;
+	int i;
 	int write_cnt;
 	unsigned char data;
 #ifdef LARGE_FILE
@@ -147,81 +192,9 @@ int main(int argc, char *argv[])
 	off_t bytes_left;
 #endif /* LARGE_FILE */
 
-	progname = *argv;
-	if (argc < 2) {
-		tst_brk(TBROK, "usage: %s %s", progname, usage);
-	}
-
-	while ((c = getopt(argc, argv, "S:omdlrf:p:t:")) != -1) {
-		switch (c) {
-		case 'd':
-			debug = 1;
-			break;
-		case 't':
-			alarmtime = atof(optarg) * 60;
-			break;
-		case 'p':
-			nprocs = atoi(optarg);
-			break;
-		case 'l':
-			leavefile = 1;
-			break;
-		case 'f':
-#ifdef LARGE_FILE
-			filesize = atoll(optarg);
-#else /* LARGE_FILE */
-			filesize = atoi(optarg);
-#endif /* LARGE_FILE */
-			if (filesize < 0)
-				tst_brk(TBROK, "error: negative filesize");
-			break;
-		case 'r':
-			randloops = 1;
-			break;
-		case 'm':
-			dosync = 1;
-			break;
-		case 'o':
-			do_offset = 1;
-			break;
-		case 'S':
-#ifdef LARGE_FILE
-			sparseoffset = atoll(optarg);
-#else /* LARGE_FILE */
-			sparseoffset = atoi(optarg);
-#endif /* LARGE_FILE */
-			if (sparseoffset % pagesize != 0)
-				tst_brk(TBROK, "sparseoffset must be pagesize multiple");
-			break;
-		default:
-			tst_brk(TBROK, "usage: %s %s", progname, usage);
-		}
-	}
-
-	/* nprocs is >= 0 since it's unsigned */
-	if (nprocs > 255)
-		tst_brk(TBROK, "invalid nprocs %d - (range 0-255)", nprocs);
-
 	seed = initrand();
 	pattern = seed & 0xff;
 
-	if (debug) {
-#ifdef LARGE_FILE
-		tst_res(TINFO, "creating file <%s> with %Ld bytes, pattern %d",
-			     TEST_FILE, filesize, pattern);
-#else /* LARGE_FILE */
-		tst_res(TINFO, "creating file <%s> with %ld bytes, pattern %d",
-			     TEST_FILE, filesize, pattern);
-#endif /* LARGE_FILE */
-		if (alarmtime)
-			tst_res(TINFO, "running for %f minutes",
-				     alarmtime / 60);
-		else
-			tst_res(TINFO, "running with no time limit");
-	}
-
-	tst_reinit();
-
 	/*
 	 *  Plan for death by signal.  User may have specified
 	 *  a time limit, in which set an alarm and catch SIGALRM.
@@ -300,7 +273,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 0:
-			child_mapper(TEST_FILE, procno, nprocs);
+			child_mapper(TEST_FILE, (unsigned int)procno, (unsigned int)nprocs);
 			exit(0);
 
 		default:
@@ -338,7 +311,7 @@ int main(int argc, char *argv[])
 				pidarray[i] = 0;
 				tst_brk(TFAIL, "fork error");
 			} else if (pid == 0) {	/* child */
-				child_mapper(TEST_FILE, i, nprocs);
+				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
 				exit(0);
 			} else
 				pidarray[i] = pid;
@@ -453,14 +426,14 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	if (debug)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, "
 			     "mapsize %ld, off %lld, loop %d",
-			     procno, getpid(), seed, filesize, (long)mapsize,
-			     offset / pagesize, nloops);
+			     procno, getpid(), seed, (long long)filesize, (long)mapsize,
+			     (long long)offset / pagesize, nloops);
 #ifdef LARGE_FILE
 	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			    fd, (off64_t)offset)) == (caddr_t) - 1)
+			    fd, offset)) == (caddr_t) - 1)
 #else /* LARGE_FILE */
 	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			  fd, (off_t)offset)) == (caddr_t) - 1)
+			  fd, offset)) == (caddr_t) - 1)
 #endif /* LARGE_FILE */
 		tst_brk(TFAIL, "mmap error");
 
@@ -492,7 +465,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			*(paddr + i) = (procno + pattern) & 0xff;
 		}
 	}
-	if (dosync) {
+	if (do_sync) {
 		/*
 		 * Exercise msync() as well!
 		 */
@@ -623,5 +596,8 @@ unsigned int initrand(void)
 
 static struct tst_test test = {
 	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.options = options,
 	.cleanup = cleanup,
 };
-- 
2.37.3.998.g577e59143f-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
