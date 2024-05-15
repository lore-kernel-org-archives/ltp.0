Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A4C25B78
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:34:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB7893CF750
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:34:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2EE53CD986
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A01661A0BC27
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7C17339EE;
 Wed, 15 May 2024 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZT4peIxZS592A6ZO4fOuEAwUJdoI7TWAATvRmmhGBE=;
 b=xa0ENKwwRWcgkzwn/GY/3xkp3GoPwxVvzoItlagRessBjm/Q1t0YK1I63j5HqWuMBkxPkZ
 eHZgZl1gMkgx/UwuSEKgqFcVOj7hFu1O7T00EzLlQnEohXqvbDWcZOoyO2CyhL/a4iUqlq
 FFnZt0RpebaEaOI3x/O9ugSpvYCcvTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZT4peIxZS592A6ZO4fOuEAwUJdoI7TWAATvRmmhGBE=;
 b=hp7YKLI0Co+0jQ66AZ6RM69y+St/7LtT1lC9n1VRkJpB/PCpzEfxNkuH/jYmcadoEG05Cq
 /kJTpz3ir80YUFAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZT4peIxZS592A6ZO4fOuEAwUJdoI7TWAATvRmmhGBE=;
 b=s7xbGbQHgMTfl9Q57hjC6i1dj1CSGMX7QhlyG36j/4XvJlwXPEshku1dyaIRZ+OXW8XJMz
 Tibhw3z753pdb3NKEr7abBoBfQRTSpD40JHX6W+guVWmTRd42KoX12yXwqMjrTpkweTGcL
 uTM61jLYUswykmWFTcY0rB84Xv1Abu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZT4peIxZS592A6ZO4fOuEAwUJdoI7TWAATvRmmhGBE=;
 b=E7ecEPnGh2ysOZ2shrdJyZVPrBlfa+oNSoYjnZWtP1fA2EVpifdch9pMXRwY/EBG1tx+ez
 SuB9EKYj2lYpfTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B22E613A66;
 Wed, 15 May 2024 09:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ePNqKYOBRGb1TwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 May 2024 09:33:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 11:33:41 +0200
Message-Id: <20240515093349.7347-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240515093349.7347-1-andrea.cervesato@suse.de>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 02/10] Add listmount/statmount fallback declarations
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
 configure.ac                       |  5 +++
 include/lapi/mount.h               | 67 ++++++++++++++++++++++++++++++
 include/lapi/stat.h                | 10 ++++-
 include/lapi/syscalls/aarch64.in   |  2 +
 include/lapi/syscalls/arc.in       |  2 +
 include/lapi/syscalls/arm.in       |  2 +
 include/lapi/syscalls/hppa.in      |  2 +
 include/lapi/syscalls/i386.in      |  2 +
 include/lapi/syscalls/ia64.in      |  2 +
 include/lapi/syscalls/loongarch.in |  2 +
 include/lapi/syscalls/mips_n32.in  |  2 +
 include/lapi/syscalls/mips_n64.in  |  2 +
 include/lapi/syscalls/mips_o32.in  |  2 +
 include/lapi/syscalls/powerpc.in   |  2 +
 include/lapi/syscalls/powerpc64.in |  2 +
 include/lapi/syscalls/s390.in      |  2 +
 include/lapi/syscalls/s390x.in     |  2 +
 include/lapi/syscalls/sh.in        |  2 +
 include/lapi/syscalls/sparc.in     |  2 +
 include/lapi/syscalls/sparc64.in   |  2 +
 include/lapi/syscalls/x86_64.in    |  2 +
 21 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1f7aa70bd..95c91c6af 100644
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
@@ -232,6 +234,9 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 #endif
 ])
 
+AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
+AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index c1af944fe..57542832f 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -37,4 +37,71 @@
 # define MS_NOSYMFOLLOW 256
 #endif
 
+#ifndef HAVE_MNT_ID_REQ
+struct mnt_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 mnt_id;
+	__u64 param;
+};
+#endif
+
+#ifndef HAVE_STATMOUNT
+struct statmount {
+	__u32 size;
+	__u32 __spare1;
+	__u64 mask;
+	__u32 sb_dev_major;
+	__u32 sb_dev_minor;
+	__u64 sb_magic;
+	__u32 sb_flags;
+	__u32 fs_type;
+	__u64 mnt_id;
+	__u64 mnt_parent_id;
+	__u32 mnt_id_old;
+	__u32 mnt_parent_id_old;
+	__u64 mnt_attr;
+	__u64 mnt_propagation;
+	__u64 mnt_peer_group;
+	__u64 mnt_master;
+	__u64 propagate_from;
+	__u32 mnt_root;
+	__u32 mnt_point;
+	__u64 __spare2[50];
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
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 2cb6c2d87..3b32a3b2a 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -297,4 +297,6 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..1a3a908e4 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -317,3 +317,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..78d84549f 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -395,3 +395,5 @@ faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
+statmount (__NR_SYSCALL_BASE+457)
+listmount (__NR_SYSCALL_BASE+458)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..1f01a4a0c 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -44,3 +44,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..f4e6589ab 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -431,3 +431,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..dd8b8c79f 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -344,3 +344,5 @@ faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
 futex_waitv 1473
+statmount 1481
+listmount 1482
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 301f611f6..f48c0658c 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -305,3 +305,5 @@ memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index e818c9d92..af5928c0e 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -371,3 +371,5 @@ epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
 futex_waitv 6449
+statmount 6457
+listmount 6458
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..a6d83e2e0 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -347,3 +347,5 @@ epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
 futex_waitv 5449
+statmount 5457
+listmount 5458
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..eda7388a3 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -417,3 +417,5 @@ epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
 futex_waitv 4449
+statmount 4457
+listmount 4458
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..1b40ea53d 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -424,3 +424,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..1b40ea53d 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -424,3 +424,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..6593a4ff7 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -411,3 +411,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..b98e727d6 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -359,3 +359,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..59178113e 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -405,3 +405,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..56a244ceb 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -410,3 +410,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..84051a600 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -375,3 +375,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..935c5d7bc 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -352,6 +352,8 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+statmount 457
+listmount 458
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
