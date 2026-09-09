Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D4AC79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE8BF3C56D8
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:05:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D402F3C56D8
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:05:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 632FE10001A7
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:04:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 13AF71FB19;
 Wed,  9 Sep 2026 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788948294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zkN0QfyN7urQKhkqjrxbaqFqu45LOkHh5ijSaXNn+Q=;
 b=quycuAl2v44qxij2ikMKsElhVVw4vnZY84F1UkfEwbNyK0DGCWoK3cCI6DvtAJO5i8jqEX
 Sf4iYFC5H5tdQstiprr+vY6qwGfABhlKwIcnGuv497ZZ9aaehQqWGUE/Nix1gMBIn0I+cb
 XRoatxts12CB7bR9gC+r61M5ZUd10bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788948294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zkN0QfyN7urQKhkqjrxbaqFqu45LOkHh5ijSaXNn+Q=;
 b=q9FOsYfXfh+V+A1aEfVs3DeIMu8dQ0L5oxYBzzM+dFpllvvwrnrHqJq77loqgdOYbST1Ft
 OqjyScXSrbt8mGBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0MoYLTXY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ITHYy5hN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788948290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zkN0QfyN7urQKhkqjrxbaqFqu45LOkHh5ijSaXNn+Q=;
 b=0MoYLTXYEyIc4poPl/upHUZi0AdPMpf1Z0Ml3HuQtd21JkBaeLFnMyfKva0i3s9v7mGr9R
 pDvCbKr5TQhKG04QM7iVqLA7wFlmiMmFG6NDwY57gu3uS7IrKR960Dz5BaPSIYAU6eV7an
 Bmn19vHPRfT2pc+/NGmcSj6yy+Ir7X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788948290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zkN0QfyN7urQKhkqjrxbaqFqu45LOkHh5ijSaXNn+Q=;
 b=ITHYy5hNFUJ6mg4wappXD73fj2G0e+DLDKPgcSGlV6aBTcRAa3F8ZUly+yi5RM2ySeMXln
 cIQ0/YPFcFbvGvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC97E1365D;
 Wed,  9 Sep 2026 10:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SD02MEEvoWpSFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Sep 2026 10:04:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Sep 2026 12:04:48 +0200
MIME-Version: 1.0
Message-Id: <20260909-coredump-v9-1-6b0ee752f57e@suse.com>
References: <20260909-coredump-v9-0-6b0ee752f57e@suse.com>
In-Reply-To: <20260909-coredump-v9-0-6b0ee752f57e@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788948289; l=2406;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FyxbI43Nidvbgo7rwbQK4NztdZWMtNXJBOwo34HxQXY=;
 b=2tBOBnQFB9ySC/hfupwGEwXHGfTssrMhYzujV/Kj9lANfMATdzWN5NfxMeb+/PyK8TVI2d5Rm
 tGpzktzGbxqDeSLyG+Qdo1WFsMOvVUihACyE7ylVa6Dves5J3NOZf/h
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 13AF71FB19
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/3] lib: Add SAFE_FILE_VPRINTF()
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

Expose safe_file_vprintf() as SAFE_FILE_VPRINTF() macro to allow
formatting directly into files with a va_list without requiring
an intermediate buffer.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/safe_file_ops_fn.h  | 6 ++++++
 include/tst_safe_file_ops.h | 4 ++++
 lib/safe_file_ops.c         | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 223fb0d68..1edaac794 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -20,6 +20,7 @@
 
 #include <sys/stat.h>
 #include <time.h>
+#include <stdarg.h>
 
 #include "lapi/utime.h"
 
@@ -62,6 +63,11 @@ void safe_file_printf(const char *file, const int lineno,
                       const char *path, const char *fmt, ...)
                       __attribute__ ((format (printf, 5, 6)));
 
+void safe_file_vprintf(const char *file, const int lineno,
+		       void (*cleanup_fn)(void),
+		       const char *path, const char *fmt, va_list va)
+	__attribute__ ((format (printf, 5, 0)));
+
 void safe_try_file_printf(const char *file, const int lineno,
 	void (*cleanup_fn)(void), const char *path, const char *fmt, ...)
 	__attribute__ ((format (printf, 5, 6)));
diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 73ebd2ab8..b2b760b33 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -65,6 +65,10 @@ void safe_file_read_str(const char *file, const int lineno,
 	safe_file_printf(__FILE__, __LINE__, NULL, \
 	                 (path), (fmt), ## __VA_ARGS__)
 
+#define SAFE_FILE_VPRINTF(path, fmt, va) \
+	safe_file_vprintf(__FILE__, __LINE__, NULL, \
+			  (path), (fmt), (va))
+
 /* Same as SAFE_FILE_PRINTF() but returns quietly if the path doesn't exist */
 #define SAFE_TRY_FILE_PRINTF(path, fmt, ...) \
 	safe_try_file_printf(__FILE__, __LINE__, NULL, \
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 19da1fd97..1069a017f 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -280,7 +280,7 @@ err:
 	return 1;
 }
 
-static void safe_file_vprintf(const char *file, const int lineno,
+void safe_file_vprintf(const char *file, const int lineno,
 	void (*cleanup_fn)(void), const char *path, const char *fmt,
 	va_list va)
 {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
