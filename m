Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDDCC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:44:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1343D1EE6
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:44:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 139813CFA07
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:44:09 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F25D1A00162
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:44:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0841FB4E;
 Thu,  1 Aug 2024 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722516246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8Md1oMlwpqHXOfMnaDg+noWm9J6OzRoRxtKGlTvrDY=;
 b=eSFSHdeFB6XPW/zW0KMgiVxptSa/xAmHJitsAMfKorXOVj4K9rDDbjHNwTJStwU7+ElSOY
 WWaphIljQGpMqXChLkKNVaBRZQa73W8NeeU3Yjwy7wdSjRH+19EeFRstLCumxAPqctGFD2
 8XCinp0We2ySFcr0A/3FBOiAtG3LBXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722516246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8Md1oMlwpqHXOfMnaDg+noWm9J6OzRoRxtKGlTvrDY=;
 b=LQ1Q4Ob4dQriWO7uuKKgzXsErHauci11laHxNA1sO4ix2TDdfazVOCv17eCgfii1l5xY27
 TGkqTuT5SrtLr2DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eSFSHdeF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LQ1Q4Ob4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722516246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8Md1oMlwpqHXOfMnaDg+noWm9J6OzRoRxtKGlTvrDY=;
 b=eSFSHdeFB6XPW/zW0KMgiVxptSa/xAmHJitsAMfKorXOVj4K9rDDbjHNwTJStwU7+ElSOY
 WWaphIljQGpMqXChLkKNVaBRZQa73W8NeeU3Yjwy7wdSjRH+19EeFRstLCumxAPqctGFD2
 8XCinp0We2ySFcr0A/3FBOiAtG3LBXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722516246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8Md1oMlwpqHXOfMnaDg+noWm9J6OzRoRxtKGlTvrDY=;
 b=LQ1Q4Ob4dQriWO7uuKKgzXsErHauci11laHxNA1sO4ix2TDdfazVOCv17eCgfii1l5xY27
 TGkqTuT5SrtLr2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1847E13946;
 Thu,  1 Aug 2024 12:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MDVzOxWDq2Z+YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:44:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:43:50 +0200
MIME-Version: 1.0
Message-Id: <20240801-mseal-v3-1-874f149dce87@suse.com>
References: <20240801-mseal-v3-0-874f149dce87@suse.com>
In-Reply-To: <20240801-mseal-v3-0-874f149dce87@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6589;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=fKsGjN9BdkWkjVXfqyUJMOEEeXH74BEd4au+9LKFfJY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq4MUY7KIYJO6dSvEUrnIOwNzvlvcRg5MDHXGB
 thkWoUVxMuJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZquDFAAKCRDLzBqyILPm
 RsvIC/9/tzoYts2cL6K9Oo9JGKgHeau6P8pPyE+eMbA8p96C38nZIWKMIK3j409JVkiBvnuYeKD
 kp+3vlBsJOGVe8w0ZbEgGRXYDyOL4hpvhRV0qB7J8giiku0UgrFLgoWHafwM1FTCbaT3ieq3H4p
 8F9XxuMa52InOz9+FZ6hDdjy76ybbsE0T1o4R7nTqpRNHAmyyBSZ51IPkO7NJ8KjEUqNS+S3/8W
 YYeTztpQc3JSjarBizK+h9woEVJq3uaAaOtJP2enhUWOvT67onEEd/yWFsmVd+FhC0QrWS5qhsU
 0rrsf26Z+KQ+oRHo3LOz9vemkkwsrhZWu6oNPVsVXcK8fhtOB+hGkOpKnr2CL/55qF24ClbqLAw
 bGgUY1j4ljQQb/1FqzTAl03lMTmYN3DrCbwm24E/mauKrqg1K3Bwy2DILJfnf17Ylbi6QGOek9F
 D4i8g40tLr290Q0s3s78hk3sVcULBtQJ9IxnN2ezDxvIcSm2m9XIGh1SLT0aVtYdCau+I=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6B0841FB4E
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add mseal() syscall declaration
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
index ef0aa04a3..d1ff7c081 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -301,4 +301,5 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3eaa6a8f1..265329cbe 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -321,3 +321,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index b52a32b6b..b49590268 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -400,3 +400,4 @@ landlock_restrict_self (__NR_SYSCALL_BASE+446)
 memfd_secret (__NR_SYSCALL_BASE+447)
 futex_waitv (__NR_SYSCALL_BASE+449)
 cachestat (__NR_SYSCALL_BASE+451)
+mseal (__NR_SYSCALL_BASE+462)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 4919ee65d..9a8832248 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -48,3 +48,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index cff40957a..59c97b9b8 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -435,3 +435,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 11d4b46f4..f08a268e8 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -348,3 +348,4 @@ landlock_add_rule 1469
 landlock_restrict_self 1470
 futex_waitv 1473
 cachestat 1475
+mseal 1486
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 9bf6a7deb..29acad012 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -306,3 +306,4 @@ process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index a76c82593..260e01518 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -375,3 +375,4 @@ landlock_add_rule 6445
 landlock_restrict_self 6446
 futex_waitv 6449
 cachestat 6451
+mseal 6462
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index df991efd5..83da993ad 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -351,3 +351,4 @@ landlock_add_rule 5445
 landlock_restrict_self 5446
 futex_waitv 5449
 cachestat 5451
+mseal 5462
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 826b7d66e..3589e0337 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -421,3 +421,4 @@ landlock_add_rule 4445
 landlock_restrict_self 4446
 futex_waitv 4449
 cachestat 4451
+mseal 4462
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 798ed9050..e39e6b69c 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -428,3 +428,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 798ed9050..e39e6b69c 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -428,3 +428,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 126938095..d3426c88f 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -415,3 +415,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 18f2496a0..02df53322 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -363,3 +363,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index ae6f26050..c93271d1b 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -409,3 +409,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 409fa2729..9be7d2e96 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -414,3 +414,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index e13cf163e..9c80a328f 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -379,3 +379,4 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 05b1bee55..49cb1ab94 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -356,6 +356,7 @@ landlock_add_rule 445
 landlock_restrict_self 446
 futex_waitv 449
 cachestat 451
+mseal 462
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
