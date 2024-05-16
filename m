Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE23BC25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 10:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3075F3CFA24
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:43:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 784333CF9C7
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:42:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CF466005EC
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:42:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5909347C2;
 Thu, 16 May 2024 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715856152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Akm5jI4sgGLKvCuy27wMcTLPdn8Sdoz31HzTz1PBRb4=;
 b=ub8yMzaIPAmAcmbye3ZbtyL1immfKLNOpGosrvvLDMemdddHNRWUL+J3wq9tptpvSzvhE1
 eBwdlLkIKyQwVAr64xALmPB3ujmlLA8JdZhjaMyawVV70T8dHPzRTKTrTZhBOpQ3ZwfBa6
 2c7ETWgSbvY4Q97+FD/z1gjbUxTsVNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715856152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Akm5jI4sgGLKvCuy27wMcTLPdn8Sdoz31HzTz1PBRb4=;
 b=3YLpCjPfk/m6bB20/suPXQhp1aOUb3NrT1hq43OvY29372Wp/MAr8RcwUd3fKIj5yX6Mrj
 Vj/7DehBziKA8+AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ub8yMzaI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3YLpCjPf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715856152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Akm5jI4sgGLKvCuy27wMcTLPdn8Sdoz31HzTz1PBRb4=;
 b=ub8yMzaIPAmAcmbye3ZbtyL1immfKLNOpGosrvvLDMemdddHNRWUL+J3wq9tptpvSzvhE1
 eBwdlLkIKyQwVAr64xALmPB3ujmlLA8JdZhjaMyawVV70T8dHPzRTKTrTZhBOpQ3ZwfBa6
 2c7ETWgSbvY4Q97+FD/z1gjbUxTsVNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715856152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Akm5jI4sgGLKvCuy27wMcTLPdn8Sdoz31HzTz1PBRb4=;
 b=3YLpCjPfk/m6bB20/suPXQhp1aOUb3NrT1hq43OvY29372Wp/MAr8RcwUd3fKIj5yX6Mrj
 Vj/7DehBziKA8+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AB5B13A69;
 Thu, 16 May 2024 10:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yM9wJBjjRWbwGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 May 2024 10:42:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 12:42:25 +0200
Message-Id: <20240516104227.25381-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240516104227.25381-1-andrea.cervesato@suse.de>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B5909347C2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] Add cachestat fallback definitions
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
 configure.ac                       |  4 +++
 include/lapi/mman.h                | 44 ++++++++++++++++++++++++++++++
 include/lapi/syscalls/aarch64.in   |  1 +
 include/lapi/syscalls/arc.in       |  1 +
 include/lapi/syscalls/arm.in       |  1 +
 include/lapi/syscalls/hppa.in      |  1 +
 include/lapi/syscalls/i386.in      |  1 +
 include/lapi/syscalls/ia64.in      |  1 +
 include/lapi/syscalls/loongarch.in |  1 +
 include/lapi/syscalls/mips_n32.in  |  1 +
 include/lapi/syscalls/mips_n64.in  |  1 +
 include/lapi/syscalls/mips_o32.in  |  1 +
 include/lapi/syscalls/powerpc.in   |  1 +
 include/lapi/syscalls/powerpc64.in |  1 +
 include/lapi/syscalls/s390.in      |  1 +
 include/lapi/syscalls/s390x.in     |  1 +
 include/lapi/syscalls/sh.in        |  1 +
 include/lapi/syscalls/sparc.in     |  1 +
 include/lapi/syscalls/sparc64.in   |  1 +
 include/lapi/syscalls/x86_64.in    |  1 +
 20 files changed, 66 insertions(+)
 create mode 100644 include/lapi/mman.h

diff --git a/configure.ac b/configure.ac
index 85c5739c4..8d59cb605 100644
--- a/configure.ac
+++ b/configure.ac
@@ -90,6 +90,7 @@ AC_SUBST(HAVE_FTS_H, $have_fts)
 AC_CHECK_HEADERS(linux/vm_sockets.h, [], [], [#include <sys/socket.h>])
 
 AC_CHECK_FUNCS_ONCE([ \
+    cachestat \
     clone3 \
     close_range \
     copy_file_range \
@@ -233,6 +234,9 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 #endif
 ])
 
+AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
+AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/include/lapi/mman.h b/include/lapi/mman.h
new file mode 100644
index 000000000..244ad9f31
--- /dev/null
+++ b/include/lapi/mman.h
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_MMAN_H__
+#define LAPI_MMAN_H__
+
+#include <stdint.h>
+#include <sys/mman.h>
+#include "config.h"
+#include "syscalls.h"
+
+#ifndef HAVE_STRUCT_CACHESTAT_RANGE
+struct cachestat_range {
+	uint64_t off;
+	uint64_t len;
+};
+#endif
+
+#ifndef HAVE_STRUCT_CACHESTAT
+struct cachestat {
+	uint64_t nr_cache;
+	uint64_t nr_dirty;
+	uint64_t nr_writeback;
+	uint64_t nr_evicted;
+	uint64_t nr_recently_evicted;
+};
+#endif
+
+#ifndef HAVE_CACHESTAT
+/*
+ * cachestat: wrapper function of cachestat
+ *
+ * Returns: It returns status of cachestat syscall
+ */
+static inline int cachestat(int fd, struct cachestat_range *cstat_range,
+	struct cachestat *cstat, unsigned int flags)
+{
+	return tst_syscall(__NR_cachestat, fd, cstat_range, cstat, flags);
+}
+#endif
+
+#endif /* LAPI_MMAN_H__ */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 2cb6c2d87..1c0218eae 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -297,4 +297,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..5d7cd6ca4 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -317,3 +317,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..e41a7e576 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -395,3 +395,4 @@ faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
+cachestat (__NR_SYSCALL_BASE+451)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..2772e7334 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -44,3 +44,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..2d341182e 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -431,3 +431,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..141c6be51 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -344,3 +344,4 @@ faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
 futex_waitv 1473
+cachestat 1475
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 301f611f6..9bf6a7deb 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -305,3 +305,4 @@ memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
+cachestat 451
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index e818c9d92..3b08add08 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -371,3 +371,4 @@ epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
 futex_waitv 6449
+cachestat 6451
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..bfc65cd2b 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -347,3 +347,4 @@ epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
 futex_waitv 5449
+cachestat 5451
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..8dc542b48 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -417,3 +417,4 @@ epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
 futex_waitv 4449
+cachestat 4451
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..67e928951 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..67e928951 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..b456ea408 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -411,3 +411,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..2c57eacdf 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -359,3 +359,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..25eb9bb26 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -405,3 +405,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..e934591dd 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -410,3 +410,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..4c489e38d 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -375,3 +375,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..4afea6019 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -352,6 +352,7 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
