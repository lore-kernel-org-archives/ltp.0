Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593D7C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2A003E1D5C
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:56:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8313E3C6F29
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 14B7B100099D
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:54:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66EA475DD1
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uScPiK8q6x1pUQ5SsRhtNfcrvcISY7FMI9oe6jcBFHw=;
 b=TxW4Z0Cb774Itcs8u+urWPaNKTx++G1GvXv+m/6EZBLXmYnBLZuhCYKkjAkZ8qE3afGHXF
 yJCuPFwgXmwOIfP7vqb3IQCvrE6StUyrm3fDv2/QtGj7WOvOtk/CVOT/0SEyf1W/p/dHo0
 kCqq21aLGXNkKLjzmKA6LGQg0zoXahs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uScPiK8q6x1pUQ5SsRhtNfcrvcISY7FMI9oe6jcBFHw=;
 b=7rbXTdhRxJbFhvDeRlzHGnQ7d4iQAKW6RE6eA6yfM7r9V/CUFk6/oISLV/2z/GHNW2u/Ed
 eHnA1b9e0yLWH1Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TxW4Z0Cb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7rbXTdhR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783587255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uScPiK8q6x1pUQ5SsRhtNfcrvcISY7FMI9oe6jcBFHw=;
 b=TxW4Z0Cb774Itcs8u+urWPaNKTx++G1GvXv+m/6EZBLXmYnBLZuhCYKkjAkZ8qE3afGHXF
 yJCuPFwgXmwOIfP7vqb3IQCvrE6StUyrm3fDv2/QtGj7WOvOtk/CVOT/0SEyf1W/p/dHo0
 kCqq21aLGXNkKLjzmKA6LGQg0zoXahs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783587255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uScPiK8q6x1pUQ5SsRhtNfcrvcISY7FMI9oe6jcBFHw=;
 b=7rbXTdhRxJbFhvDeRlzHGnQ7d4iQAKW6RE6eA6yfM7r9V/CUFk6/oISLV/2z/GHNW2u/Ed
 eHnA1b9e0yLWH1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CFC779AA
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 08:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9TVUFLdhT2oiHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 08:54:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 10:53:51 +0200
Message-ID: <20260709085353.345957-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709085353.345957-1-chrubis@suse.cz>
References: <20260709085353.345957-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 66EA475DD1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/9] SAFE_MACROS: Add SAFE_POLL()
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h |  6 ++++++
 lib/tst_safe_macros.c     | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c73c1acb1..91a130a48 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <grp.h>
+#include <poll.h>
 
 #include "safe_stdio_fn.h"
 #include "safe_macros_fn.h"
@@ -517,4 +518,9 @@ int safe_statvfs(const char *file, const int lineno,
 #define SAFE_STATVFS(path, buf) \
 	safe_statvfs(__FILE__, __LINE__, (path), (buf))
 
+int safe_poll(const char *const file, const int lineno, struct pollfd *fds,
+		nfds_t nfds, int timeout);
+#define SAFE_POLL(fds, nfds, timeout) \
+	safe_poll(__FILE__, __LINE__, (fds), (nfds), (timeout))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index cdc8c7dd3..f17f911ef 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -829,3 +829,21 @@ int safe_statvfs(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_poll(const char *const file, const int lineno, struct pollfd *fds,
+		nfds_t nfds, int timeout)
+{
+	int rval;
+
+	rval = poll(fds, nfds, timeout);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"poll(%p, %li, %i) failed", fds, (long)nfds, timeout);
+	} else if (rval < -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid poll(%p, %li, %i) return value %i",
+			fds, (long)nfds, timeout, rval);
+	}
+
+	return rval;
+}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
