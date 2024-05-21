Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BC2C41513
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 06:17:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A26853CFF4E
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:17:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E6173CEDDC
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E9B360086E
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EFE25BEE7;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0R8PZ1t0i1B2ViHCOBN7hhsH6DeA8pqlWMqyDFnDGk=;
 b=HxBOwxGVcE1PSv21m3WQpSBqDX49Bb3pCvlMLgvrcIABUVI6vcW6TTvEKwANVYGqO6GHlE
 aTOGXC89FNCPIKJWe8brCjcEFQ/Hn6Kc54NaDEEeKBPjYR5305LjuJYw/M395gQbbTNYxp
 mS0aEH5S2ERkb+JjVAWNiHBuFlio7V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0R8PZ1t0i1B2ViHCOBN7hhsH6DeA8pqlWMqyDFnDGk=;
 b=gmV/dg/7AhcIKFyf4HckJDfp9U+yZkCytQY8rolgsAPtjc08Xk9447D5aW63TskgB0OKyB
 5medVD7OojHpgxBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HxBOwxGV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="gmV/dg/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0R8PZ1t0i1B2ViHCOBN7hhsH6DeA8pqlWMqyDFnDGk=;
 b=HxBOwxGVcE1PSv21m3WQpSBqDX49Bb3pCvlMLgvrcIABUVI6vcW6TTvEKwANVYGqO6GHlE
 aTOGXC89FNCPIKJWe8brCjcEFQ/Hn6Kc54NaDEEeKBPjYR5305LjuJYw/M395gQbbTNYxp
 mS0aEH5S2ERkb+JjVAWNiHBuFlio7V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0R8PZ1t0i1B2ViHCOBN7hhsH6DeA8pqlWMqyDFnDGk=;
 b=gmV/dg/7AhcIKFyf4HckJDfp9U+yZkCytQY8rolgsAPtjc08Xk9447D5aW63TskgB0OKyB
 5medVD7OojHpgxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1AD613A21;
 Tue, 21 May 2024 06:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cJCrMEA8TGZmMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 May 2024 06:16:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 May 2024 08:15:28 +0200
MIME-Version: 1.0
Message-Id: <20240521-fchmodat2-v1-2-191b4a986202@suse.com>
References: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
In-Reply-To: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6484;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=pNKx0IZpWfc5y84+p+IrFtmwVTJzv8/aQc06mk2+7jg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTDw/B2wAZ3YoPTsuw0yFBAposMcNMYSw7Wrg0
 Mp/y7tM0l2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkw8PwAKCRDLzBqyILPm
 Rv0DDACTgiUhlThSrmOljp1xjlsRrbVMeKVNy5gpvHNpTcGSRa564+MQGlzNW/al7O040aHemN4
 KMvwWEXBnAplQvXUJfzeEek95W6ljAqRShw6wgQjn5dotd6uvXaOJOtdhvdX51AJQtv1U/PIz9z
 PkvQGjs2HNn1xI4sKQFlTFNGUqUAP3MJRmDy83MvSZBPYaG4J3NEZGycareLDznQbwek6tAz93P
 Yb5AlnMVWR79BGHuOuzbB8fcIcWmB8QC3CFDQOJBZsgThF5oAScjXO94LJBMEz6k232dtY2bFsG
 7AhKCbY2kgox5mLmL7C9YG60UQl8LqrOXDm8V+KDJe803T8zqF/izeTF3gDMDrGW1Qmtaxxt1CT
 7MLap402z8ELp72R5CfIjt6k2K9qG58d9M9kYFmiy9z+rO1la1qBmtc61EK6dxvqegQerghyAT0
 JbvDc1TOHWnm2fOWmc+vbaGRkC5Q6Ob22yQ1dcit0Ep19u2zFyLxHrIp+et+CSqEjOUmY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0EFE25BEE7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] Add fchmodat2 syscall definitions
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
index 2cb6c2d87..b2a8e5e8b 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -297,4 +297,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..adc3e5e70 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -317,3 +317,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..c2cda553e 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -395,3 +395,4 @@ faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
+fchmodat2 (__NR_SYSCALL_BASE+452)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..095261564 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -44,3 +44,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..00d2a84d6 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -431,3 +431,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..223ea2ee9 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -344,3 +344,4 @@ faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
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
index e818c9d92..40fdeafb0 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -371,3 +371,4 @@ epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
 futex_waitv 6449
+fchmodat2 6452
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..eae498659 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -347,3 +347,4 @@ epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
 futex_waitv 5449
+fchmodat2 5452
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..c355fb9b3 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -417,3 +417,4 @@ epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
 futex_waitv 4449
+fchmodat2 4452
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..f4be8321b 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..f4be8321b 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..6c9c59d94 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -411,3 +411,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..b4541ec5a 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -359,3 +359,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..65f8c5bfd 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -405,3 +405,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..05e32ff26 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -410,3 +410,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..59dc1ec4d 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -375,3 +375,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..a9b523fdc 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -352,6 +352,7 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+fchmodat2 452
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
