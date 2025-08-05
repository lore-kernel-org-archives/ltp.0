Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343BAC87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 07:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1F7E3C743E
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 09:03:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4DF93C1C44
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:02:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 130021000D29
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F361C1F38C;
 Tue,  5 Aug 2025 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/zxxRy+te67UWpfodzhAtWS67yvnQZcQK8uegDHhdM=;
 b=px8oLCrBJL7nzO9CykEYp2Qkigfc8Lz5OYZZDG0FT71JAptLZiFeagJRnFKGJXG7aBl16X
 dmZaI4Ibgj5NLdfRaSTBCXm4nGXU0KqwVGH6gSc1lag1agzNlgckgAS8r8Fz+/o3OBlpkl
 zdHhi7FK+PulGu/D/AvV+Bd68tXMu0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/zxxRy+te67UWpfodzhAtWS67yvnQZcQK8uegDHhdM=;
 b=oVEwacanwvbvO7Lj3QYzg8HJyKPU7FxOlEKYlbe9pVKNng5mDElkQJkQRsYoKn2Qerokix
 sdVTRs57EPV3DiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/zxxRy+te67UWpfodzhAtWS67yvnQZcQK8uegDHhdM=;
 b=r3rj5A/QiLIs9wBC8eoROUNDCCGhEyV54X2Jh6tB+gtvcBSLa1GTeSFXvMkwRjBdTM4nz3
 /1B5ijwYptdp4AmAhy7OtReEdiK3HUkIx2G0M2HW2DaYxC3OQfJvh5PPEeU9eEgfDSY8pq
 Lop4ZZmzWCFQu4FAu7x3IynLRT87sBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/zxxRy+te67UWpfodzhAtWS67yvnQZcQK8uegDHhdM=;
 b=LrvKya62wkA/FbHPvGSKlIgV05k9AACCITG6zLZSsYcO8gl7JKbv8lTOlPiF+5njZ4/xHq
 CQajtoxn29tdJCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE78A13A9F;
 Tue,  5 Aug 2025 07:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4MjqL1+skWgiGgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 07:01:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 09:01:50 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v3-2-67a7747d226c@suse.com>
References: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754377311; l=1941;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=S3YguhUwzrBizMvTZ8+h05N1l2EG+UlBSS9H35wDFZM=;
 b=FFOZjUyF9QI01TMKNWCWZQqr6VPozD76WlCR7lYFDHJTGo9zse3uzZVp219i+58yHyO4Zueb6
 RUvB73GoxH2BXsgOH9/xp3rTp5Dy/GTRmT7LUjtx+82hC9cGEB5T78h
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/6] fs: add struct fsxattr fallback definitions
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac      |  2 ++
 include/lapi/fs.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/configure.ac b/configure.ac
index 12025be51c865719b68c06ec3c286210dafbfa43..9bd139f602b9f174e5314171f8f03338c06f3df4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -264,6 +264,8 @@ AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
 
+AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 8261ca41dab7d01ea5e7dc9d65e3d5604013cd46..261f9fd016eaa39e3072d9fb48742616b0c5f571 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -14,10 +14,22 @@
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
