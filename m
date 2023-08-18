Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59335C001DE
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 11:20:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E29363CCAA5
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 13:20:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83D833CCA74
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 13:20:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B7235100079A
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 13:20:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B14C61F891
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692357625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wK52zqfRQ4bNP1EXMmHA9JN4aho7fRhqmiqg4WfUDTw=;
 b=PCOP0cmimzOJIATqHrVhfK1WrdIf5FxtP2slmkq3zEWu8/Tz7koeUKaH6/ZzXS4/+H9BDm
 pFqbTFmUAIAXz2gfPhWHxZEA95unUPy3qPwUgh8zlVDeEuXScu/iaXbNQgm1UyC6izHf6P
 Up6p97wseYPvqQd6e/lYE0T1L5FV2ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692357625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wK52zqfRQ4bNP1EXMmHA9JN4aho7fRhqmiqg4WfUDTw=;
 b=wF8yiDkCwrDhG581ZpC2UHUhiDtZ3F+rHR4tIuZW48Qo1LVLTGPrRp6Xgl5wHnaqMxJJys
 2TasKElBsCe/6xBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5446D13441
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CSOfCvlT32SpYQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:20:25 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 18 Aug 2023 16:50:14 +0530
Message-ID: <20230818112023.18159-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib: Add SAFE_CALLOC() helper function to LTP
 library
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 0cf3d7878..90ef451fd 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -72,6 +72,11 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd);
 #define SAFE_MALLOC(size) \
 	safe_malloc(__FILE__, __LINE__, NULL, (size))
 
+void *safe_calloc(const char *file, const int lineno, size_t nmemb, size_t size);
+
+#define SAFE_CALLOC(nmemb, size) \
+	safe_calloc(__FILE__, __LINE__, (nmemb), (size))
+
 void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size);
 
 #define SAFE_REALLOC(ptr, size) \
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index c4cdc87e7..f69802726 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -548,6 +548,21 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd)
 	return rval;
 }
 
+void *safe_calloc(const char *file, const int lineno,
+				size_t nmemb, size_t size)
+{
+	void *rval;
+
+	rval = calloc(nmemb, size);
+
+	if (rval == NULL) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"calloc(%zu, %zu) failed", nmemb, size);
+	}
+
+	return rval;
+}
+
 void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size)
 {
 	void *ret;
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
