Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A54C87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 07:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EDD73C742B
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 09:02:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B49303C736D
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:01:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 21D851000D20
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 09:01:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3270921994;
 Tue,  5 Aug 2025 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O45uv2aqeL+ROVwaitZBxi6AwjiWcgj9JgX5u/yawqY=;
 b=Ibj9o45bMWZfS3iWKfduGp7r3y1xZQ3dyj3MVA0rGGjW0Wp9IJJ2hLQfIL8iOSlM/hVtrR
 cKXwdA+A7ef4WfKfwsuM2FhIlM20z6BU3sNguJDf1230AuWaMQuOH3KuixD0wviS+EiqlJ
 ucmMPzRHG+16Igg2EAnGNQEjHICXPrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O45uv2aqeL+ROVwaitZBxi6AwjiWcgj9JgX5u/yawqY=;
 b=GCsoq77J0ArGRz6zgfu9zXCy+TsIR05yzNu+9ERJ+pSYYb0IQsJApdm1jqeycvrXPTgRa8
 kk6oUCBB3MzmaBDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ibj9o45b;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GCsoq77J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754377312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O45uv2aqeL+ROVwaitZBxi6AwjiWcgj9JgX5u/yawqY=;
 b=Ibj9o45bMWZfS3iWKfduGp7r3y1xZQ3dyj3MVA0rGGjW0Wp9IJJ2hLQfIL8iOSlM/hVtrR
 cKXwdA+A7ef4WfKfwsuM2FhIlM20z6BU3sNguJDf1230AuWaMQuOH3KuixD0wviS+EiqlJ
 ucmMPzRHG+16Igg2EAnGNQEjHICXPrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754377312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O45uv2aqeL+ROVwaitZBxi6AwjiWcgj9JgX5u/yawqY=;
 b=GCsoq77J0ArGRz6zgfu9zXCy+TsIR05yzNu+9ERJ+pSYYb0IQsJApdm1jqeycvrXPTgRa8
 kk6oUCBB3MzmaBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EA3C13A50;
 Tue,  5 Aug 2025 07:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OkLAWCskWgiGgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 07:01:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 09:01:51 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v3-3-67a7747d226c@suse.com>
References: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754377311; l=2860;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=oyX3D1zgwvnWdqMZkqAxfEWrKdqJfU2jth5n6v/CFU8=;
 b=1VJVexNiAMWaynhxRegrKma3bhdaR5j5sBkA1VcbYHmOvwAtw5ptScSeIap+Yar0qNhI6l8cm
 Kil4ks1yqBHACC1JjJ7Go7RzyRRf4vu+R00tzS/D8z0JzJOdAUDt44L
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 3270921994
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/6] fs: add file_setattr/file_getattr fallback
 definitions
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
 configure.ac      |  1 +
 include/lapi/fs.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9bd139f602b9f174e5314171f8f03338c06f3df4..3ddea62b57270662fe8f24d52d697874ee8768ef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,6 +263,7 @@ AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
+AC_CHECK_TYPES([struct file_attr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 261f9fd016eaa39e3072d9fb48742616b0c5f571..ac3e09fd6dcc60e3237247bd575b0d8c2796cb07 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -14,10 +14,13 @@
 # include <linux/fs.h>
 #endif
 
+#include <stddef.h>
 #include <stdint.h>
 #include <sys/user.h>
 #include <limits.h>
+#include "tst_test.h"
 #include "lapi/abisize.h"
+#include "lapi/syscalls.h"
 
 #ifndef HAVE_STRUCT_FSXATTR
 struct fsxattr {
@@ -66,6 +69,18 @@ struct fsxattr {
 # define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
 #endif
 
+#ifndef FS_XFLAG_APPEND
+# define FS_XFLAG_APPEND	0x00000010	/* all writes append */
+#endif
+
+#ifndef FS_XFLAG_EXTSIZE
+# define FS_XFLAG_EXTSIZE	0x00000800	/* extent size allocator hint */
+#endif
+
+#ifndef FS_XFLAG_COWEXTSIZE
+# define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#endif
+
 /*
  * Helper function to get MAX_LFS_FILESIZE.
  * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
@@ -88,4 +103,33 @@ static inline long long tst_max_lfs_filesize(void)
 #endif
 }
 
+#ifndef HAVE_STRUCT_FILE_ATTR
+struct file_attr {
+	uint64_t fa_xflags;	/* xflags field value (get/set) */
+	uint32_t fa_extsize;	/* extsize field value (get/set)*/
+	uint32_t fa_nextents;	/* nextents field value (get)   */
+	uint32_t fa_projid;	/* project identifier (get/set) */
+	uint32_t fa_cowextsize;	/* CoW extsize field value (get/set) */
+};
+#endif
+
+#define FILE_ATTR_SIZE_VER0 24
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+
+static inline int file_getattr(int dfd, const char *filename,
+			    struct file_attr *ufattr, size_t usize,
+			    unsigned int at_flags)
+{
+	return tst_syscall(__NR_file_getattr, dfd, filename, ufattr, usize,
+		    at_flags);
+}
+
+static inline int file_setattr(int dfd, const char *filename,
+			    struct file_attr *ufattr, size_t usize,
+			    unsigned int at_flags)
+{
+	return tst_syscall(__NR_file_setattr, dfd, filename, ufattr, usize,
+		    at_flags);
+}
+
 #endif /* LAPI_FS_H__ */

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
