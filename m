Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7235C52D7C
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 11:47:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 608803D20F7
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 13:47:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C0063D20FF
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:35 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72937600648
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E23622026E;
 Mon, 12 Aug 2024 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrdkbNYwlLv4lySkobVm1W/QNQ8dWIPL0jZp8Wp0OWo=;
 b=G3AQJA6YaUsf01wv68NfvbwYjJYeydszYS7dXF+A+rn4mC+q/PMLSFBdze8QGoAsSuG71o
 ZJWlUhsY11UTmYLhCohQWCK1Z99cKcRTi36zYE9o//IkvqwA7AEJVitmDPF2vOkmiAucpM
 GHmknhenrn718FH7i9VICFpaAakul6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrdkbNYwlLv4lySkobVm1W/QNQ8dWIPL0jZp8Wp0OWo=;
 b=Le8QLnuknZCwHyyyOonkZO31UoijelM8T80zmTS53xet0I1bRxMAm7CNTufsOUuc9seHjT
 VpuNKIQaPY347FAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gnfa2HzB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7iKmq02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrdkbNYwlLv4lySkobVm1W/QNQ8dWIPL0jZp8Wp0OWo=;
 b=gnfa2HzBPBuG4w+Aepol949mrA/f0K1OVoMKyLtsOSSQhkOKvSoKV4V1sgJgBxzxo67aeK
 fELbGwocmNgGeGLPjRSKgUnQierLZbYgoEYTvxDWMs1P71TpH9qp2t+pc0Y4xcAGbEiaUc
 MxnDaHDFcQj/R0l80Nlbosp+GX+FwwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrdkbNYwlLv4lySkobVm1W/QNQ8dWIPL0jZp8Wp0OWo=;
 b=7iKmq02VCdbc+6u9F6IwKAbPxQ6c6hQssxTtuGMaqaHGlHQNRVQZd5oU3LXz8AnqHzWBoT
 43cOUTJmqfSQaLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C18DD13A3D;
 Mon, 12 Aug 2024 11:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJJOLRX2uWYTWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 12 Aug 2024 11:46:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 12 Aug 2024 13:46:28 +0200
MIME-Version: 1.0
Message-Id: <20240812-process_mrelease-v2-1-e61249986a0a@suse.com>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
In-Reply-To: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723463189; l=7572;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=13S46lV7zrsMD3RE47RQFmD0/p83mkAupgw7MUoJ9K4=;
 b=4TmJ2VbOpZ42uUpNp7wizRmM9V7v+Dk1j0ff+p7LjjmkakFbBDA6DwN/uYyNGUufmTUm4Wi8k
 74A9/GNshd8DSfZ1im3tgPQbbuMjzaOXbkJXmdpp82cb5Z/636KZL5o
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E23622026E
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] Add process_mrelease syscalls definition
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
 include/lapi/syscalls/aarch64.in   | 1 +
 include/lapi/syscalls/arc.in       | 1 +
 include/lapi/syscalls/arm.in       | 1 +
 include/lapi/syscalls/hppa.in      | 1 +
 include/lapi/syscalls/i386.in      | 1 +
 include/lapi/syscalls/ia64.in      | 1 +
 include/lapi/syscalls/mips_n32.in  | 1 +
 include/lapi/syscalls/mips_n64.in  | 1 +
 include/lapi/syscalls/mips_o32.in  | 1 +
 include/lapi/syscalls/powerpc.in   | 1 +
 include/lapi/syscalls/powerpc64.in | 1 +
 include/lapi/syscalls/s390.in      | 1 +
 include/lapi/syscalls/s390x.in     | 1 +
 include/lapi/syscalls/sh.in        | 1 +
 include/lapi/syscalls/sparc.in     | 1 +
 include/lapi/syscalls/sparc64.in   | 1 +
 include/lapi/syscalls/x86_64.in    | 1 +
 17 files changed, 17 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 61d4450bf..219f53b86 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -299,6 +299,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 752cc54fd..6519acc6f 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -319,6 +319,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 84203ca4d..655038994 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -398,6 +398,7 @@ landlock_create_ruleset (__NR_SYSCALL_BASE+444)
 landlock_add_rule (__NR_SYSCALL_BASE+445)
 landlock_restrict_self (__NR_SYSCALL_BASE+446)
 memfd_secret (__NR_SYSCALL_BASE+447)
+process_mrelease (__NR_SYSCALL_BASE+448)
 futex_waitv (__NR_SYSCALL_BASE+449)
 cachestat (__NR_SYSCALL_BASE+451)
 fchmodat2 (__NR_SYSCALL_BASE+452)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8240c69ce..a7178213f 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -46,6 +46,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index f6e8c7258..1800f35cd 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -433,6 +433,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 8f55029a9..45798e890 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -346,6 +346,7 @@ quotactl_fd 1467
 landlock_create_ruleset 1468
 landlock_add_rule 1469
 landlock_restrict_self 1470
+process_mrelease 1472
 futex_waitv 1473
 cachestat 1475
 fchmodat2 1476
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index d85c567c7..dc1d120cc 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -373,6 +373,7 @@ quotactl_fd 6443
 landlock_create_ruleset 6444
 landlock_add_rule 6445
 landlock_restrict_self 6446
+process_mrelease 6448
 futex_waitv 6449
 cachestat 6451
 fchmodat2 6452
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index c34a85bbe..b8e18ea70 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -349,6 +349,7 @@ quotactl_fd 5443
 landlock_create_ruleset 5444
 landlock_add_rule 5445
 landlock_restrict_self 5446
+process_mrelease 5448
 futex_waitv 5449
 cachestat 5451
 fchmodat2 5452
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 10d77787b..630f3a4ef 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -419,6 +419,7 @@ quotactl_fd 4443
 landlock_create_ruleset 4444
 landlock_add_rule 4445
 landlock_restrict_self 4446
+process_mrelease 4448
 futex_waitv 4449
 cachestat 4451
 fchmodat2 4452
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index af3ae5c90..3c9b9a2f2 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -426,6 +426,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index af3ae5c90..3c9b9a2f2 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -426,6 +426,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index e8e7fff0b..28f913bef 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -413,6 +413,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 0ee3bd897..5b74fedd4 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -361,6 +361,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 5701f2285..4dd344903 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -407,6 +407,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 172969f60..4507c0aff 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -412,6 +412,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 5b667f10f..95e7e6baa 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -377,6 +377,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 1993f343a..8e5ea998c 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -354,6 +354,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+process_mrelease 448
 futex_waitv 449
 cachestat 451
 fchmodat2 452

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
