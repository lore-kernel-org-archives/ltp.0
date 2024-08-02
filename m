Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2BFC3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:24:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D72F83D1F43
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:24:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9E6D3D1C9C
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:59 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5DBB6204B40
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A41DD219DB;
 Fri,  2 Aug 2024 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=rehgp/vFF+Zz2eh8R2R20cyafGjNPSlt6rZMDgOyQx7yN5HduYUYXiWQZ8VVkzhMAHZFjx
 1ATf8yUg3UfJzju9vV8zbDC6V/yCGB5ktnhTsEkjVWhiMjsNQIBaBTQHYuuwUM8HLlW9+t
 Mnw+2Du+ogTol+s42QztzRwV2I8MHUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=v+PuEHgHyH2sNzsGXyiW+a4RzC8ug1MrvM/Te2YPKRjoQOdm8rbaUuyqrqDaBy8dbaymPN
 GcOMubg3kzIojCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=rehgp/vFF+Zz2eh8R2R20cyafGjNPSlt6rZMDgOyQx7yN5HduYUYXiWQZ8VVkzhMAHZFjx
 1ATf8yUg3UfJzju9vV8zbDC6V/yCGB5ktnhTsEkjVWhiMjsNQIBaBTQHYuuwUM8HLlW9+t
 Mnw+2Du+ogTol+s42QztzRwV2I8MHUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=v+PuEHgHyH2sNzsGXyiW+a4RzC8ug1MrvM/Te2YPKRjoQOdm8rbaUuyqrqDaBy8dbaymPN
 GcOMubg3kzIojCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DBED13B06;
 Fri,  2 Aug 2024 08:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WMUMHJ2XrGaaFgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 08:23:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 10:23:47 +0200
MIME-Version: 1.0
Message-Id: <20240802-fchmodat2-v5-2-bff2ec1a4f06@suse.com>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
In-Reply-To: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6722;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=19SBkQVjGamz0EGcR2EqrhvrwjUzQTHSc+6fIN4g6xY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrJebwZYbgBvke/q4GtN4C7Y/L1+UhG8xCwH6N
 ILUSj6Rr8+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqyXmwAKCRDLzBqyILPm
 RundDACSpK/TOyJhLObBrhQ61DGDarNAirYSjzOD9HaSSAXLDZkifsJkNSjLtVEqTEK6GTlZaVt
 L3/zBmobXpWVq2t0Y9JJLTt+gN3wcH4VQ72C7O3e+qNaFQu2QuSLc4b1B7uhN/Co3BTMgr94GF3
 7FUIbBQg5TG2A+ThNN9t33dGaQo8s49Xb46NHg2XKXTJc65MZMOIpjIyTVBPCMenpmirf0OimgW
 5V6OcHdpi/MDM2DTpIwawMeX5WegdXeOfD8a+qkfaLet69D7LwInuSk6JbyJ8sps/+10UgS7kDQ
 JdXpAB4xPzzBzSpR9HaAuXC1pz+UUy5XY3qRK2JF8CVP59d/SM4WY4aY5zCZt8DKZnvtdOHajRx
 AjiAozr+UPLwEh1Ize2hQehWVrI+YyaFe1huUAkBf7Ls2veCTViDkRujRE/9GYstvsIFqq4hcO8
 UpM6oQYvTeGgdJSlAcQW3WTI6xH1S59nuSlKypNKw38FOPXkh2G6Hol/A/vLaqDR+nwcs=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/5] Add fchmodat2 syscalls definitions
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
index ef0aa04a3..31ea5a8c2 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -301,4 +301,5 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3eaa6a8f1..5a00c6cf7 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -321,3 +321,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index b52a32b6b..41b6fe733 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -400,3 +400,4 @@ landlock_restrict_self (__NR_SYSCALL_BASE+446)
 memfd_secret (__NR_SYSCALL_BASE+447)
 futex_waitv (__NR_SYSCALL_BASE+449)
 cachestat (__NR_SYSCALL_BASE+451)
+fchmodat2 (__NR_SYSCALL_BASE+452)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 4919ee65d..d8429a4c1 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -48,3 +48,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index cff40957a..facb3824a 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -435,3 +435,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 11d4b46f4..9aeb0f99d 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -348,3 +348,4 @@ landlock_add_rule 1469
 landlock_restrict_self 1470
 futex_waitv 1473
 cachestat 1475
+fchmodat2 1476
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 9bf6a7deb..edda29f75 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -306,3 +306,4 @@ process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index a76c82593..039e674b9 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -375,3 +375,4 @@ landlock_add_rule 6445
 landlock_restrict_self 6446
 futex_waitv 6449
 cachestat 6451
+fchmodat2 6452
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index df991efd5..778979e1c 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -351,3 +351,4 @@ landlock_add_rule 5445
 landlock_restrict_self 5446
 futex_waitv 5449
 cachestat 5451
+fchmodat2 5452
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 826b7d66e..11a6415a2 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -421,3 +421,4 @@ landlock_add_rule 4445
 landlock_restrict_self 4446
 futex_waitv 4449
 cachestat 4451
+fchmodat2 4452
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 798ed9050..ad05235c1 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -428,3 +428,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 798ed9050..ad05235c1 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -428,3 +428,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 126938095..cdfdb670e 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -415,3 +415,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 18f2496a0..a9e6fa707 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -363,3 +363,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index ae6f26050..3c0a927fd 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -409,3 +409,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 409fa2729..df77f5688 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -414,3 +414,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index e13cf163e..860613684 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -379,3 +379,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 05b1bee55..477b08510 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -356,6 +356,7 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+fchmodat2 452
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
