Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC1BC001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:57:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79DFC3CDA77
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:57:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B308A3CD06E
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69CB910001B7
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EDE721875
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcnkJcVZ7awYt0eaJouCrcrHhWdyxEhyjzbZ5sRu3qU=;
 b=jzUMHKns5MOsDKly6ItcdsAVXLABY8OkZkH3/7AnARqCcgCU/50leJKQEGd016yJPvDpBM
 Rk4Uq1nCHcme4tvQX9/tra+P8y0hXMJKHl6JRbu98FF5ZcLd83S+W3ouJdzpH25jJj0dg8
 O0eT6TVPocRmNRM7pksKnThSQPLjtJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcnkJcVZ7awYt0eaJouCrcrHhWdyxEhyjzbZ5sRu3qU=;
 b=0codm1NQcH5EJcAO1dQgsITDjj1uMukCgyjIcFAl4yuSBfCGlGxutCle9h5QsL6xLTQJL1
 wKPySVlDfSg2CuBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D4F7138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zuqYEcMh1mQCWwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:42 +0200
Message-ID: <20230811115647.32387-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
