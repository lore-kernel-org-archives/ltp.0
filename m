Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0826AC87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:02:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A53F3C91B9
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 09:02:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDE2E3C8F7A
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:01:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7107600096
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:01:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F99933C7A;
 Thu,  7 Aug 2025 07:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBo7B5tQHcRrPn6hO7rZZtQoaShl5dlFaZiXhMajNH8=;
 b=yUe8xiaDSm6nByVddRxkHNW3INutnNZH2R1ZPhPgk/SJ6d85J+4bqBeLveyoYzMjdVtXo7
 gdNA7QV0Q9urHa277DKfQD8V9EcB7c3hlVlLJrRv+OLrAjxnu2n5DiqqYK5pvsoVMgMBgr
 DWyIHIdv2XsMMlqunLeP2CkEGEiNBz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBo7B5tQHcRrPn6hO7rZZtQoaShl5dlFaZiXhMajNH8=;
 b=eQQe9tW5xo1VI8cku925RMrmn9PXe0B+dwUFk9gnsQpJWIvWiIGl2w8PdD42uRRxMKUkpX
 3Igamb4Vk0kGqQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBo7B5tQHcRrPn6hO7rZZtQoaShl5dlFaZiXhMajNH8=;
 b=yUe8xiaDSm6nByVddRxkHNW3INutnNZH2R1ZPhPgk/SJ6d85J+4bqBeLveyoYzMjdVtXo7
 gdNA7QV0Q9urHa277DKfQD8V9EcB7c3hlVlLJrRv+OLrAjxnu2n5DiqqYK5pvsoVMgMBgr
 DWyIHIdv2XsMMlqunLeP2CkEGEiNBz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBo7B5tQHcRrPn6hO7rZZtQoaShl5dlFaZiXhMajNH8=;
 b=eQQe9tW5xo1VI8cku925RMrmn9PXe0B+dwUFk9gnsQpJWIvWiIGl2w8PdD42uRRxMKUkpX
 3Igamb4Vk0kGqQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F8FC13969;
 Thu,  7 Aug 2025 07:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CEBiBVdPlGhaDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 07 Aug 2025 07:01:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 07 Aug 2025 09:01:41 +0200
MIME-Version: 1.0
Message-Id: <20250807-file_setattr_getattr-v6-3-ebe32b282d49@suse.com>
References: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
In-Reply-To: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754550102; l=3174;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=oKyFArPSmDfx8omA5maNulhXTF9hRAu0F23f9kOsCzs=;
 b=GQNILDota23rySEjOmDS/40utPs2OA9DvHPkGqOp++jy3fhxaff9FnD60/ZsPwi2rXpam1izy
 cSsMFaTCEe6AsMXoAvzoYp5Jn7whnqeYCLBejQA+zHBj2DKStZeeUJw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/7] fs: add file_setattr/file_getattr fallback
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac      |  3 +++
 include/lapi/fs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8b506e43f8c8549f6dc9cbc4154db2be95851e59..db41175bf277775bf8aec990e2119bc6795c863e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -112,6 +112,8 @@ AC_CHECK_FUNCS_ONCE([ \
     execveat \
     faccessat2 \
     fallocate \
+    file_getattr \
+    file_setattr \
     fsconfig \
     fsmount \
     fsopen \
@@ -264,6 +266,7 @@ AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
+AC_CHECK_TYPES([struct file_attr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 44f299149abd9415c243b2052b93f1524442beb7..6b5056bd25c5504637f01f10be8b091f79d5632d 100644
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
@@ -88,4 +103,37 @@ static inline long long tst_max_lfs_filesize(void)
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
+#ifndef HAVE_FILE_GETATTR
+static inline int file_getattr(int dfd, const char *filename,
+			    struct file_attr *ufattr, size_t usize,
+			    unsigned int at_flags)
+{
+	return tst_syscall(__NR_file_getattr, dfd, filename, ufattr, usize,
+		    at_flags);
+}
+#endif
+
+#ifndef HAVE_FILE_SETATTR
+static inline int file_setattr(int dfd, const char *filename,
+			    struct file_attr *ufattr, size_t usize,
+			    unsigned int at_flags)
+{
+	return tst_syscall(__NR_file_setattr, dfd, filename, ufattr, usize,
+		    at_flags);
+}
+#endif
+
 #endif /* LAPI_FS_H__ */

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
