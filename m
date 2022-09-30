Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B05FC433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 18:00:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD7603CA8FF
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 20:00:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 941613CAA78
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 20:00:16 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 490DA20115D
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 20:00:14 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 hk15-20020a17090b224f00b00205fa3483bdso5057857pjb.8
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=z3xOG2z4wiuhhrM2NmLfl6jflzYQeqnglOSK0uDgGeA=;
 b=dL3PdP7PvONTZwtGD7xs0J3Teo6Q/7FTuTMXH6vB+s19okdLtq41f9ErZ7m2HXzO3/
 9QkATjb5T+plbKYwu8cn6/4fyLjY0xBSHlBJoMEwUu5+LCnjs9lGAXL5ffDvxng998Of
 8pXL7GOvKHtdte9vNG/4b04chWgJmzW/UvygMZjxIuQZ3fmdU2jwxphgqPZybiahawH8
 fmTwx3a+akPDoCBkaeqqIMb9uFZDh1FW3Ciu6Rl8rLISFqxrdthBnNLgqxJ7n/5Yp56k
 +V8vq0E+DvqYty1uyZW6ykyTieQaaxMnb/CkQNhsqD65rbv1lRO5Wmu2dXLaVBD6iqTA
 geuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=z3xOG2z4wiuhhrM2NmLfl6jflzYQeqnglOSK0uDgGeA=;
 b=7A+kZcvrjfdFAtGnap+NeF1Iy1DzBbAFgBBBb4pt2Kwibf2ZaPGEGV7rKqF7ByRgYa
 wELL09V+F/ORUT7JI256Oz8BJY7NGx4gwF7q+DEe7s8J2j7iZCdCm8vIv38H8tybYAJ4
 JPdzsPjkGmiXoBYBceb5KMssHiZhb7kAMYEL1n0K50kH2y/WX1ZS8TIiQ83alwlxmn3h
 9VB1Da95iQxJivsj3m4a6oywsWT5nILdOqzZeVLAka16QX7l70/eajfDm4bd9Ixabi8t
 OvjcI8m+0S2uP6q4BOh5hux9R+l7TtkSgL0wirQzrrjVNhLUCco75m+43L3tmIwSdA87
 P8ug==
X-Gm-Message-State: ACrzQf3qZlf7zxM2W1sBq9VEtTmF4GIzpk8dZnZV1Mb0HwZV7Qcuq3By
 t5oEvJsZZb8AIJZG532rIFWzDlrYu9NE1C3veiVNHYZXSL2ch7U/JdKKTAV5H/98S1HnDKgIjUA
 vo7+wvVknMj85j6CFvrKtt2bjvoA2dr5kdR6tfoY6+AdEIIeAWDjC5icz
X-Google-Smtp-Source: AMsMyM7eYze/ddJ8q6dBuR6fy/3QlDcV/wwqK1xgNcmtQpoFHHiJIVDLEaKZyKK7kH8iUU5No4znq02lEJE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3808:b0:202:c5ba:d71b with SMTP id
 mq8-20020a17090b380800b00202c5bad71bmr23279072pjb.18.1664560812654; Fri, 30
 Sep 2022 11:00:12 -0700 (PDT)
Date: Fri, 30 Sep 2022 17:59:58 +0000
In-Reply-To: <20220930175959.3955586-1-edliaw@google.com>
Mime-Version: 1.0
References: <20220930175959.3955586-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930175959.3955586-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] mmapstress01: use FILE_OFFSET_BITS=64
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

Build tests with FILE_OFFSET_BITS=64 instead of doing LARGE_FILE checks
to switch between 32 and 64 bit types and syscalls.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/mem/mmapstress/Makefile      |  2 +
 .../kernel/mem/mmapstress/mmapstress01.c      | 64 ++-----------------
 2 files changed, 8 insertions(+), 58 deletions(-)

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
index 90cb285d6..0f5071a20 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -146,14 +146,14 @@ static void setup(void)
 		tst_brk(TBROK,
 		        "missing number of mapping children, specify with -p nprocs");
 
-#ifdef LARGE_FILE
+#if _FILE_OFFSET_BITS == 64
 	if (tst_parse_filesize(opt_filesize, &filesize, 0, LONG_MAX))
 #else
 	if (tst_parse_filesize(opt_filesize, &filesize, 0, INT_MAX))
 #endif
 		tst_brk(TBROK, "invalid initial filesize '%s'", opt_filesize);
 
-#ifdef LARGE_FILE
+#if _FILE_OFFSET_BITS == 64
 	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, LONG_MIN, LONG_MAX))
 #else
 	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, INT_MIN, INT_MAX))
@@ -192,11 +192,7 @@ static void run(void)
 	int i;
 	int write_cnt;
 	unsigned char data;
-#ifdef LARGE_FILE
-	off64_t bytes_left;
-#else /* LARGE_FILE */
 	off_t bytes_left;
-#endif /* LARGE_FILE */
 
 	seed = initrand();
 	pattern = seed & 0xff;
@@ -223,11 +219,7 @@ static void run(void)
 			tst_brk(TFAIL, "sigaction error");
 		(void)alarm(alarmtime);
 	}
-#ifdef LARGE_FILE
-	if ((fd = open64(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#else /* LARGE_FILE */
 	if ((fd = open(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "open error");
 	}
 
@@ -244,11 +236,7 @@ static void run(void)
 		if (++data == nprocs)
 			data = 0;
 	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, (off64_t)sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
 	if (lseek(fd, (off_t)sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "lseek");
 	}
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
@@ -381,15 +369,9 @@ static void cleanup(void)
  */
 void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
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
@@ -404,19 +386,11 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
 	seed = initrand();	/* initialize random seed */
 
-#ifdef LARGE_FILE
-	if (stat64(file, &statbuf) == -1)
-#else /* LARGE_FILE */
 	if (stat(file, &statbuf) == -1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "stat error");
 	filesize = statbuf.st_size;
 
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDWR)) == -1)
-#else /* LARGE_FILE */
 	if ((fd = open(file, O_RDWR)) == -1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "open error");
 
 	if (statbuf.st_size - sparseoffset > UINT_MAX)
@@ -437,13 +411,8 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
 		        procno, getpid(), seed, (long long)filesize,
 		        (long)mapsize, (long long)offset / pagesize, nloops);
-#ifdef LARGE_FILE
-	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-	                    fd, offset)) == (caddr_t) - 1)
-#else /* LARGE_FILE */
 	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
 	                  fd, offset)) == (caddr_t) - 1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "mmap error");
 
 	(void)close(fd);
@@ -494,11 +463,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
  */
 int fileokay(char *file, unsigned char *expbuf)
 {
-#ifdef LARGE_FILE
-	struct stat64 statbuf;
-#else /* LARGE_FILE */
 	struct stat statbuf;
-#endif /* LARGE_FILE */
 	size_t mapsize;
 	unsigned int mappages;
 	unsigned int pagesize = sysconf(_SC_PAGE_SIZE);
@@ -507,25 +472,13 @@ int fileokay(char *file, unsigned char *expbuf)
 	int cnt;
 	unsigned int i, j;
 
-#ifdef LARGE_FILE
-	if ((fd = open64(file, O_RDONLY)) == -1)
-#else /* LARGE_FILE */
 	if ((fd = open(file, O_RDONLY)) == -1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "open error");
 
-#ifdef LARGE_FILE
-	if (fstat64(fd, &statbuf) == -1)
-#else /* LARGE_FILE */
 	if (fstat(fd, &statbuf) == -1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "stat error");
 
-#ifdef LARGE_FILE
-	if (lseek64(fd, sparseoffset, SEEK_SET) < 0)
-#else /* LARGE_FILE */
 	if (lseek(fd, sparseoffset, SEEK_SET) < 0)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "lseek");
 
 	if (statbuf.st_size - sparseoffset > UINT_MAX)
@@ -554,15 +507,10 @@ int fileokay(char *file, unsigned char *expbuf)
 		 */
 		for (j = 0; j < (unsigned int)cnt; j++) {
 			if (expbuf[j] != readbuf[j]) {
-				tst_res(TINFO, "read bad data: exp %c got %c)",
-				        expbuf[j], readbuf[j]);
-#ifdef LARGE_FILE
-				tst_res(TINFO, ", pg %d off %d, (fsize %Ld)",
-				        i, j, statbuf.st_size);
-#else /* LARGE_FILE */
-				tst_res(TINFO, ", pg %d off %d, (fsize %ld)",
-				        i, j, statbuf.st_size);
-#endif /* LARGE_FILE */
+				tst_res(TINFO,
+				        "read bad data: exp %c got %c, pg %d off %d, (fsize %lld)",
+				        expbuf[j], readbuf[j], i, j,
+				        (long long)statbuf.st_size);
 				close(fd);
 				return 0;
 			}
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
