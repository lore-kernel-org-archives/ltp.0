Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BB0C32771
	for <ltp@archiver.kernel.org>; Thu, 29 Sep 2022 01:38:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AAB43CA28A
	for <ltp@archiver.kernel.org>; Thu, 29 Sep 2022 03:37:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10CC43C8D70
 for <ltp@lists.linux.it>; Thu, 29 Sep 2022 03:37:46 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1314200FC4
 for <ltp@lists.linux.it>; Thu, 29 Sep 2022 03:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664415464; x=1695951464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F3lWPr4fbfduHH9qolA3CpobTIh/f0T943/gjVeyMto=;
 b=DVgcCabIaNmitNUt6ajwXaP8kPFEkpwI+MClfUYB9s7UlSkJ0WMtdtVr
 vG/0uc1MgTevl5gxbj0cAFdelQ61Kj45HJ8pMfB5Q8O4d42HIMvzSv8qQ
 2Gs2Cr3Y5yGc+ErB/fXmaKH16Q5yHgMwzsj/tXPAtjG9uqovVkqKvmcVm
 AWe5miKU9b+djB9Ix3NxRw1mDALhQAWkNFxsjTk2S2Xu0F3wdMgZOpwem
 AlE/lLS8VUGVUu+TwtRZ1RqqOE1PqWTZXNQ6Ku2eOrT8Luwh7HCKqSApt
 xaIaOTSy7cgZwlMSVBnriIMvBLn6N+ZStvR8CAMHyiw8tuL3xNgPumbiL g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="303249527"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; d="scan'208";a="303249527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2022 18:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="655355784"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; d="scan'208";a="655355784"
Received: from xpf.sh.intel.com ([10.239.182.112])
 by orsmga001.jf.intel.com with ESMTP; 28 Sep 2022 18:36:54 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Thu, 29 Sep 2022 09:36:56 +0800
Message-Id: <95045db25972298c8776d40666219d4d1c83546c.1664414900.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664414900.git.pengfei.xu@intel.com>
References: <cover.1664414900.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] ptrace07: should not use a hard-coded xstate
 size and use CPUID specified instead
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
Cc: chang.seok.bae@intel.com, eric.devolder@oracle.com,
 Heng Su <heng.su@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Should not use a hard-coded xstate size(512 * 8 = 4096 bytes) which is
wrong, should use maximum XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX.
If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
it will cause the ptrace07 case to fail as below:
"
./ptrace07
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
tst_test.c:1571: TINFO: Killed the leftover descendant processes

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
"

Reported-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/syscalls/ptrace/ptrace07.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index da62cadb0..358a422c0 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -35,6 +35,7 @@
 #include "config.h"
 #include "ptrace.h"
 #include "tst_test.h"
+#include "ltp_cpuid.h"
 
 #ifndef PTRACE_GETREGSET
 # define PTRACE_GETREGSET 0x4204
@@ -48,6 +49,8 @@
 # define NT_X86_XSTATE 0x202
 #endif
 
+#define CPUID_LEAF_XSTATE 0xd
+
 static void check_regs_loop(uint32_t initval)
 {
 	const unsigned long num_iters = 1000000000;
@@ -83,8 +86,14 @@ static void do_test(void)
 	int i;
 	int num_cpus = tst_ncpus();
 	pid_t pid;
-	uint64_t xstate[512];
-	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
+	uint32_t eax, ebx, ecx = 0, edx, *xstate;
+	/*
+	 * CPUID.(EAX=0DH, ECX=0H):EBX: maximum size (bytes, from the beginning
+	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
+	 */
+	cpuid(CPUID_LEAF_XSTATE, &eax, &ebx, &ecx, &edx);
+	xstate = aligned_alloc(64, ebx);
+	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
 	int status;
 	bool okay;
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
