Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D4BCD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:50:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 794753E2C2F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:50:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A87BC3E140D
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:50:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EFF041A003EC
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:50:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95CA96C198
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778140204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUyHLzAfzlMM1tQ15rwgyXn5dkMhfbQcP0Mtn0i3sus=;
 b=NUsKi0KzVpfcpouHt/+T6q6s8TMZpt5fVTD8r1EndvKGMDHVAdI3gequhVhlnM5XRcaBeW
 H3MHnGBlPd0/7xkhVhMxiZolXZ5mDNrDpOTYiFkzzFf4YAwupw6BX72jk25g89rr/TGJt8
 EP7pekRdabv8HxIQjKLPWxhiYKf2z9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778140204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUyHLzAfzlMM1tQ15rwgyXn5dkMhfbQcP0Mtn0i3sus=;
 b=xGthbzrIIDUViJG0+pJJaL6Gxj/3Gh7vHPq0DVULBTrkJJhOo4At/6BXJ8IqVsy3iEyfl2
 pcDxcGU56Rg3SqBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NUsKi0Kz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xGthbzrI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778140204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUyHLzAfzlMM1tQ15rwgyXn5dkMhfbQcP0Mtn0i3sus=;
 b=NUsKi0KzVpfcpouHt/+T6q6s8TMZpt5fVTD8r1EndvKGMDHVAdI3gequhVhlnM5XRcaBeW
 H3MHnGBlPd0/7xkhVhMxiZolXZ5mDNrDpOTYiFkzzFf4YAwupw6BX72jk25g89rr/TGJt8
 EP7pekRdabv8HxIQjKLPWxhiYKf2z9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778140204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUyHLzAfzlMM1tQ15rwgyXn5dkMhfbQcP0Mtn0i3sus=;
 b=xGthbzrIIDUViJG0+pJJaL6Gxj/3Gh7vHPq0DVULBTrkJJhOo4At/6BXJ8IqVsy3iEyfl2
 pcDxcGU56Rg3SqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87424593A7
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GmFOICxE/Gn+HQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:50:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 09:50:05 +0200
Message-ID: <20260507075006.8690-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507075006.8690-1-chrubis@suse.cz>
References: <20260507075006.8690-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 95CA96C198
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: safe_file_ops: Add SAFE_FILE_READ_STR()
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
 lib/safe_file_ops.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 0d8819594..73ebd2ab8 100644
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
+ * It's recommended to use this for various sysfs or procfs files that may be
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
index 8314c4b1b..19da1fd97 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -160,6 +160,32 @@ void safe_file_scanf(const char *file, const int lineno,
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
+		return;
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
+		return;
+	}
+}
 
 /*
  * Try to parse each line from file specified by 'path' according
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
