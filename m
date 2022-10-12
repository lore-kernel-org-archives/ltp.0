Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4127C4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 14:49:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 962AB3CAEAE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 16:49:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F27E3CAEB9
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:48:38 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 898CE2002D1
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:48:37 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 o11-20020a17090aac0b00b0020625062cbaso1556932pjq.2
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=z8/7I6ipNopzpau11UcxujEQsyasoyogtCjtdvziyD0=;
 b=Mq1xIjvHmomJj2wh7gfb2p3rv42ZauUajYwwoXgckOUuiybqldOO1WGrYsYlW06SBC
 gX1399OtEw627ST1nwKgNhraE6NUtsy7BIqMogF4aJiyWapYWxLH9zO3g+FAh07VLSki
 ULBl0VDDdi4+dt+w1jr7MThzkBCt4rZzVBflQOu7CM2tagmFLiRY7jwpnhTEugWHMCTM
 o64BKcQW8gTX9meBP0h8L118LkENxAikLznPb2pBvxibi5YbA5v0ouRM6so2l0gRd2I7
 FJXfptauK8fje4rEfVpeE15mHvVQjPlUo4v1nBe+ylLSDl89mhWWUBxQg4DdJ28bS0M9
 W6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8/7I6ipNopzpau11UcxujEQsyasoyogtCjtdvziyD0=;
 b=qVw35ZMmX2Y9FxuSmhQUKO19d/1WU77I0kh8yb1GuKjG5iZVYxzhWREw1qdrixvkbY
 9YbZDDUP0QV43L6OP5lmiCJW6dSei1j04gigYp6T2ZKK188Umk4YPhg1YtFRnt4pncIv
 vTz8BIWDCGd5x3smyBzLxYmrfE+mFIbHi5KST2lJeUc/GaPQz5BqSn0p+bYoH+iehA0F
 MrVVNYErF9ipOzjOZKeXPVeAy0Jza1ztXz2YOX/MSv9HLX1IK/tjXW+fj/OE0yny7cTr
 /WIbtJ5rPEDciCELakPYSeozXczqmrG0v1Yh7MpT3sN/sv7v3ZdJ8SR1XX5H4lb+/Ezp
 65OA==
X-Gm-Message-State: ACrzQf2NGEb1srbkR5Mks2pSvZQkmc1jYEGrHgjYLyMpIGkCFxJc+M78
 yHe7jknQtjGCGJMM0VQCRJZUBJ9WvO7xlBSODxaQcrylUA7IvVRUZZdLV9Q4Q1O5Y41oye9z1II
 QfYfCm9F7O0FlHLMPiCofoz4B/ZBP+BJBphGaizu2yFHOhaAuUuYavO8I
X-Google-Smtp-Source: AMsMyM7eIiCLAbJKTWLYBRFm4wArO59dJAOMi+dFRlKoKFl/wiGHegQT0+Sw/9NVTW287fJHuJvFIVkiy+s=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1947:b0:565:c337:c53b with SMTP id
 s7-20020a056a00194700b00565c337c53bmr1739056pfk.10.1665586116026; Wed, 12 Oct
 2022 07:48:36 -0700 (PDT)
Date: Wed, 12 Oct 2022 14:48:20 +0000
In-Reply-To: <20221012144823.1595671-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221012144823.1595671-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012144823.1595671-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/5] mmapstress01: format comments
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 102 +++++++-----------
 1 file changed, 41 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 83d3f387d..dee73de5e 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -5,19 +5,20 @@
  * 06/30/2001	Port to Linux	nsharoff@us.ibm.com
  * 10/03/2022	Refactor to LTP framework	edliaw@google.com
  */
-/*
- *  This test stresses mmaps, without dealing with fragments or anything!
- *  It forks a specified number of children,
- *  all of whom mmap the same file, make a given number of accesses
- *  to random pages in the map (reading & writing and comparing data).
- *  Then the child exits and the parent forks another to take its place.
- *  Each time a child is forked, it stats the file and maps the full
- *  length of the file.
+/*\
+ * [Description]
+ * This test stresses mmaps, without dealing with fragments or anything!
+ * It forks a specified number of children,
+ * all of whom mmap the same file, make a given number of accesses
+ * to random pages in the map (reading & writing and comparing data).
+ * Then the child exits and the parent forks another to take its place.
+ * Each time a child is forked, it stats the file and maps the full
+ * length of the file.
  *
- *  This program continues to run until it either receives a SIGINT,
- *  or times out (if a timeout value is specified).  When either of
- *  these things happens, it cleans up its kids, then checks the
- *  file to make sure it has the correct data.
+ * This program continues to run until it either receives a SIGINT,
+ * or times out (if a timeout value is specified).  When either of
+ * these things happens, it cleans up its kids, then checks the
+ * file to make sure it has the correct data.
  */
 
 #define _GNU_SOURCE 1
@@ -102,10 +103,9 @@ static void setup(void)
 		tst_brk(TBROK, "invalid number of mapping children '%s'",
 			opt_nprocs);
 
-	if (debug) {
+	if (debug)
 		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
 			TEST_FILE, filesize, pattern);
-	}
 }
 
 static void cleanup(void)
@@ -115,11 +115,11 @@ static void cleanup(void)
 }
 
 /*
- *  Child process that reads/writes map.  The child stats the file
- *  to determine the size, maps the size of the file, then reads/writes
- *  its own locations on random pages of the map (its locations being
- *  determined based on nprocs & procno).  After a specific number of
- *  iterations, it exits.
+ * Child process that reads/writes map.  The child stats the file
+ * to determine the size, maps the size of the file, then reads/writes
+ * its own locations on random pages of the map (its locations being
+ * determined based on nprocs & procno).  After a specific number of
+ * iterations, it exits.
  */
 static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 {
@@ -136,7 +136,7 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	unsigned int mappages;
 	unsigned int i;
 
-	seed = initrand();	/* initialize random seed */
+	seed = initrand();
 
 	SAFE_STAT(file, &statbuf);
 	filesize = statbuf.st_size;
@@ -167,9 +167,7 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			  offset);
 	SAFE_CLOSE(fd);
 
-	/*
-	 *  Now loop read/writing random pages.
-	 */
+	/* Loop read/writing random pages. */
 	for (loopcnt = 0; loopcnt < nloops; loopcnt++) {
 		randpage = lrand48() % mappages;
 		paddr = maddr + (randpage * pagesize);	/* page address */
@@ -187,16 +185,12 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 					*((unsigned char *)(paddr + i)),
 					randpage, i, (procno + pattern) & 0xff);
 
-			/*
-			 *  Now write it.
-			 */
+			/* Now write it. */
 			*(paddr + i) = (procno + pattern) & 0xff;
 		}
 	}
 	if (do_sync) {
-		/*
-		 * Exercise msync() as well!
-		 */
+		/* Exercise msync() as well! */
 		randpage = lrand48() % mappages;
 		paddr = maddr + (randpage * pagesize);	/* page address */
 		if (msync(paddr, (mappages - randpage) * pagesize,
@@ -207,9 +201,7 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	exit(0);
 }
 
-/*
- *  Make sure file has all the correct data.
- */
+/* Make sure file has all the correct data. */
 static void fileokay(char *file, unsigned char *expbuf)
 {
 	int cnt;
@@ -234,16 +226,12 @@ static void fileokay(char *file, unsigned char *expbuf)
 	for (i = 0; i < mappages; i++) {
 		cnt = SAFE_READ(0, fd, readbuf, pagesize);
 		if ((unsigned int)cnt != pagesize) {
-			/*
-			 *  Okay if at last page in file...
-			 */
+			/* Okay if at last page in file... */
 			if ((i * pagesize) + cnt != mapsize)
 				tst_brk(TFAIL, "missing data: read %d of %ld bytes",
 					(i * pagesize) + cnt, (long)mapsize);
 		}
-		/*
-		 *  Compare read bytes of data.
-		 */
+		/* Compare read bytes of data. */
 		for (j = 0; j < (unsigned int)cnt; j++) {
 			if (expbuf[j] != readbuf[j])
 				tst_brk(TFAIL,
@@ -265,12 +253,10 @@ static unsigned int initrand(void)
 	unsigned int seed;
 
 	/*
-	 *  Initialize random seed...  Got this from a test written
-	 *  by scooter:
-	 *      Use srand/rand to diffuse the information from the
-	 *      time and pid.  If you start several processes, then
-	 *      the time and pid information don't provide much
-	 *      variation.
+	 * Use srand/rand to diffuse the information from the
+	 * time and pid.  If you start several processes, then
+	 * the time and pid information don't provide much
+	 * variation.
 	 */
 	srand((unsigned int)getpid());
 	seed = rand();
@@ -301,8 +287,8 @@ static void run(void)
 	pattern = seed & 0xff;
 
 	/*
-	 *  Plan for death by signal or alarm.
-	 *  Also catch and cleanup with SIGINT.
+	 * Plan for death by signal or alarm.
+	 * Also catch and cleanup with SIGINT.
 	 */
 	sa.sa_handler = sighandler;
 	sa.sa_flags = 0;
@@ -334,9 +320,7 @@ static void run(void)
 	}
 	SAFE_CLOSE(fd);
 
-	/*
-	 *  Fork off mmap children.
-	 */
+	/* Fork off mmap children. */
 	for (procno = 0; procno < nprocs; procno++) {
 		switch (pid = SAFE_FORK()) {
 		case 0:
@@ -348,9 +332,7 @@ static void run(void)
 		}
 	}
 
-	/*
-	 *  Now wait for children and refork them as needed.
-	 */
+	/* Now wait for children and refork them as needed. */
 
 	SAFE_SIGEMPTYSET(&set_mask);
 	SAFE_SIGADDSET(&set_mask, SIGALRM);
@@ -358,15 +340,15 @@ static void run(void)
 	while (!finished) {
 		pid = wait(&wait_stat);
 		/*
-		 *  Block signals while processing child exit.
+		 * Block signals while processing child exit.
 		 */
 
 		SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
 
 		if (pid != -1) {
 			/*
-			 *  Check exit status, then refork with the
-			 *  appropriate procno.
+			 * Check exit status, then refork with the
+			 * appropriate procno.
 			 */
 			if (!WIFEXITED(wait_stat)
 			    || WEXITSTATUS(wait_stat) != 0)
@@ -388,9 +370,9 @@ static void run(void)
 			}
 		} else {
 			/*
-			 *  wait returned an error.  If EINTR, then
-			 *  normal finish, else it's an unexpected
-			 *  error...
+			 * wait returned an error.  If EINTR, then
+			 * normal finish, else it's an unexpected
+			 * error...
 			 */
 			if (errno != EINTR || !finished)
 				tst_brk(TBROK | TERRNO,
@@ -404,9 +386,7 @@ static void run(void)
 	SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
 	alarm(0);
 
-	/*
-	 *  Finished!  Check the file for sanity.
-	 */
+	/* Finished!  Check the file for sanity. */
 	fileokay(TEST_FILE, buf);
 	tst_res(TPASS, "file has expected data");
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
