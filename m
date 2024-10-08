Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC39CEF147
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:43:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0A8D3C1876
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:43:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A05EF3C19F5
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B415614016EE
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A50521A32;
 Tue,  8 Oct 2024 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRkAhFPCIcOZJZeCZWci64d3TF06+IPDpZRAxk3upqk=;
 b=D8QyG1DakAelqRppZ/mer7BpPFz5mCIOEich9ng3zWVnlg7pex3UG7a0xtyTbj15Y4kfQ9
 2MA0pzgQV+ouIpLEpvtUA2uZ4Vd1EVksn9CsYfRXmLv+L+gomDlWzfBRdHjJhfeCZnldjr
 QWVOK9a863oFrqJ0019N63PucbMe6+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRkAhFPCIcOZJZeCZWci64d3TF06+IPDpZRAxk3upqk=;
 b=kn7f7MXn2ZvoEU3dm/yAfPuIJi/m5OXVKENgUsmvbFqIr2Q5fyTlkL9JIilIgUv5jGj0Bx
 IJRAaLJCarzzM5Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRkAhFPCIcOZJZeCZWci64d3TF06+IPDpZRAxk3upqk=;
 b=D8QyG1DakAelqRppZ/mer7BpPFz5mCIOEich9ng3zWVnlg7pex3UG7a0xtyTbj15Y4kfQ9
 2MA0pzgQV+ouIpLEpvtUA2uZ4Vd1EVksn9CsYfRXmLv+L+gomDlWzfBRdHjJhfeCZnldjr
 QWVOK9a863oFrqJ0019N63PucbMe6+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRkAhFPCIcOZJZeCZWci64d3TF06+IPDpZRAxk3upqk=;
 b=kn7f7MXn2ZvoEU3dm/yAfPuIJi/m5OXVKENgUsmvbFqIr2Q5fyTlkL9JIilIgUv5jGj0Bx
 IJRAaLJCarzzM5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 771021340C;
 Tue,  8 Oct 2024 09:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KOpeEXf+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 09:42:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:41:56 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-3-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=6709;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=9tHG4xrUQVc3KnoXc0vEEtCQs39dALcEvHEz5qnQ1v8=;
 b=IPKqM39XK2qJcRSzh9rtub8BXgbERDpRsAKSzUH0bzrgdvA6VjI1s5WThmXtheUU4PQesTi/m
 SiVhGNYvDhbBix/AejofyDri+9o3loA0ZtO7S8u+pTWddf7lWWkxKAx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:mid, suse.com:email,
 suse.de:email, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 03/16] Add listmount/statmount syscalls
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

Reviewed-by: Avinesh Kumar <akumar@suse.de>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/aarch64.in   | 2 ++
 include/lapi/syscalls/arc.in       | 2 ++
 include/lapi/syscalls/arm.in       | 2 ++
 include/lapi/syscalls/hppa.in      | 2 ++
 include/lapi/syscalls/i386.in      | 2 ++
 include/lapi/syscalls/ia64.in      | 2 ++
 include/lapi/syscalls/loongarch.in | 2 ++
 include/lapi/syscalls/mips_n32.in  | 2 ++
 include/lapi/syscalls/mips_n64.in  | 2 ++
 include/lapi/syscalls/mips_o32.in  | 2 ++
 include/lapi/syscalls/powerpc.in   | 2 ++
 include/lapi/syscalls/powerpc64.in | 2 ++
 include/lapi/syscalls/s390.in      | 2 ++
 include/lapi/syscalls/s390x.in     | 2 ++
 include/lapi/syscalls/sh.in        | 2 ++
 include/lapi/syscalls/sparc.in     | 2 ++
 include/lapi/syscalls/sparc64.in   | 2 ++
 include/lapi/syscalls/x86_64.in    | 2 ++
 18 files changed, 36 insertions(+)

diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 61d4450bf..c184f5710 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -303,4 +303,6 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 752cc54fd..ff58f1be2 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -323,3 +323,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 84203ca4d..ff1415f52 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -402,3 +402,5 @@ futex_waitv (__NR_SYSCALL_BASE+449)
 cachestat (__NR_SYSCALL_BASE+451)
 fchmodat2 (__NR_SYSCALL_BASE+452)
 mseal (__NR_SYSCALL_BASE+462)
+statmount (__NR_SYSCALL_BASE+457)
+listmount (__NR_SYSCALL_BASE+458)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8240c69ce..ac6cd691d 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -50,3 +50,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index f6e8c7258..d2f8c295d 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -437,3 +437,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 8f55029a9..cd770bace 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -350,3 +350,5 @@ futex_waitv 1473
 cachestat 1475
 fchmodat2 1476
 mseal 1486
+statmount 1481
+listmount 1482
diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
index 3df354fce..7e40e01bf 100644
--- a/include/lapi/syscalls/loongarch.in
+++ b/include/lapi/syscalls/loongarch.in
@@ -308,3 +308,5 @@ set_mempolicy_home_node 450
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index d85c567c7..1c64e9ab4 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -377,3 +377,5 @@ futex_waitv 6449
 cachestat 6451
 fchmodat2 6452
 mseal 6462
+statmount 6457
+listmount 6458
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index c34a85bbe..e3895b1ea 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -353,3 +353,5 @@ futex_waitv 5449
 cachestat 5451
 fchmodat2 5452
 mseal 5462
+statmount 5457
+listmount 5458
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index 10d77787b..043747da7 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -423,3 +423,5 @@ futex_waitv 4449
 cachestat 4451
 fchmodat2 4452
 mseal 4462
+statmount 4457
+listmount 4458
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index af3ae5c90..a3b8fdabf 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -430,3 +430,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index af3ae5c90..a3b8fdabf 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -430,3 +430,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index e8e7fff0b..bf55073d6 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -417,3 +417,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 0ee3bd897..d11e22bd3 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -365,3 +365,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 5701f2285..67cf85d50 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -411,3 +411,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 172969f60..56e275f74 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -416,3 +416,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 5b667f10f..cfe221919 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -381,3 +381,5 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 1993f343a..8919487c8 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -358,6 +358,8 @@ futex_waitv 449
 cachestat 451
 fchmodat2 452
 mseal 462
+statmount 457
+listmount 458
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
