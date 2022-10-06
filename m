Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F4FC433FE
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 18:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 039C13CAE0E
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 20:42:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024F73CAE1B
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:36 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B74B8601BD1
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:35 +0200 (CEST)
Received: by mail-pf1-x449.google.com with SMTP id
 24-20020aa79118000000b00561ed88c3b9so1559548pfh.7
 for <ltp@lists.linux.it>; Thu, 06 Oct 2022 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+77CiiZaK4+694Jqg306mNSckGtCDMbwZQiaLGz1cU=;
 b=o+guYxtPOF3GbUVqcFD7mJBN1Gx/Y7H2YL37mihKL4mlrsa75NkqBS/H6DNvp+JFfJ
 PJ0bWULxM9SR5pB6CHNOPv7Jz4FN7jKfto5xth7CicOxp7eCCv1JnBzB1uYA5vojA16B
 1lvoMOwWZ/p8x9Y476WpBzsbWCD/kAX+tt0mcwG8stu25xRGbkJYIYumhvocTIs4+q43
 XiXKEgbwb++h1qpFsZ7N5LXA++kJlwkWVs8wb8vjyp4/TVHYNfD3Svl4CAi9WSfjIG+a
 TpHijzR0QoQm/kmD+6XZneLr0BxKEzEdSoxzHPFAgd+6OWw3Lga8ak1OF2jXsoljDzKy
 nZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+77CiiZaK4+694Jqg306mNSckGtCDMbwZQiaLGz1cU=;
 b=wIc3QPsCyN1QcL2oWTb7fFskmsNgxMzdEgSZ8ciGIF6V7h+4W/IYgnwaSAB72wUQod
 7yFMlNTQGM2CzQdBauSioNk1oDzpXsAKhhvmr+5JgVPAJzIyUfBUdHFoXM9AW95CHhJL
 jUH/Cu1skVMBKdmgBcebPpbaOAphAEkiyA+47NmpbfBykTdqnByl6w29qR/HwUzRnHg9
 HyG4d/W9xjZDYLB0cdd5apThB+F6MWI9d+O7U80j5hUUGrdHdCKgDt3xklq3mLm+aMIX
 53dyF2xr91BjUwpAKxbcoZxafjS95bOxXdzBCSxYmjbFAxlXZrCHCuhzgSYDwZtChD80
 8TLw==
X-Gm-Message-State: ACrzQf34SILkaPeCuMcJPIzcMfhIFzEKxxGbMnNwHmnzR2XwWNWCZ72I
 OJBBf+HlaezhfyI6hOu1WoHQEvYshlPcR+K1Rc6m40wga7kj691OMtIRX6Bly+HLMBfSFz6d+vJ
 AM54WQoQSbRNxcgxMSj09CE5Weg4AoRitpzqBSbbO9Zh8NQM41NDGDWCU
X-Google-Smtp-Source: AMsMyM5JBFqITBVRllMp4aMX+ynjaet+/qJ4zG+uxs6ZmdZVUfV0BUoGYCBYwr/zgaUmUCDpC3Fhk8gsHGw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:cc8:b0:541:5de7:fcd2 with SMTP id
 b8-20020a056a000cc800b005415de7fcd2mr801501pfv.25.1665081753921; Thu, 06 Oct
 2022 11:42:33 -0700 (PDT)
Date: Thu,  6 Oct 2022 18:42:25 +0000
In-Reply-To: <20221006184228.3281392-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221006184228.3281392-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006184228.3281392-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] mmapstress01: refactor to tst_test framework
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

Use ltp framework and apply make check corrections.  Reorder functions
and variables.  Use safe macros.
Drop leavefile option.
Build tests with FILE_OFFSET_BITS=64 instead of doing LARGE_FILE checks
to switch between 32 and 64 bit types and syscalls.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/mem/mmapstress/Makefile      |   2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 845 ++++++------------
 2 files changed, 289 insertions(+), 558 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/Makefile b/testcases/kernel/mem/mmapstress/Makefile
index 744f099d8..b30bd34b8 100644
--- a/testcases/kernel/mem/mmapstress/Makefile
+++ b/testcases/kernel/mem/mmapstress/Makefile
@@ -5,3 +5,5 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+mmapstress01: CFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index f425c223d..f68193706 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -1,51 +1,10 @@
-/* IBM Corporation */
-/* 01/02/2003	Port to LTP avenkat@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2003
- *
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2003
+ * 01/02/2003	Port to LTP avenkat@us.ibm.com
+ * 06/30/2001	Port to Linux	nsharoff@us.ibm.com
+ * 10/03/2022	Refactor to LTP framework	edliaw@google.com
  */
-
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <limits.h>
-/*****  LTP Port        *****/
-#include "test.h"
-#define FAILED 0
-#define PASSED 1
-
-int local_flag = PASSED;
-char *TCID = "mmapstress01";	//tmnoextend
-FILE *temp;
-int TST_TOTAL = 1;
-
-int anyfail();
-void ok_exit();
-/*****  **      **      *****/
-
 /*
  *  This test stresses mmaps, without dealing with fragments or anything!
  *  It forks a specified number of children,
@@ -88,363 +47,116 @@ void ok_exit();
  *  Compile with -DLARGE_FILE to enable file sizes > 2 GB.
  */
 
+#define _GNU_SOURCE 1
+#include <stdio.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <limits.h>
+#include <float.h>
+#include "tst_test.h"
+
 #define MAXLOOPS	500	/* max pages for map children to write */
 #define	FILESIZE	4096	/* initial filesize set up by parent */
+#define TEST_FILE	"mmapstress01.out"
 
 #ifdef roundup
 #undef roundup
 #endif
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
 
-extern time_t time(time_t *);
-extern char *ctime(const time_t *);
-extern void *malloc(size_t);
-extern long lrand48(void);
-extern void srand(unsigned);
-extern void srand48(long);
-extern int rand(void);
-extern int atoi(const char *);
-
-char *usage =
-    "-p nprocs [-t minutes -f filesize -S sparseoffset -r -o -m -l -d]";
-
-typedef unsigned char uchar_t;
-#define SIZE_MAX UINT_MAX
-
-unsigned int initrand(void);
-void finish(int sig);
-void child_mapper(char *file, unsigned procno, unsigned nprocs);
-int fileokay(char *file, uchar_t * expbuf);
-int finished = 0;
-int leavefile = 0;
-
-int debug = 0;
-#ifdef LARGE_FILE
-off64_t filesize = FILESIZE;
-off64_t sparseoffset = 0;
-#else /* LARGE_FILE */
-off_t filesize = FILESIZE;
-off_t sparseoffset = 0;
-#endif /* LARGE_FILE */
-unsigned randloops = 0;
-unsigned dosync = 0;
-unsigned do_offset = 0;
-unsigned pattern = 0;
-
-int main(int argc, char *argv[])
+static unsigned int initrand(void);
+static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
+static void fileokay(char *file, unsigned char *expbuf);
+static void sighandler(int sig);
+
+static char *debug;
+static char *do_sync;
+static char *do_offset;
+static char *opt_alarmtime;
+static char *opt_filesize;
+static char *opt_nprocs;
+static char *opt_sparseoffset;
+static char *randloops;
+
+static int fd;
+static int finished;
+static int nprocs;
+static float alarmtime;
+static long long filesize = FILESIZE;
+static long long sparseoffset;
+static size_t pagesize;
+static unsigned int pattern;
+
+static struct tst_option options[] = {
+	{"d", &debug, "Enable debug output"},
+	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
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
 {
-	char *progname;
-	int fd;
-	int c;
-	extern char *optarg;
-	unsigned nprocs = 0;
-	unsigned procno;
-	pid_t *pidarray = NULL;
-	pid_t pid;
-	uchar_t *buf = NULL;
-	unsigned int seed;
 	int pagesize = sysconf(_SC_PAGE_SIZE);
-	float alarmtime = 0;
-	struct sigaction sa;
-	unsigned i;
-	int write_cnt;
-	uchar_t data;
-	int no_prob = 0;
-	int wait_stat;
-	time_t t;
-#ifdef LARGE_FILE
-	off64_t bytes_left;
-#else /* LARGE_FILE */
-	off_t bytes_left;
-#endif /* LARGE_FILE */
-	const char *filename = "mmapstress01.out";
 
-	progname = *argv;
-	tst_tmpdir();
-	if (argc < 2) {
-		tst_brkm(TBROK, NULL, "usage: %s %s", progname, usage);
-	}
+	if (!opt_nprocs)
+		tst_brk(TBROK,
+			"missing number of mapping children, specify with -p nprocs");
 
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
-			if (filesize < 0) {
-				(void)fprintf(stderr, "error: negative "
-					      "filesize\n");
-				anyfail();
-			}
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
-			if (sparseoffset % pagesize != 0) {
-				fprintf(stderr,
-					"sparseoffset must be pagesize multiple\n");
-				anyfail();
-			}
-			break;
-		default:
-			(void)fprintf(stderr, "usage: %s %s\n", progname,
-				      usage);
-			tst_exit();
-		}
-	}
+#if _FILE_OFFSET_BITS == 64
+	if (tst_parse_filesize(opt_filesize, &filesize, 0, LONG_MAX))
+#else
+	if (tst_parse_filesize(opt_filesize, &filesize, 0, INT_MAX))
+#endif
+		tst_brk(TBROK, "invalid initial filesize '%s'", opt_filesize);
 
-	/* nprocs is >= 0 since it's unsigned */
-	if (nprocs > 255) {
-		(void)fprintf(stderr, "invalid nprocs %d - (range 0-255)\n",
-			      nprocs);
-		anyfail();
-	}
+#if _FILE_OFFSET_BITS == 64
+	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, LONG_MIN, LONG_MAX))
+#else
+	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, INT_MIN, INT_MAX))
+#endif
+		tst_brk(TBROK, "invalid sparse offset '%s'", opt_sparseoffset);
+	if (sparseoffset % pagesize != 0)
+		tst_brk(TBROK, "sparseoffset must be pagesize multiple");
 
-	(void)time(&t);
+	if (tst_parse_int(opt_nprocs, &nprocs, 0, 255))
+		tst_brk(TBROK, "invalid number of mapping children '%s'",
+			opt_nprocs);
 
-	seed = initrand();
-	pattern = seed & 0xff;
+	if (tst_parse_float(opt_alarmtime, &alarmtime, 0, FLT_MAX / 60))
+		tst_brk(TBROK, "invalid minutes to run '%s'", opt_alarmtime);
 
 	if (debug) {
-#ifdef LARGE_FILE
-		(void)printf("creating file <%s> with %Ld bytes, pattern %d\n",
-			     filename, filesize, pattern);
-#else /* LARGE_FILE */
-		(void)printf("creating file <%s> with %ld bytes, pattern %d\n",
-			     filename, filesize, pattern);
-#endif /* LARGE_FILE */
+		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
+			TEST_FILE, filesize, pattern);
 		if (alarmtime)
-			(void)printf("running for %f minutes\n",
-				     alarmtime / 60);
+			tst_res(TINFO, "running for %f minutes", alarmtime);
 		else
-			(void)printf("running with no time limit\n");
-	}
-
-	/*
-	 *  Plan for death by signal.  User may have specified
-	 *  a time limit, in which set an alarm and catch SIGALRM.
-	 *  Also catch and cleanup with SIGINT.
-	 */
-	sa.sa_handler = finish;
-	sa.sa_flags = 0;
-	if (sigemptyset(&sa.sa_mask)) {
-		perror("sigemptyset error");
-		goto cleanup;
-	}
-
-	if (sigaction(SIGINT, &sa, 0) == -1) {
-		perror("sigaction error SIGINT");
-		goto cleanup;
-	}
-	if (sigaction(SIGQUIT, &sa, 0) == -1) {
-		perror("sigaction error SIGQUIT");
-		goto cleanup;
-	}
-	if (sigaction(SIGTERM, &sa, 0) == -1) {
-		perror("sigaction error SIGTERM");
-		goto cleanup;
-	}
-
-	if (alarmtime) {
-		if (sigaction(SIGALRM, &sa, 0) == -1) {
-			perror("sigaction error");
-			goto cleanup;
-		}
-		(void)alarm(alarmtime);
-	}
-#ifdef LARGE_FILE
-	if ((fd = open64(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#else /* LARGE_FILE */
-	if ((fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#endif /* LARGE_FILE */
-		perror("open error");
-		anyfail();
-	}
-
-	if ((buf = malloc(pagesize)) == NULL
-	    || (pidarray = malloc(nprocs * sizeof(pid_t))) == NULL) {
-		perror("malloc error");
-		anyfail();
-	}
-
-	for (i = 0; i < nprocs; i++)
-		*(pidarray + i) = 0;
-
-	for (i = 0, data = 0; i < pagesize; i++) {
-		*(buf + i) = (data + pattern) & 0xff;
-		if (++data == nprocs)
-			data = 0;
-	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
-	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
-		perror("lseek");
-		anyfail();
-	}
-	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-		write_cnt = MIN(pagesize, (int)bytes_left);
-		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
-			if (c == -1) {
-				perror("write error");
-			} else {
-				(void)fprintf(stderr, "write: wrote %d of %d "
-					      "bytes\n", c, write_cnt);
-			}
-			(void)close(fd);
-			(void)unlink(filename);
-			anyfail();
-		}
-	}
-
-	(void)close(fd);
-
-	/*
-	 *  Fork off mmap children.
-	 */
-	for (procno = 0; procno < nprocs; procno++) {
-		switch (pid = fork()) {
-
-		case -1:
-			perror("fork error");
-			goto cleanup;
-
-		case 0:
-			child_mapper(filename, procno, nprocs);
-			exit(0);
-
-		default:
-			pidarray[procno] = pid;
-		}
-	}
-
-	/*
-	 *  Now wait for children and refork them as needed.
-	 */
-
-	while (!finished) {
-		pid = wait(&wait_stat);
-		/*
-		 *  Block signals while processing child exit.
-		 */
-
-		if (sighold(SIGALRM) || sighold(SIGINT)) {
-			perror("sighold error");
-			goto cleanup;
-		}
-
-		if (pid != -1) {
-			/*
-			 *  Check exit status, then refork with the
-			 *  appropriate procno.
-			 */
-			if (!WIFEXITED(wait_stat)
-			    || WEXITSTATUS(wait_stat) != 0) {
-				(void)fprintf(stderr, "child exit with err "
-					      "<x%x>\n", wait_stat);
-				goto cleanup;
-			}
-			for (i = 0; i < nprocs; i++)
-				if (pid == pidarray[i])
-					break;
-			if (i == nprocs) {
-				(void)fprintf(stderr, "unknown child pid %d, "
-					      "<x%x>\n", pid, wait_stat);
-				goto cleanup;
-			}
-
-			if ((pid = fork()) == -1) {
-				perror("fork error");
-				pidarray[i] = 0;
-				goto cleanup;
-			} else if (pid == 0) {	/* child */
-				child_mapper(filename, i, nprocs);
-				exit(0);
-			} else
-				pidarray[i] = pid;
-		} else {
-			/*
-			 *  wait returned an error.  If EINTR, then
-			 *  normal finish, else it's an unexpected
-			 *  error...
-			 */
-			if (errno != EINTR || !finished) {
-				perror("unexpected wait error");
-				goto cleanup;
-			}
-		}
-		if (sigrelse(SIGALRM) || sigrelse(SIGINT)) {
-			perror("sigrelse error");
-			goto cleanup;
-		}
-	}
-
-	/*
-	 *  Finished!  Check the file for sanity, then kill all
-	 *  the children and done!.
-	 */
-
-	if (sighold(SIGALRM)) {
-		perror("sighold error");
-		goto cleanup;
+			tst_res(TINFO, "running with no time limit");
 	}
-	(void)alarm(0);
-	no_prob = 1;
-
-cleanup:
-	for (i = 0; i < nprocs; i++)
-		(void)kill(pidarray[i], SIGKILL);
-
-	while (wait(&wait_stat) != -1 || errno != ECHILD)
-		continue;
-
-	if (no_prob) {		/* only check file if no errors */
-		if (!fileokay(filename, buf)) {
-			(void)fprintf(stderr, "file data incorrect!\n");
-			(void)printf("  leaving file <%s>\n", filename);
-			/***** LTP Port *****/
-			local_flag = FAILED;
-			anyfail();
-			/*****	**	*****/
-		} else {
-			(void)printf("file data okay\n");
-			if (!leavefile)
-				(void)unlink(filename);
-		}
-	} else
-		(void)printf("  leaving file <%s>\n", filename);
+	alarmtime *= 60;
+}
 
-	(void)time(&t);
-	//(void)printf("%s: Finished %s", argv[0], ctime(&t)); LTP Port
-	ok_exit();
-	tst_exit();
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 /*
@@ -454,91 +166,51 @@ cleanup:
  *  determined based on nprocs & procno).  After a specific number of
  *  iterations, it exits.
  */
-void child_mapper(char *file, unsigned procno, unsigned nprocs)
+static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-	off64_t filesize;
-	off64_t offset;
-#else /* LARGE_FILE */
 	struct stat statbuf;
 	off_t filesize;
 	off_t offset;
-#endif /* LARGE_FILE */
 	size_t validsize;
 	size_t mapsize;
 	char *maddr = NULL, *paddr;
-	int fd;
-	size_t pagesize = sysconf(_SC_PAGE_SIZE);
-	unsigned randpage;
+	unsigned int randpage;
 	unsigned int seed;
-	unsigned loopcnt;
-	unsigned nloops;
-	unsigned mappages;
-	unsigned i;
+	unsigned int loopcnt;
+	unsigned int nloops;
+	unsigned int mappages;
+	unsigned int i;
 
 	seed = initrand();	/* initialize random seed */
 
-#ifdef LARGE_FILE
-	if (stat64(file, &statbuf) == -1) {
-#else /* LARGE_FILE */
-	if (stat(file, &statbuf) == -1) {
-#endif /* LARGE_FILE */
-		perror("stat error");
-		anyfail();
-	}
+	SAFE_STAT(file, &statbuf);
 	filesize = statbuf.st_size;
 
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDWR)) == -1) {
-#else /* LARGE_FILE */
-	if ((fd = open(file, O_RDWR)) == -1) {
-#endif /* LARGE_FILE */
-		perror("open error");
-		anyfail();
-	}
+	fd = SAFE_OPEN(file, O_RDWR);
 
-	if (statbuf.st_size - sparseoffset > SIZE_MAX) {
-		fprintf(stderr, "size_t overflow when setting up map\n");
-		anyfail();
-	}
+	if (statbuf.st_size - sparseoffset > UINT_MAX)
+		tst_brk(TFAIL, "size_t overflow when setting up map");
 	mapsize = (size_t) (statbuf.st_size - sparseoffset);
 	mappages = roundup(mapsize, pagesize) / pagesize;
 	offset = sparseoffset;
 	if (do_offset) {
 		int pageoffset = lrand48() % mappages;
 		int byteoffset = pageoffset * pagesize;
+
 		offset += byteoffset;
 		mapsize -= byteoffset;
 		mappages -= pageoffset;
 	}
 	nloops = (randloops) ? (lrand48() % MAXLOOPS) : MAXLOOPS;
 
-	if (debug) {
-#ifdef LARGE_FILE
-		(void)printf("child %d (pid %ld): seed %d, fsize %Ld, "
-			     "mapsize %d, off %Ld, loop %d\n",
-			     procno, getpid(), seed, filesize, mapsize,
-			     offset / pagesize, nloops);
-#else /* LARGE_FILE */
-		(void)printf("child %d (pid %d): seed %d, fsize %ld, "
-			     "mapsize %ld, off %ld, loop %d\n",
-			     procno, getpid(), seed, filesize, (long)mapsize,
-			     offset / pagesize, nloops);
-#endif /* LARGE_FILE */
-	}
-#ifdef LARGE_FILE
-	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			    fd, offset)) == (caddr_t) - 1) {
-#else /* LARGE_FILE */
-	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			  fd, offset)) == (caddr_t) - 1) {
-#endif /* LARGE_FILE */
-		perror("mmap error");
-		anyfail();
-	}
+	if (debug)
+		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
+			procno, getpid(), seed, (long long)filesize,
+			(long)mapsize, (long long)offset / pagesize, nloops);
 
-	(void)close(fd);
+	maddr = SAFE_MMAP(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+			  offset);
+	SAFE_CLOSE(fd);
 
 	/*
 	 *  Now loop read/writing random pages.
@@ -554,15 +226,11 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 
 		for (i = procno; i < validsize; i += nprocs) {
 			if (*((unsigned char *)(paddr + i))
-			    != ((procno + pattern) & 0xff)) {
-				(void)fprintf(stderr, "child %d: invalid data "
-					      "<x%x>", procno,
-					      *((unsigned char *)(paddr + i)));
-				(void)fprintf(stderr, " at pg %d off %d, exp "
-					      "<x%x>\n", randpage, i,
-					      (procno + pattern) & 0xff);
-				anyfail();
-			}
+			    != ((procno + pattern) & 0xff))
+				tst_brk(TFAIL, "child %d: invalid data <x%x>\n"
+					" at pg %d off %d, exp <x%x>", procno,
+					*((unsigned char *)(paddr + i)),
+					randpage, i, (procno + pattern) & 0xff);
 
 			/*
 			 *  Now write it.
@@ -570,139 +238,74 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
 			*(paddr + i) = (procno + pattern) & 0xff;
 		}
 	}
-	if (dosync) {
+	if (do_sync) {
 		/*
 		 * Exercise msync() as well!
 		 */
 		randpage = lrand48() % mappages;
 		paddr = maddr + (randpage * pagesize);	/* page address */
 		if (msync(paddr, (mappages - randpage) * pagesize,
-			  MS_SYNC) == -1) {
-			anyfail();
-		}
-	}
-	if (munmap(maddr, mapsize) == -1) {
-		perror("munmap failed");
-		local_flag = FAILED;
-		anyfail();
+			  MS_SYNC) == -1)
+			tst_brk(TFAIL, "msync failed");
 	}
+	SAFE_MUNMAP(maddr, mapsize);
 	exit(0);
 }
 
 /*
  *  Make sure file has all the correct data.
  */
-int fileokay(char *file, uchar_t * expbuf)
+static void fileokay(char *file, unsigned char *expbuf)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-#else /* LARGE_FILE */
-	struct stat statbuf;
-#endif /* LARGE_FILE */
-	size_t mapsize;
-	unsigned mappages;
-	unsigned pagesize = sysconf(_SC_PAGE_SIZE);
-	uchar_t readbuf[pagesize];
-	int fd;
 	int cnt;
-	unsigned i, j;
-
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDONLY)) == -1) {
-#else /* LARGE_FILE */
-	if ((fd = open(file, O_RDONLY)) == -1) {
-#endif /* LARGE_FILE */
-		perror("open error");
-		/***** LTP Port *****/
-		local_flag = FAILED;
-		anyfail();
-		/*****	**	*****/
-		return 0;
-	}
-#ifdef LARGE_FILE
-	if (fstat64(fd, &statbuf) == -1) {
-#else /* LARGE_FILE */
-	if (fstat(fd, &statbuf) == -1) {
-#endif /* LARGE_FILE */
-		perror("stat error");
-		/***** LTP Port *****/
-		local_flag = FAILED;
-		anyfail();
-		/*****	**	*****/
-		return 0;
-	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
-	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
-		perror("lseek");
-		anyfail();
-	}
+	size_t mapsize;
+	struct stat statbuf;
+	unsigned char readbuf[pagesize];
+	unsigned int i, j;
+	unsigned int mappages;
+	unsigned int pagesize = sysconf(_SC_PAGE_SIZE);
 
-	if (statbuf.st_size - sparseoffset > SIZE_MAX) {
-		fprintf(stderr, "size_t overflow when setting up map\n");
-		anyfail();
-	}
+	fd = SAFE_OPEN(file, O_RDONLY);
+
+	SAFE_FSTAT(fd, &statbuf);
+	SAFE_LSEEK(fd, sparseoffset, SEEK_SET);
+
+	if (statbuf.st_size - sparseoffset > UINT_MAX)
+		tst_brk(TFAIL, "size_t overflow when setting up map");
 	mapsize = (size_t) (statbuf.st_size - sparseoffset);
 
 	mappages = roundup(mapsize, pagesize) / pagesize;
 
 	for (i = 0; i < mappages; i++) {
-		cnt = read(fd, readbuf, pagesize);
-		if (cnt == -1) {
-			perror("read error");
-			/***** LTP Port *****/
-			local_flag = FAILED;
-			anyfail();
-			/*****	**	*****/
-			return 0;
-		} else if (cnt != pagesize) {
+		cnt = SAFE_READ(0, fd, readbuf, pagesize);
+		if ((unsigned int)cnt != pagesize) {
 			/*
 			 *  Okay if at last page in file...
 			 */
-			if ((i * pagesize) + cnt != mapsize) {
-				(void)fprintf(stderr, "read %d of %ld bytes\n",
-					      (i * pagesize) + cnt,
-					      (long)mapsize);
-				close(fd);
-				return 0;
-			}
+			if ((i * pagesize) + cnt != mapsize)
+				tst_brk(TFAIL, "missing data: read %d of %ld bytes",
+					(i * pagesize) + cnt, (long)mapsize);
 		}
 		/*
 		 *  Compare read bytes of data.
 		 */
-		for (j = 0; j < cnt; j++) {
-			if (expbuf[j] != readbuf[j]) {
-				(void)fprintf(stderr,
-					      "read bad data: exp %c got %c)",
-					      expbuf[j], readbuf[j]);
-#ifdef LARGE_FILE
-				(void)fprintf(stderr, ", pg %d off %d, "
-					      "(fsize %Ld)\n", i, j,
-					      statbuf.st_size);
-#else /* LARGE_FILE */
-				(void)fprintf(stderr, ", pg %d off %d, "
-					      "(fsize %ld)\n", i, j,
-					      statbuf.st_size);
-#endif /* LARGE_FILE */
-				close(fd);
-				return 0;
-			}
+		for (j = 0; j < (unsigned int)cnt; j++) {
+			if (expbuf[j] != readbuf[j])
+				tst_brk(TFAIL,
+					"read bad data: exp %c got %c, pg %d off %d, (fsize %lld)",
+					expbuf[j], readbuf[j], i, j,
+					(long long)statbuf.st_size);
 		}
 	}
-	close(fd);
-
-	return 1;
+	SAFE_CLOSE(fd);
 }
 
- /*ARGSUSED*/ void finish(int sig)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	finished++;
-	return;
 }
 
-unsigned int initrand(void)
+static unsigned int initrand(void)
 {
 	unsigned int seed;
 
@@ -718,21 +321,147 @@ unsigned int initrand(void)
 	seed = rand();
 	srand((unsigned int)time(NULL));
 	seed = (seed ^ rand()) % 100000;
-	srand48((long int)seed);
-	return (seed);
+	srand48((long)seed);
+	return seed;
 }
 
-/*****  LTP Port        *****/
-void ok_exit(void)
+static void run(void)
 {
-	tst_resm(TPASS, "Test passed");
-	tst_rmdir();
-	tst_exit();
-}
+	int c;
+	int i;
+	int procno;
+	int wait_stat;
+	off_t bytes_left;
+	pid_t pid;
+	pid_t *pidarray = NULL;
+	sigset_t set_mask;
+	size_t write_cnt;
+	struct sigaction sa;
+	unsigned char data;
+	unsigned char *buf;
+	unsigned int seed;
 
-int anyfail(void)
-{
-	tst_brkm(TFAIL, tst_rmdir, "Test failed");
+	pagesize = sysconf(_SC_PAGE_SIZE);
+	seed = initrand();
+	pattern = seed & 0xff;
+
+	/*
+	 *  Plan for death by signal.  User may have specified
+	 *  a time limit, in which set an alarm and catch SIGALRM.
+	 *  Also catch and cleanup with SIGINT.
+	 */
+	sa.sa_handler = sighandler;
+	sa.sa_flags = 0;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGINT, &sa, 0);
+	SAFE_SIGACTION(SIGQUIT, &sa, 0);
+	SAFE_SIGACTION(SIGTERM, &sa, 0);
+
+	if (alarmtime) {
+		SAFE_SIGACTION(SIGALRM, &sa, 0);
+		(void)alarm(alarmtime);
+	}
+	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
+
+	buf = SAFE_MALLOC(pagesize);
+	pidarray = SAFE_MALLOC(nprocs * sizeof(pid_t));
+
+	for (i = 0; i < nprocs; i++)
+		*(pidarray + i) = 0;
+
+	for (i = 0, data = 0; i < (int)pagesize; i++) {
+		*(buf + i) = (data + pattern) & 0xff;
+		if (++data == nprocs)
+			data = 0;
+	}
+	SAFE_LSEEK(fd, (off_t)sparseoffset, SEEK_SET);
+	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
+		write_cnt = MIN((long long)pagesize, (long long)bytes_left);
+		c = SAFE_WRITE(1, fd, buf, write_cnt);
+	}
+	SAFE_CLOSE(fd);
+
+	/*
+	 *  Fork off mmap children.
+	 */
+	for (procno = 0; procno < nprocs; procno++) {
+		switch (pid = SAFE_FORK()) {
+		case 0:
+			child_mapper(TEST_FILE, (unsigned int)procno, (unsigned int)nprocs);
+			exit(0);
+
+		default:
+			pidarray[procno] = pid;
+		}
+	}
+
+	/*
+	 *  Now wait for children and refork them as needed.
+	 */
+
+	SAFE_SIGEMPTYSET(&set_mask);
+	SAFE_SIGADDSET(&set_mask, SIGALRM);
+	SAFE_SIGADDSET(&set_mask, SIGINT);
+	while (!finished) {
+		pid = wait(&wait_stat);
+		/*
+		 *  Block signals while processing child exit.
+		 */
+
+		SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
+
+		if (pid != -1) {
+			/*
+			 *  Check exit status, then refork with the
+			 *  appropriate procno.
+			 */
+			if (!WIFEXITED(wait_stat)
+			    || WEXITSTATUS(wait_stat) != 0)
+				tst_brk(TFAIL, "child exit with err <x%x>",
+					wait_stat);
+			for (i = 0; i < nprocs; i++)
+				if (pid == pidarray[i])
+					break;
+			if (i == nprocs)
+				tst_brk(TFAIL, "unknown child pid %d, <x%x>",
+					pid, wait_stat);
+
+			pid = SAFE_FORK();
+			if (pid == 0) {	/* child */
+				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
+				exit(0);
+			} else {
+				pidarray[i] = pid;
+			}
+		} else {
+			/*
+			 *  wait returned an error.  If EINTR, then
+			 *  normal finish, else it's an unexpected
+			 *  error...
+			 */
+			if (errno != EINTR || !finished)
+				tst_brk(TFAIL, "unexpected wait error");
+		}
+		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
+	}
+
+	SAFE_SIGEMPTYSET(&set_mask);
+	SAFE_SIGADDSET(&set_mask, SIGALRM);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
+	(void)alarm(0);
+
+	/*
+	 *  Finished!  Check the file for sanity.
+	 */
+	fileokay(TEST_FILE, buf);
+	tst_res(TPASS, "file has expected data");
 }
 
-/*****  **      **      *****/
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.options = options,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
