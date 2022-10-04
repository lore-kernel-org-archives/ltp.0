Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32BEC433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:22:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C96C83CA47E
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:22:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCC853CAA6E
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:24 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 24F731400F4F
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:23 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 p24-20020a63f458000000b0043cd718c49dso9315363pgk.15
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=NUXp1GUoKzZ6pS2psJ+v0XBDnpOwJ+u8Hnl0KOX3f38=;
 b=BFvT5TPJhgr5t/Gjq9c3P3Z2ydaxHEnjsWP3+ASnYZC7aQn+mxD7D0pQIckBYAc47G
 V5NCE1ecOJpcbCmI0hNy1Zz20SZPQdWWhxHa8GL8kYh1xxGCq+hqmRgfJN2Slxdtv4Dt
 9u06unMtd7/YwWgNgAoYuE26JZGRe1ndSg6QV82xJ0s28FXNPj4u0ZJPGhGch4FjVfvA
 0WGMI0B8EF9hKjKHqf0FcT3SmEBjCDFk1/64q+S6LG8Vi9LaUTzL8BJEQjT6AaWrdwu8
 K0177UkIpaP6/stQRGSTRlpe8b66ejzB5JuDqx8Mfql8sMm3HQ+4UQV8UYi628DxO3NP
 pIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=NUXp1GUoKzZ6pS2psJ+v0XBDnpOwJ+u8Hnl0KOX3f38=;
 b=174ftFLiHks6X0Y7GIwnLLIB08Vg6ud7/eTkhhKFRG3aCgoqY6SUf57oUXJVo/IYMx
 9tQKWXsP4Di3Lp+g0paPF9tsBWXqyl9CvK71vNFToSmKliboqYxkGy6ZwttRtPLJEr7c
 KV8mPGbiQXIdAczOS7M7OfR57bYT58E/Ohr5uozGWCn0vltvtt67DUsFXfXq509rUaed
 OUQ7+1CVmKB4LqpFZqSAT1A8/VXTavxqLPyk1m6xsFnSKsO0IWnuCG++APYSAmIYOxPD
 ku4lwnJ9+4/493NyuAxGBkLEcuYpxU/cvoUYT18LZJO3zhxgsBEnIaMpeomttWhs7x6e
 yAOw==
X-Gm-Message-State: ACrzQf2hvxz7ysQqjH0eIofxOi+oPJvJSUIhAkBzko09EJXhA6+s0E9q
 gSUHJtGrViLJN6a88r97fN/b7hgV6/IJtbzYmNct3fEWdEy8WYY6trF9HitTySddHg0MvTAnxwI
 O8qUehxQazJNE3dbRJYuPOIPjU8RfQstwSN3tLWWPfAzMk5NGHlgGwx8J
X-Google-Smtp-Source: AMsMyM6IkB6TAL6lw6V5vZBHaOYDZooc9wpAkJwvoL1cuqeoCjZPn2h4pYjCOJim1aIcOMjlX6GnHeBLdzc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr370445pju.0.1664907680966; Tue, 04 Oct
 2022 11:21:20 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:35 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/9] mmapstress01: use FILE_OFFSET_BITS=64
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 70 +++----------------
 2 files changed, 10 insertions(+), 62 deletions(-)

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
index 33213a0f0..3f7f617c6 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -139,14 +139,14 @@ static void setup(void)
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
@@ -185,11 +185,7 @@ static void run(void)
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
@@ -216,13 +212,8 @@ static void run(void)
 			tst_brk(TFAIL, "sigaction error");
 		(void)alarm(alarmtime);
 	}
-#ifdef LARGE_FILE
-	if ((fd = open64(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#else /* LARGE_FILE */
-	if ((fd = open(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
-#endif /* LARGE_FILE */
+	if ((fd = open(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1)
 		tst_brk(TFAIL, "open error");
-	}
 
 	if ((buf = malloc(pagesize)) == NULL
 	    || (pidarray = malloc(nprocs * sizeof(pid_t))) == NULL) {
@@ -237,13 +228,8 @@ static void run(void)
 		if (++data == nprocs)
 			data = 0;
 	}
-#ifdef LARGE_FILE
-	if (lseek64(fd, (off64_t)sparseoffset, SEEK_SET) < 0) {
-#else /* LARGE_FILE */
-	if (lseek(fd, (off_t)sparseoffset, SEEK_SET) < 0) {
-#endif /* LARGE_FILE */
+	if (lseek(fd, (off_t)sparseoffset, SEEK_SET) < 0)
 		tst_brk(TFAIL, "lseek");
-	}
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
 		write_cnt = MIN(pagesize, (int)bytes_left);
 		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
@@ -374,15 +360,9 @@ static void cleanup(void)
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
@@ -397,19 +377,11 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
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
@@ -431,13 +403,8 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
 			procno, getpid(), seed, (long long)filesize,
 			(long)mapsize, (long long)offset / pagesize, nloops);
-#ifdef LARGE_FILE
-	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			    fd, offset)) == (caddr_t) - 1)
-#else /* LARGE_FILE */
 	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
 			  fd, offset)) == (caddr_t) - 1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "mmap error");
 
 	(void)close(fd);
@@ -488,11 +455,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
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
@@ -501,25 +464,13 @@ int fileokay(char *file, unsigned char *expbuf)
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
@@ -548,15 +499,10 @@ int fileokay(char *file, unsigned char *expbuf)
 		 */
 		for (j = 0; j < (unsigned int)cnt; j++) {
 			if (expbuf[j] != readbuf[j]) {
-				tst_res(TINFO, "read bad data: exp %c got %c)",
-					expbuf[j], readbuf[j]);
-#ifdef LARGE_FILE
-				tst_res(TINFO, ", pg %d off %d, (fsize %lld)",
-					i, j, statbuf.st_size);
-#else /* LARGE_FILE */
-				tst_res(TINFO, ", pg %d off %d, (fsize %ld)",
-					i, j, statbuf.st_size);
-#endif /* LARGE_FILE */
+				tst_res(TINFO,
+					"read bad data: exp %c got %c, pg %d off %d, (fsize %lld)",
+					expbuf[j], readbuf[j], i, j,
+					(long long)statbuf.st_size);
 				close(fd);
 				return 0;
 			}
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
