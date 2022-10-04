Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECB6C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 18:21:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1FB73CABEA
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 20:21:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 403123CAD76
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:20 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5D2831A010F7
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 20:21:19 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 m3-20020a170902bb8300b0017f7e7e4385so205501pls.20
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date;
 bh=GROnVb91ObSkQjtl2A8OjrHhW6Lh57XNN2m+6ey3+q8=;
 b=i6J4U+EZaMoxOsDl5t/jsfCl0eV+Hf/ev/Vn8FSTm5yYMg8wf8aMHmaJrtPsh1ZuYr
 DIN6r9cDUosTEKm9ORWu0NSQ1TmLRoTxbNg75tQEaq69xWyIZUNuPBRYcbHgTQCloSrY
 z4d1ZSM5nBj39xvgCVy+m7wru7bFtjJ/FJMBrZOzyC8UpK69lCDlwBV2B2+xrB0VVK0z
 YscM4FpAEfL7gulRujuWfpyZ/gd03Uz5U9YaRzERI6m2dUnLdgpnu8nIhy8NZ1yWOZeS
 1L9qX4wVcI9pcoAbGcmM5aA1I3qPrgRXYzrsd4EuXshP9N4ToP4pWpxmvs/xBRXqdF/d
 nwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date;
 bh=GROnVb91ObSkQjtl2A8OjrHhW6Lh57XNN2m+6ey3+q8=;
 b=unFbzaj+ZOXcYQVhZEcPHN7X5mBxUyCxkb0DVAhu/YsouUuPVX+lAxXhegEQPoGDWT
 1XPXlDzGs1faiBbi4rSzbYShOznTdqYbxSDP9H9x0kGeZNo8CwBvGUlBnV8xR6niTUl2
 pzahKAQunkmGG3Kt6v1bRifr664M/anhYYdpW5ID29wbu/dHn13g6kyyMqM51wnNBZY/
 /8qvXhlk+tR8vt8scSW04Tx7hwaN6N7PY1+ydKtbxCP4Uw9RB6+tJCJipNTEWoxN28sN
 6WS8VsiENWoxcbQuk7QiIYWnKCoXYmpkWVbsiTy6hXSLOv3IDMmYrYQZ25i5/h070BWI
 TQFw==
X-Gm-Message-State: ACrzQf1yUB0KxnY0oFpEaJXTxWgs9JnTtsQhu6z8H1iOPfRtXBCi1Fzo
 ueRBELyagR+9mNmIR73wLYk53Zt7wW9LceR6xlkPmVCnG7dayVT0LxugYOHQLhJmiH3caHVIaqo
 HSZVYUKs7ZWIqOOhpqnE24uSmf9hCO6TxcaMxE56l6sQ3LmwlVmBK7CJz
X-Google-Smtp-Source: AMsMyM6nCq3ehp7gHiS/AksenKph0f7tWwj9HD407qmEk/3/A356rX98D6QwokQQekche9GVD35k7SlMeQY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:5b16:0:b0:439:ac9b:34b5 with SMTP id
 p22-20020a635b16000000b00439ac9b34b5mr24260973pgb.144.1664907677616; Tue, 04
 Oct 2022 11:21:17 -0700 (PDT)
Date: Tue,  4 Oct 2022 18:20:33 +0000
In-Reply-To: <20221004182040.1859774-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221004182040.1859774-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004182040.1859774-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/9] mmapstress01: apply make check suggestions
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
 .../kernel/mem/mmapstress/mmapstress01.c      | 87 ++++++++-----------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 41f94a52a..20574314b 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -86,46 +86,36 @@
 #endif
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
 
-extern time_t time(time_t *);
-extern char *ctime(const time_t *);
-extern void *malloc(size_t);
-extern long lrand48(void);
-extern void srand(unsigned int);
-extern void srand48(long);
-extern int rand(void);
-extern int atoi(const char *);
-
 static char *usage =
-    "-p nprocs [-t minutes -f filesize -S sparseoffset -r -o -m -l -d]";
+	"-p nprocs [-t minutes -f filesize -S sparseoffset -r -o -m -l -d]";
 
 static unsigned int initrand(void);
 static void finish(int sig);
 static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
 static int fileokay(char *file, unsigned char *expbuf);
-static int finished = 0;
-static int leavefile = 0;
+static int finished;
+static int leavefile;
 
-static float alarmtime = 0;
-static unsigned int nprocs = 0;
+static float alarmtime;
+static unsigned int nprocs;
 
-static pid_t *pidarray = NULL;
+static pid_t *pidarray;
 static int wait_stat;
 static int check_for_sanity;
-static unsigned char *buf = NULL;
-
+static unsigned char *buf;
 
-static int debug = 0;
+static int debug;
 #ifdef LARGE_FILE
 static off64_t filesize = FILESIZE;
-static off64_t sparseoffset = 0;
+static off64_t sparseoffset;
 #else /* LARGE_FILE */
 static off_t filesize = FILESIZE;
-static off_t sparseoffset = 0;
+static off_t sparseoffset;
 #endif /* LARGE_FILE */
-static unsigned int randloops = 0;
-static unsigned int dosync = 0;
-static unsigned int do_offset = 0;
-static unsigned int pattern = 0;
+static unsigned int randloops;
+static unsigned int dosync;
+static unsigned int do_offset;
+static unsigned int pattern;
 
 int main(int argc, char *argv[])
 {
@@ -148,9 +138,8 @@ int main(int argc, char *argv[])
 #endif /* LARGE_FILE */
 
 	progname = *argv;
-	if (argc < 2) {
+	if (argc < 2)
 		tst_brk(TBROK, "usage: %s %s", progname, usage);
-	}
 
 	while ((c = getopt(argc, argv, "S:omdlrf:p:t:")) != -1) {
 		switch (c) {
@@ -192,7 +181,7 @@ int main(int argc, char *argv[])
 #endif /* LARGE_FILE */
 			if (sparseoffset % pagesize != 0)
 				tst_brk(TBROK,
-				        "sparseoffset must be pagesize multiple");
+					"sparseoffset must be pagesize multiple");
 			break;
 		default:
 			tst_brk(TBROK, "usage: %s %s", progname, usage);
@@ -208,15 +197,15 @@ int main(int argc, char *argv[])
 
 	if (debug) {
 #ifdef LARGE_FILE
-		tst_res(TINFO, "creating file <%s> with %Ld bytes, pattern %d",
-		        TEST_FILE, filesize, pattern);
+		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
+			TEST_FILE, filesize, pattern);
 #else /* LARGE_FILE */
 		tst_res(TINFO, "creating file <%s> with %ld bytes, pattern %d",
-		        TEST_FILE, filesize, pattern);
+			TEST_FILE, filesize, pattern);
 #endif /* LARGE_FILE */
 		if (alarmtime)
 			tst_res(TINFO, "running for %f minutes",
-			        alarmtime / 60);
+				alarmtime / 60);
 		else
 			tst_res(TINFO, "running with no time limit");
 	}
@@ -280,7 +269,7 @@ int main(int argc, char *argv[])
 				tst_res(TINFO, "write error");
 			else
 				tst_res(TINFO, "write: wrote %d of %d bytes",
-				        c, write_cnt);
+					c, write_cnt);
 			(void)close(fd);
 			(void)unlink(TEST_FILE);
 			tst_brk(TFAIL, "write error");
@@ -329,13 +318,13 @@ int main(int argc, char *argv[])
 			if (!WIFEXITED(wait_stat)
 			    || WEXITSTATUS(wait_stat) != 0)
 				tst_brk(TFAIL, "child exit with err <x%x>",
-				        wait_stat);
+					wait_stat);
 			for (i = 0; i < nprocs; i++)
 				if (pid == pidarray[i])
 					break;
 			if (i == nprocs)
 				tst_brk(TFAIL, "unknown child pid %d, <x%x>",
-				        pid, wait_stat);
+					pid, wait_stat);
 
 			if ((pid = fork()) == -1) {
 				pidarray[i] = 0;
@@ -449,6 +438,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 	if (do_offset) {
 		int pageoffset = lrand48() % mappages;
 		int byteoffset = pageoffset * pagesize;
+
 		offset += byteoffset;
 		mapsize -= byteoffset;
 		mappages -= pageoffset;
@@ -457,14 +447,14 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 
 	if (debug)
 		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
-		        procno, getpid(), seed, filesize, (long)mapsize,
-		        offset / pagesize, nloops);
+			procno, getpid(), seed, filesize, (long)mapsize,
+			offset / pagesize, nloops);
 #ifdef LARGE_FILE
 	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-	                    fd, (off64_t)offset)) == (caddr_t) - 1)
+			    fd, (off64_t)offset)) == (caddr_t) - 1)
 #else /* LARGE_FILE */
 	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
-	                  fd, (off_t)offset)) == (caddr_t) - 1)
+			  fd, (off_t)offset)) == (caddr_t) - 1)
 #endif /* LARGE_FILE */
 		tst_brk(TFAIL, "mmap error");
 
@@ -486,9 +476,9 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 			if (*((unsigned char *)(paddr + i))
 			    != ((procno + pattern) & 0xff))
 				tst_brk(TFAIL, "child %d: invalid data <x%x>\n"
-				        " at pg %d off %d, exp <x%x>", procno,
-				        *((unsigned char *)(paddr + i)),
-				        randpage, i, (procno + pattern) & 0xff);
+					" at pg %d off %d, exp <x%x>", procno,
+					*((unsigned char *)(paddr + i)),
+					randpage, i, (procno + pattern) & 0xff);
 
 			/*
 			 *  Now write it.
@@ -503,7 +493,7 @@ void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
 		randpage = lrand48() % mappages;
 		paddr = maddr + (randpage * pagesize);	/* page address */
 		if (msync(paddr, (mappages - randpage) * pagesize,
-		          MS_SYNC) == -1)
+			  MS_SYNC) == -1)
 			tst_brk(TFAIL, "msync failed");
 	}
 	if (munmap(maddr, mapsize) == -1)
@@ -566,7 +556,7 @@ int fileokay(char *file, unsigned char *expbuf)
 			 */
 			if ((i * pagesize) + cnt != mapsize) {
 				tst_res(TINFO, "read %d of %ld bytes",
-				        (i * pagesize) + cnt, (long)mapsize);
+					(i * pagesize) + cnt, (long)mapsize);
 				close(fd);
 				return 0;
 			}
@@ -577,13 +567,13 @@ int fileokay(char *file, unsigned char *expbuf)
 		for (j = 0; j < (unsigned int)cnt; j++) {
 			if (expbuf[j] != readbuf[j]) {
 				tst_res(TINFO, "read bad data: exp %c got %c)",
-				        expbuf[j], readbuf[j]);
+					expbuf[j], readbuf[j]);
 #ifdef LARGE_FILE
 				tst_res(TINFO, ", pg %d off %d, "
-				        "(fsize %Ld)", i, j, statbuf.st_size);
+					"(fsize %lld)", i, j, statbuf.st_size);
 #else /* LARGE_FILE */
 				tst_res(TINFO, ", pg %d off %d, "
-				        "(fsize %ld)", i, j, statbuf.st_size);
+					"(fsize %ld)", i, j, statbuf.st_size);
 #endif /* LARGE_FILE */
 				close(fd);
 				return 0;
@@ -598,7 +588,6 @@ int fileokay(char *file, unsigned char *expbuf)
 void finish(int sig LTP_ATTRIBUTE_UNUSED)
 {
 	finished++;
-	return;
 }
 
 unsigned int initrand(void)
@@ -617,8 +606,8 @@ unsigned int initrand(void)
 	seed = rand();
 	srand((unsigned int)time(NULL));
 	seed = (seed ^ rand()) % 100000;
-	srand48((long int)seed);
-	return (seed);
+	srand48((long)seed);
+	return seed;
 }
 
 static struct tst_test test = {
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
