Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C85FC3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 08:42:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDA9F3D1BE9
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 10:42:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 904D93D0EA8
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 10:41:45 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83C0F200C20
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 10:41:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94CF121A2C;
 Tue, 23 Jul 2024 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721724103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya02vQd1nEA4mGaGa7onRjvL4CyoFsJ+P9pTJXVK9Qg=;
 b=Ks/LtZammjURxhXNdht828dDmnYenK7uKw5F8WKz0SV3n5xDXGcmoiDhAOtI9c1tlTmZhR
 MAFL9bE4A+hmSrobJGguyF7q+e1g0HFHDXwtjd9BDMgyuUmlE7FwgVLAQuNR8JGYYe4K4i
 ulpJ7AY6O/XZ2Nos5tDpMpkD7gQbtgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721724103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya02vQd1nEA4mGaGa7onRjvL4CyoFsJ+P9pTJXVK9Qg=;
 b=Sd0s2EFLoMAGGn0vTtLwGn7/wd0nkBjuM2IiGeCk7zBo0PavjsC0ZqTSzS3iFO6tMBwB/T
 8TjiftsRim72/DDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ks/LtZam";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sd0s2EFL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721724103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya02vQd1nEA4mGaGa7onRjvL4CyoFsJ+P9pTJXVK9Qg=;
 b=Ks/LtZammjURxhXNdht828dDmnYenK7uKw5F8WKz0SV3n5xDXGcmoiDhAOtI9c1tlTmZhR
 MAFL9bE4A+hmSrobJGguyF7q+e1g0HFHDXwtjd9BDMgyuUmlE7FwgVLAQuNR8JGYYe4K4i
 ulpJ7AY6O/XZ2Nos5tDpMpkD7gQbtgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721724103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya02vQd1nEA4mGaGa7onRjvL4CyoFsJ+P9pTJXVK9Qg=;
 b=Sd0s2EFLoMAGGn0vTtLwGn7/wd0nkBjuM2IiGeCk7zBo0PavjsC0ZqTSzS3iFO6tMBwB/T
 8TjiftsRim72/DDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 737501393E;
 Tue, 23 Jul 2024 08:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SL9RGsdsn2Z/bAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 08:41:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 10:41:11 +0200
MIME-Version: 1.0
Message-Id: <20240723-mseal-v2-1-5aa872d611bc@suse.com>
References: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
In-Reply-To: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6824;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Rp+gZdHPDYQ191A0vSLk3Us3Gy6UFV/9joFm44kcHqI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn2yy6PX1hotJ8p0Aj9VUg2bqWJixxuTiqmmLv
 Z8gMw7e4kCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9ssgAKCRDLzBqyILPm
 RpchC/9oCOq4skShd/g4DEKHC/8PDAbnVt/O+i/m20F+Zo9vvodgTAt5B1A8fvrcFrQnOlfBTKA
 +4hqGPKeYQrTg2w3vVz0/H8cmFSMOs0OC8qeey0JGaF5a6tQx7xHqlYxjivbW2DgXiTsn0kAnlH
 a08uREsbF0lGbohKUOK3Sd6vx2P4tY7Tp8TO0ea8HsgHyaRq6WaBudd1SJlFpo2Mp4svksua+lY
 ocafKhiXGdZXV41JB2kTCfEcmiI8ek9vlKgXzwUquHga680ECGeLIriAUqTPyez6AXirIdHfQVI
 5YtzsN7jTAjNY3wIL5NyeXzSy0nZR9B1uyk7Nc0julFKl5wjKHJ2rVI4qJbmevujXyAqpiPR7kX
 /J68YdPqzIjy1jrK0pSVJLaigkzxzB6Zieqg4Wk62bSrWScrDxE32yE51AAcKQ1spzKmy/dpcdP
 4dWW3Agdo4Hao+TKcn+ciMKss15BAeKdASD+O4nQVlFk/dbSx3gjZc1ADdrSa7A8chWWs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 94CF121A2C
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Add mseal() syscall declaration
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
index 3e7797718..7e08c63f3 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -300,4 +300,5 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 7fde1d263..94ae09a4b 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -320,3 +320,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 8e76ad164..95c7b20f9 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -399,3 +399,4 @@ landlock_add_rule (__NR_SYSCALL_BASE+445)
 landlock_restrict_self (__NR_SYSCALL_BASE+446)
 memfd_secret (__NR_SYSCALL_BASE+447)
 futex_waitv (__NR_SYSCALL_BASE+449)
+mseal (__NR_SYSCALL_BASE+462)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 60c02aff2..a16bb74d8 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -47,3 +47,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 31ec1ecb2..99e7aa5ba 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -434,3 +434,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 2e56da7f9..6cdd161ad 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -347,3 +347,4 @@ landlock_create_ruleset 1468
 landlock_add_rule 1469
 landlock_restrict_self 1470
 futex_waitv 1473
+mseal 1486
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 301f611f6..0215e9cd5 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -305,3 +305,4 @@ memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
+mseal 462
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index 5f0fe65eb..199295b9b 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -374,3 +374,4 @@ landlock_create_ruleset 6444
 landlock_add_rule 6445
 landlock_restrict_self 6446
 futex_waitv 6449
+mseal 6462
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index f81c60e66..49f875a9e 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -350,3 +350,4 @@ landlock_create_ruleset 5444
 landlock_add_rule 5445
 landlock_restrict_self 5446
 futex_waitv 5449
+mseal 5462
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index c2beffb75..b379e52c7 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -420,3 +420,4 @@ landlock_create_ruleset 4444
 landlock_add_rule 4445
 landlock_restrict_self 4446
 futex_waitv 4449
+mseal 4462
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 5460e4197..e35e114ad 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -427,3 +427,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 5460e4197..e35e114ad 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -427,3 +427,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 275b27f47..1207551cb 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -414,3 +414,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index c200d02b2..503419282 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -362,3 +362,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 6f482a77b..060ab613c 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -408,3 +408,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 7181e80a0..6821f053c 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -413,3 +413,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index c96ab2021..661db0cae 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -378,3 +378,4 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 3082ca110..af6ab689f 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -355,6 +355,7 @@ landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
+mseal 462
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
