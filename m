Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5D3C32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 18:27:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 645933CADE3
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 20:27:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFCF3CAE07
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:47 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A22C81400BF8
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 20:26:46 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 l72-20020a63914b000000b00434ac6f8214so4421633pge.13
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=T8EsmXKIjyJSRYbPx2IBPn6I+boorNp+KAXmUbsM+mg=;
 b=HYaCIz874UQwG+Mj/lmRc9pxNOV43CdtSEdqsz7oVDQMEUceoS5fHr7g5tyxq9Z0u3
 vWC5Noanp2rydqf8ti3I5gH2GyLutaEjgVZWigWdg5l5VFXZB9ymR0t39WuwsUK0KpFl
 LRTDkREeVfheQhb5L9w/EnymdE4m73IaXk2nb8PMjdKac3ZWfUVftnmyYYigDN7nqMUS
 0gSTjtU0787oouGQZLWGrqm5ZsXSFzC8/cD9WmJeU389AvhfiBc0/mVuqy5UT3WbUmep
 QXblOyekL7Ga3c6EPoYKIl8yAl95V1wI3Nh2UjONbLjAxb+5n5aNH/N8N1bYn8MCXz4o
 HKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=T8EsmXKIjyJSRYbPx2IBPn6I+boorNp+KAXmUbsM+mg=;
 b=igT6Ryn4e21FeK6WliWE1nJmsPXcZrY8ISHx4Jx0htryzTeMVBsa6MX1+/6mI9jAP3
 27w9EWpKM/kJoWWdAtXMEWOOETfMin1Lt0YlY8BULvdj0xaCIu/LDsFQhyZu4yrt5Y/V
 frQ0Pby6/MbW64gtltfz3BX84dbhJF6n9FGWnljC5kuDgKSOlfNpPlniT58UZZmfIUmw
 4RFmZws7qR6jjwUAeZLtYFJDEhkwJi9pltDCZW1EwyjoqLb/PVDEnUY97SkUZor4xSVm
 poBI2XkK5rCjrgJPKXpj3IDdNkrfbl+NrVap3WJC5IczrvtdUaj//TrRqLN3Nd99s1f4
 brMQ==
X-Gm-Message-State: ACrzQf0Eos9ORRKaXBJM15iXXHUoytJ4RGNR+ljALRVpm25fRP/l5FIj
 HGKlzz7pytYHhVT2MD8M3/b8Gq4Z24F8PYRo3pL7AY8WK7rF/kWSR4VIHCbb/lE7lFrEXwErB/V
 hUmAteVNolwbuTEZeLJ1i5fahQu0t50gG/ZpWuZCOETFWxgfjSlHKb5OQ
X-Google-Smtp-Source: AMsMyM60xAW3c9GASvX884+z1ND2C03R+sDqMFGpKPoB0sky3gC7kCyP/HVhwrMIdZjdOOaQGvCO+ooX56c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr2125pju.0.1664216803755; Mon, 26 Sep
 2022 11:26:43 -0700 (PDT)
Date: Mon, 26 Sep 2022 18:26:24 +0000
In-Reply-To: <20220926182625.103275-1-edliaw@google.com>
Mime-Version: 1.0
References: <20220926182625.103275-1-edliaw@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926182625.103275-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/4] mmapstress01: use FILE_OFFSET_BITS=64
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 57 +------------------
 2 files changed, 4 insertions(+), 55 deletions(-)

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
index aad4ba942..cb18241de 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -140,14 +140,14 @@ static void setup(void)
 	if (!opt_nprocs)
 		tst_brk(TBROK, "missing number of mapping children, specify with -p nprocs");
 
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
@@ -186,11 +186,7 @@ static void run(void)
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
@@ -217,11 +213,7 @@ static void run(void)
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
 
@@ -238,11 +230,7 @@ static void run(void)
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
@@ -371,15 +359,9 @@ static void cleanup(void)
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
@@ -394,19 +376,11 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
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
@@ -428,13 +402,8 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			     "mapsize %ld, off %lld, loop %d",
 			     procno, getpid(), seed, (long long)filesize, (long)mapsize,
 			     (long long)offset / pagesize, nloops);
-#ifdef LARGE_FILE
-	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-			    fd, offset)) == (caddr_t) - 1)
-#else /* LARGE_FILE */
 	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
 			  fd, offset)) == (caddr_t) - 1)
-#endif /* LARGE_FILE */
 		tst_brk(TFAIL, "mmap error");
 
 	(void)close(fd);
@@ -485,11 +454,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
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
@@ -498,25 +463,13 @@ int fileokay(char *file, unsigned char *expbuf)
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
@@ -549,15 +502,9 @@ int fileokay(char *file, unsigned char *expbuf)
 				tst_res(TINFO,
 					      "read bad data: exp %c got %c)",
 					      expbuf[j], readbuf[j]);
-#ifdef LARGE_FILE
-				tst_res(TINFO, ", pg %d off %d, "
-					      "(fsize %Ld)", i, j,
-					      statbuf.st_size);
-#else /* LARGE_FILE */
 				tst_res(TINFO, ", pg %d off %d, "
 					      "(fsize %ld)", i, j,
 					      statbuf.st_size);
-#endif /* LARGE_FILE */
 				close(fd);
 				return 0;
 			}
-- 
2.37.3.998.g577e59143f-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
