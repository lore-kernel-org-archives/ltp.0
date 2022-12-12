Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C9AC4167B
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 13:55:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25DFC3CBE5C
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:55:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAFE53CBE3E
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 14:55:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A9AD140044F
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 14:55:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 38F2A1FEA3;
 Mon, 12 Dec 2022 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1670853341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcnIgkyP+pswBZSeZdNS4cVibgYS/EXHhjNLAhX1m3g=;
 b=V3ULtLUd4TBo0TJai7hZRbjf+BzP5GufbvlRXDVh+96abVT9mP8RLCzJBvfxJC6S1xz6aj
 wnB2LciZ9uc808ddLi5WqH6W24IXzigd+JKOEza9GSptRxzlDvBBnFaA4vG63d5Gdemze2
 MZ8pITnnaIx2KhRq2McAlkMgOsTIY6U=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 062772C141;
 Mon, 12 Dec 2022 13:55:40 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 12 Dec 2022 13:55:23 +0000
Message-Id: <20221212135524.1333-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212135524.1333-1-rpalethorpe@suse.com>
References: <20221212135524.1333-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] tst_fill_fs: Ensure data is not easily
 compressed
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

If the stack is auto initialized to zero, then we will write all
zeros. Some FS may treat this as a special case and just record the
number of zero bytes or sectors.

This could alter the test behaviour in unpredictable ways. For example
a large number of (slow) syscalls may be required to fill up the
drive, extending the required test time. Or we could overflow the file
size/offset causing EFBIG.

So this uses tst_rand_data.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_fill_fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 121dd2f20..1d6d76abd 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -11,16 +11,17 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_fs.h"
+#include "tst_rand_data.h"
 
 void tst_fill_fs(const char *path, int verbose)
 {
 	int i = 0;
 	char file[PATH_MAX];
-	char buf[4096];
 	size_t len;
 	ssize_t ret;
 	int fd;
 	struct statvfs fi;
+
 	statvfs(path, &fi);
 
 	for (;;) {
@@ -41,7 +42,7 @@ void tst_fill_fs(const char *path, int verbose)
 		}
 
 		while (len) {
-			ret = write(fd, buf, MIN(len, sizeof(buf)));
+			ret = write(fd, tst_rand_data, MIN(len, tst_rand_data_len));
 
 			if (ret < 0) {
 				/* retry on ENOSPC to make sure filesystem is really full */
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
