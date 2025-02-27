Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5844C19F32
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41F523C9E26
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 18:05:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0969D3C0516
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 18:05:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E1F0B1002055
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 18:05:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFAFF21174;
 Thu, 27 Feb 2025 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740675927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ua/+NF7qEXqyFMmb+zPsBfK8gdikZ3SaRTPu6aHwrc4=;
 b=L/E+7mY9Y6R6MHLShIJXN+gHNM+cz/bapxGgaouHY0SvkSYMbZ4y245EIOmEDd7td4WKR0
 mH/VEQG0YKhNqh5YHsdU5VJwYCKLX//uoueFmlsoF33xJQTIlIki8pJ+PCPThJgsKAw//t
 nrNtp6UoUNX3dXj4LSW3R0b9bQZHBPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740675927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ua/+NF7qEXqyFMmb+zPsBfK8gdikZ3SaRTPu6aHwrc4=;
 b=ezsOy6Ic/R5Ivb5+5G+1H+JikeY8ehlRx+FdLk0bPrsBGIpNcfxjkEAmQSs3kdfgVj/jFY
 em1NRtN0ECM3WTBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740675927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ua/+NF7qEXqyFMmb+zPsBfK8gdikZ3SaRTPu6aHwrc4=;
 b=L/E+7mY9Y6R6MHLShIJXN+gHNM+cz/bapxGgaouHY0SvkSYMbZ4y245EIOmEDd7td4WKR0
 mH/VEQG0YKhNqh5YHsdU5VJwYCKLX//uoueFmlsoF33xJQTIlIki8pJ+PCPThJgsKAw//t
 nrNtp6UoUNX3dXj4LSW3R0b9bQZHBPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740675927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ua/+NF7qEXqyFMmb+zPsBfK8gdikZ3SaRTPu6aHwrc4=;
 b=ezsOy6Ic/R5Ivb5+5G+1H+JikeY8ehlRx+FdLk0bPrsBGIpNcfxjkEAmQSs3kdfgVj/jFY
 em1NRtN0ECM3WTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A10B13888;
 Thu, 27 Feb 2025 17:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KA9xDVebwGcGLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 17:05:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Feb 2025 18:05:24 +0100
Message-ID: <20250227170524.3168535-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] include: Move safe_mmap into
 tst_safe_macros_inline.h
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

tst_safe_macros_inline.h contains functions which are forced to be
'inline' because the behaviour may depend on -D_FILE_OFFSET_BITS=64
compile flag (type off_t or structures containing off_t fields).
safe_mmap() was left from this conversion.

Fixes: 3f571da28d ("include: Move inline functions to special header")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Fix build by moving also tst_prot_to_str() signature.

Link to v1
https://patchwork.ozlabs.org/project/ltp/patch/20250227165817.3166403-1-pvorel@suse.cz/

Tested:
https://github.com/pevik/ltp/actions/runs/13571853789

 include/tst_safe_macros.h        | 29 -----------------------------
 include/tst_safe_macros_inline.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 6985aa4bd8..3b02f86c76 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -271,35 +271,6 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 	            "fcntl(%i,%s,...) failed", fd, #cmd), 0 \
 	 : tst_ret_;})
 
-void tst_prot_to_str(const int prot, char *buf);
-
-static inline void *safe_mmap(const char *file, const int lineno,
-	void *addr, size_t length, int prot, int flags, int fd, off_t offset)
-{
-	void *rval;
-	char prot_buf[512];
-
-	tst_prot_to_str(prot, prot_buf);
-
-	tst_res_(file, lineno, TDEBUG,
-		"mmap(%p, %zu, %s(%x), %d, %d, %lld)",
-		addr, length, prot_buf, prot, flags, fd, (long long int)offset);
-
-	rval = mmap(addr, length, prot, flags, fd, offset);
-	if (rval == MAP_FAILED) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
-			addr, length, prot_buf, prot, flags, fd, (long) offset);
-	}
-
-	return rval;
-}
-
-
-#define SAFE_MMAP(addr, length, prot, flags, fd, offset) \
-	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
-	(flags), (fd), (offset))
-
 int safe_mprotect(const char *file, const int lineno,
 	char *addr, size_t len, int prot);
 
diff --git a/include/tst_safe_macros_inline.h b/include/tst_safe_macros_inline.h
index 5eed3a18d0..15b756860e 100644
--- a/include/tst_safe_macros_inline.h
+++ b/include/tst_safe_macros_inline.h
@@ -227,4 +227,32 @@ static inline int safe_setrlimit(const char *file, const int lineno,
 #define SAFE_SETRLIMIT(resource, rlim) \
 	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
 
+void tst_prot_to_str(const int prot, char *buf);
+
+static inline void *safe_mmap(const char *file, const int lineno,
+	void *addr, size_t length, int prot, int flags, int fd, off_t offset)
+{
+	void *rval;
+	char prot_buf[512];
+
+	tst_prot_to_str(prot, prot_buf);
+
+	tst_res_(file, lineno, TDEBUG,
+		"mmap(%p, %zu, %s(%x), %d, %d, %lld)",
+		addr, length, prot_buf, prot, flags, fd, (long long int)offset);
+
+	rval = mmap(addr, length, prot, flags, fd, offset);
+	if (rval == MAP_FAILED) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
+			addr, length, prot_buf, prot, flags, fd, (long) offset);
+	}
+
+	return rval;
+}
+
+#define SAFE_MMAP(addr, length, prot, flags, fd, offset) \
+	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
+	(flags), (fd), (offset))
+
 #endif /* TST_SAFE_MACROS_INLINE_H__ */
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
