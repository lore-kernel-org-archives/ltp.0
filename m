Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826B0C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 18:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDE883CAE03
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 20:43:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E4F3CAE27
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:37 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F962601202
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:37 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 m3-20020a632603000000b00459948fc453so1593626pgm.0
 for <ltp@lists.linux.it>; Thu, 06 Oct 2022 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IF2NZDUc7hA7wr+Xe5Cn0W2BgUC62MNZ0R5tnbEqBqE=;
 b=h5+F35g/92XI1Z3dQnoC/FiJ4vnj28guyyKTwcZT78WXh17o1Q15ea1zoGXdC8jLiH
 zcGMRhgls/TESUAudXrcodofkNSsou+qIlakGFGQu39CdTLx08JcC8U01RM562P3ZPW5
 /S98nl0CouqhO4K9HQA9qeKSwzxfrLj74Bc2ixnk+qkkzKlhPU+wU+Z6c8KZSaq8S+Ny
 lE6nNtutC/MGh7QJbLZuQaCWqkUQyEgpFaB1sXdule+D4ljXwDhEpMs55185jE3QHd3m
 m0QS52mB86dWna4quMHet8871ikNKrGV5EsiQFJdO8J+br2YzzF4q3FfY8HR8TCN5rRR
 em1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IF2NZDUc7hA7wr+Xe5Cn0W2BgUC62MNZ0R5tnbEqBqE=;
 b=pVWQBygAepyg99mNIcG5QAIBAOqZFcGa1fd8fhuvKv2kEEHL4rVwqUXYRVfy3iQYMY
 +4HSQf49Yz2Fm9F60c5FJ5J/nCrTHH0twJVB96ws9ZHn0Y9BwQFLbeKocqqOPyl9HI9B
 I3xN+kKHGjU8IpgScJ/EmBQzKOxPJ2a93Z438jM3g7WD5zVd49WTh82Iom1wlmF9aW0n
 lZmYV/ZQHu4BkyXOhHu6a72GziI5/X6kK3rR+otygma18u1j/TCkBxY4JcESKeV6y1gW
 HI/DVyWDxyvhYsI1K18bDnxxZGbHsH/jFzs9+InIhIF/k0nt+cEdXRqL4S2UJ108b3HR
 WiSw==
X-Gm-Message-State: ACrzQf05LOwLewh2Riv6SLL+LrGeQiNxyViENbXVyOTDjMPQX5GBeMWU
 OEdAP4cAcYnn7v8sVJrMj1sLDA1BY66rzIP62T4KEaSNHImQtueSb/UDT3Vxrnzoq0vqXQSlsbN
 QuNzHuYuzn5Vs9w91/sMyjrAGJ2O1DMi87uuPzWOUps03oUIOKkKjlH3r
X-Google-Smtp-Source: AMsMyM7mN/VYoS9soR6G7xyUZinjPp2LQUA3WSHl5MLf7gBssLfEP5S3t6/iHJXCjPHgcCofJ7efyRotHYQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ce82:b0:17a:234:cae6 with SMTP id
 f2-20020a170902ce8200b0017a0234cae6mr853192plg.174.1665081755716; Thu, 06 Oct
 2022 11:42:35 -0700 (PDT)
Date: Thu,  6 Oct 2022 18:42:26 +0000
In-Reply-To: <20221006184228.3281392-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221006184228.3281392-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006184228.3281392-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] mmapstress01: default nprocs 20 and cleanup
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

Drop usage information from top level comment and remove
unnecessary function definitions.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/mem/mmapstress/mmapstress01.c      | 46 +++----------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index f68193706..67a2b747d 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -18,33 +18,6 @@
  *  or times out (if a timeout value is specified).  When either of
  *  these things happens, it cleans up its kids, then checks the
  *  file to make sure it has the correct data.
- *
- *  usage:
- *	tmnoextend -p nprocs [-t minutes -f filesize -S sparseoffset
- *			      -r -o -m -l -d]
- *  where:
- *	-p nprocs	- specifies the number of mapping children
- *			  to create.  (nprocs + 1 children actually
- *			  get created, since one is the writer child)
- *	-t minutes	- specifies minutes to run.  If not specified,
- *			  default is to run forever until a SIGINT
- *			  is received.
- *	-f filesize	- initial filesize (defaults to FILESIZE)
- *	-S sparseoffset - when non-zero, causes a sparse area to
- *			  be left before the data, meaning that the
- *			  actual initial file size is sparseoffset +
- *			  filesize.  Useful for testing large files.
- *			  (default is 0).
- *	-r		- randomize number of pages map children check.
- *			  (random % MAXLOOPS).  If not specified, each
- *			  child checks MAXLOOPS pages.
- *	-o		- randomize offset of file to map. (default is 0)
- *	-m		- do random msync/fsyncs as well
- *	-l		- if set, the output file is not removed on
- *			  program exit.
- *	-d		- enable debug output
- *
- *  Compile with -DLARGE_FILE to enable file sizes > 2 GB.
  */
 
 #define _GNU_SOURCE 1
@@ -63,7 +36,6 @@
 #include "tst_test.h"
 
 #define MAXLOOPS	500	/* max pages for map children to write */
-#define	FILESIZE	4096	/* initial filesize set up by parent */
 #define TEST_FILE	"mmapstress01.out"
 
 #ifdef roundup
@@ -72,9 +44,6 @@
 #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
 
 static unsigned int initrand(void);
-static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
-static void fileokay(char *file, unsigned char *expbuf);
-static void sighandler(int sig);
 
 static char *debug;
 static char *do_sync;
@@ -87,9 +56,9 @@ static char *randloops;
 
 static int fd;
 static int finished;
-static int nprocs;
+static int nprocs = 20;
 static float alarmtime;
-static long long filesize = FILESIZE;
+static long long filesize = 4096;
 static long long sparseoffset;
 static size_t pagesize;
 static unsigned int pattern;
@@ -99,10 +68,11 @@ static struct tst_option options[] = {
 	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
 	{"m", &do_sync, "Do random msync/fsyncs as well"},
 	{"o", &do_offset, "Randomize the offset of file to map"},
-	{"p:", &opt_nprocs, "Number of mapping children to create (required)"},
+	{"p:", &opt_nprocs,
+	 "Number of mapping children to create (default 20)"},
 	{"r", &randloops,
-	 "Randomize number of pages map children check (random % MAXLOOPS), "
-	 "otherwise each child checks MAXLOOPS pages"},
+	 "Randomize number of pages map children check (random % 500), "
+	 "otherwise each child checks 500 pages"},
 	{"S:", &opt_sparseoffset,
 	 "When non-zero, causes the sparse area to be left before the data, "
 	 "so that the actual initial filesize is sparseoffset + filesize "
@@ -115,10 +85,6 @@ static void setup(void)
 {
 	int pagesize = sysconf(_SC_PAGE_SIZE);
 
-	if (!opt_nprocs)
-		tst_brk(TBROK,
-			"missing number of mapping children, specify with -p nprocs");
-
 #if _FILE_OFFSET_BITS == 64
 	if (tst_parse_filesize(opt_filesize, &filesize, 0, LONG_MAX))
 #else
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
