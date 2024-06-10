Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A08BC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 09:45:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81A1D3D0B15
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:45:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 527943D0729
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:44:40 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61736200C05
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:44:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A81DF1F7D0;
 Mon, 10 Jun 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718012678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJD91h6J7NiiRrLm8NPEvw9khT8Bwo5aqGLarlj2Zjw=;
 b=xGWpz6wX7TsnZ1ZZf4HW7MIODyNGByIKh5dCdoOkwDL5orjOl446d+ySQW2ciZw6LFBMRm
 l6uXsitoILUJijJXCPd3Y0INx45GrD5GDUN8u+T/bnqnYhUrUrNV6GgaMrRJ58PCcPXfDa
 j+29iMYoD4z7hYr29A5hgbZa2rTnfyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718012678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJD91h6J7NiiRrLm8NPEvw9khT8Bwo5aqGLarlj2Zjw=;
 b=oR0JgApJxFkAMHsLZ2c0KupvnGK6i3f6b/jXyc21yn/UFhbnesZttoeg5hxURTqxhM5DEf
 PeXZ0jFyVk/Fd4BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xGWpz6wX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oR0JgApJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718012678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJD91h6J7NiiRrLm8NPEvw9khT8Bwo5aqGLarlj2Zjw=;
 b=xGWpz6wX7TsnZ1ZZf4HW7MIODyNGByIKh5dCdoOkwDL5orjOl446d+ySQW2ciZw6LFBMRm
 l6uXsitoILUJijJXCPd3Y0INx45GrD5GDUN8u+T/bnqnYhUrUrNV6GgaMrRJ58PCcPXfDa
 j+29iMYoD4z7hYr29A5hgbZa2rTnfyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718012678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJD91h6J7NiiRrLm8NPEvw9khT8Bwo5aqGLarlj2Zjw=;
 b=oR0JgApJxFkAMHsLZ2c0KupvnGK6i3f6b/jXyc21yn/UFhbnesZttoeg5hxURTqxhM5DEf
 PeXZ0jFyVk/Fd4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AF1B13AA0;
 Mon, 10 Jun 2024 09:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SG2OIAbLZmbpbgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Jun 2024 09:44:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Jun 2024 11:44:00 +0200
MIME-Version: 1.0
Message-Id: <20240610-mseal-v1-1-f659b9e97efa@suse.com>
References: <20240610-mseal-v1-0-f659b9e97efa@suse.com>
In-Reply-To: <20240610-mseal-v1-0-f659b9e97efa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6351;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=cfIBL4seD4YgFJzjtZSCmq5JYl6Han8W1jNGTwIR8BU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmZssGGHTU1s6cASTpULYqYWG1Ti4wTS8aRNRm+
 xhThlN0VzeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmbLBgAKCRDLzBqyILPm
 RraYDACT6tWdA4LWT8ZZP2KW7wn29ndXQB9jejMJKotEVzDc5CF6TGoyMBYF9BG89bmp68rataA
 mXo9+WTK1RgZG9oiZx2sERo1DpRGeK/XCmVRlMapAcZGOyedL/5J9TYlPv0lLxEeI1XLllmSLN8
 RjB7gb9hL7k4kM3Y1mpRmQkuxaoquhiCNh+JFMg65gj6pS0QUWY+jZ4o449Mlb2Z4kiBhUsrCaT
 eNRQJJgVeUpvtl4ePDnBbDlwdvJPZLYYAFJ+LblyiWazQYsPJZDGnT+Z2e6fqcZJ7OV6MLtlqKr
 d85wpcN8NhLjXsgU/SiRVCzgtjqjSqlqZwDMzJ62uCr4U0fF9MrR/gxzXEftqhRTfe/du9hsaMZ
 8tpSpLzvaGlMmx3sF+X2CxUXLqVfNgznS33D580XfKRyYfCUMAwtuq8ITVRM+Zj/qjsQhpLgRP0
 XANX5IqVSBFyPL2qkKuv3C/8lmqJuCYGxlWYhMgTubHuRF+V+5m90k+PgD3IuP934dVeA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A81DF1F7D0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add mseal() syscall declaration
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
index 2cb6c2d87..18e637c99 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -297,4 +297,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..bdcc4be74 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -317,3 +317,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..b5486ced0 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -395,3 +395,4 @@ faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
+mseal (__NR_SYSCALL_BASE+462)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..b1e2ef799 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -44,3 +44,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..e528977de 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -431,3 +431,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..05e7062e5 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -344,3 +344,4 @@ faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
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
index e818c9d92..adee58fc8 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -371,3 +371,4 @@ epoll_pwait2 6441
 mount_setattr 6442
 quotactl_fd 6443
 futex_waitv 6449
+mseal 6462
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 6e15f43b3..6ab95ddf1 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -347,3 +347,4 @@ epoll_pwait2 5441
 mount_setattr 5442
 quotactl_fd 5443
 futex_waitv 5449
+mseal 5462
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 921d5d331..4757d9c94 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -417,3 +417,4 @@ epoll_pwait2 4441
 mount_setattr 4442
 quotactl_fd 4443
 futex_waitv 4449
+mseal 4462
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..7b5a94ba5 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..7b5a94ba5 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..4cf870697 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -411,3 +411,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..9e70b9421 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -359,3 +359,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..d8cd978f5 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -405,3 +405,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..3d123727f 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -410,3 +410,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..9ef7abe37 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -375,3 +375,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..a59fa452d 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -352,6 +352,7 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+mseal 462
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
