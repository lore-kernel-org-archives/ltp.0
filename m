Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E99FC07E9D
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 18:27:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 121DF3CADEC
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 20:27:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4201E3CADFE
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:48 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89C6260004F
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:47 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 128-20020a630486000000b00435b18f71b3so4412371pge.19
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=eVu+OTHsm0UCm+0mp50CV5MOalhz7rOWx4qPpsO2mUA=;
 b=XjlyFRVbKWQpg85OquI1SFfxk8wT6vj4+8Od8Mwl6ag4w075DevH3UnMHBBmW7wLa+
 wq5dSSClP4W3PyhfBD0R+b6ehX71P8DkCVlByDFif1D92BFMqgUwUdzm2YNWFCoDdLnS
 GIxMTyZgpBTS3yboaP0wLSXp7y1IEBKwrEJx6simqQqYZtx/P48tOnRD7CRd2En6lszS
 WTk3FetNZrm78WGMEMoms73NJUo18/MnMLE0zYS6VI1VXR4a++2NGnceVi+3d4Zbj3dh
 Ad/d3Z8nWeXqgXWDiHrryFC6Fvt+Maum2w9oTBkqcz7tC6m26J9ctxE7VruP7ya2/Z9a
 d1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=eVu+OTHsm0UCm+0mp50CV5MOalhz7rOWx4qPpsO2mUA=;
 b=JYOt/2GtiT5ME0R7lAx0YOHDUKI7/pzBYqpbNW1zqCd0XJ1V0Sso2G8w9rcdwxmJl4
 /5DfuKzECzwhf3AP5cxf9kKDo1xFF8fIEf8wFFXyFyW66YwRJde3N2byGe6IInVWXESC
 shMOBqyXJvvaS3r4p/JXrqClG+gQeQZaBZFNz18nvuLjQ1YA1PmQJKT1KM6AUzUMkUbW
 Yg7qCsHYzemxbAYTq3/tP/kcKQsAch74/z0to+VGSal2KNT3lvnJqhSqOB3/RyPvVQQY
 WMNni3ZpeVayveVU33edKjQFpNcoJv8uEqvaQ+5xYxZVjCpe6u1OlOpI3tbAtgl1FDut
 tBdg==
X-Gm-Message-State: ACrzQf1hHfRikvIiZE1W6FFyslUK59Vay96U9ycH5d4B5VpB7G054qYN
 9Z49W5QRKF5nIBqPYjy6URtriUks/e1G1iZZA8ZnQFftR1A0QfmTHTDXS/WKe8nfWP0SkLqrShD
 vySg948Ga97Rrs1kR6FEgkT1uwadpLbBsheat55l4cpir9jTX84eBw1sx
X-Google-Smtp-Source: AMsMyM67BBWtEHvQDBQ/UIWF4DzZdFqVej/4hULLnBjO0ENmmBaHu3x1h4LydrPkzeA+rPukoHsA2FiTSno=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:244d:b0:178:a0eb:d4bc with SMTP id
 l13-20020a170903244d00b00178a0ebd4bcmr23514112pls.33.1664216806025; Mon, 26
 Sep 2022 11:26:46 -0700 (PDT)
Date: Mon, 26 Sep 2022 18:26:25 +0000
In-Reply-To: <20220926182625.103275-1-edliaw@google.com>
Mime-Version: 1.0
References: <20220926182625.103275-1-edliaw@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926182625.103275-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 4/4] mmapstress01: use safe macros
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 80 ++++++++-----------
 1 file changed, 32 insertions(+), 48 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index cb18241de..bb1723c42 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -187,6 +187,7 @@ static void run(void)
 	int write_cnt;
 	unsigned char data;
 	off_t bytes_left;
+	sigset_t set_mask;
 
 	seed = initrand();
 	pattern = seed & 0xff;
@@ -198,29 +199,19 @@ static void run(void)
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
@@ -230,9 +221,7 @@ static void run(void)
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
@@ -242,13 +231,13 @@ static void run(void)
 				tst_res(TINFO, "write: wrote %d of %d "
 					      "bytes", c, write_cnt);
 			}
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
@@ -273,14 +262,16 @@ static void run(void)
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
@@ -312,8 +303,7 @@ static void run(void)
 			if (errno != EINTR || !finished)
 				tst_brk(TFAIL, "unexpected wait error");
 		}
-		if (sigrelse(SIGALRM) || sigrelse(SIGINT))
-			tst_brk(TFAIL, "sigrelse error");
+		SAFE_SIGPROCMASK(SIG_UNBLOCK, &set_mask, NULL);
 	}
 
 	/*
@@ -321,8 +311,9 @@ static void run(void)
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
@@ -343,7 +334,7 @@ static void cleanup(void)
 		} else {
 			tst_res(TINFO, "file data okay");
 			if (!leavefile)
-				(void)unlink(TEST_FILE);
+				SAFE_UNLINK(TEST_FILE);
 			tst_res(TPASS, "test passed");
 		}
 	} else
@@ -376,12 +367,10 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
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
@@ -406,7 +395,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			  fd, offset)) == (caddr_t) - 1)
 		tst_brk(TFAIL, "mmap error");
 
-	(void)close(fd);
+	SAFE_CLOSE(fd);
 
 	/*
 	 *  Now loop read/writing random pages.
@@ -444,8 +433,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			  MS_SYNC) == -1)
 			tst_brk(TFAIL, "msync failed");
 	}
-	if (munmap(maddr, mapsize) == -1)
-		tst_brk(TFAIL, "munmap failed");
+	SAFE_MUNMAP(maddr, mapsize);
 	exit(0);
 }
 
@@ -463,14 +451,10 @@ int fileokay(char *file, unsigned char *expbuf)
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
@@ -490,7 +474,7 @@ int fileokay(char *file, unsigned char *expbuf)
 				tst_res(TINFO, "read %d of %ld bytes",
 					      (i * pagesize) + cnt,
 					      (long)mapsize);
-				close(fd);
+				SAFE_CLOSE(fd);
 				return 0;
 			}
 		}
@@ -505,12 +489,12 @@ int fileokay(char *file, unsigned char *expbuf)
 				tst_res(TINFO, ", pg %d off %d, "
 					      "(fsize %ld)", i, j,
 					      statbuf.st_size);
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
2.37.3.998.g577e59143f-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
