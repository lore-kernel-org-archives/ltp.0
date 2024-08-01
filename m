Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF23C3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F000C3D1EF0
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:31:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27A6E3D1EF3
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2EBC72009E4
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D252219CE;
 Thu,  1 Aug 2024 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=TbgFGTzj9MGknPk9nAcHMoDdBJrWoZXqa5kf+S1yPxhB5yQcPFpA3KPdLYHvv/OrD8leCw
 SbvOOKOwO9BmmB0cMMFbvTnfJUUxI0C233HdrST7X2VfM8fCx1hc2IXFRAdxqSQWOfeamw
 xw0mf87OjZiWGD7hwsGQLUf89/yK5O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=VQRAItMNrbAFxqV7fLJTY32t9PwmZglfn5KHFhn+qXILLjWTzmYsFY91EnjSsGO0ly87ii
 2FmDsKZcQYMMNzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=TbgFGTzj9MGknPk9nAcHMoDdBJrWoZXqa5kf+S1yPxhB5yQcPFpA3KPdLYHvv/OrD8leCw
 SbvOOKOwO9BmmB0cMMFbvTnfJUUxI0C233HdrST7X2VfM8fCx1hc2IXFRAdxqSQWOfeamw
 xw0mf87OjZiWGD7hwsGQLUf89/yK5O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1g4m1fRfy5Cy9h3g4MwhrSgf3X5V5R7wDwYRI/PBBE=;
 b=VQRAItMNrbAFxqV7fLJTY32t9PwmZglfn5KHFhn+qXILLjWTzmYsFY91EnjSsGO0ly87ii
 2FmDsKZcQYMMNzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFCD513946;
 Thu,  1 Aug 2024 14:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cIyaLOmbq2Z2AwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 14:30:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 16:29:41 +0200
MIME-Version: 1.0
Message-Id: <20240801-fchmodat2-v4-2-7f2f11a53a09@suse.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
In-Reply-To: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6722;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=19SBkQVjGamz0EGcR2EqrhvrwjUzQTHSc+6fIN4g6xY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq5vnURJzwMXCPX+g8RwEoAnpmh+DxBhILywIC
 oAHuTYoBxyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqub5wAKCRDLzBqyILPm
 RsV2DACKjYGLbsTpNv7wix5BldsXvfw/NVCq3JoFt+Y3QYPB81eZF2y8hHa8zU/GwRFBL8awMLc
 p76fRE8apGSI/5wdRvxbvLkEAiaLqHarhlpuL1FRSP+nVaW0HIhrqouQfGFe0iWHlSdiMu2PhUb
 WWQHP6kFe/QKz9XlzwQbNpeOWtzdsHdmIRnlcL/5ByicOthK6oVjJq7AxtuIGKipUX7mUwD2yN0
 Ovlx99o0qkkUjWv1/RKyWM/7BtXECmlcm+IYeUk+9hJ1267j3v3pyasu69utmo3n3znDsYqSVGu
 p/E5mo02pcS64SjTWZv/teBfJfIHKsPkzdbiL6aTdekPwe5MaoSyKeN6sA6zDyod6lNcvpHbjHL
 yBKHpbtu1Tln9N+OyTh0PeH5W0n2576V/s7k0d+jZ9ENdFdVvmG/5MiTYwY14tieoJjTqxRfkwo
 g8D96K7v1xm4mOa2DIHPiAViS+WjBGY9039hF2o4Cvbk/LY3+5DwEYpwRe9Wqx3ub+dXY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/5] Add fchmodat2 syscalls definitions
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
