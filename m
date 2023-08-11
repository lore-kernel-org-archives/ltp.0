Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD92C0015E
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:56:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 232C63CD07D
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:56:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09C853CC82C
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D3E7140096C
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA49021857
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcnkJcVZ7awYt0eaJouCrcrHhWdyxEhyjzbZ5sRu3qU=;
 b=W+zCoZcvvIrAx996e8L1Q2F6Wl5mRHD22hyybyLa7F3jN3p66YF55kW5Bn1JitJCjdLI6n
 unnTD4Z1BIhb2Hh7UarWFJa4WPT2xvA4BYBXIJ2fkWT7ozslK5kvb7RpFUkrb+XeTro0q2
 nR9dO0VDAIC+zs5vxT7PH4LavUB9arw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcnkJcVZ7awYt0eaJouCrcrHhWdyxEhyjzbZ5sRu3qU=;
 b=2Stua3QBnPluI8B4fAQdWqf6hC9u0zBPFM1OE1Su5bKpBf515sRVEVKU3wvOil0+Wka7yR
 Q3LA5lYH7sCeYYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C83BB138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IRvBL8Ih1mT9WgAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:46 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:41 +0200
Message-ID: <20230811115647.32387-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] lib: tst_buffers: Add bufs .str and tst_aprintf()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_buffers.h | 11 +++++++++++
 lib/tst_buffers.c     | 28 +++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/tst_buffers.h b/include/tst_buffers.h
index d19ac8cf0..b5f355f0f 100644
--- a/include/tst_buffers.h
+++ b/include/tst_buffers.h
@@ -25,6 +25,11 @@ struct tst_buffers {
 	 * Array of iov buffer sizes terminated by -1.
 	 */
 	int *iov_sizes;
+	/*
+	 * If size and iov_sizes is NULL this is the string we want to strdup()
+	 * into the buffer.
+	 */
+	char *str;
 };
 
 /*
@@ -46,6 +51,12 @@ char *tst_strdup(const char *str);
  */
 void *tst_alloc(size_t size);
 
+/*
+ * Printf into a guarded buffer.
+ */
+char *tst_aprintf(const char *fmt, ...)
+      __attribute__((format (printf, 1, 2)));
+
 /*
  * Allocates iovec structure including the buffers.
  *
diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
index b8b597a12..b0bd359eb 100644
--- a/lib/tst_buffers.c
+++ b/lib/tst_buffers.c
@@ -5,6 +5,7 @@
 
 #include <sys/mman.h>
 #include <stdlib.h>
+#include <stdio.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 
@@ -76,6 +77,25 @@ void *tst_alloc(size_t size)
 	return ret + map->buf_shift;
 }
 
+char *tst_aprintf(const char *fmt, ...)
+{
+	va_list va;
+	int len;
+	char *ret;
+
+        va_start(va, fmt);
+        len = vsnprintf(NULL, 0, fmt, va)+1;
+        va_end(va);
+
+	ret = tst_alloc(len);
+
+	va_start(va, fmt);
+        vsprintf(ret, fmt, va);
+        va_end(va);
+
+	return ret;
+}
+
 static int count_iovec(int *sizes)
 {
 	int ret = 0;
@@ -115,15 +135,17 @@ void tst_buffers_alloc(struct tst_buffers bufs[])
 	for (i = 0; bufs[i].ptr; i++) {
 		if (bufs[i].size)
 			*((void**)bufs[i].ptr) = tst_alloc(bufs[i].size);
-		else
+		else if (bufs[i].iov_sizes)
 			*((void**)bufs[i].ptr) = tst_iovec_alloc(bufs[i].iov_sizes);
+		else
+			*((void**)bufs[i].ptr) = tst_strdup(bufs[i].str);
 	}
 }
 
 char *tst_strdup(const char *str)
 {
-	size_t len = strlen(str);
-	char *ret = tst_alloc(len + 1);
+	char *ret = tst_alloc(strlen(str) + 1);
+
 	return strcpy(ret, str);
 }
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
