Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18608EA3C25
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4C1D3E4CF8
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 12:31:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB0543DEBF8
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 12:30:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A6971A00901
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 12:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E67184EEAF
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775730631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gcvb69npmLg6i4pLz/R4tYcvpoR6TJ2eMFCwYLyPQ4=;
 b=Upuk97FyBULtuH9iND6GRkWCHUimcP4Y29UQGsVh3apRX7w8sY+6p5Oq8j/ipf3VcNVlwQ
 4qEu8Jh2klZEXXko6/lMBQhWdk2CDlEg0ly0n6JUSFX2Cmi4/ELBMGtipR8ZP7YY5kbRal
 vvFagvdc6jYKre5Q9WcvtFZ0pP9GgBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775730631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gcvb69npmLg6i4pLz/R4tYcvpoR6TJ2eMFCwYLyPQ4=;
 b=Q+j1YaW1xfJ/ENPPE8uVnTxyS5xYVv0ogmYL1Z+CtCb+o6EAx28WtPYMIrcvO8KQNLHBG4
 ScUSqxHb+a3MvDAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hGag+QN8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qndyqi7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775730630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gcvb69npmLg6i4pLz/R4tYcvpoR6TJ2eMFCwYLyPQ4=;
 b=hGag+QN8Ot4s0uU3ARoItL9HNfLa4XI0HT3c+PTtPNdDfnKpVg9HGMtTVPTfKePDfMaXN3
 wa3LjGpn8q0jWgT20x4Au9b+SrKAQbjQEzqXi66ElBnWcQrv2jONb5nGhYQe6ykEpa8nAw
 eFa4miVI/FvVl5lnuB8zpT4YCE52tjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775730630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gcvb69npmLg6i4pLz/R4tYcvpoR6TJ2eMFCwYLyPQ4=;
 b=qndyqi7JuWjq7h1owasu1rZZpkGkObWG0+V6bbbSV/QWoSv4d49GIBb7MzpL0Hy4LnRxo5
 Toln0faks7st5tBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D972E4A0B3
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id doyFNMZ/12lAEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 10:30:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Apr 2026 12:30:40 +0200
Message-ID: <20260409103041.8253-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409103041.8253-1-chrubis@suse.cz>
References: <20260409103041.8253-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E67184EEAF
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: safe_file_ops: Add SAFE_FILE_READ_STR()
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

Unlike the scanf("%s") this function can properly handle empty files and
in case of an empty file produces an empty string.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_file_ops.h | 21 +++++++++++++++++++++
 lib/safe_file_ops.c         | 24 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 0d8819594..d9110ba9c 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -14,6 +14,27 @@
 	safe_file_scanf(__FILE__, __LINE__, NULL, \
 	                (path), (fmt), ## __VA_ARGS__)
 
+/**
+ * SAFE_FILE_READ_STR() - Reads a string from a file.
+ *
+ * Unlike scanf("%s") this function works fine with empty files or files that
+ * consist only of white spaces. In such case an empty string is stored into
+ * the supplied buffer.
+ *
+ * It's recomended to use this for various sysfs or procfs files that may be
+ * empty.
+ *
+ * @path: A path to a file.
+ * @buf: A buffer to store the string into.
+ * @buf_size: A buffer size.
+ */
+#define SAFE_FILE_READ_STR(path, buf, buf_size) \
+	safe_file_read_str(__FILE__, __LINE__, \
+	                   (path), (buf), (buf_size))
+
+void safe_file_read_str(const char *file, const int lineno,
+                        const char *path, char *buf, size_t buf_size);
+
 #define FILE_LINES_SCANF(path, fmt, ...) \
 	file_lines_scanf(__FILE__, __LINE__, NULL, 0,\
 			(path), (fmt), ## __VA_ARGS__)
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 8314c4b1b..2d163c0af 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -160,6 +160,30 @@ void safe_file_scanf(const char *file, const int lineno,
 	}
 }
 
+void safe_file_read_str(const char *file, const int lineno,
+                        const char *path, char *buf, size_t buf_size)
+{
+	FILE *f;
+
+	f = fopen(path, "r");
+	if (!f) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+		          "Failed to open FILE '%s' for reading", path);
+	}
+
+	if (!fgets(buf, buf_size, f))
+		buf[0] = 0;
+
+	size_t len = strlen(buf);
+
+	if (len && buf[len-1] == '\n')
+		buf[len-1] = 0;
+
+	if (fclose(f)) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Failed to close FILE '%s'", path);
+	}
+}
 
 /*
  * Try to parse each line from file specified by 'path' according
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
