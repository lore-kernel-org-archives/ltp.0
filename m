Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66CBC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B80953E9A6E
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:12:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4CBA3CD537
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD81C1A000F1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BE064223C1;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=uDpuDCBZ8meXT1fazwNGjO8bxdJdCUATwvpyz5sRxz0B/bSnXT4rchHMS+4Bm0RDQTYQkr
 P3FjsbiYI9sRodasyq7UXV/S9Ymh7cleb2kOy4HmuQD/EJhqINBLMuTWwA/LH5h/Uq9pSV
 gG6Oz6pddQLiJQ/E7WQKcCVGiWeyUQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=0p5qtJXQRyv1rgxO9YvER2dW4pBAYvtVgZrtDVdqwdOvd4e7NieiVnMS8zSr/stAkH5SN6
 V9HKFi8D/zEt0zDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=Gi1eDuOMpNfeKlm8QLGG03wWi02oRIGUtfHvaV2WRU/Y2gH1HuU2n2QMjuqPB5x8HzRmaz
 qz/VsbJcoQT0DPMOuHvDbBXC6GBAfjI3QM+eQSOfNNIVsB4ZYZQ1Y9Aeb7vWGRi7aFcR6y
 8N+7EvIolHvLBvpzTXtpLLBAlGTjoz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=wQfGQqjgV+Wm3+xTy7iZXnEEqJqPovAhWDRt2TG5ZhCK8rd3UE9DXv2Dc2uMX/TakbVNeK
 h96z2yY/K75j95Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CD7113675;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gGbaICCXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:36 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-2-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=6820;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=m68Rq3D0AuTz0g2JYolbkLIfHkdVPUctTkcO7UmKS/A=;
 b=DlRVdBSSmlSC6KEWCzsK8WM7NYtu6k2vPxSXLSb7U/p4YCqYSZVmcACxTj5T543KEpdZwQ9Bn
 rIDC/DBun43AUhTOmZ0ALEe68ceA/xfQS6vq7B/8T65CjmHstk7f06A
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/15] syscalls: update outdated syscall entries
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

Add uprobe (336) on x86_64 and clone3 (435) on sparc, which were
missing from the architecture syscall tables.

Drop the _sysctl and timerfd entries because both are wired to
sys_ni_syscall in the kernel syscall tables and cannot be called.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/arm.in       | 1 -
 include/lapi/syscalls/i386.in      | 1 -
 include/lapi/syscalls/mips64.in    | 2 --
 include/lapi/syscalls/mips64n32.in | 2 --
 include/lapi/syscalls/mipso32.in   | 2 --
 include/lapi/syscalls/parisc.in    | 1 -
 include/lapi/syscalls/powerpc.in   | 1 -
 include/lapi/syscalls/powerpc64.in | 1 -
 include/lapi/syscalls/s390.in      | 2 --
 include/lapi/syscalls/s390x.in     | 2 --
 include/lapi/syscalls/sh.in        | 1 -
 include/lapi/syscalls/sparc.in     | 2 +-
 include/lapi/syscalls/sparc64.in   | 2 +-
 include/lapi/syscalls/x86_64.in    | 2 +-
 14 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index c4058e8de..158350976 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -109,7 +109,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 21d5da053..ee229b567 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -145,7 +145,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index 3c19066b8..d1087e049 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -150,7 +150,6 @@ mlockall 5148
 munlockall 5149
 vhangup 5150
 pivot_root 5151
-_sysctl 5152
 prctl 5153
 adjtimex 5154
 setrlimit 5155
@@ -272,7 +271,6 @@ ioprio_set 5273
 ioprio_get 5274
 utimensat 5275
 signalfd 5276
-timerfd 5277
 eventfd 5278
 fallocate 5279
 timerfd_create 5280
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 0c539bd62..2a3883198 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -150,7 +150,6 @@ mlockall 6148
 munlockall 6149
 vhangup 6150
 pivot_root 6151
-_sysctl 6152
 prctl 6153
 adjtimex 6154
 setrlimit 6155
@@ -276,7 +275,6 @@ ioprio_set 6277
 ioprio_get 6278
 utimensat 6279
 signalfd 6280
-timerfd 6281
 eventfd 6282
 fallocate 6283
 timerfd_create 6284
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index ecbe4d4b9..0d682d072 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -144,7 +144,6 @@ cachectl 4148
 sysmips 4149
 getsid 4151
 fdatasync 4152
-_sysctl 4153
 mlock 4154
 munlock 4155
 mlockall 4156
@@ -307,7 +306,6 @@ ioprio_set 4314
 ioprio_get 4315
 utimensat 4316
 signalfd 4317
-timerfd 4318
 eventfd 4319
 fallocate 4320
 timerfd_create 4321
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index e84c3b344..71d40f7b2 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -142,7 +142,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 9354dbe2b..85d7aec9a 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -145,7 +145,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index e4bef6838..def01478d 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -145,7 +145,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 4a11871b6..5024313a5 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -126,7 +126,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -291,7 +290,6 @@ utimes 313
 fallocate 314
 utimensat 315
 signalfd 316
-timerfd 317
 eventfd 318
 timerfd_create 319
 timerfd_settime 320
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 055a039fb..357b04ceb 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -107,7 +107,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
@@ -258,7 +257,6 @@ utimes 313
 fallocate 314
 utimensat 315
 signalfd 316
-timerfd 317
 eventfd 318
 timerfd_create 319
 timerfd_settime 320
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 29cd8f8df..584d36a4e 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -128,7 +128,6 @@ readv 145
 writev 146
 getsid 147
 fdatasync 148
-_sysctl 149
 mlock 150
 munlock 151
 mlockall 152
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index ea2bfc9c1..a48c5b365 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -246,7 +246,6 @@ sched_get_priority_min 247
 sched_rr_get_interval 248
 nanosleep 249
 mremap 250
-_sysctl 251
 getsid 252
 fdatasync 253
 nfsservctl 254
@@ -402,6 +401,7 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 692652c3b..9f3e825a9 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -228,7 +228,6 @@ sched_get_priority_min 247
 sched_rr_get_interval 248
 nanosleep 249
 mremap 250
-_sysctl 251
 getsid 252
 fdatasync 253
 nfsservctl 254
@@ -365,6 +364,7 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+clone3 435
 close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 7d3d8163c..1996c26b8 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -154,7 +154,6 @@ munlockall 152
 vhangup 153
 modify_ldt 154
 pivot_root 155
-_sysctl 156
 prctl 157
 arch_prctl 158
 adjtimex 159
@@ -334,6 +333,7 @@ statx 332
 io_pgetevents 333
 rseq 334
 uretprobe 335
+uprobe 336
 pidfd_send_signal 424
 io_uring_setup 425
 io_uring_enter 426

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
