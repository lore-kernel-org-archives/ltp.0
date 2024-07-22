Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10748C3DA5D
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 14:29:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BB753D1BDD
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 16:29:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D5423D0BC9
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7774C1A01936
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B5321F8D4;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hglHsjkXTMTxCM2mDFYEW/BeBCveLRO99csbWHIVPM=;
 b=0GJVvpIfCTrOjwMo5Z+TyNQEhnaOR3tFFIWWIW4EEx1FPj9UIJ/BtXg5ILSqZu9iEMHjAG
 I4tiSLcINan/3ELUAPDaPXVyRUceG7aPMlt7RLxJAKrkpM646RJY4tYGepDOKvI7sy6gA4
 nFcYZNVNFDqBzJlXkLbT49mLbQRoJJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hglHsjkXTMTxCM2mDFYEW/BeBCveLRO99csbWHIVPM=;
 b=adEbrOuGn7E7UgfeO3faY5++97sc5c8dDZGLZNybXSkw+feWwfkEKbYPN89ujct1QUz66I
 c5047ojEItwHpQBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0GJVvpIf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=adEbrOuG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hglHsjkXTMTxCM2mDFYEW/BeBCveLRO99csbWHIVPM=;
 b=0GJVvpIfCTrOjwMo5Z+TyNQEhnaOR3tFFIWWIW4EEx1FPj9UIJ/BtXg5ILSqZu9iEMHjAG
 I4tiSLcINan/3ELUAPDaPXVyRUceG7aPMlt7RLxJAKrkpM646RJY4tYGepDOKvI7sy6gA4
 nFcYZNVNFDqBzJlXkLbT49mLbQRoJJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hglHsjkXTMTxCM2mDFYEW/BeBCveLRO99csbWHIVPM=;
 b=adEbrOuGn7E7UgfeO3faY5++97sc5c8dDZGLZNybXSkw+feWwfkEKbYPN89ujct1QUz66I
 c5047ojEItwHpQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D491398E;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wG/qF8RsnmazSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jul 2024 14:29:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jul 2024 16:28:40 +0200
MIME-Version: 1.0
Message-Id: <20240722-cachestat-v3-1-a0386f7cdaaa@suse.com>
References: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
In-Reply-To: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8837;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=WNwA8kzJq2jKIaz7O4NBI3BpxhOOY1R8ZYipZCzbrms=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmnmyvJPft5CJdCZU8CggDT7Ub5ocYxuQ+2p6Ql
 d7oxuNt+dyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp5srwAKCRDLzBqyILPm
 Rv5DC/9TdM/gdbiLbOOnL3ASApX2hmzvA+tTVm/SCpJOKFgjYl04n/KkL+0g5e/F2GCfMaB603u
 vgdrZuwrFdNYTIOr9yISyWMh63opU+uIc5NwfXarBcMsXdZfXb6oJx/c5QpC+bAsUNXbBrHBaf0
 itm3BR6NslqTsoQij/gydh7vmiFeI8CHPNi8pc98ZDCR3Gy7KLKLSfdiEDWY0E7L4lY/eAcmflS
 U7F3iNRBg33bvxTwi5UJn5Xk8U86o5trQqJ5ezH1LRqI6HqfiNmf+GVgQOW0ziDwzXxyCPHVe4W
 kjpyDx253Nh071hYEbfS2u8uONYipAPcTC3ilFRFtqa7KPIROhc+4yDUtNA20/baXuzckdUy+rs
 vnOWrJa7q/36mkT6L1zxLTzHBehGCwtyrydbcrui4AslbrfJRPTWaLfCugLMygpnzH/V/fRuVLd
 zLqZcyDYx2FHJyCVltuOF7u0/NdZGz1Jz2twD3ekdHF9VT08RaunRaqzaE65uxywif2d4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.31 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8B5321F8D4
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/5] Add cachestat fallback definitions
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
 configure.ac                       |  4 ++++
 include/lapi/mman.h                | 44 ++++++++++++++++++++++++++++++++++++++
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

diff --git a/configure.ac b/configure.ac
index 1f8796c87..cbcf308e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -91,6 +91,7 @@ AC_SUBST(HAVE_FTS_H, $have_fts)
 AC_CHECK_HEADERS(linux/vm_sockets.h, [], [], [#include <sys/socket.h>])
 
 AC_CHECK_FUNCS_ONCE([ \
+    cachestat \
     clone3 \
     close_range \
     copy_file_range \
@@ -243,6 +244,9 @@ AC_CHECK_TYPES([struct mount_attr],,,[
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
index 3e7797718..ef0aa04a3 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -300,4 +300,5 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 7fde1d263..3eaa6a8f1 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -320,3 +320,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 8e76ad164..b52a32b6b 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -399,3 +399,4 @@ landlock_add_rule (__NR_SYSCALL_BASE+445)
 landlock_restrict_self (__NR_SYSCALL_BASE+446)
 memfd_secret (__NR_SYSCALL_BASE+447)
 futex_waitv (__NR_SYSCALL_BASE+449)
+cachestat (__NR_SYSCALL_BASE+451)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 60c02aff2..4919ee65d 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -47,3 +47,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 31ec1ecb2..cff40957a 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -434,3 +434,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 2e56da7f9..11d4b46f4 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -347,3 +347,4 @@ landlock_create_ruleset 1468
 landlock_add_rule 1469
 landlock_restrict_self 1470
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
index 5f0fe65eb..a76c82593 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -374,3 +374,4 @@ landlock_create_ruleset 6444
 landlock_add_rule 6445
 landlock_restrict_self 6446
 futex_waitv 6449
+cachestat 6451
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index f81c60e66..df991efd5 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -350,3 +350,4 @@ landlock_create_ruleset 5444
 landlock_add_rule 5445
 landlock_restrict_self 5446
 futex_waitv 5449
+cachestat 5451
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index c2beffb75..826b7d66e 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -420,3 +420,4 @@ landlock_create_ruleset 4444
 landlock_add_rule 4445
 landlock_restrict_self 4446
 futex_waitv 4449
+cachestat 4451
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 5460e4197..798ed9050 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -427,3 +427,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 5460e4197..798ed9050 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -427,3 +427,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 275b27f47..126938095 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -414,3 +414,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index c200d02b2..18f2496a0 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -362,3 +362,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 6f482a77b..ae6f26050 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -408,3 +408,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 7181e80a0..409fa2729 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -413,3 +413,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index c96ab2021..e13cf163e 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -378,3 +378,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 3082ca110..05b1bee55 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -355,6 +355,7 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+cachestat 451
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
