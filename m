Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF04C433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 18:01:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C5AB3CA950
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 20:01:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C47033CAAE9
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 20:00:16 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F17DA140075D
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 20:00:15 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 k2-20020a170902c40200b001782bd6c416so3710119plk.20
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=il8dMVGdybulSzwK0RPt+bs7nkLT8s4scRqbMcDfoCA=;
 b=hi+d6qHZbqkc0BwojT2PILsO3uahyH/f2UiT00yp0tvXibnEHPRAbbTZov8sDccz4r
 oNRCsnbWu7YhTS9qwLNZVdOX+rmhi0IP7kJPwdjg6+o6R2n9pfChsIhn7sozuCVNQ8PI
 LNPekJxY2qykZS6nLixJkT6h6adnhT3Q2OC0Oi1vZnmaHT98oSREdn1mP/1SAaGa55O4
 vh75b7wWd1n8zmueNxzpT1outyhcb7SgWnrmVz5FjTIvb4N0nSSC45SqF6ZOjZRJv/4W
 YStwz83PMrVcuG/qsandiW1swZ5xCefACdTOC24SpVCfrivOHAVHYDBYSvrGpfTD2dq3
 5/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=il8dMVGdybulSzwK0RPt+bs7nkLT8s4scRqbMcDfoCA=;
 b=GC6ftkYCT39vR2/6bhfJv454UNgZOxZOP6weJK99D8cWFEdrGm/Bs5Q1GbyJJ/B93Z
 iI6JynwuQp+p19PMq195EdXN2c0bjmVT0BNiQq3cYX4zwNKUgTuoz9AqTlx2rxwxWMEK
 6roxmtM4HgkPI30B93NespXTxduLgOO+6c6I6zCTMG+LpC49P+p8eFPUbGt48bI2EiHw
 SnIfAQiL9RBjKcosGFUNdQYIuN6Q1DEBD1Et6Dymdn4TSz8fteDJf24a3AYtsiBFzieJ
 oKONS9rMN1lq42isn4bchQICvxVGHCadJRy5aHPSX67lr5IdgrfjGNzIqGgFeoCRnHq1
 842g==
X-Gm-Message-State: ACrzQf18Gbye3L5D7UKZS+IRTJjOfP6Dl6AnEZgJ90gakPq9JfY9KeYm
 2nE8vSPlweHsJt1sse8dvCu9K0KNcZchx/ZLowP5FchRdBzEfVVyklo34pBHW1wHfgOBvxpbItz
 agiLKJyOhcNCBp7Axmk03tvaDIMxHx5nsq1MLbG3//LY64XeYVhKs2MIp
X-Google-Smtp-Source: AMsMyM7F0rgnpDsV3P54j80EAQr7O6068ek8mhXc63WQ5gy8JCC/QsKW+bPxe+Hbckl7HRJJrmtpz5zcN9A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a62:1c8f:0:b0:537:2284:bd00 with SMTP id
 c137-20020a621c8f000000b005372284bd00mr10078222pfc.78.1664560814442; Fri, 30
 Sep 2022 11:00:14 -0700 (PDT)
Date: Fri, 30 Sep 2022 17:59:59 +0000
In-Reply-To: <20220930175959.3955586-1-edliaw@google.com>
Mime-Version: 1.0
References: <20220930175959.3955586-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930175959.3955586-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] mmapstress01: use safe macros
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 85 ++++++++-----------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 0f5071a20..955d6ac3f 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -193,6 +193,7 @@ static void run(void)
 	int write_cnt;
 	unsigned char data;
 	off_t bytes_left;
+	sigset_t set_mask;
 
 	seed = initrand();
 	pattern = seed & 0xff;
@@ -204,29 +205,19 @@ static void run(void)
 	 */
 	sa.sa_handler = finish;
 	sa.sa_flags = 0;
-	if (sigemptyset(&sa.sa_mask))
-		tst_brk(TFAIL, "sigemptyset error");
-
-	if (sigaction(SIGINT, &sa, 0) == -1)
-		tst_brk(TFAIL, "sigaction error SIGINT");
-	if (sigaction(SIGQUIT, &sa, 0) == -1)
-		tst_brk(TFAIL, "sigaction error SIGQUIT");
-	if (sigaction(SIGTERM, &sa, 0) == -1)
-		tst_brk(TFAIL, "sigaction error SIGTERM");
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGINT, &sa, 0);
+	SAFE_SIGACTION(SIGQUIT, &sa, 0);
+	SAFE_SIGACTION(SIGTERM, &sa, 0);
 
 	if (alarmtime) {
-		if (sigaction(SIGALRM, &sa, 0) == -1)
-			tst_brk(TFAIL, "sigaction error");
+		SAFE_SIGACTION(SIGALRM, &sa, 0);
 		(void)alarm(alarmtime);
 	}
-	if ((fd = open(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-		tst_brk(TFAIL, "open error");
-	}
+	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
 
-	if ((buf = malloc(pagesize)) == NULL
-	    || (pidarray = malloc(nprocs * sizeof(pid_t))) == NULL) {
-		tst_brk(TFAIL, "malloc error");
-	}
+	buf = SAFE_MALLOC(pagesize);
+	pidarray = SAFE_MALLOC(nprocs * sizeof(pid_t));
 
 	for (i = 0; i < nprocs; i++)
 		*(pidarray + i) = 0;
@@ -236,9 +227,7 @@ static void run(void)
 		if (++data == nprocs)
 			data = 0;
 	}
-	if (lseek(fd, (off_t)sparseoffset, SEEK_SET) < 0) {
-		tst_brk(TFAIL, "lseek");
-	}
+	SAFE_LSEEK(fd, (off_t)sparseoffset, SEEK_SET);
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
 		write_cnt = MIN(pagesize, (int)bytes_left);
 		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
@@ -247,13 +236,13 @@ static void run(void)
 			else
 				tst_res(TINFO, "write: wrote %d of %d bytes",
 				        c, write_cnt);
-			(void)close(fd);
-			(void)unlink(TEST_FILE);
+			SAFE_CLOSE(fd);
+			SAFE_UNLINK(TEST_FILE);
 			tst_brk(TFAIL, "write error");
 		}
 	}
 
-	(void)close(fd);
+	SAFE_CLOSE(fd);
 
 	/*
 	 *  Fork off mmap children.
@@ -278,14 +267,16 @@ static void run(void)
 	 *  Now wait for children and refork them as needed.
 	 */
 
+	SAFE_SIGEMPTYSET(&set_mask);
+	SAFE_SIGADDSET(&set_mask, SIGALRM);
+	SAFE_SIGADDSET(&set_mask, SIGINT);
 	while (!finished) {
 		pid = wait(&wait_stat);
 		/*
 		 *  Block signals while processing child exit.
 		 */
 
-		if (sighold(SIGALRM) || sighold(SIGINT))
-			tst_brk(TFAIL, "sighold error");
+		SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
 
 		if (pid != -1) {
 			/*
@@ -321,8 +312,7 @@ static void run(void)
 			if (errno != EINTR || !finished)
 				tst_brk(TFAIL, "unexpected wait error");
 		}
-		if (sigrelse(SIGALRM) || sigrelse(SIGINT))
-			tst_brk(TFAIL, "sigrelse error");
+		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
 	}
 
 	/*
@@ -330,8 +320,9 @@ static void run(void)
 	 *  the children and done!.
 	 */
 
-	if (sighold(SIGALRM))
-		tst_brk(TFAIL, "sighold error");
+	SAFE_SIGEMPTYSET(&set_mask);
+	SAFE_SIGADDSET(&set_mask, SIGALRM);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
 	(void)alarm(0);
 	check_for_sanity = 1;
 	tst_res(TPASS, "finished, cleaning up");
@@ -352,7 +343,7 @@ static void cleanup(void)
 		} else {
 			tst_res(TINFO, "file data okay");
 			if (!leavefile)
-				(void)unlink(TEST_FILE);
+				SAFE_UNLINK(TEST_FILE);
 			tst_res(TPASS, "test passed");
 		}
 	} else {
@@ -386,12 +377,10 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
 	seed = initrand();	/* initialize random seed */
 
-	if (stat(file, &statbuf) == -1)
-		tst_brk(TFAIL, "stat error");
+	SAFE_STAT(file, &statbuf);
 	filesize = statbuf.st_size;
 
-	if ((fd = open(file, O_RDWR)) == -1)
-		tst_brk(TFAIL, "open error");
+	fd = SAFE_OPEN(file, O_RDWR);
 
 	if (statbuf.st_size - sparseoffset > UINT_MAX)
 		tst_brk(TFAIL, "size_t overflow when setting up map");
@@ -411,11 +400,10 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
 		        procno, getpid(), seed, (long long)filesize,
 		        (long)mapsize, (long long)offset / pagesize, nloops);
-	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-	                  fd, offset)) == (caddr_t) - 1)
-		tst_brk(TFAIL, "mmap error");
 
-	(void)close(fd);
+	maddr = SAFE_MMAP(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+	                  offset);
+	SAFE_CLOSE(fd);
 
 	/*
 	 *  Now loop read/writing random pages.
@@ -453,8 +441,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		          MS_SYNC) == -1)
 			tst_brk(TFAIL, "msync failed");
 	}
-	if (munmap(maddr, mapsize) == -1)
-		tst_brk(TFAIL, "munmap failed");
+	SAFE_MUNMAP(maddr, mapsize);
 	exit(0);
 }
 
@@ -472,14 +459,10 @@ int fileokay(char *file, unsigned char *expbuf)
 	int cnt;
 	unsigned int i, j;
 
-	if ((fd = open(file, O_RDONLY)) == -1)
-		tst_brk(TFAIL, "open error");
-
-	if (fstat(fd, &statbuf) == -1)
-		tst_brk(TFAIL, "stat error");
+	fd = SAFE_OPEN(file, O_RDONLY);
 
-	if (lseek(fd, sparseoffset, SEEK_SET) < 0)
-		tst_brk(TFAIL, "lseek");
+	SAFE_FSTAT(fd, &statbuf);
+	SAFE_LSEEK(fd, sparseoffset, SEEK_SET);
 
 	if (statbuf.st_size - sparseoffset > UINT_MAX)
 		tst_brk(TFAIL, "size_t overflow when setting up map");
@@ -498,7 +481,7 @@ int fileokay(char *file, unsigned char *expbuf)
 			if ((i * pagesize) + cnt != mapsize) {
 				tst_res(TINFO, "read %d of %ld bytes",
 				        (i * pagesize) + cnt, (long)mapsize);
-				close(fd);
+				SAFE_CLOSE(fd);
 				return 0;
 			}
 		}
@@ -511,12 +494,12 @@ int fileokay(char *file, unsigned char *expbuf)
 				        "read bad data: exp %c got %c, pg %d off %d, (fsize %lld)",
 				        expbuf[j], readbuf[j], i, j,
 				        (long long)statbuf.st_size);
-				close(fd);
+				SAFE_CLOSE(fd);
 				return 0;
 			}
 		}
 	}
-	close(fd);
+	SAFE_CLOSE(fd);
 
 	return 1;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
