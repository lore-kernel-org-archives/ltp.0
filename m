Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E775CC4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:11:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2E083CB374
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:11:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843E03CB498
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id D29BC1A00484
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 17:44:49 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 468AB1FB
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 09:44:54 -0700 (PDT)
Received: from e126380.cambridge.arm.com (e126380.cambridge.arm.com
 [10.1.32.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 852A43F5A1
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 09:44:47 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu,  3 Nov 2022 16:44:30 +0000
Message-Id: <20221103164431.365731-2-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103164431.365731-1-teo.coupriediaz@arm.com>
References: <20221103164431.365731-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] regen.sh: Use intptr_t for tst_syscall return
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

Some syscalls directly return pointers, like brk or mmap. int is currently
used for the return value in tst_syscall but is not large enough
to guarantee that such a returned value will fit.
Instead, use intptr_t which is guaranted to be castable to (void *)
without loss of data.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
 include/lapi/syscalls/regen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 3bf38fd03..97027e2f3 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -48,7 +48,7 @@ cat << EOF > "${output_pid}"
 #endif
 
 #define tst_syscall(NR, ...) ({ \\
-	int tst_ret; \\
+	intptr_t tst_ret; \\
 	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
 		errno = ENOSYS; \\
 		tst_ret = -1; \\
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
