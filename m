Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B550CC25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 13:39:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA7353C9DC9
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 15:39:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34F753C9F03
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id E65C32009E2
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069E5152B;
 Wed, 17 Aug 2022 06:38:47 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A425E3F67D;
 Wed, 17 Aug 2022 06:38:45 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 17 Aug 2022 14:39:45 +0100
Message-Id: <20220817133946.234985-4-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817133946.234985-1-tudor.cretu@arm.com>
References: <20220817133946.234985-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] syscalls/prctl04: Allow rt_sigprocmask in the
 syscall filter
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

Some libcs (e.g. Musl) call rt_sigprocmask as part of their fork
implementation. To successfully call fork, rt_sigprocmask must be allowed
as well in the filter.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/prctl/prctl04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index 1cc19bbd3..2f7e9a1ac 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/prctl/prctl04.c
@@ -45,6 +45,7 @@
 static const struct sock_filter  strict_filter[] = {
 	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof(struct seccomp_data, nr))),
 
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_rt_sigprocmask, 6, 0),
 	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_close, 5, 0),
 	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_exit,  4, 0),
 	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_wait4, 3, 0),
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
