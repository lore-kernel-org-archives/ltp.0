Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A59C87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:04:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 520003C2EFD
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 15:04:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9819F3C2C78
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E022E1000999
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0CF21F441;
 Tue,  5 Aug 2025 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHtU0Tvv4qQSM5HohjHq52eitMapaj6HJ55yPJxuMIg=;
 b=qaBMi5l9wf/IHpQ9Jiv36E641xDteTKtrwMLFUdarQ6bCmnvF002p1EsORdcY+cl6Bf8WI
 DeYgiKvpm5eWldHsSGGHJ5iogqNVsx4jQxEruhxXxsPR7ArwG5y8e4Fyk8TgqLuJx27hUC
 qUI1akptpe13iucqV6zRcowzUDGy5pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHtU0Tvv4qQSM5HohjHq52eitMapaj6HJ55yPJxuMIg=;
 b=0CNKxPEa0kqqm1dqujr18OMzq5xjrVUKAPq4KW6tbFlWX0Rv8r90VehFdqK+6LplEmnBeK
 EfRqt1O8S5MvjWDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHtU0Tvv4qQSM5HohjHq52eitMapaj6HJ55yPJxuMIg=;
 b=qaBMi5l9wf/IHpQ9Jiv36E641xDteTKtrwMLFUdarQ6bCmnvF002p1EsORdcY+cl6Bf8WI
 DeYgiKvpm5eWldHsSGGHJ5iogqNVsx4jQxEruhxXxsPR7ArwG5y8e4Fyk8TgqLuJx27hUC
 qUI1akptpe13iucqV6zRcowzUDGy5pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHtU0Tvv4qQSM5HohjHq52eitMapaj6HJ55yPJxuMIg=;
 b=0CNKxPEa0kqqm1dqujr18OMzq5xjrVUKAPq4KW6tbFlWX0Rv8r90VehFdqK+6LplEmnBeK
 EfRqt1O8S5MvjWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9176F13AA8;
 Tue,  5 Aug 2025 13:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KIdTIBkBkmhpFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 13:03:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 15:03:15 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v4-2-08e23354abc8@suse.com>
References: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754399000; l=2269;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=QIRpiPBRcBoO2A7CFbxfci1NVxN3amWgwPByr22WVkE=;
 b=A6ofHSf8YrwuirzN7qXyUkPTFfLjSjpItMzOPhKqxuFsfiL78wmxYt2Bcbg/LkK2r58AB0Tju
 ZuoqtWRUd4UC8xV0WJ+idymQ2WyjkSpuaoa+K9SjtaLQRNeUkTP74gu
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, configure.ac:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/7] fs: add struct fsxattr fallback definitions
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
