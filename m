Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F5C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:04:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1DCE3C8F8E
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 09:04:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C9E33C9205
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:02:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B4B23600874
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:02:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1305B1F804;
 Thu,  7 Aug 2025 07:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQFKZnVqdyyXrB61cC/xZIChmb6K0DrW7H2XWWvRcwU=;
 b=qK94zGNK266FJKylZGfe8bWmMHDhnS6Do0puSMfLONAmhPfy/7LMjaySk+gUxna2Q7bPbs
 Wud2ana760AyCYkto5x7hKaF3mDPKlbxebo/RqPkwq9ZHdK8sHuW6EawonEyUuARFyqATb
 sYMoHKvLheRfZrUxCfjwLDhMsd2O68I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQFKZnVqdyyXrB61cC/xZIChmb6K0DrW7H2XWWvRcwU=;
 b=gVeDDSTH1kZ/DLATd/Wr5gXAFequBrTrSXTdV9NbQelGspCyMEdJErt4h0mEPf9Xf0P1ow
 KuvlEaX75+ACwEBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qK94zGNK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gVeDDSTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQFKZnVqdyyXrB61cC/xZIChmb6K0DrW7H2XWWvRcwU=;
 b=qK94zGNK266FJKylZGfe8bWmMHDhnS6Do0puSMfLONAmhPfy/7LMjaySk+gUxna2Q7bPbs
 Wud2ana760AyCYkto5x7hKaF3mDPKlbxebo/RqPkwq9ZHdK8sHuW6EawonEyUuARFyqATb
 sYMoHKvLheRfZrUxCfjwLDhMsd2O68I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQFKZnVqdyyXrB61cC/xZIChmb6K0DrW7H2XWWvRcwU=;
 b=gVeDDSTH1kZ/DLATd/Wr5gXAFequBrTrSXTdV9NbQelGspCyMEdJErt4h0mEPf9Xf0P1ow
 KuvlEaX75+ACwEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8C5E13ABE;
 Thu,  7 Aug 2025 07:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HGoMlZPlGhaDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 07 Aug 2025 07:01:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 07 Aug 2025 09:01:40 +0200
MIME-Version: 1.0
Message-Id: <20250807-file_setattr_getattr-v6-2-ebe32b282d49@suse.com>
References: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
In-Reply-To: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754550102; l=2314;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=c7Rwim5SYPyPSNkby7zfnIf1ZS4dJQmVxxJCFv0u2Ow=;
 b=XQ3quUFA3WTmiM5WHlrLGsRPy/lJPrncOjwvvHsZ9IoBZLNLB/6uyIz5kUtUh+qJTQNBzvFcP
 6VyrVkachG6AAowj32R+3xGTGxf8u0BZzzETs68V3SPqOoFdm8AELzU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 1305B1F804
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/7] fs: add struct fsxattr fallback definitions
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

Add strut fsxattr fallback, as well as FS_IOC_FSGETFLAGS and
FS_IOC_FSSETFLAGS.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac      |  3 +++
 include/lapi/fs.h | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 12025be51c865719b68c06ec3c286210dafbfa43..8b506e43f8c8549f6dc9cbc4154db2be95851e59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,6 +61,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/cryptouser.h \
     linux/close_range.h \
     linux/dccp.h \
+    linux/fs.h \
     linux/futex.h \
     linux/genetlink.h \
     linux/genhd.h \
@@ -264,6 +265,8 @@ AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
 
+AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 8261ca41dab7d01ea5e7dc9d65e3d5604013cd46..44f299149abd9415c243b2052b93f1524442beb7 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -10,14 +10,26 @@
 #define LAPI_FS_H__
 
 #include "config.h"
-#ifndef HAVE_MOUNT_SETATTR
+#ifndef HAVE_LINUX_FS
 # include <linux/fs.h>
 #endif
 
+#include <stdint.h>
 #include <sys/user.h>
 #include <limits.h>
 #include "lapi/abisize.h"
 
+#ifndef HAVE_STRUCT_FSXATTR
+struct fsxattr {
+	uint32_t fsx_xflags;	        /* xflags field value (get/set) */
+	uint32_t fsx_extsize;	        /* extsize field value (get/set)*/
+	uint32_t fsx_nextents;	        /* nextents field value (get)	*/
+	uint32_t fsx_projid;            /* project identifier (get/set) */
+	uint32_t fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	unsigned char fsx_pad[8];
+};
+#endif
+
 #ifndef FS_IOC_GETFLAGS
 # define	FS_IOC_GETFLAGS	_IOR('f', 1, long)
 #endif
@@ -26,6 +38,14 @@
 # define	FS_IOC_SETFLAGS	_IOW('f', 2, long)
 #endif
 
+#ifndef FS_IOC_FSGETXATTR
+# define FS_IOC_FSGETXATTR _IOR('X', 31, struct fsxattr)
+#endif
+
+#ifndef FS_IOC_FSSETXATTR
+# define FS_IOC_FSSETXATTR _IOW('X', 32, struct fsxattr)
+#endif
+
 #ifndef FS_COMPR_FL
 # define	FS_COMPR_FL        0x00000004 /* Compress file */
 #endif

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
