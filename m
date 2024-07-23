Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB33C3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 18:00:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9575A3D1C4C
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 20:00:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1742D3D1BFA
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:11 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2036D600BF8
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0CBF1FD62;
 Tue, 23 Jul 2024 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eRUkHziJ3tM8kvcWiH3F/vBFLntz/g884/z24OG2ac=;
 b=jT6XPbCncEi3BtQiGMyda4Wtf6wOOeqNlX9wTqdF7XSQmNQ/tT2HBrXmH6agOtGafo3wP/
 0inXIAhOQ61KTmFz63DyCjPsHufmieWExckChUPNcTy61Qf5rtnLvzZMGgJ2Tyd99Tt3qZ
 aHsCPQn0MekArlev4UvexXjGQ6Travg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eRUkHziJ3tM8kvcWiH3F/vBFLntz/g884/z24OG2ac=;
 b=6d13HczE2pfLPBNC8SNdJEBTl601A9h5OOIu3gGt4u2X2EuIdrI2pukuM8ltTyitHcEEst
 YGqiAKbOqYo46cDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eRUkHziJ3tM8kvcWiH3F/vBFLntz/g884/z24OG2ac=;
 b=jT6XPbCncEi3BtQiGMyda4Wtf6wOOeqNlX9wTqdF7XSQmNQ/tT2HBrXmH6agOtGafo3wP/
 0inXIAhOQ61KTmFz63DyCjPsHufmieWExckChUPNcTy61Qf5rtnLvzZMGgJ2Tyd99Tt3qZ
 aHsCPQn0MekArlev4UvexXjGQ6Travg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eRUkHziJ3tM8kvcWiH3F/vBFLntz/g884/z24OG2ac=;
 b=6d13HczE2pfLPBNC8SNdJEBTl601A9h5OOIu3gGt4u2X2EuIdrI2pukuM8ltTyitHcEEst
 YGqiAKbOqYo46cDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D89E1393E;
 Tue, 23 Jul 2024 17:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AH4HJVTvn2aMEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 17:58:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 17:41:04 +0200
MIME-Version: 1.0
Message-Id: <20240723-fchmodat2-v2-2-e658a98b113e@suse.com>
References: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
In-Reply-To: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6957;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=UU8j8kZYUBW7JffgT1nx9ktBUE6jiQCGs092IgyCMmQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn+9Wvfs+R1SLfKfEFPejUyssvLUhjNbkhKYg/
 PhOQ2gVQFGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp/vVgAKCRDLzBqyILPm
 RuvFDACpYtmoc+uor6ZHmhtPuHJbEDxvwyXzzn2hlYm4vMpNuAE4J+8LvukkW6c+cF2z5WJ9HMr
 ORnaMgw+NtTyguB6s+TV+UO6LWFz7e+Sl+y9/BVQcmLHAhEKJEI0uTspdi9ESDkRsldkqspnE2W
 V6nbgyM/Wh8fB0nfLIc73ZRqDA0OB96SNj05/FRuQQ/0qMmqlZrLNlNYW9hdQ9dcYzBNcMiHA7a
 n7DQOycNGOo0yDbdWgE0Qi4ZlPv5qSdIGCe245sNAoaR5l9N67UcOLYCXLdYkKWSFL5QoihF5UP
 5ur05U2DiT6DvAYuS/kP+z8zyJh8r2y2Nbq60hrbj+qQGtwfPTUtGNiLGe4Vq/e4SRla/kIrj1J
 CcFDenHFe9U3VfSOjZUzNaiOCjC4TnvG0/I5ogRdCS1pp52QFDunf84LyJb8RnnDtIgBUjEMoAB
 45iyUh5QBZT/aUsr5Kz4ba9kM3loxHNaDRYxdGJvlLZwiEzw0/1LAaOB4wpJDr28OaHFM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] Add fchmodat2 syscalls definitions
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
 include/lapi/syscalls/loongarch.in | 1 +
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
 18 files changed, 18 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 3e7797718..6c3bd69b5 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -300,4 +300,5 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 7fde1d263..f1721551e 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -320,3 +320,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 8e76ad164..032941b7e 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -399,3 +399,4 @@ landlock_add_rule (__NR_SYSCALL_BASE+445)
 landlock_restrict_self (__NR_SYSCALL_BASE+446)
 memfd_secret (__NR_SYSCALL_BASE+447)
 futex_waitv (__NR_SYSCALL_BASE+449)
+fchmodat2 (__NR_SYSCALL_BASE+452)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 60c02aff2..39fdcc1d9 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -47,3 +47,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 31ec1ecb2..36129b491 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -434,3 +434,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 2e56da7f9..60f657457 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -347,3 +347,4 @@ landlock_create_ruleset 1468
 landlock_add_rule 1469
 landlock_restrict_self 1470
 futex_waitv 1473
+fchmodat2 1476
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 301f611f6..63e05d6b6 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -305,3 +305,4 @@ memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
+fchmodat2 452
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index 5f0fe65eb..b53fefc1f 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -374,3 +374,4 @@ landlock_create_ruleset 6444
 landlock_add_rule 6445
 landlock_restrict_self 6446
 futex_waitv 6449
+fchmodat2 6452
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index f81c60e66..d9336c6e3 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -350,3 +350,4 @@ landlock_create_ruleset 5444
 landlock_add_rule 5445
 landlock_restrict_self 5446
 futex_waitv 5449
+fchmodat2 5452
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index c2beffb75..30d42419e 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -420,3 +420,4 @@ landlock_create_ruleset 4444
 landlock_add_rule 4445
 landlock_restrict_self 4446
 futex_waitv 4449
+fchmodat2 4452
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 5460e4197..2a2259841 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -427,3 +427,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 5460e4197..2a2259841 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -427,3 +427,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 275b27f47..656f5c118 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -414,3 +414,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index c200d02b2..46007bf89 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -362,3 +362,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 6f482a77b..df7c1c378 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -408,3 +408,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 7181e80a0..03030dd30 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -413,3 +413,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index c96ab2021..4ab40a5c5 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -378,3 +378,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 3082ca110..57ffce837 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -355,6 +355,7 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+fchmodat2 452
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
