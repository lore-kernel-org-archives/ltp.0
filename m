Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98AC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 16:21:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523C060F70
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 16:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 523C060F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A3613CA2B2
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 18:21:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16E4C3C21AC
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 18:21:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5985C60069E
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 18:21:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D9911FEF5
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632241259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EvfDgcgBusCbv99IrQHltWvkCsZ5ocH8Jdd+Cn91IZc=;
 b=QFiX7IjD3/n+ZzlbMiVO8wO8F8EO0CzeON/6viBKffo4r93++nVQhIaRde/vT73fWXHaIA
 FH6KoAP+bnqdIJlqt2+hPGjKpyqY0Bu9pgJHXIyGpOqzzHfmxOUx/eknIAwjTJWQLkh4wK
 895MUTPQahfWfVvcVQEU7rlMtQXb75c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632241259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EvfDgcgBusCbv99IrQHltWvkCsZ5ocH8Jdd+Cn91IZc=;
 b=WV0bnueG3pODDWJrDceRE0izRjT70+wVHQoPKWczzj5NT6AzT+B8cv14ELEbxZgYgA35mP
 QrFpKUelSkontrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8790013BD9
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8DFEH2sGSmGkGgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:20:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Sep 2021 18:20:56 +0200
Message-Id: <20210921162057.29598-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add SAFE_TRY_FILE_PRINTF() helper function
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

SAFE_TRY_FILE_PRINTF() works just like SAFE_FILE_PRINTF() but it quietly
returns if the path doesn't exist instead of terminating the test.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/safe_file_ops_fn.h  |  4 ++++
 include/tst_safe_file_ops.h |  5 +++++
 lib/safe_file_ops.c         | 34 ++++++++++++++++++++++++++--------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 6d680967b..e8ed85382 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -62,6 +62,10 @@ void safe_file_printf(const char *file, const int lineno,
                       const char *path, const char *fmt, ...)
                       __attribute__ ((format (printf, 5, 6)));
 
+void safe_try_file_printf(const char *file, const int lineno,
+	void (*cleanup_fn)(void), const char *path, const char *fmt, ...)
+	__attribute__ ((format (printf, 5, 6)));
+
 /*
  * Safe function to copy files, no more system("cp ...") please.
  */
diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 223eddd1f..62f6600ec 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -44,6 +44,11 @@
 	safe_file_printf(__FILE__, __LINE__, NULL, \
 	                 (path), (fmt), ## __VA_ARGS__)
 
+/* Same as SAFE_FILE_PRINTF() but returns quietly if the path doesn't exist */
+#define SAFE_TRY_FILE_PRINTF(path, fmt, ...) \
+	safe_try_file_printf(__FILE__, __LINE__, NULL, \
+		(path), (fmt), ## __VA_ARGS__)
+
 #define SAFE_CP(src, dst) \
 	safe_cp(__FILE__, __LINE__, NULL, (src), (dst))
 
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 249a512a1..f803691d8 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -250,11 +250,10 @@ err:
 	return 1;
 }
 
-void safe_file_printf(const char *file, const int lineno,
-		      void (*cleanup_fn) (void),
-		      const char *path, const char *fmt, ...)
+static void safe_file_vprintf(const char *file, const int lineno,
+	void (*cleanup_fn)(void), const char *path, const char *fmt,
+	va_list va)
 {
-	va_list va;
 	FILE *f;
 
 	f = fopen(path, "w");
@@ -265,16 +264,12 @@ void safe_file_printf(const char *file, const int lineno,
 		return;
 	}
 
-	va_start(va, fmt);
-
 	if (vfprintf(f, fmt, va) < 0) {
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
 			"Failed to print to FILE '%s'", path);
 		return;
 	}
 
-	va_end(va);
-
 	if (fclose(f)) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Failed to close FILE '%s'", path);
@@ -282,6 +277,29 @@ void safe_file_printf(const char *file, const int lineno,
 	}
 }
 
+void safe_file_printf(const char *file, const int lineno,
+	void (*cleanup_fn)(void), const char *path, const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	safe_file_vprintf(file, lineno, cleanup_fn, path, fmt, va);
+	va_end(va);
+}
+
+void safe_try_file_printf(const char *file, const int lineno,
+	void (*cleanup_fn)(void), const char *path, const char *fmt, ...)
+{
+	va_list va;
+
+	if (access(path, F_OK))
+		return;
+
+	va_start(va, fmt);
+	safe_file_vprintf(file, lineno, cleanup_fn, path, fmt, va);
+	va_end(va);
+}
+
 //TODO: C implementation? better error condition reporting?
 int safe_cp(const char *file, const int lineno,
 	     void (*cleanup_fn) (void), const char *src, const char *dst)
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
