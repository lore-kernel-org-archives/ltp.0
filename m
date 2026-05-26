Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8187CCD5BD5
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 08:35:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C47FF3E5249
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 10:35:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E6C03C5730
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:34:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77B99600925
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:34:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3518654E6
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779784454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5ESTMPJWe2/yVRXCqhEi4L8sTVHKyBKoOC/0IL3SbE=;
 b=ra4oocYjrrlaNfVXV5sp4D3nYTYdEqE7sZO61MZBNHyH37gYeoKYdgL5nO7Z7n7vNzkEjr
 GxSK3RnyB2rLT9g+5qxc7dK/vCCh9NqOIjZ/9DHh6AGFHxtMx844500novSGiGUH0ypB70
 Wjocn7qbU5ZiFEKHJ6qK1Tvbt+0ktNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779784454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5ESTMPJWe2/yVRXCqhEi4L8sTVHKyBKoOC/0IL3SbE=;
 b=khDqlEJ3Vnz/8l3HE/BJBErjR1tSIUG1p7FF8Z9Th1h48aSSCz/sfy9k+CuHpjNopF1O3h
 HfeV7RLHi1A3zDAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2rvYZY1G;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pYUuTcDm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779784453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5ESTMPJWe2/yVRXCqhEi4L8sTVHKyBKoOC/0IL3SbE=;
 b=2rvYZY1GZaXy7u+5WPj4qhcmHnXWKvP2OrK0OlsnCZ8xzb7Xb0mnd5WbT75kV+3WN/MhYs
 SjpLUrBxDJ4Tw/XdxzJ7QYmHSdDCp5/Qv8AxIwLdu+EtiFUOCZ8rhUfSzwz1qmohq+Xq+K
 PljwppYOe2MZWCCBGvlSeEA9E0fCbMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779784453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5ESTMPJWe2/yVRXCqhEi4L8sTVHKyBKoOC/0IL3SbE=;
 b=pYUuTcDmWv17OdHAjwTELI2cc0WWvorJxNYCVvHKNAFAykhKwDZOFvVBDTsbJiDo0DLpVx
 OZQjrKDlGP5W2cDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A259D5A0F6
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iXKuJgVbFWo7SwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 10:34:05 +0200
Message-ID: <20260526083406.357092-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526083406.357092-1-chrubis@suse.cz>
References: <20260526083406.357092-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B3518654E6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] safe_macros: Add SAFE_READ_ANY_EAGAIN
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

Similarly to the safe_write() this turns the len_strict into three way
switch with the new value SAFE_READ_ANY_EAGAIN=2 that turns EAGAIN into
a read with a zero length.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/safe_macros_fn.h | 16 ++++++++++++++--
 lib/safe_macros.c        | 10 +++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 9a09c4922..e8dc02539 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -36,6 +36,18 @@ enum safe_write_opts {
 	SAFE_WRITE_RETRY = 2,
 };
 
+/* supported values for safe_read() len_strict parameter */
+enum safe_read_opts {
+	/* no length strictness, short reads are ok */
+	SAFE_READ_ANY = 0,
+
+	/* strict length, short reads trigger TBROK */
+	SAFE_READ_ALL = 1,
+
+	/* converts EAGAIN to read that returns 0 */
+	SAFE_READ_ANY_EAGAIN = 2,
+};
+
 char* safe_basename(const char *file, const int lineno,
                     void (*cleanup_fn)(void), char *path);
 
@@ -80,8 +92,8 @@ int safe_pipe(const char *file, const int lineno,
               void (*cleanup_fn)(void), int fildes[2]);
 
 ssize_t safe_read(const char *file, const int lineno,
-                  void (*cleanup_fn)(void), char len_strict, int fildes,
-                  void *buf, size_t nbyte);
+                  void (*cleanup_fn)(void), enum safe_read_opts len_strict,
+                  int fildes, void *buf, size_t nbyte);
 
 int safe_setegid(const char *file, const int lineno,
                  void (*cleanup_fn)(void), gid_t egid);
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 68b8747b4..f95c5fdc5 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -286,14 +286,18 @@ int safe_pipe(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
-ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
-                  char len_strict, int fildes, void *buf, size_t nbyte)
+ssize_t safe_read(const char *file, const int lineno,
+                  void (*cleanup_fn) (void), enum safe_read_opts len_strict,
+                  int fildes, void *buf, size_t nbyte)
 {
 	ssize_t rval;
 
 	rval = read(fildes, buf, nbyte);
 
 	if (rval == -1) {
+		if (len_strict == SAFE_READ_ANY_EAGAIN && errno == EAGAIN)
+			return 0;
+
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
 			nbyte, rval);
@@ -301,7 +305,7 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid read(%d,%p,%zu) return value %zd", fildes,
 			buf, nbyte, rval);
-	} else if (len_strict && (size_t)rval != nbyte) {
+	} else if (len_strict == SAFE_READ_ALL && (size_t)rval != nbyte) {
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
 			  "Short read(%d,%p,%zu) returned only %zd",
 			  fildes, buf, nbyte, rval);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
