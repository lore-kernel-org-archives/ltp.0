Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07444C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:23:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E7FE3CAE01
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:23:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360903CABEA
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:31 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF04A600634
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:30 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 y62-20020a638a41000000b0044a5d5be5b8so5313547pgd.13
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=/nbqv4N9ztmyb2Ewjmw6DU/CJhin4caMIprlYkwVWzg=;
 b=gyiAxkA+9uE6l+sEugf4YBq1afe+SYh2mVT9x2r8A/dMRg4jYuxCSPrBqgLa+iPhY5
 teiN6fKH/POgdBtNJPiJ8KP4ac9qsoxKicfWzqvYvDIwS5RbnNSRFUi8yMdJm1JuUeLa
 mnkfFx1kVRkYNeuEYlkYcG+LhKnUseibqUI05yUZD4Ykj9I9EOxTSI41eoE6iBqyVGyq
 JqLrps0EO0706P62Ofh8jbvIPPBPrRTY7LgPucrILBUfs48uRnoPI5M+ocNPB/Nch/jE
 NxdiHjgc0WXQAwPJMnleXveY70WYFSmzwBGSVDsajKIgdqEB/rCFCWfaqzP2B5tdGVHr
 YmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=/nbqv4N9ztmyb2Ewjmw6DU/CJhin4caMIprlYkwVWzg=;
 b=N+E81WQ8UWHm7N9DFcnnvZMhZG9JzYGp7d5sk6hXTW8KgxXIolmRk30nnzAwwgTXIO
 e9tepNYjllBHIHq9MJ56oFetcOCjO/+7v+AtXYZcMHGFMJi87zOpnbvvuepzHOW6c0dE
 plmlh4WyYFFw3mBA6hNjWy2fjxVrLpQv1FJNFGmIpLH1/fvNlerOnagCYydLZ6d2REj1
 JX0l9Eoi0Ncwn/vSXpn13QcXixdllKSoJeHfGaJqbtC5Vif5nWVNxz+fuZXpZ/hXXZrx
 gQ0Z2AxcylDe9oVvjSnjbP/ZPJKy3tBIwJg2NFfLeVJStch/0CHNd/DOC1CwupsOrGzb
 Mxow==
X-Gm-Message-State: ACrzQf1rNZzm65x7wbK5cLngMOdpR+m4ieQjth3l4MBSMci3FHMrSwya
 uboNV5cKuaFU+xK7LIsv/dtrVauwNZ8O28cXM6V9lmz7TwiGwF1uP1PbZbHxfkgWQGc06+Rlbgr
 TeJjcDX+lTlo+A6oohPv86IZQxUkevV/E9IHzD+hgxDvnNbmgalecD1iV
X-Google-Smtp-Source: AMsMyM7j0AMF4zMldwWsc9bvPI00Fgq+kiJ/4WDH941QjJ4tAdxi/EsPvOeRYS8hITG+TlZpjFVS8704b8c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3392:b0:547:f861:1fad with SMTP id
 cm18-20020a056a00339200b00547f8611fadmr28999262pfb.16.1664907689245; Tue, 04
 Oct 2022 11:21:29 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:40 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-10-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 9/9] mmapstress01: reorder vars and functions
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 286 +++++++++---------
 1 file changed, 143 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 9eced3526..f68193706 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -72,26 +72,27 @@
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
 
 static unsigned int initrand(void);
-static void finish(int sig);
 static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
 static void fileokay(char *file, unsigned char *expbuf);
+static void sighandler(int sig);
 
 static char *debug;
 static char *do_sync;
 static char *do_offset;
-static char *randloops;
+static char *opt_alarmtime;
 static char *opt_filesize;
 static char *opt_nprocs;
 static char *opt_sparseoffset;
-static char *opt_alarmtime;
+static char *randloops;
 
 static int fd;
-static float alarmtime;
+static int finished;
 static int nprocs;
+static float alarmtime;
 static long long filesize = FILESIZE;
 static long long sparseoffset;
+static size_t pagesize;
 static unsigned int pattern;
-static int finished;
 
 static struct tst_option options[] = {
 	{"d", &debug, "Enable debug output"},
@@ -152,138 +153,6 @@ static void setup(void)
 	alarmtime *= 60;
 }
 
-static void run(void)
-{
-	int c;
-	int procno;
-	pid_t pid;
-	unsigned int seed;
-	int pagesize = sysconf(_SC_PAGE_SIZE);
-	struct sigaction sa;
-	int i;
-	int write_cnt;
-	unsigned char data;
-	off_t bytes_left;
-	sigset_t set_mask;
-	pid_t *pidarray = NULL;
-	int wait_stat;
-	unsigned char *buf;
-
-	seed = initrand();
-	pattern = seed & 0xff;
-
-	/*
-	 *  Plan for death by signal.  User may have specified
-	 *  a time limit, in which set an alarm and catch SIGALRM.
-	 *  Also catch and cleanup with SIGINT.
-	 */
-	sa.sa_handler = finish;
-	sa.sa_flags = 0;
-	SAFE_SIGEMPTYSET(&sa.sa_mask);
-	SAFE_SIGACTION(SIGINT, &sa, 0);
-	SAFE_SIGACTION(SIGQUIT, &sa, 0);
-	SAFE_SIGACTION(SIGTERM, &sa, 0);
-
-	if (alarmtime) {
-		SAFE_SIGACTION(SIGALRM, &sa, 0);
-		(void)alarm(alarmtime);
-	}
-	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
-
-	buf = SAFE_MALLOC(pagesize);
-	pidarray = SAFE_MALLOC(nprocs * sizeof(pid_t));
-
-	for (i = 0; i < nprocs; i++)
-		*(pidarray + i) = 0;
-
-	for (i = 0, data = 0; i < pagesize; i++) {
-		*(buf + i) = (data + pattern) & 0xff;
-		if (++data == nprocs)
-			data = 0;
-	}
-	SAFE_LSEEK(fd, (off_t)sparseoffset, SEEK_SET);
-	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-		write_cnt = MIN(pagesize, (int)bytes_left);
-		c = SAFE_WRITE(1, fd, buf, write_cnt);
-	}
-	SAFE_CLOSE(fd);
-
-	/*
-	 *  Fork off mmap children.
-	 */
-	for (procno = 0; procno < nprocs; procno++) {
-		switch (pid = SAFE_FORK()) {
-		case 0:
-			child_mapper(TEST_FILE, (unsigned int)procno, (unsigned int)nprocs);
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
-	SAFE_SIGEMPTYSET(&set_mask);
-	SAFE_SIGADDSET(&set_mask, SIGALRM);
-	SAFE_SIGADDSET(&set_mask, SIGINT);
-	while (!finished) {
-		pid = wait(&wait_stat);
-		/*
-		 *  Block signals while processing child exit.
-		 */
-
-		SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
-
-		if (pid != -1) {
-			/*
-			 *  Check exit status, then refork with the
-			 *  appropriate procno.
-			 */
-			if (!WIFEXITED(wait_stat)
-			    || WEXITSTATUS(wait_stat) != 0)
-				tst_brk(TFAIL, "child exit with err <x%x>",
-					wait_stat);
-			for (i = 0; i < nprocs; i++)
-				if (pid == pidarray[i])
-					break;
-			if (i == nprocs)
-				tst_brk(TFAIL, "unknown child pid %d, <x%x>",
-					pid, wait_stat);
-
-			pid = SAFE_FORK();
-			if (pid == 0) {	/* child */
-				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
-				exit(0);
-			} else {
-				pidarray[i] = pid;
-			}
-		} else {
-			/*
-			 *  wait returned an error.  If EINTR, then
-			 *  normal finish, else it's an unexpected
-			 *  error...
-			 */
-			if (errno != EINTR || !finished)
-				tst_brk(TFAIL, "unexpected wait error");
-		}
-		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
-	}
-
-	SAFE_SIGEMPTYSET(&set_mask);
-	SAFE_SIGADDSET(&set_mask, SIGALRM);
-	SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
-	(void)alarm(0);
-
-	/*
-	 *  Finished!  Check the file for sanity.
-	 */
-	fileokay(TEST_FILE, buf);
-	tst_res(TPASS, "file has expected data");
-}
-
 static void cleanup(void)
 {
 	if (fd > 0)
@@ -305,7 +174,6 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	size_t validsize;
 	size_t mapsize;
 	char *maddr = NULL, *paddr;
-	size_t pagesize = sysconf(_SC_PAGE_SIZE);
 	unsigned int randpage;
 	unsigned int seed;
 	unsigned int loopcnt;
@@ -389,13 +257,13 @@ static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
  */
 static void fileokay(char *file, unsigned char *expbuf)
 {
-	struct stat statbuf;
+	int cnt;
 	size_t mapsize;
-	unsigned int mappages;
-	unsigned int pagesize = sysconf(_SC_PAGE_SIZE);
+	struct stat statbuf;
 	unsigned char readbuf[pagesize];
-	int cnt;
 	unsigned int i, j;
+	unsigned int mappages;
+	unsigned int pagesize = sysconf(_SC_PAGE_SIZE);
 
 	fd = SAFE_OPEN(file, O_RDONLY);
 
@@ -432,7 +300,7 @@ static void fileokay(char *file, unsigned char *expbuf)
 	SAFE_CLOSE(fd);
 }
 
-static void finish(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	finished++;
 }
@@ -457,6 +325,138 @@ static unsigned int initrand(void)
 	return seed;
 }
 
+static void run(void)
+{
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
+
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
+}
+
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
