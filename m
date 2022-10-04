Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE99C433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:22:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F82E3CADE5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:22:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4123CADED
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:21 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E449D60102D
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:20 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 k16-20020a635a50000000b0042986056df6so9195329pgm.2
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=TpAq1FJgLzCpDNuNMLe27DIFR8s55ID621h0FFV8EhY=;
 b=FrghoM1gGCGzzGicmev+q5FxM0jT/Gz+aspr7s9NzQWXmNUwQHcRQRPXG5tuQL1ePK
 zAmo14rfb4af7wqXWXko4Ao0majUngz4qLjYBXoMtuBmPY1nh5sGAOfkXxzZ5LQvACIb
 yQ9WO6071V2BpkRpIcxfMo0Rs5dX63FqEDcEkEF9tqNPj6lM/20cF/SWZp8pgyLSVIUV
 y1O7caBJBHe138Ne23Ab6xp1/JPz5mT2Vj12QlqSfETYIj00YTb/E14FSIDYdijghle3
 Svel7WK+TGm56ose8YESjAZ90n+jJMux9fVw4jmsmu0tp0vtXCiz/uUkBEK3kAtsJwJi
 G58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=TpAq1FJgLzCpDNuNMLe27DIFR8s55ID621h0FFV8EhY=;
 b=OOTbrG9l7NGNmHB/zNZQqXvfopOQorSOeP73QdIBl8bEcFnCWjZHG+0jBTt8nPKWMq
 dek+zZwFDYuskcMwnkOpJjgmRxnOOnFUTQLEZLQIBZD1m2H3Yp0Lw7adHH7D/dQsMLYb
 776Qe9Ryqn4U9Hr9luehKoUwsbzLDXrLhPp+48KelXAuuE/Rg1UJk6twPiMjXPC40ecU
 O6HNYL/E+ap/cgpNI92p56fqIN3O1l0eizQ7WRA+zts1vdD/v/yTVfEzHz71w9sFXIde
 dVmpmYGdQr/iUAYYh8PKmGbzLZtuwxN7v/Z1SSm0sT70+bS2a8Jm10cD3Wq0GzLdNn2O
 qPtA==
X-Gm-Message-State: ACrzQf05eqcrN9KxGsri59azzV2NFmNoNH5rwnngZSoDTtnCi9Ma/MO+
 s6JWoXMtFJ54+r4f9E7KPYVYTDZzQn3xChoPT8DxGRL//NqizeTnAxJvWhAw5z4VxFfFS7Yzi+2
 lEw3SfWlI2hnMmw/5rQGpXIr/g/+/X6QP7Ndh1udKjhEEC+9ih6tp/M6c
X-Google-Smtp-Source: AMsMyM7sR6O3nK7ZWjisKOAJHeaPS1Vd5rqOTN7WjFcRcV38XdlcaX7Jnkai4//KV+8OMaYNycgYOFKAE8I=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:aa7:88d0:0:b0:542:d98d:bf1f with SMTP id
 k16-20020aa788d0000000b00542d98dbf1fmr28689357pff.78.1664907679369; Tue, 04
 Oct 2022 11:21:19 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:34 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/9] mmapstress01: refactor options
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 195 ++++++++----------
 1 file changed, 90 insertions(+), 105 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 20574314b..33213a0f0 100644
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
@@ -86,49 +86,103 @@
 #endif
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
 
-static char *usage =
-	"-p nprocs [-t minutes -f filesize -S sparseoffset -r -o -m -l -d]";
-
 static unsigned int initrand(void);
 static void finish(int sig);
 static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
 static int fileokay(char *file, unsigned char *expbuf);
 static int finished;
-static int leavefile;
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
 
 static float alarmtime;
-static unsigned int nprocs;
+static int nprocs;
+static long long filesize = FILESIZE;
+static long long sparseoffset;
+static unsigned int pattern;
 
 static pid_t *pidarray;
 static int wait_stat;
 static int check_for_sanity;
 static unsigned char *buf;
 
-static int debug;
+static struct tst_option options[] = {
+	{"d", &debug, "Enable debug output"},
+	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
+	{"l", &leavefile, "Don't remove the output file on program exit"},
+	{"m", &do_sync, "Do random msync/fsyncs as well"},
+	{"o", &do_offset, "Randomize the offset of file to map"},
+	{"p:", &opt_nprocs, "Number of mapping children to create (required)"},
+	{"r", &randloops,
+	 "Randomize number of pages map children check (random % MAXLOOPS), "
+	 "otherwise each child checks MAXLOOPS pages"},
+	{"S:", &opt_sparseoffset,
+	 "When non-zero, causes the sparse area to be left before the data, "
+	 "so that the actual initial filesize is sparseoffset + filesize "
+	 "(default 0)"},
+	{"t:", &opt_alarmtime, "Number of minutes to run (default 0)"},
+	{},
+};
+
+static void setup(void)
+{
+	int pagesize = sysconf(_SC_PAGE_SIZE);
+
+	if (!opt_nprocs)
+		tst_brk(TBROK,
+			"missing number of mapping children, specify with -p nprocs");
+
 #ifdef LARGE_FILE
-static off64_t filesize = FILESIZE;
-static off64_t sparseoffset;
-#else /* LARGE_FILE */
-static off_t filesize = FILESIZE;
-static off_t sparseoffset;
-#endif /* LARGE_FILE */
-static unsigned int randloops;
-static unsigned int dosync;
-static unsigned int do_offset;
-static unsigned int pattern;
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
 
-int main(int argc, char *argv[])
+	if (tst_parse_int(opt_nprocs, &nprocs, 0, 255))
+		tst_brk(TBROK, "invalid number of mapping children '%s'",
+			opt_nprocs);
+
+	if (tst_parse_float(opt_alarmtime, &alarmtime, 0, FLT_MAX / 60))
+		tst_brk(TBROK, "invalid minutes to run '%s'", opt_alarmtime);
+
+	if (debug) {
+		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
+			TEST_FILE, filesize, pattern);
+		if (alarmtime)
+			tst_res(TINFO, "running for %f minutes", alarmtime);
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
@@ -137,81 +191,9 @@ int main(int argc, char *argv[])
 	off_t bytes_left;
 #endif /* LARGE_FILE */
 
-	progname = *argv;
-	if (argc < 2)
-		tst_brk(TBROK, "usage: %s %s", progname, usage);
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
-				tst_brk(TBROK,
-					"sparseoffset must be pagesize multiple");
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
-		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
-			TEST_FILE, filesize, pattern);
-#else /* LARGE_FILE */
-		tst_res(TINFO, "creating file <%s> with %ld bytes, pattern %d",
-			TEST_FILE, filesize, pattern);
-#endif /* LARGE_FILE */
-		if (alarmtime)
-			tst_res(TINFO, "running for %f minutes",
-				alarmtime / 60);
-		else
-			tst_res(TINFO, "running with no time limit");
-	}
-
-	tst_reinit();
-
 	/*
 	 *  Plan for death by signal.  User may have specified
 	 *  a time limit, in which set an alarm and catch SIGALRM.
@@ -289,7 +271,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 0:
-			child_mapper(TEST_FILE, procno, nprocs);
+			child_mapper(TEST_FILE, (unsigned int)procno, (unsigned int)nprocs);
 			exit(0);
 
 		default:
@@ -330,7 +312,7 @@ int main(int argc, char *argv[])
 				pidarray[i] = 0;
 				tst_brk(TFAIL, "fork error");
 			} else if (pid == 0) {	/* child */
-				child_mapper(TEST_FILE, i, nprocs);
+				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
 				exit(0);
 			} else {
 				pidarray[i] = pid;
@@ -447,14 +429,14 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
 	if (debug)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
-			procno, getpid(), seed, filesize, (long)mapsize,
-			offset / pagesize, nloops);
+			procno, getpid(), seed, (long long)filesize,
+			(long)mapsize, (long long)offset / pagesize, nloops);
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
 
@@ -486,7 +468,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			*(paddr + i) = (procno + pattern) & 0xff;
 		}
 	}
-	if (dosync) {
+	if (do_sync) {
 		/*
 		 * Exercise msync() as well!
 		 */
@@ -569,11 +551,11 @@ int fileokay(char *file, unsigned char *expbuf)
 				tst_res(TINFO, "read bad data: exp %c got %c)",
 					expbuf[j], readbuf[j]);
 #ifdef LARGE_FILE
-				tst_res(TINFO, ", pg %d off %d, "
-					"(fsize %lld)", i, j, statbuf.st_size);
+				tst_res(TINFO, ", pg %d off %d, (fsize %lld)",
+					i, j, statbuf.st_size);
 #else /* LARGE_FILE */
-				tst_res(TINFO, ", pg %d off %d, "
-					"(fsize %ld)", i, j, statbuf.st_size);
+				tst_res(TINFO, ", pg %d off %d, (fsize %ld)",
+					i, j, statbuf.st_size);
 #endif /* LARGE_FILE */
 				close(fd);
 				return 0;
@@ -612,5 +594,8 @@ unsigned int initrand(void)
 
 static struct tst_test test = {
 	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.options = options,
 	.cleanup = cleanup,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
