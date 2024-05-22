Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ED9C25B7A
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 14:34:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA27E3D012C
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 16:34:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B910F3D00F0
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:46 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E7D21401713
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24F2C5C8DD;
 Wed, 22 May 2024 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txr46a8eXeO6aRxdkpNNTLZ3Yq6MyHrW1hD9qnP8EDE=;
 b=JRkSNCDdOwigGm7evBnLpy01XzYAlZli2L5Bkogud4a5fSZBNix4i6lqqjnGN/tDzZmHnG
 czaLXKtNKgE0Rvgdiot56Phqf2c+41Om7SuUX8ybp3i2IwTWbfpMNR13aIf7bahklZUXZU
 ZAyn2ENzZjd/sJe/xpdRk5u1VrOftjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txr46a8eXeO6aRxdkpNNTLZ3Yq6MyHrW1hD9qnP8EDE=;
 b=8e9wd/2DIwrVl/rPUsAPEzpJUAvvZ7oWwuIoMq1EPTvmmNdbDYmB2uwr/Dp0lFsctXnFJn
 /kcMQ9wSHmMV/6AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txr46a8eXeO6aRxdkpNNTLZ3Yq6MyHrW1hD9qnP8EDE=;
 b=JRkSNCDdOwigGm7evBnLpy01XzYAlZli2L5Bkogud4a5fSZBNix4i6lqqjnGN/tDzZmHnG
 czaLXKtNKgE0Rvgdiot56Phqf2c+41Om7SuUX8ybp3i2IwTWbfpMNR13aIf7bahklZUXZU
 ZAyn2ENzZjd/sJe/xpdRk5u1VrOftjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txr46a8eXeO6aRxdkpNNTLZ3Yq6MyHrW1hD9qnP8EDE=;
 b=8e9wd/2DIwrVl/rPUsAPEzpJUAvvZ7oWwuIoMq1EPTvmmNdbDYmB2uwr/Dp0lFsctXnFJn
 /kcMQ9wSHmMV/6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3C3913A7A;
 Wed, 22 May 2024 14:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mLP4OEYCTmaJOwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 May 2024 14:33:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 May 2024 16:33:05 +0200
MIME-Version: 1.0
Message-Id: <20240522-process_mrelease-v1-1-41fe2fa44194@suse.com>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
In-Reply-To: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6560;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=boImZPjckVuKrOunvGkOvH4vLzN8TH7rEvehX+G6sYY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTgJGy1FQxRPtlzi/wHAIrKpIeZThxj0C4bluF
 0ukLerQd3+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZk4CRgAKCRDLzBqyILPm
 Rh2hC/95Hi1gb7cPBR0JBZquo8EFxejYiL+vc5Cjut/gU71uUHZGyu4eXtXKrk3ZGKudiAS7FjP
 plKw3fLduOI5X5eXqZAEu2Mydia90e20cFrEU2/JyYa6GnQ7WVf+Zro0QuE9tdryjz4hWqUwQY/
 7dkRudpDiCZyrgqpodaUC5snMR29vs0WcMWi+Bmz1qhyzd5HsGMugCQl71cVONRKuZht09lNDes
 FHo/KACQ5NEw5/9AqgkCEVKAfUPDmHvVIVfUxVXvuNLxg7nRshbapCW5+N+N25X08HPz93IL3q2
 7iLXKgFo20k4KjN4WikfVxYuMWxryZxVKN0gsRYyZFlCeNdUFVq0QUASQiR7zYTuWFxBBh5NfGR
 pARIUc8qiY0FbUo2/xlJCit0K2nza+UaT5ban+z8X7JkdJKf7w94XQM64+MqNzyb4jWNo5a9wtq
 Yg7j3wLyIzzrY9Uoqtyd17HxLGZcXgtsOpbtBfXHxXnpGo16Jw9eMWTIdD0mIhI1mFpjQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Add process_mrelease syscalls definition
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
index 2cb6c2d87..98e6c69c5 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -296,5 +296,6 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..8ed05ce68 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -316,4 +316,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..d133a44be 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -394,4 +394,5 @@ pidfd_getfd (__NR_SYSCALL_BASE+438)
 faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
+process_mrelease (__NR_SYSCALL_BASE+448)
 futex_waitv (__NR_SYSCALL_BASE+449)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..578751e2e 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -43,4 +43,5 @@ close_range 436
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..59a1d030b 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -430,4 +430,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..e410582d8 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -343,4 +343,5 @@ pidfd_getfd 1462
 faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
+process_mrelease 1472
 futex_waitv 1473
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index e818c9d92..f2602a02f 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -370,4 +370,5 @@ process_madvise 6440
 epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
+process_mrelease 6448
 futex_waitv 6449
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..f16762c69 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -346,4 +346,5 @@ process_madvise 5440
 epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
+process_mrelease 5448
 futex_waitv 5449
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..88a0d7ca8 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -416,4 +416,5 @@ process_madvise 4440
 epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
+process_mrelease 4448
 futex_waitv 4449
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..20233339d 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -423,4 +423,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..20233339d 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -423,4 +423,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..ae0c83636 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -410,4 +410,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..d1476e98f 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -358,4 +358,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..845deff4d 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -404,4 +404,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..ec73eaa2b 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -409,4 +409,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..ecf8e1d22 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -374,4 +374,5 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..415f3011d 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -351,6 +351,7 @@ pidfd_getfd 438
 faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
+process_mrelease 448
 futex_waitv 449
 rt_sigaction 512
 rt_sigreturn 513

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
