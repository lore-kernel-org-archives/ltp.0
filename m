Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD2BC19F32
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 16:58:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED0503C9E08
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 17:58:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 310F23C29CB
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:58:23 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D3901BBFB3C
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:58:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C64C71F38A;
 Thu, 27 Feb 2025 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740675500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=od6OPMLh/QAmoNXTBeIBAkaI38Ub97WLJ6syqTJigXg=;
 b=zG0yRNoPsF4xdwNQAy202SSEEClBiiSXoSbldDANzGrYIOporziPhoCZTXOefnO0woahiO
 PYDbRGtAsNqboaGBAZOwOpl7RFvP5ZoYUCzBBqpRScR/XlMIDwrD0GC3V3FFXfddcc82GY
 epuHGYDNsjA2/Ny/pmMyjrSVoCPaLH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740675500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=od6OPMLh/QAmoNXTBeIBAkaI38Ub97WLJ6syqTJigXg=;
 b=oxSmY1y8CIlFyNpN9e8h0YYtKFAoBD8zv4gHctiD9vJ8lbXDP+KGA4NIZyoGjdIiNzUjKW
 iG/KweNv36pwTKDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zG0yRNoP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oxSmY1y8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740675500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=od6OPMLh/QAmoNXTBeIBAkaI38Ub97WLJ6syqTJigXg=;
 b=zG0yRNoPsF4xdwNQAy202SSEEClBiiSXoSbldDANzGrYIOporziPhoCZTXOefnO0woahiO
 PYDbRGtAsNqboaGBAZOwOpl7RFvP5ZoYUCzBBqpRScR/XlMIDwrD0GC3V3FFXfddcc82GY
 epuHGYDNsjA2/Ny/pmMyjrSVoCPaLH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740675500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=od6OPMLh/QAmoNXTBeIBAkaI38Ub97WLJ6syqTJigXg=;
 b=oxSmY1y8CIlFyNpN9e8h0YYtKFAoBD8zv4gHctiD9vJ8lbXDP+KGA4NIZyoGjdIiNzUjKW
 iG/KweNv36pwTKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CB4213888;
 Thu, 27 Feb 2025 16:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ZQSJayZwGdxKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 16:58:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Feb 2025 17:58:16 +0100
Message-ID: <20250227165817.3166403-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: C64C71F38A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] include: Move safe_mmap into
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
 include/tst_safe_macros.h        | 27 ---------------------------
 include/tst_safe_macros_inline.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 6985aa4bd8..d4b266297b 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -273,33 +273,6 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 
 void tst_prot_to_str(const int prot, char *buf);
 
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
index 5eed3a18d0..7a7a2b0ddd 100644
--- a/include/tst_safe_macros_inline.h
+++ b/include/tst_safe_macros_inline.h
@@ -227,4 +227,30 @@ static inline int safe_setrlimit(const char *file, const int lineno,
 #define SAFE_SETRLIMIT(resource, rlim) \
 	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
 
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
