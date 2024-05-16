Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD42C25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:32:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 994F83CF9AD
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:32:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 464743CF98A
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:38 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE31A600C78
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2025A34924
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcngAa9n7wwGfLXAah+5j185B246yDE4zqVXiSx5agc=;
 b=zTqLHcM+e3jKSH+RJi9SDLzVF///UDJ5qkIULC9GtNMqmhUCLO5sLbHtUvXJKqgRkNWzXC
 zro62kedW2cS0mCFarQ4GTwZCV6UCYcBWJpwCLfbomQW5PhsG1mrgjgByp7futdp8G3LGQ
 Z3IDokhNIQ+aC6ZwWpV3eMMqpek/ArY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcngAa9n7wwGfLXAah+5j185B246yDE4zqVXiSx5agc=;
 b=IFAjxNiZ1Cif0qVFAcU2cOmlxMutUIyMFq1DkAHajFenhk6mIZHoqJkWhEUkHNC1pbyTYn
 wjRETuB3TMfF6dBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcngAa9n7wwGfLXAah+5j185B246yDE4zqVXiSx5agc=;
 b=zTqLHcM+e3jKSH+RJi9SDLzVF///UDJ5qkIULC9GtNMqmhUCLO5sLbHtUvXJKqgRkNWzXC
 zro62kedW2cS0mCFarQ4GTwZCV6UCYcBWJpwCLfbomQW5PhsG1mrgjgByp7futdp8G3LGQ
 Z3IDokhNIQ+aC6ZwWpV3eMMqpek/ArY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcngAa9n7wwGfLXAah+5j185B246yDE4zqVXiSx5agc=;
 b=IFAjxNiZ1Cif0qVFAcU2cOmlxMutUIyMFq1DkAHajFenhk6mIZHoqJkWhEUkHNC1pbyTYn
 wjRETuB3TMfF6dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F3A813A6A
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iHJ2Ai/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:11 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-3-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=hoP/WeLBriswU9VAcuqC6eIrSjxpS9ndWh8NDWIxSRY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwtLgosCf4eOWviM6qSh4efjIJsvfrR7l8Ui
 txwKlXJQOaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LQAKCRDLzBqyILPm
 RrBqDACP7LSt1pRJoXsBoyZa3ZWZx605iGqCIcTHDY7OvKz5zPHF9D7KhEzyziJDSpQfv8CLu3I
 4lh5pxqWQWNwdhrT+/k7a1MJdZTq2wDOghC6jJexWFSwaYVBFcV8PXVl/+MrkJJAZQw39NvQWer
 oCPi44cfijQNSaduNACzG/yZehdLxlyi/D1J2AFk0vw+ObKtteu2m+LLD1jWV/YSp2Y4Cw8zZUZ
 duglDzdUmHxPC+B7ruZkRkJO9++kSy3VpS50pV4Gdz0A9AB+CdFZK4diJJpM1FImlACQ4t6wH0X
 VW3m9wY7DPaxSLqDLb5rS2ZLKr32v2Db+CM3GiHi/PC3Nb7W46w4KclrkvlzOfoW3jJZ9+5QVlf
 Ux0Os/GZp6hMu4naBi4giPwJ8D8B/Y4qNiqlqB2sTEnK4ArGEpeRA6Gv0Aieg0ffwiv6HPXH/9Z
 /z+dNLkeBtNZ4z131IhwGTucv4zZElgLdsH+FPc1qJjQcFINCfgFxbI/U8UQ24KQC4UZw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 03/11] Add listmount/statmount fallback declarations
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

---
 configure.ac         |  5 ++++
 include/lapi/mount.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/lapi/stat.h  | 10 +++++++-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 85c5739c4..80462d2f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -113,6 +113,7 @@ AC_CHECK_FUNCS_ONCE([ \
     io_uring_register \
     io_uring_enter \
     kcmp \
+    listmount \
     mallinfo \
     mallinfo2 \
     mallopt \
@@ -142,6 +143,7 @@ AC_CHECK_FUNCS_ONCE([ \
     setns \
     sigpending \
     splice \
+    statmount \
     statx \
     stime \
     sync_file_range \
@@ -233,6 +235,9 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 #endif
 ])
 
+AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
+AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index c1af944fe..01a0fd2d6 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -2,12 +2,15 @@
 /*
  * Copyright (c) Linux Test Project, 2015-2022
  * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 #ifndef LAPI_MOUNT_H__
 #define LAPI_MOUNT_H__
 
+#include <stdint.h>
 #include <sys/mount.h>
+#include "config.h"
 
 #ifndef MS_REC
 # define MS_REC 16384
@@ -37,4 +40,71 @@
 # define MS_NOSYMFOLLOW 256
 #endif
 
+#ifndef HAVE_STRUCT_MNT_ID_REQ
+struct mnt_id_req {
+	uint32_t size;
+	uint32_t spare;
+	uint64_t mnt_id;
+	uint64_t param;
+};
+#endif
+
+#ifndef HAVE_STRUCT_STATMOUNT
+struct statmount {
+	uint32_t size;
+	uint32_t __spare1;
+	uint64_t mask;
+	uint32_t sb_dev_major;
+	uint32_t sb_dev_minor;
+	uint64_t sb_magic;
+	uint32_t sb_flags;
+	uint32_t fs_type;
+	uint64_t mnt_id;
+	uint64_t mnt_parent_id;
+	uint32_t mnt_id_old;
+	uint32_t mnt_parent_id_old;
+	uint64_t mnt_attr;
+	uint64_t mnt_propagation;
+	uint64_t mnt_peer_group;
+	uint64_t mnt_master;
+	uint64_t propagate_from;
+	uint32_t mnt_root;
+	uint32_t mnt_point;
+	uint64_t __spare2[50];
+	char str[];
+};
+#endif
+
+#ifndef MNT_ID_REQ_SIZE_VER0
+# define MNT_ID_REQ_SIZE_VER0 24
+#endif
+
+#ifndef STATMOUNT_SB_BASIC
+# define STATMOUNT_SB_BASIC 0x00000001U
+#endif
+
+#ifndef STATMOUNT_MNT_BASIC
+# define STATMOUNT_MNT_BASIC 0x00000002U
+#endif
+
+#ifndef STATMOUNT_PROPAGATE_FROM
+# define STATMOUNT_PROPAGATE_FROM 0x00000004U
+#endif
+
+#ifndef STATMOUNT_MNT_ROOT
+# define STATMOUNT_MNT_ROOT 0x00000008U
+#endif
+
+#ifndef STATMOUNT_MNT_POINT
+# define STATMOUNT_MNT_POINT 0x00000010U
+#endif
+
+#ifndef STATMOUNT_FS_TYPE
+# define STATMOUNT_FS_TYPE 0x00000020U
+#endif
+
+#ifndef LSMT_ROOT
+# define LSMT_ROOT 0xffffffffffffffff
+#endif
+
 #endif /* LAPI_MOUNT_H__ */
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 3606c9eb0..84dc76faf 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -95,7 +95,11 @@ struct statx {
 	uint32_t	stx_dev_major;
 	uint32_t	stx_dev_minor;
 	/* 0x90 */
-	uint64_t	__spare2[14];
+	__u64	stx_mnt_id;
+	__u32	stx_dio_mem_align;
+	__u32	stx_dio_offset_align;
+	/* 0xa0 */
+	__u64	__spare3[12];
 	/* 0x100 */
 };
 #endif
@@ -229,4 +233,8 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
+#ifndef STATX_MNT_ID_UNIQUE
+# define STATX_MNT_ID_UNIQUE  0x00004000U
+#endif
+
 #endif /* LAPI_STAT_H__ */

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
