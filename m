Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5F4E6B27C
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D500B3CD718
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 15:11:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94F443CD6B2
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1571B1BBC78C
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BCD61FECD
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWl4X1UiYZisuYiQAi/QtvZJiaU/GOaWOda8eovgBzM=;
 b=yfK4hKAwrvobuWEe4KszKuXBwTJ2ZJXGWDIeZNxi+QwFoxQ8MJCAPyljpIUn6xOIUVdx0Y
 GUWjB0ZAhSV54A7zUL/oOsn1VYEUDZyDfp/46M43m/v6z2vTCMEc9aHP7b3yqqlsle6GuM
 6LviciXt4WapEeyS3WNN7vTkVQkGc1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWl4X1UiYZisuYiQAi/QtvZJiaU/GOaWOda8eovgBzM=;
 b=4M9+2M6zMAhDX1AKv6dF3GYp+jYqM6E2ahfnuu67IxdV0cK1Pg7PWP1xzKlrlXXy/aWj8Y
 Ib9Uk154lyAMjyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWl4X1UiYZisuYiQAi/QtvZJiaU/GOaWOda8eovgBzM=;
 b=yfK4hKAwrvobuWEe4KszKuXBwTJ2ZJXGWDIeZNxi+QwFoxQ8MJCAPyljpIUn6xOIUVdx0Y
 GUWjB0ZAhSV54A7zUL/oOsn1VYEUDZyDfp/46M43m/v6z2vTCMEc9aHP7b3yqqlsle6GuM
 6LviciXt4WapEeyS3WNN7vTkVQkGc1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWl4X1UiYZisuYiQAi/QtvZJiaU/GOaWOda8eovgBzM=;
 b=4M9+2M6zMAhDX1AKv6dF3GYp+jYqM6E2ahfnuu67IxdV0cK1Pg7PWP1xzKlrlXXy/aWj8Y
 Ib9Uk154lyAMjyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83A0713B18
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SF3qH5HhJGf1BAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 14:11:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 15:11:07 +0100
Message-ID: <20241101141111.104803-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241101141111.104803-1-mdoucha@suse.cz>
References: <20241101141111.104803-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] Add safe readv()/writev() functions
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

Add safe macros for vectorized I/O functions:
- SAFE_READV()
- SAFE_PREADV()
- SAFE_WRITEV()
- SAFE_PWRITEV()

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/uio.h        |  1 +
 include/tst_safe_macros.h | 13 +++++++++
 include/tst_safe_prw.h    | 58 +++++++++++++++++++++++++++++++++++++++
 lib/tst_safe_macros.c     | 45 ++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)

diff --git a/include/lapi/uio.h b/include/lapi/uio.h
index a78103d99..0ad2faacf 100644
--- a/include/lapi/uio.h
+++ b/include/lapi/uio.h
@@ -7,6 +7,7 @@
 #ifndef LAPI_PREADV2_H__
 #define LAPI_PREADV2_H__
 
+#include <sys/uio.h>
 #include "config.h"
 #include "lapi/syscalls.h"
 
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 4df23e602..a9fa7dbe1 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -14,6 +14,7 @@
 #include <sys/stat.h>
 #include <sys/vfs.h>
 #include <sys/sysinfo.h>
+#include <sys/uio.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <signal.h>
@@ -515,4 +516,16 @@ int safe_symlinkat(const char *file, const int lineno,
 #define SAFE_SYMLINKAT(oldpath, newdirfd, newpath) \
 	safe_symlinkat(__FILE__, __LINE__, (oldpath), (newdirfd), (newpath))
 
+ssize_t safe_readv(const char *file, const int lineno, char len_strict,
+	int fildes, const struct iovec *iov, int iovcnt);
+#define SAFE_READV(len_strict, fildes, iov, iovcnt) \
+	safe_readv(__FILE__, __LINE__, (len_strict), (fildes), \
+		(iov), (iovcnt))
+
+ssize_t safe_writev(const char *file, const int lineno, char len_strict,
+	int fildes, const struct iovec *iov, int iovcnt);
+#define SAFE_WRITEV(len_strict, fildes, iov, iovcnt) \
+	safe_writev(__FILE__, __LINE__, (len_strict), (fildes), \
+		(iov), (iovcnt))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/include/tst_safe_prw.h b/include/tst_safe_prw.h
index 2e506cb41..349fb46b4 100644
--- a/include/tst_safe_prw.h
+++ b/include/tst_safe_prw.h
@@ -5,6 +5,8 @@
 #ifndef TST_SAFE_PRW_H__
 #define TST_SAFE_PRW_H__
 
+#include "lapi/uio.h"
+
 static inline ssize_t safe_pread(const char *file, const int lineno,
 		char len_strict, int fildes, void *buf, size_t nbyte,
 		off_t offset)
@@ -52,4 +54,60 @@ static inline ssize_t safe_pwrite(const char *file, const int lineno,
 	safe_pwrite(__FILE__, __LINE__, (len_strict), (fildes), \
 	            (buf), (nbyte), (offset))
 
+static inline ssize_t safe_preadv(const char *file, const int lineno,
+	char len_strict, int fildes, const struct iovec *iov, int iovcnt,
+	off_t offset)
+{
+	ssize_t rval, nbyte;
+	int i;
+
+	for (i = 0, nbyte = 0; i < iovcnt; i++)
+		nbyte += iov[i].iov_len;
+
+	rval = preadv(fildes, iov, iovcnt, offset);
+
+	if (rval == -1 || (len_strict && rval != nbyte)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"preadv(%d,%p,%d,%lld) failed",
+			fildes, iov, iovcnt, (long long)offset);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid preadv(%d,%p,%d,%lld) return value %zd",
+			fildes, iov, iovcnt, (long long)offset, rval);
+	}
+
+	return rval;
+}
+#define SAFE_PREADV(len_strict, fildes, iov, iovcnt, offset) \
+	safe_preadv(__FILE__, __LINE__, (len_strict), (fildes), \
+		(iov), (iovcnt), (offset))
+
+static inline ssize_t safe_pwritev(const char *file, const int lineno,
+	char len_strict, int fildes, const struct iovec *iov, int iovcnt,
+	off_t offset)
+{
+	ssize_t rval, nbyte;
+	int i;
+
+	for (i = 0, nbyte = 0; i < iovcnt; i++)
+		nbyte += iov[i].iov_len;
+
+	rval = pwritev(fildes, iov, iovcnt, offset);
+
+	if (rval == -1 || (len_strict && rval != nbyte)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"pwritev(%d,%p,%d,%lld) failed",
+			fildes, iov, iovcnt, (long long)offset);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid pwritev(%d,%p,%d,%lld) return value %zd",
+			fildes, iov, iovcnt, (long long)offset, rval);
+	}
+
+	return rval;
+}
+#define SAFE_PWRITEV(len_strict, fildes, iov, iovcnt, offset) \
+	safe_pwritev(__FILE__, __LINE__, (len_strict), (fildes), \
+		(iov), (iovcnt), (offset))
+
 #endif /* SAFE_PRW_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 868ebc08e..633b00404 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -732,6 +732,29 @@ int safe_prctl(const char *file, const int lineno,
 	return rval;
 }
 
+ssize_t safe_readv(const char *file, const int lineno, char len_strict,
+	int fildes, const struct iovec *iov, int iovcnt)
+{
+	ssize_t rval, nbyte;
+	int i;
+
+	for (i = 0, nbyte = 0; i < iovcnt; i++)
+		nbyte += iov[i].iov_len;
+
+	rval = readv(fildes, iov, iovcnt);
+
+	if (rval == -1 || (len_strict && rval != nbyte)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"readv(%d,%p,%d) failed", fildes, iov, iovcnt);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid readv(%d,%p,%d) return value %zd",
+			fildes, iov, iovcnt, rval);
+	}
+
+	return rval;
+}
+
 int safe_symlinkat(const char *file, const int lineno,
                  const char *oldpath, const int newdirfd, const char *newpath)
 {
@@ -751,3 +774,25 @@ int safe_symlinkat(const char *file, const int lineno,
 	return rval;
 }
 
+ssize_t safe_writev(const char *file, const int lineno, char len_strict,
+	int fildes, const struct iovec *iov, int iovcnt)
+{
+	ssize_t rval, nbyte;
+	int i;
+
+	for (i = 0, nbyte = 0; i < iovcnt; i++)
+		nbyte += iov[i].iov_len;
+
+	rval = writev(fildes, iov, iovcnt);
+
+	if (rval == -1 || (len_strict && rval != nbyte)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"writev(%d,%p,%d) failed", fildes, iov, iovcnt);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid writev(%d,%p,%d) return value %zd",
+			fildes, iov, iovcnt, rval);
+	}
+
+	return rval;
+}
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
