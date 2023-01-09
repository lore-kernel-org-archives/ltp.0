Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA5C5479D
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 12:53:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD9B23CCBCD
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 13:53:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F3403CB5A0
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 13:52:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AEF8A600635
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 13:52:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4D1B2340BB;
 Mon,  9 Jan 2023 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673268775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+djHWY71XQ/WoDBMvlFZu52NAQZ78r4R5740Fjx+USQ=;
 b=Ovz4j4+pXT/7aF0D5aN9ulZlYXkosiXVsx+XTUynlJQ3Mpj1fjarP1Bv1XgdFzoKl87Fhi
 Q8eZWO4n7cy2+MGwFiq2oBMOq3N5BD5I/c59nY5eK58adNk3DUJnpx2YBNBc6X4VRf7YMz
 XfxBzHgaScB35WKg5MG1s3SfCON1SrQ=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 247A22C142;
 Mon,  9 Jan 2023 12:52:55 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  9 Jan 2023 12:52:33 +0000
Message-Id: <20230109125234.4232-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109125234.4232-1-rpalethorpe@suse.com>
References: <20230109125234.4232-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] aiocp: Don't use O_DIRECT when writing random file
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The initial write doesn't need to use O_DIRECT and could fail because
the write sizes were not aligned. This drops O_DIRECT on the initial
write.

Also it switches to using the static data from tst_rand_data. This is
better for reproducibility.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/io/ltp-aiodio/aiocp.c | 36 ++++++--------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index 275000f3e..cace924a2 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -27,6 +27,8 @@
 #include <sys/stat.h>
 #include "common.h"
 
+#include "tst_rand_data.h"
+
 static const char *srcname = "srcfile.bin";
 static const char *dstname = "dstfile.bin";
 
@@ -55,35 +57,13 @@ static int iocb_free_count;
 
 static void fill_with_rand_data(int fd, long long size)
 {
-	const int bufsize = 64 * 1024;
-	const int lower = 'a';
-	const int upper = 'z';
-	char buf[bufsize];
-	long long i = 0, j;
-	long long length, towrite;
-
-	srand(time(NULL));
-
-	for (j = 0; j < bufsize; j++)
-		buf[j] = (rand() % (upper - lower + 1)) + lower;
+	long long i = size;
 
-	if (size <= bufsize) {
-		SAFE_WRITE(0, fd, buf, size);
-		return;
+	while (i > 0) {
+		SAFE_WRITE(1, fd, tst_rand_data,
+			   MIN((long long)tst_rand_data_len, i));
+		i -= tst_rand_data_len;
 	}
-
-	while (i < size) {
-		if (!tst_remaining_runtime())
-			tst_brk(TCONF, "Out of runtime!");
-
-		length = rand() % (bufsize / 2) + bufsize / 2;
-		towrite = MIN(length, size - i);
-
-		i += towrite;
-
-		SAFE_WRITE(1, fd, buf, towrite);
-	}
-
 	SAFE_FSYNC(fd);
 }
 
@@ -266,7 +246,7 @@ static void setup(void)
 
 	tst_res(TINFO, "Fill %s with random data", srcname);
 
-	srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
+	srcfd = SAFE_OPEN(srcname, (srcflags & ~O_DIRECT) | O_RDWR | O_CREAT, 0666);
 	fill_with_rand_data(srcfd, filesize);
 	SAFE_CLOSE(srcfd);
 }
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
