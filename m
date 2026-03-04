Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C0EEF8FE1
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0DF23DB1FD
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:27:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D87DC3DADA3
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 804A32005DD
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 14:25:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A7BD5BE2D;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0h/G41vZOBv7tkyijS8PxDV3cvBxEIW92pfiinxBaA8=;
 b=XriYEmPt4sxeTMoibe6N/NTKAFR08IPZuPtUzt7ekYjO/D21CAOpOOsQDPjBGRT9+EbI83
 GundliWQ+YqVCia6uwhXuraXsIw17si5WnKIfkEhnZ7bU9M4oyzDTV2xHwuRbC6rSbeygW
 Vokb/dO+HmwDGQAvgq22Qjq72aqlVoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0h/G41vZOBv7tkyijS8PxDV3cvBxEIW92pfiinxBaA8=;
 b=HaZmslSRv7t2ON5G9wFM56IVmk/whVjCp9NpaXhm/wIGwXoMkjiVfoSfgHb9rEl412v/UC
 FpmOp8F3edfQTqAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XriYEmPt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HaZmslSR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772630754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0h/G41vZOBv7tkyijS8PxDV3cvBxEIW92pfiinxBaA8=;
 b=XriYEmPt4sxeTMoibe6N/NTKAFR08IPZuPtUzt7ekYjO/D21CAOpOOsQDPjBGRT9+EbI83
 GundliWQ+YqVCia6uwhXuraXsIw17si5WnKIfkEhnZ7bU9M4oyzDTV2xHwuRbC6rSbeygW
 Vokb/dO+HmwDGQAvgq22Qjq72aqlVoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772630754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0h/G41vZOBv7tkyijS8PxDV3cvBxEIW92pfiinxBaA8=;
 b=HaZmslSRv7t2ON5G9wFM56IVmk/whVjCp9NpaXhm/wIGwXoMkjiVfoSfgHb9rEl412v/UC
 FpmOp8F3edfQTqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D5AC3EA6C;
 Wed,  4 Mar 2026 13:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cN+0FOIyqGlBTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 13:25:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 14:25:39 +0100
MIME-Version: 1.0
Message-Id: <20260304-stream_refactoring-v2-1-3e48ada8ff1a@suse.com>
References: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
In-Reply-To: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772630754; l=4993;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=d2vfPWFkSuh0KxbuI0eygCKqSQArqTWm5jp6e+q7wrE=;
 b=LTn1P3oConj9dhtkCwq62XKMtUxwUrkIwwmfODy6PLD6hIRapelmCWHxqSG4S68Rw2YFxw/HW
 kMudAhv57F9AljTCpq3lSrELXomUU6slOth8Pk5YIQbCCLYr/1WW6AG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8A7BD5BE2D
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] Add safe macros for stream testing suite
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Introduce the following SAFE_* macros for stream file testing:

- SAFE_FREAD
- SAFE_FWRITE
- SAFE_FREOPEN
- SAFE_FSEEK
- SAFE_FTELL
- SAFE_FILENO
- SAFE_FFLUSH

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/safe_stdio_fn.h  |  21 ++++++++++
 include/tst_safe_stdio.h |  21 ++++++++++
 lib/safe_stdio.c         | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/include/safe_stdio_fn.h b/include/safe_stdio_fn.h
index 3818a86571a6d9bc63fcf432c93683bb3298e5b2..255a85949749748533e93b86c7cf170900e95082 100644
--- a/include/safe_stdio_fn.h
+++ b/include/safe_stdio_fn.h
@@ -32,4 +32,25 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
 FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
 		 const char *command, const char *type);
 
+size_t safe_fread(const char *file, const int lineno,
+		  void *ptr, size_t size, size_t n, FILE *stream);
+
+size_t safe_fwrite(const char *file, const int lineno,
+		   const void *ptr, size_t size, size_t n, FILE *stream);
+
+FILE *safe_freopen(const char *file, const int lineno,
+		   const char *path, const char *mode, FILE *stream);
+
+int safe_fseek(const char *file, const int lineno,
+	       FILE *f, long offset, int whence);
+
+long safe_ftell(const char *file, const int lineno,
+		FILE *f);
+
+int safe_fileno(const char *file, const int lineno,
+		FILE *stream);
+
+int safe_fflush(const char *file, const int lineno,
+		FILE *stream);
+
 #endif /* SAFE_STDIO_FN_H__ */
diff --git a/include/tst_safe_stdio.h b/include/tst_safe_stdio.h
index e4bff34da15c9116809fcf851cbf544a51e384ef..45d4bc7e5d590468eec7a95b0aa37019e4e15f18 100644
--- a/include/tst_safe_stdio.h
+++ b/include/tst_safe_stdio.h
@@ -21,4 +21,25 @@
 #define SAFE_POPEN(command, type) \
 	safe_popen(__FILE__, __LINE__, NULL, command, type)
 
+#define SAFE_FREAD(ptr, size, n, stream) \
+	safe_fread(__FILE__, __LINE__, ptr, size, n, stream)
+
+#define SAFE_FWRITE(ptr, size, n, stream) \
+	safe_fwrite(__FILE__, __LINE__, ptr, size, n, stream)
+
+#define SAFE_FREOPEN(path, mode, stream) \
+	safe_freopen(__FILE__, __LINE__, path, mode, stream)
+
+#define SAFE_FSEEK(f, offset, whence) \
+	safe_fseek(__FILE__, __LINE__, f, offset, whence)
+
+#define SAFE_FTELL(f) \
+	safe_ftell(__FILE__, __LINE__, f)
+
+#define SAFE_FILENO(f) \
+	safe_fileno(__FILE__, __LINE__, f)
+
+#define SAFE_FFLUSH(f) \
+	safe_fflush(__FILE__, __LINE__, f)
+
 #endif /* TST_SAFE_STDIO_H__ */
diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index ab23e43bb0835cdca5eaa015bc873fd23f9a8408..feb8a4b5c87c8b2cb7f7f59f6ba763e45acdf237 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -99,3 +99,104 @@ FILE *safe_popen(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	return stream;
 }
+
+size_t safe_fread(const char *file, const int lineno,
+	void *ptr, size_t size, size_t n, FILE *stream)
+{
+	size_t ret;
+
+	ret = fread(ptr, size, n, stream);
+	if (ret != n) {
+		tst_brkm_(file, lineno, TBROK, NULL,
+			"fread(%p, %lu, %lu, %p) read %lu bytes",
+			ptr, size, n, stream, ret);
+	}
+
+	return ret;
+}
+
+size_t safe_fwrite(const char *file, const int lineno,
+	const void *ptr, size_t size, size_t n, FILE *stream)
+{
+	size_t ret;
+
+	ret = fwrite(ptr, size, n, stream);
+	if (ret != n) {
+		tst_brkm_(file, lineno, TBROK, NULL,
+			"fwrite(%p, %lu, %lu, %p) written %lu bytes",
+			ptr, size, n, stream, ret);
+	}
+
+	return ret;
+}
+
+FILE *safe_freopen(const char *file, const int lineno,
+	       const char *path, const char *mode, FILE *stream)
+{
+	FILE *f = freopen(path, mode, stream);
+
+	if (!f) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"freopen(%s,%s,%p) failed", path, mode, stream);
+	}
+
+	return f;
+}
+
+int safe_fseek(const char *file, const int lineno,
+		   FILE *f, long offset, int whence)
+{
+	int ret;
+
+	errno = 0;
+	ret = fseek(f, offset, whence);
+
+	if (ret == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"fseek(%p, %ld, %d)", f, offset, whence);
+	}
+
+	return ret;
+}
+
+long safe_ftell(const char *file, const int lineno,
+	       FILE *f)
+{
+	long ret;
+
+	errno = 0;
+	ret = ftell(f);
+
+	if (ret == -1)
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "ftell(%p)", f);
+
+	return ret;
+}
+
+int safe_fileno(const char *file, const int lineno,
+		FILE *f)
+{
+	int ret;
+
+	errno = 0;
+	ret = fileno(f);
+
+	if (ret == -1)
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "fileno(%p)", f);
+
+	return ret;
+}
+
+int safe_fflush(const char *file, const int lineno,
+		FILE *f)
+{
+	int ret;
+
+	errno = 0;
+	ret = fflush(f);
+
+	if (ret == EOF)
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "fflush(%p)", f);
+
+	return ret;
+}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
