Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEE5C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:05:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D0183D3876
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:05:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D11B73D387A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:23 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB3AB14060A5
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 073581F84E;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As8ay3HIm5emxm7z55JrjZ4UHlYQ0h3j0G6QPGOqSPg=;
 b=BTzKVvuw2FL9n15boKppWSy54cVFoFzAM4lojt4ZYfmOHg73vxFiJ7eN1M38kpwcW1YktT
 NrDTgHcHH/+A1jqPF7H4zf7HTkTwCAUHBW+3p5+/fl4bTyK4yxdXqYI0Y22+jPjLfiGsxv
 YOvbsizzdThoaCj0Zzup8UlqxL1c9uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As8ay3HIm5emxm7z55JrjZ4UHlYQ0h3j0G6QPGOqSPg=;
 b=LsJ0J2sdLYrKo5L4p3YnoBFx+TyQ89/dkj4L2dN4mtdZLBvwhUnW6btJelbSwcYZ/t5Lxp
 jyp3dKkgdtOdgMCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BTzKVvuw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LsJ0J2sd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As8ay3HIm5emxm7z55JrjZ4UHlYQ0h3j0G6QPGOqSPg=;
 b=BTzKVvuw2FL9n15boKppWSy54cVFoFzAM4lojt4ZYfmOHg73vxFiJ7eN1M38kpwcW1YktT
 NrDTgHcHH/+A1jqPF7H4zf7HTkTwCAUHBW+3p5+/fl4bTyK4yxdXqYI0Y22+jPjLfiGsxv
 YOvbsizzdThoaCj0Zzup8UlqxL1c9uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As8ay3HIm5emxm7z55JrjZ4UHlYQ0h3j0G6QPGOqSPg=;
 b=LsJ0J2sdLYrKo5L4p3YnoBFx+TyQ89/dkj4L2dN4mtdZLBvwhUnW6btJelbSwcYZ/t5Lxp
 jyp3dKkgdtOdgMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEDD513942;
 Wed, 10 Jul 2024 18:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iDgeNarMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:01:56 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-1-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7662;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=U0omUv1OaYCChlqTr9cV14UoTcJ6DOVonEFFqTckFbA=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsydYA1WJz7gjIH9y6hjLqG6TDVqgfaTVHWsH
 axRUybotQuJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MnQAKCRDLzBqyILPm
 RnxQC/43cB3Ma3bc133oczj9IWCIUZw4KtH597AH8DxGI7GSCsRtN9B7jZtCEtWrAkPfH/t8J/z
 +lyJbFLWfqzlHhlQFg+TgQp6jaCTLe0I8eeVMH+/Ori1i+cPgrvJE0CoaKYNnAYxiIWJ31OK4Rw
 N6ejYhgE9duujusmm6lbQ2+3Xo/9j5OcYEGf2QX2mtSxB7dXaLd5wUZEQ8fPwB10fzU9aTmkoDh
 VUFRzD5S90cV/kYIbqG83BvvI8kraYDMMlJGKiirorwi6LofbMWvyZXmLAvYDhPPeCqc6Nd3rSt
 6u/FU5FDykZ9njYiZnrpzyjynynxrereI/4xhdF+RwT/5hcTvrgciBrdaCo6suC3XsR9+Hq6GND
 8MmgzYQ+T7hUbmAZzBIalWBXD/SB26PsGpuEEesOtneIRvnYInZKrZwXptuWqKX3bi702ObPvmv
 aKYSKSkovhauZWxgNQiJiX9ycQRs1MrtLkNdKhvYa1XyE64BZ2Z0migPI63M9mDCOCKSY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 073581F84E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/11] Add landlock syscalls definitions
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
 include/lapi/syscalls/aarch64.in   | 3 +++
 include/lapi/syscalls/arc.in       | 3 +++
 include/lapi/syscalls/arm.in       | 3 +++
 include/lapi/syscalls/hppa.in      | 3 +++
 include/lapi/syscalls/i386.in      | 3 +++
 include/lapi/syscalls/ia64.in      | 3 +++
 include/lapi/syscalls/mips_n32.in  | 3 +++
 include/lapi/syscalls/mips_n64.in  | 3 +++
 include/lapi/syscalls/mips_o32.in  | 3 +++
 include/lapi/syscalls/powerpc.in   | 3 +++
 include/lapi/syscalls/powerpc64.in | 3 +++
 include/lapi/syscalls/s390.in      | 3 +++
 include/lapi/syscalls/s390x.in     | 3 +++
 include/lapi/syscalls/sh.in        | 3 +++
 include/lapi/syscalls/sparc.in     | 3 +++
 include/lapi/syscalls/sparc64.in   | 3 +++
 include/lapi/syscalls/x86_64.in    | 3 +++
 17 files changed, 51 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 2cb6c2d87..3e7797718 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -296,5 +296,8 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..7fde1d263 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -316,4 +316,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..693644f83 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -394,4 +394,7 @@ pidfd_getfd (__NR_SYSCALL_BASE+438)
 faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
+landlock_create_ruleset (__NR_SYSCALL_BASE+444)
+landlock_add_rule (__NR_SYSCALL_BASE+445)
+landlock_restrict_self (__NR_SYSCALL_BASE+446)
 futex_waitv (__NR_SYSCALL_BASE+449)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..60c02aff2 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -43,4 +43,7 @@ close_range 436
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..31ec1ecb2 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -430,4 +430,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..2e56da7f9 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -343,4 +343,7 @@ pidfd_getfd 1462
 faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
+landlock_create_ruleset 1468
+landlock_add_rule 1469
+landlock_restrict_self 1470
 futex_waitv 1473
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index e818c9d92..5f0fe65eb 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -370,4 +370,7 @@ process_madvise 6440
 epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
+landlock_create_ruleset 6444
+landlock_add_rule 6445
+landlock_restrict_self 6446
 futex_waitv 6449
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..f81c60e66 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -346,4 +346,7 @@ process_madvise 5440
 epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
+landlock_create_ruleset 5444
+landlock_add_rule 5445
+landlock_restrict_self 5446
 futex_waitv 5449
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..c2beffb75 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -416,4 +416,7 @@ process_madvise 4440
 epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
+landlock_create_ruleset 4444
+landlock_add_rule 4445
+landlock_restrict_self 4446
 futex_waitv 4449
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..5460e4197 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -423,4 +423,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..5460e4197 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -423,4 +423,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..275b27f47 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -410,4 +410,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..c200d02b2 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -358,4 +358,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..6f482a77b 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -404,4 +404,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..7181e80a0 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -409,4 +409,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..c96ab2021 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -374,4 +374,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..3082ca110 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -351,6 +351,9 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
 futex_waitv 449
 rt_sigaction 512
 rt_sigreturn 513

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
