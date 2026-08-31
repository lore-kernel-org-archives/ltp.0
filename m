Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6793C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:01:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 479A63E0E1A
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:01:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0293C98E4
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 755371000972
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70D1C21B98;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=VSmNb7ysZc07dGzxCVu8nWkvxo+HLtLZ4MQD0a3aHeGZC3Xv6I36rk5CZl/ZMxyZydEY5X
 Wp4qjurN1YbTF9uuyhqde9cSx0Qr+REVmtgkKr3mBT34uxlYMiqm9sxyLbAzmidqW99PTv
 PcP2zQp8G0L/ylqtVDqZTVIJ/dBro7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=PZTetISlqylpj2nN7YOMZsgW8fBDHfFBoGpVGxPY+xpE2ub5uF9so1pll8v4DwHazqcTHE
 c62FhjyECV7/xiDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w+28jGTi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tUcv82v1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=w+28jGTinYA0CPr68+gDfPxKzK6W2pUVugDaf6bihqN1cCcQl8YcsT9oIrL380KFnKdYKI
 3Mv8+gCegRfjEvJbCDJHjU6pvWgPgqRBOWRnvZgWTtbtn3SWjAiML0nIP9p497hvVftPGe
 lbkwn2wtf2dR3ssfvj4ixAfiJvfg6bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/XSP9M+juDvV/mqAGKnIfDzapoYMJZbxm48cz7m/NI=;
 b=tUcv82v1EWpnzIVJsn0tlhfwHjF00dq4/CqwH2BSQtYpuWMfizzT8dIOjhLMvNSpUGYyAL
 0XUriKrV6WPKe3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D300136A5;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KHtKDYY0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:03 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-2-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=6820;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=m68Rq3D0AuTz0g2JYolbkLIfHkdVPUctTkcO7UmKS/A=;
 b=pmE6Z1q7noAGMXCpJNZElDFQvwBWpGchEIMa5oPlzaLglZRWa0BS+Ke1lswi1lW7xDN9pHeHh
 plmHuI57nf5Dt+Wi7zqG3fznh1L2Zh8IwN5Bt1d8mzuympjdhs9AYc8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 70D1C21B98
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 02/16] syscalls: update outdated syscall entries
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
