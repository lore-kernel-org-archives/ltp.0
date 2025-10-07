Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59109CAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D32B23CE1BA
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:48:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AECF23CE338
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 152EC600858
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E376E1F452;
 Tue,  7 Oct 2025 06:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hc0aKrvD3knkoPTDf/th42K3CBJI+lK3o1HH4HyZp/A=;
 b=GkUagnyfCN8f56pJ18ZZybOC3tj1wa/Q2elmD+h5D+3rTOFBzpSQ90A10I95aZZdhTwPL0
 DI9VdVUU/MyA5y0gWk38ntYjoshP6Wk7BwfIJV2fi7dKXkiyHUuVaRKm0unC6huTM455qx
 dh20fGQtoNDLT+J7vR4xfwWsSOELXhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hc0aKrvD3knkoPTDf/th42K3CBJI+lK3o1HH4HyZp/A=;
 b=6vdISgCUKaRBtDH1QAdvWifcLtWNzCMIbVrRS3WcETDea17eDc2Thn9TikqVy0RAVixb1c
 czuOQ0EziIQa1lBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GkUagnyf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6vdISgCU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hc0aKrvD3knkoPTDf/th42K3CBJI+lK3o1HH4HyZp/A=;
 b=GkUagnyfCN8f56pJ18ZZybOC3tj1wa/Q2elmD+h5D+3rTOFBzpSQ90A10I95aZZdhTwPL0
 DI9VdVUU/MyA5y0gWk38ntYjoshP6Wk7BwfIJV2fi7dKXkiyHUuVaRKm0unC6huTM455qx
 dh20fGQtoNDLT+J7vR4xfwWsSOELXhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hc0aKrvD3knkoPTDf/th42K3CBJI+lK3o1HH4HyZp/A=;
 b=6vdISgCUKaRBtDH1QAdvWifcLtWNzCMIbVrRS3WcETDea17eDc2Thn9TikqVy0RAVixb1c
 czuOQ0EziIQa1lBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4482313AAC;
 Tue,  7 Oct 2025 06:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SAOtAm235Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:54 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-2-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=1216;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=Aff1lzVM7dRbresLhMElOXZj2kaoDXZXUg/9gCvwWUY=;
 b=XDZBBFfXymL1dlt54dvc/gpUOTqeTC8ByYYBxDJg3PSRuPaNeN7cVmLaqG694+xBADki7NKX7
 QDSPV7S5cfZCJ4A8ypxqNqyDpBYggcyJvI1aBrSLsa83DAK37va3A1F
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: E376E1F452
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,configure.ac:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/10] lapi: add setxattrat() fallback definition
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  1 +
 include/lapi/xattr.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index c32d9992c..827a8e6eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -157,6 +157,7 @@ AC_CHECK_FUNCS_ONCE([ \
     sendmmsg \
     sethostid \
     setns \
+    setxattrat \
     sigpending \
     splice \
     statx \
diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
index 8bd2d45e4..8ab7e51d5 100644
--- a/include/lapi/xattr.h
+++ b/include/lapi/xattr.h
@@ -7,7 +7,9 @@
 #define LAPI_XATTR_H__
 
 #include <stdint.h>
+#include <stddef.h>
 #include "config.h"
+#include "lapi/syscalls.h"
 
 #ifdef HAVE_LINUX_XATTR_H
 # include <linux/xattr.h>
@@ -29,4 +31,14 @@ struct xattr_args {
 };
 #endif
 
+#ifndef HAVE_FUNC_SETXATTRAT
+static inline int setxattrat(int dfd, const char *pathname,
+			     unsigned int at_flags, const char *name,
+			     const struct xattr_args *uargs, size_t usize)
+{
+	return tst_syscall(__NR_setxattrat, dfd, pathname, at_flags, name,
+		    uargs, usize);
+}
+#endif
+
 #endif /* LAPI_XATTR_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
