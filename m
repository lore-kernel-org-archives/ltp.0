Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AF1C54E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 16:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF99A3D10EF
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 17:26:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92BE53CC8BF
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:25:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 842E8200043
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:25:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A29BE34C31;
 Mon, 18 Mar 2024 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710779147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuFfXqm4QpjSDoG1njBgEMkCQWsl81UKmnsg7kg2KHs=;
 b=eYRg4WUDO+duKLkmOmjsDqbjDGqK1cNV2n3ZMyXuZmb4k0+d31lme3uIHpXfftBEFDKlSU
 VpuDH4vLEsZly69iZisJ7HUaKkFPY94jkktpRVZ4xPHrsrtE/ZTm/npiE1xLs1jVuZk/f1
 Aw6CwvLaYKouxEmR88+gXrBwf8S7GFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710779147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuFfXqm4QpjSDoG1njBgEMkCQWsl81UKmnsg7kg2KHs=;
 b=Ph41WiIXgqDMAj6XD0evfcBD9hzFXcUqomVO8ndPnGwxCwaLMYeQHy2akBWxI/61W+8A6f
 3AOjcqv4eFts7PDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710779147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuFfXqm4QpjSDoG1njBgEMkCQWsl81UKmnsg7kg2KHs=;
 b=eYRg4WUDO+duKLkmOmjsDqbjDGqK1cNV2n3ZMyXuZmb4k0+d31lme3uIHpXfftBEFDKlSU
 VpuDH4vLEsZly69iZisJ7HUaKkFPY94jkktpRVZ4xPHrsrtE/ZTm/npiE1xLs1jVuZk/f1
 Aw6CwvLaYKouxEmR88+gXrBwf8S7GFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710779147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuFfXqm4QpjSDoG1njBgEMkCQWsl81UKmnsg7kg2KHs=;
 b=Ph41WiIXgqDMAj6XD0evfcBD9hzFXcUqomVO8ndPnGwxCwaLMYeQHy2akBWxI/61W+8A6f
 3AOjcqv4eFts7PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 878A3136A8;
 Mon, 18 Mar 2024 16:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SOxkIAtr+GXcZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Mar 2024 16:25:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Mar 2024 17:25:39 +0100
Message-ID: <20240318162539.407214-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318162539.407214-1-pvorel@suse.cz>
References: <20240318162539.407214-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] include: Move inline functions to special header
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

9120d8a22 ("safe_macros: turn functions with off_t parameter into static
inline") changed some functions to inline because they depend on
-D_FILE_OFFSET_BITS=64. Separate them into it's own header, because
normal functions should be in C files.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_macros.h        | 213 +---------------------------
 include/tst_safe_macros_inline.h | 229 +++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+), 211 deletions(-)
 create mode 100644 include/tst_safe_macros_inline.h

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 1c2decadd..cfd1d89ad 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -25,6 +25,7 @@
 #include "safe_stdio_fn.h"
 #include "safe_macros_fn.h"
 #include "tst_cmd.h"
+#include "tst_safe_macros_inline.h"
 
 int safe_access(const char *filename, const int lineno, const char *pathname,
 		   int mode);
@@ -299,216 +300,6 @@ int safe_mprotect(const char *file, const int lineno,
 #define SAFE_MPROTECT(addr, len, prot) \
 	safe_mprotect(__FILE__, __LINE__, (addr), (len), (prot))
 
-/*
- * Following functions are inline because the behaviour may depend on
- * -D_FILE_OFFSET_BITS=64 compile flag.
- */
-
-static inline int safe_ftruncate(const char *file, const int lineno,
-                                 int fd, off_t length)
-{
-	int rval;
-
-	rval = ftruncate(fd, length);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"ftruncate(%d,%ld) failed", fd, (long)length);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid ftruncate(%d,%ld) return value %d", fd,
-			(long)length, rval);
-	}
-
-	return rval;
-}
-#define SAFE_FTRUNCATE(fd, length) \
-	safe_ftruncate(__FILE__, __LINE__, (fd), (length))
-
-static inline int safe_posix_fadvise(const char *file, const int lineno,
-                                int fd, off_t offset, off_t len, int advice)
-{
-	int rval;
-
-	rval = posix_fadvise(fd, offset, len, advice);
-
-	if (rval)
-		tst_brk_(file, lineno, TBROK,
-			"posix_fadvise(%d,%ld,%ld,%d) failed: %s",
-			fd, (long)offset, (long)len, advice, tst_strerrno(rval));
-
-	return rval;
-}
-#define SAFE_POSIX_FADVISE(fd, offset, len, advice) \
-	safe_posix_fadvise(__FILE__, __LINE__, (fd), (offset), (len), (advice))
-
-static inline int safe_truncate(const char *file, const int lineno,
-                                const char *path, off_t length)
-{
-	int rval;
-
-	rval = truncate(path, length);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"truncate(%s,%ld) failed", path, (long)length);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid truncate(%s,%ld) return value %d", path,
-			(long)length, rval);
-	}
-
-	return rval;
-}
-#define SAFE_TRUNCATE(path, length) \
-	safe_truncate(__FILE__, __LINE__, (path), (length))
-
-static inline int safe_stat(const char *file, const int lineno,
-                            const char *path, struct stat *buf)
-{
-	int rval;
-
-	rval = stat(path, buf);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"stat(%s,%p) failed", path, buf);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid stat(%s,%p) return value %d", path, buf,
-			rval);
-	}
-
-	return rval;
-}
-#define SAFE_STAT(path, buf) \
-	safe_stat(__FILE__, __LINE__, (path), (buf))
-
-static inline int safe_fstat(const char *file, const int lineno,
-                             int fd, struct stat *buf)
-{
-	int rval;
-
-	rval = fstat(fd, buf);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"fstat(%d,%p) failed", fd, buf);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid fstat(%d,%p) return value %d", fd, buf, rval);
-	}
-
-	return rval;
-}
-#define SAFE_FSTAT(fd, buf) \
-	safe_fstat(__FILE__, __LINE__, (fd), (buf))
-
-static inline int safe_lstat(const char *file, const int lineno,
-	const char *path, struct stat *buf)
-{
-	int rval;
-
-	rval = lstat(path, buf);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"lstat(%s,%p) failed", path, buf);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid lstat(%s,%p) return value %d", path, buf,
-			rval);
-	}
-
-	return rval;
-}
-#define SAFE_LSTAT(path, buf) \
-	safe_lstat(__FILE__, __LINE__, (path), (buf))
-
-static inline int safe_statfs(const char *file, const int lineno,
-                              const char *path, struct statfs *buf)
-{
-	int rval;
-
-	rval = statfs(path, buf);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"statfs(%s,%p) failed", path, buf);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid statfs(%s,%p) return value %d", path, buf,
-			rval);
-	}
-
-	return rval;
-}
-#define SAFE_STATFS(path, buf) \
-	safe_statfs(__FILE__, __LINE__, (path), (buf))
-
-static inline off_t safe_lseek(const char *file, const int lineno,
-                               int fd, off_t offset, int whence)
-{
-	off_t rval;
-
-	rval = lseek(fd, offset, whence);
-
-	if (rval == (off_t) -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"lseek(%d,%ld,%d) failed", fd, (long)offset, whence);
-	} else if (rval < 0) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid lseek(%d,%ld,%d) return value %ld", fd,
-			(long)offset, whence, (long)rval);
-	}
-
-	return rval;
-}
-#define SAFE_LSEEK(fd, offset, whence) \
-	safe_lseek(__FILE__, __LINE__, (fd), (offset), (whence))
-
-static inline int safe_getrlimit(const char *file, const int lineno,
-                                 int resource, struct rlimit *rlim)
-{
-	int rval;
-
-	rval = getrlimit(resource, rlim);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"getrlimit(%d,%p) failed", resource, rlim);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid getrlimit(%d,%p) return value %d", resource,
-			rlim, rval);
-	}
-
-	return rval;
-}
-#define SAFE_GETRLIMIT(resource, rlim) \
-	safe_getrlimit(__FILE__, __LINE__, (resource), (rlim))
-
-static inline int safe_setrlimit(const char *file, const int lineno,
-                                 int resource, const struct rlimit *rlim)
-{
-	int rval;
-
-	rval = setrlimit(resource, rlim);
-
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"setrlimit(%d,%p) failed", resource, rlim);
-	} else if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"Invalid setrlimit(%d,%p) return value %d", resource,
-			rlim, rval);
-	}
-
-	return rval;
-}
-#define SAFE_SETRLIMIT(resource, rlim) \
-	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
-
 typedef void (*sighandler_t)(int);
 sighandler_t safe_signal(const char *file, const int lineno,
 	int signum, sighandler_t handler);
@@ -702,4 +493,4 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
 
 void safe_print_file(const char *file, const int lineno, char *path);
 
-#endif /* SAFE_MACROS_H__ */
+#endif /* TST_SAFE_MACROS_H__ */
diff --git a/include/tst_safe_macros_inline.h b/include/tst_safe_macros_inline.h
new file mode 100644
index 000000000..c497f6059
--- /dev/null
+++ b/include/tst_safe_macros_inline.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2010-2024 Linux Test Project
+ * Copyright (c) 2011-2015 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_SAFE_MACROS_INLINE_H__
+#define TST_SAFE_MACROS_INLINE_H__
+
+/*
+ * Following functions are inline because the behaviour may depend on
+ * -D_FILE_OFFSET_BITS=64 compile flag.
+ *
+ * Do not add other functions here.
+ */
+
+static inline int safe_ftruncate(const char *file, const int lineno,
+	int fd, off_t length)
+{
+	int rval;
+
+	rval = ftruncate(fd, length);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"ftruncate(%d,%ld) failed", fd, (long)length);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid ftruncate(%d,%ld) return value %d", fd,
+			(long)length, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_FTRUNCATE(fd, length) \
+	safe_ftruncate(__FILE__, __LINE__, (fd), (length))
+
+static inline int safe_posix_fadvise(const char *file, const int lineno,
+	int fd, off_t offset, off_t len, int advice)
+{
+	int rval;
+
+	rval = posix_fadvise(fd, offset, len, advice);
+
+	if (rval)
+		tst_brk_(file, lineno, TBROK,
+			"posix_fadvise(%d,%ld,%ld,%d) failed: %s",
+			fd, (long)offset, (long)len, advice, tst_strerrno(rval));
+
+	return rval;
+}
+
+#define SAFE_POSIX_FADVISE(fd, offset, len, advice) \
+	safe_posix_fadvise(__FILE__, __LINE__, (fd), (offset), (len), (advice))
+
+static inline int safe_truncate(const char *file, const int lineno,
+	const char *path, off_t length)
+{
+	int rval;
+
+	rval = truncate(path, length);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"truncate(%s,%ld) failed", path, (long)length);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid truncate(%s,%ld) return value %d", path,
+			(long)length, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_TRUNCATE(path, length) \
+	safe_truncate(__FILE__, __LINE__, (path), (length))
+
+static inline int safe_stat(const char *file, const int lineno,
+	const char *path, struct stat *buf)
+{
+	int rval;
+
+	rval = stat(path, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"stat(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid stat(%s,%p) return value %d", path, buf,
+			rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_STAT(path, buf) \
+	safe_stat(__FILE__, __LINE__, (path), (buf))
+
+static inline int safe_fstat(const char *file, const int lineno,
+	int fd, struct stat *buf)
+{
+	int rval;
+
+	rval = fstat(fd, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"fstat(%d,%p) failed", fd, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid fstat(%d,%p) return value %d", fd, buf, rval);
+	}
+
+	return rval;
+}
+#define SAFE_FSTAT(fd, buf) \
+	safe_fstat(__FILE__, __LINE__, (fd), (buf))
+
+static inline int safe_lstat(const char *file, const int lineno,
+	const char *path, struct stat *buf)
+{
+	int rval;
+
+	rval = lstat(path, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"lstat(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid lstat(%s,%p) return value %d", path, buf,
+			rval);
+	}
+
+	return rval;
+}
+#define SAFE_LSTAT(path, buf) \
+	safe_lstat(__FILE__, __LINE__, (path), (buf))
+
+static inline int safe_statfs(const char *file, const int lineno,
+	const char *path, struct statfs *buf)
+{
+	int rval;
+
+	rval = statfs(path, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"statfs(%s,%p) failed", path, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid statfs(%s,%p) return value %d", path, buf,
+			rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_STATFS(path, buf) \
+	safe_statfs(__FILE__, __LINE__, (path), (buf))
+
+static inline off_t safe_lseek(const char *file, const int lineno,
+	int fd, off_t offset, int whence)
+{
+	off_t rval;
+
+	rval = lseek(fd, offset, whence);
+
+	if (rval == (off_t) -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"lseek(%d,%ld,%d) failed", fd, (long)offset, whence);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid lseek(%d,%ld,%d) return value %ld", fd,
+			(long)offset, whence, (long)rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_LSEEK(fd, offset, whence) \
+	safe_lseek(__FILE__, __LINE__, (fd), (offset), (whence))
+
+static inline int safe_getrlimit(const char *file, const int lineno,
+	int resource, struct rlimit *rlim)
+{
+	int rval;
+
+	rval = getrlimit(resource, rlim);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"getrlimit(%d,%p) failed", resource, rlim);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid getrlimit(%d,%p) return value %d", resource,
+			rlim, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_GETRLIMIT(resource, rlim) \
+	safe_getrlimit(__FILE__, __LINE__, (resource), (rlim))
+
+static inline int safe_setrlimit(const char *file, const int lineno,
+	int resource, const struct rlimit *rlim)
+{
+	int rval;
+
+	rval = setrlimit(resource, rlim);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setrlimit(%d,%p) failed", resource, rlim);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setrlimit(%d,%p) return value %d", resource,
+			rlim, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_SETRLIMIT(resource, rlim) \
+	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
+
+#endif /* TST_SAFE_MACROS_INLINE_H__ */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
