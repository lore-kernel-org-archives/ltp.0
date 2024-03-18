Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887D9C54E58
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 16:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DDAB3D14C7
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 17:26:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6BF03D00F0
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:25:49 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2B3D1002048
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:25:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 834AD5C748;
 Mon, 18 Mar 2024 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710779147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gvn3f0q8OOA25qPYvgAd4IeFyGJaWilslrmYeFKM3c0=;
 b=ggavaGNG221DYIPl0VYRF/nSx80DXv7RrY4Gol2BajtY6MbS74qaYOaJNOBbRAxksZIZl4
 YALSvPQlheqA7hsJOI/xUgTkXcyZU+OXEHoSx7qnEaFvp+xoZD85XcQ+QtGVB8LN2V3NDO
 yXwm1HYRLYTFHejEnw4BN7CKTLy/7jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710779147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gvn3f0q8OOA25qPYvgAd4IeFyGJaWilslrmYeFKM3c0=;
 b=I5Fd6COsK23zCvS4wLe+Eh1gI/s6u/kOsx5hCg7blJn0th+Eua244Gd9TghcAGpaGzNVvY
 gF7S7rCE3J+LszDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710779147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gvn3f0q8OOA25qPYvgAd4IeFyGJaWilslrmYeFKM3c0=;
 b=ggavaGNG221DYIPl0VYRF/nSx80DXv7RrY4Gol2BajtY6MbS74qaYOaJNOBbRAxksZIZl4
 YALSvPQlheqA7hsJOI/xUgTkXcyZU+OXEHoSx7qnEaFvp+xoZD85XcQ+QtGVB8LN2V3NDO
 yXwm1HYRLYTFHejEnw4BN7CKTLy/7jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710779147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Gvn3f0q8OOA25qPYvgAd4IeFyGJaWilslrmYeFKM3c0=;
 b=I5Fd6COsK23zCvS4wLe+Eh1gI/s6u/kOsx5hCg7blJn0th+Eua244Gd9TghcAGpaGzNVvY
 gF7S7rCE3J+LszDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61430136A5;
 Mon, 18 Mar 2024 16:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MFapFgtr+GXcZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Mar 2024 16:25:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Mar 2024 17:25:38 +0100
Message-ID: <20240318162539.407214-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_safe_macros: Move implementations into C file, rename
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

9120d8a22 ("safe_macros: turn functions with off_t parameter into static inline")
noted:

    Some functions used to implement safe macros have parameters
    of type off_t or structures containing off_t fields.

But that's not the case of safe_mprotect() and helper safe_prot_to_str().
Therefore move their implementations into C file (following the approach
we don't want static inline implementations in the API headers).

Also rename safe_prot_to_str() to tst_prot_to_str() (safe_ functions
take const char *file, const int lineno and call tst_brk_() on error).

Fixes: b366afb64 ("Add SAFE_MPROTECT() macro")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_macros.h | 74 +++++++--------------------------------
 lib/tst_safe_macros.c     | 55 +++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 61 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 7178a842d..1c2decadd 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later
- * Copyright (c) 2010-2018 Linux Test Project
+ * Copyright (c) 2010-2024 Linux Test Project
  * Copyright (c) 2011-2015 Cyril Hrubis <chrubis@suse.cz>
  */
 
@@ -264,49 +264,15 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 	            "fcntl(%i,%s,...) failed", fd, #cmd), 0 \
 	 : tst_ret_;})
 
-/*
- * following functions are inline because the behaviour may depend on
- * -D_FILE_OFFSET_BITS=64 compile flag
- */
-
-#define PROT_FLAG_STR(f) #f " | "
-
-static void safe_prot_to_str(const int prot, char *buf)
-{
-	char *ptr = buf;
-
-	if (prot == PROT_NONE) {
-		strcpy(buf, "PROT_NONE");
-		return;
-	}
-
-	if (prot & PROT_READ) {
-		strcpy(ptr, PROT_FLAG_STR(PROT_READ));
-		ptr += sizeof(PROT_FLAG_STR(PROT_READ)) - 1;
-	}
-
-	if (prot & PROT_WRITE) {
-		strcpy(ptr, PROT_FLAG_STR(PROT_WRITE));
-		ptr += sizeof(PROT_FLAG_STR(PROT_WRITE)) - 1;
-	}
-
-	if (prot & PROT_EXEC) {
-		strcpy(ptr, PROT_FLAG_STR(PROT_EXEC));
-		ptr += sizeof(PROT_FLAG_STR(PROT_EXEC)) - 1;
-	}
-
-	if (buf != ptr)
-		ptr[-3] = 0;
-}
+void tst_prot_to_str(const int prot, char *buf);
 
 static inline void *safe_mmap(const char *file, const int lineno,
-                              void *addr, size_t length,
-                              int prot, int flags, int fd, off_t offset)
+	void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
 	void *rval;
 	char prot_buf[512];
 
-	safe_prot_to_str(prot, prot_buf);
+	tst_prot_to_str(prot, prot_buf);
 
 	tst_res_(file, lineno, TDEBUG,
 		"mmap(%p, %ld, %s(%x), %d, %d, %ld)",
@@ -321,37 +287,23 @@ static inline void *safe_mmap(const char *file, const int lineno,
 
 	return rval;
 }
+
+
 #define SAFE_MMAP(addr, length, prot, flags, fd, offset) \
 	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
 	(flags), (fd), (offset))
 
-static inline int safe_mprotect(const char *file, const int lineno,
-	char *addr, size_t len, int prot)
-{
-	int rval;
-	char prot_buf[512];
-
-	safe_prot_to_str(prot, prot_buf);
-
-	tst_res_(file, lineno, TDEBUG,
-		"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
+int safe_mprotect(const char *file, const int lineno,
+	char *addr, size_t len, int prot);
 
-	rval = mprotect(addr, len, prot);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mprotect(%p, %ld, %s(%x)) return value %d",
-			addr, len, prot_buf, prot, rval);
-	}
-
-	return rval;
-}
 #define SAFE_MPROTECT(addr, len, prot) \
 	safe_mprotect(__FILE__, __LINE__, (addr), (len), (prot))
 
+/*
+ * Following functions are inline because the behaviour may depend on
+ * -D_FILE_OFFSET_BITS=64 compile flag.
+ */
+
 static inline int safe_ftruncate(const char *file, const int lineno,
                                  int fd, off_t length)
 {
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 498e45a74..907675afe 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2017-2024 Linux Test Project
  */
 
 #define _GNU_SOURCE
@@ -622,3 +623,57 @@ void safe_print_file(const char *file, const int lineno, char *path)
 
 	safe_fclose(file, lineno, NULL, pfile);
 }
+
+#define PROT_FLAG_STR(f) #f " | "
+void tst_prot_to_str(const int prot, char *buf)
+{
+	char *ptr = buf;
+
+	if (prot == PROT_NONE) {
+		strcpy(buf, "PROT_NONE");
+		return;
+	}
+
+	if (prot & PROT_READ) {
+		strcpy(ptr, PROT_FLAG_STR(PROT_READ));
+		ptr += sizeof(PROT_FLAG_STR(PROT_READ)) - 1;
+	}
+
+	if (prot & PROT_WRITE) {
+		strcpy(ptr, PROT_FLAG_STR(PROT_WRITE));
+		ptr += sizeof(PROT_FLAG_STR(PROT_WRITE)) - 1;
+	}
+
+	if (prot & PROT_EXEC) {
+		strcpy(ptr, PROT_FLAG_STR(PROT_EXEC));
+		ptr += sizeof(PROT_FLAG_STR(PROT_EXEC)) - 1;
+	}
+
+	if (buf != ptr)
+		ptr[-3] = 0;
+}
+
+int safe_mprotect(const char *file, const int lineno,
+	char *addr, size_t len, int prot)
+{
+	int rval;
+	char prot_buf[512];
+
+	tst_prot_to_str(prot, prot_buf);
+
+	tst_res_(file, lineno, TDEBUG,
+		"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
+
+	rval = mprotect(addr, len, prot);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mprotect(%p, %ld, %s(%x)) return value %d",
+			addr, len, prot_buf, prot, rval);
+	}
+
+	return rval;
+}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
