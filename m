Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8E8C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:22:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3353CADE6
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:22:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E8313CACDD
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:25 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68C97600634
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:24 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 n1-20020a170902f60100b00179c0a5c51fso10627674plg.7
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=jgmDPCtFYVOuyTlEfR95+wakysEHxyQ9usC/FXUG/jo=;
 b=kNW2GbCibxN/BeaxqzIOzvjA3AWmaa6FCEXtZm1efnaMtzNzQxEzv9jL0b3/348gpR
 TNekwsS8FG9PYiDWe/63/NhKMCEMi1ybtVxEolmjc4vxhd3vVYQTZk3rQxiInPiHGD9L
 8lUiJ1v82DaUp9Kxii/SUhG0XbcddJvoKI9XTO+lL+NFS3fdj1lXjPP8Xs+Ba1I6k1KZ
 06E/zZcsmg0ab9q9ilJkTW7ijzcRUEKJMA3MQ2N2fUM5nTdsgwctAReY7vg7wiw2JuX7
 H2/al1PVu3oN1/1weZTIQmHeLpZ2wRn9BaGvboe9XP6y+dEwHXeRRUocCwUihSGazpQ5
 eLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=jgmDPCtFYVOuyTlEfR95+wakysEHxyQ9usC/FXUG/jo=;
 b=Z6fQ5wU/Ax4fFafxnCTd8dphgm3a+WhxQ3ut38EsRvbwRvMdZ6QAwvnlZsnTVmGvWT
 aX5mR3RBZ/FfSq9jJC2hdcJuaK/NztvarE6Mff45/JRiLEHHjdE+8BJ/x7V8uy58RqIx
 tzgdRROO74usJMgstF4w294OR9wSplbdOaUVxa0UN3I/uVXoVtjlEMdcqofOEAWHJ78F
 ZdH5eW2w/SEI8AE/Idxl8ZLMlon0ITLug/rsJR35YYEY7ZiqlmueMrGk6Qyt9MDABUgV
 wvj9IOItrKDfP1UWxvSdsrqhHbM/gDeO3fAzMw7Ee1WGXkHkfxGdLpbRLN3UeoEvs5Ls
 zCkA==
X-Gm-Message-State: ACrzQf2ulMZ+F8oWCEsCFXLPERAGVkrL4po4UkoCFL9Jj7O4IhiyUFdu
 x9NTyXnHlXJZYi0ke3wnmkGBBuf5GF36Y62SrIE8BQlVsqVPXD/EcVtAcemiCnARVqqNikng10k
 kv3ut3D8ZqxEUzv06AK5AnjQ/5ar355CJxYo9w4zz3i7PjbL9aq1eIm4g
X-Google-Smtp-Source: AMsMyM7WE4CKtrN4PPyDUWhR+ExfCrzuO0SxxZeGF6cDcVF5DLrWx21b5+W3chIugOwOfQbJ6Xx+Jo0NxDQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1626:b0:561:5c63:7291 with SMTP id
 e6-20020a056a00162600b005615c637291mr12083318pfc.29.1664907682887; Tue, 04
 Oct 2022 11:21:22 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:36 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-6-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/9] mmapstress01: use safe macros
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 91 +++++++------------
 1 file changed, 33 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 3f7f617c6..165db2b81 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -186,6 +186,7 @@ static void run(void)
 	int write_cnt;
 	unsigned char data;
 	off_t bytes_left;
+	sigset_t set_mask;
 
 	seed = initrand();
 	pattern = seed & 0xff;
@@ -197,28 +198,19 @@ static void run(void)
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
-	if ((fd = open(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1)
-		tst_brk(TFAIL, "open error");
+	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
 
-	if ((buf = malloc(pagesize)) == NULL
-	    || (pidarray = malloc(nprocs * sizeof(pid_t))) == NULL) {
-		tst_brk(TFAIL, "malloc error");
-	}
+	buf = SAFE_MALLOC(pagesize);
+	pidarray = SAFE_MALLOC(nprocs * sizeof(pid_t));
 
 	for (i = 0; i < nprocs; i++)
 		*(pidarray + i) = 0;
@@ -228,23 +220,12 @@ static void run(void)
 		if (++data == nprocs)
 			data = 0;
 	}
-	if (lseek(fd, (off_t)sparseoffset, SEEK_SET) < 0)
-		tst_brk(TFAIL, "lseek");
+	SAFE_LSEEK(fd, (off_t)sparseoffset, SEEK_SET);
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
 		write_cnt = MIN(pagesize, (int)bytes_left);
-		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
-			if (c == -1)
-				tst_res(TINFO, "write error");
-			else
-				tst_res(TINFO, "write: wrote %d of %d bytes",
-					c, write_cnt);
-			(void)close(fd);
-			(void)unlink(TEST_FILE);
-			tst_brk(TFAIL, "write error");
-		}
+		c = SAFE_WRITE(1, fd, buf, write_cnt);
 	}
-
-	(void)close(fd);
+	SAFE_CLOSE(fd);
 
 	/*
 	 *  Fork off mmap children.
@@ -269,14 +250,16 @@ static void run(void)
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
@@ -312,8 +295,7 @@ static void run(void)
 			if (errno != EINTR || !finished)
 				tst_brk(TFAIL, "unexpected wait error");
 		}
-		if (sigrelse(SIGALRM) || sigrelse(SIGINT))
-			tst_brk(TFAIL, "sigrelse error");
+		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
 	}
 
 	/*
@@ -321,8 +303,9 @@ static void run(void)
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
@@ -343,7 +326,7 @@ static void cleanup(void)
 		} else {
 			tst_res(TINFO, "file data okay");
 			if (!leavefile)
-				(void)unlink(TEST_FILE);
+				SAFE_UNLINK(TEST_FILE);
 			tst_res(TPASS, "test passed");
 		}
 	} else {
@@ -377,12 +360,10 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
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
@@ -403,11 +384,10 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
 			procno, getpid(), seed, (long long)filesize,
 			(long)mapsize, (long long)offset / pagesize, nloops);
-	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			  fd, offset)) == (caddr_t) - 1)
-		tst_brk(TFAIL, "mmap error");
 
-	(void)close(fd);
+	maddr = SAFE_MMAP(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+			  offset);
+	SAFE_CLOSE(fd);
 
 	/*
 	 *  Now loop read/writing random pages.
@@ -445,8 +425,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			  MS_SYNC) == -1)
 			tst_brk(TFAIL, "msync failed");
 	}
-	if (munmap(maddr, mapsize) == -1)
-		tst_brk(TFAIL, "munmap failed");
+	SAFE_MUNMAP(maddr, mapsize);
 	exit(0);
 }
 
@@ -464,14 +443,10 @@ int fileokay(char *file, unsigned char *expbuf)
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
@@ -490,7 +465,7 @@ int fileokay(char *file, unsigned char *expbuf)
 			if ((i * pagesize) + cnt != mapsize) {
 				tst_res(TINFO, "read %d of %ld bytes",
 					(i * pagesize) + cnt, (long)mapsize);
-				close(fd);
+				SAFE_CLOSE(fd);
 				return 0;
 			}
 		}
@@ -503,12 +478,12 @@ int fileokay(char *file, unsigned char *expbuf)
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
