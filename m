Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE83FC433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF7BA3CB08A
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:11:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 062053C2CAE
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:10:42 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0521520004C
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666095041; x=1697631041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w3s13M9/nB/0YYXAxT3jEI5kdTxvJ5+E6TOGgmO8FVg=;
 b=cpU80v7Cykmcch1jN2x7/axktNrpLVdFNkkLo1kscFvfp+EVuKJfUZdZ
 5uaqdrriATSOPAzPXg8tla21DygAysVjD4klBjPBrY6e4VzESC7vlrEGD
 V7aPXPnF1tGMya2T/bH2c+r/7uU8JVcMlk+OejBYvUizs1XEx5Zi0b0So
 J3/HwjSwRINtYBzD2hL9PdOvRhLArJx+zpzcJnZtjtYAKKfNfwLGkevq9
 llnFiRBmmwXKHU8lGuvPFjKPtmJ8WDbW3ulJzY1T+6a8TVDLxPNCGlAMW
 oSDkm0CBWbHhRHx7gNRqgHjbug3gm/PN3uRQfJ5gljBjglfozWe6rjZQW A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368113367"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="368113367"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 05:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="771172082"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="771172082"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 05:10:36 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Tue, 18 Oct 2022 20:10:47 +0800
Message-Id: <803972797903c4e31badbc44ad6c89fa4dbc2ff0.1666094709.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1666094709.git.pengfei.xu@intel.com>
References: <cover.1666094709.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] ptrace07: fix the broken case caused by
 hardcoded xstate size
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

Should not use a hardcoded xstate size(512 * 8 = 4096 bytes), and use maximum
XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX instead.
If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
it will cause the ptrace07 case to break as below:
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
 testcases/kernel/syscalls/ptrace/ptrace07.c | 29 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index da62cadb0..c2c2ad77c 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -35,6 +35,7 @@
 #include "config.h"
 #include "ptrace.h"
 #include "tst_test.h"
+#include "cpuid.h"
 
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
@@ -83,11 +86,22 @@ static void do_test(void)
 	int i;
 	int num_cpus = tst_ncpus();
 	pid_t pid;
-	uint64_t xstate[512];
-	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
+	uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
+	uint64_t *xstate;
+	/*
+	 * CPUID.(EAX=0DH, ECX=0H):EBX: maximum size (bytes, from the beginning
+	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
+	 */
+	__cpuid_count(CPUID_LEAF_XSTATE, ecx, eax, ebx, ecx, edx);
+	xstate = aligned_alloc(64, ebx);
+	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
 	int status;
 	bool okay;
 
+	if (!xstate)
+		tst_brk(TBROK, "aligned_alloc() failed for xstate buffer");
+	tst_res(TINFO, "CPUID.(EAX=%u, ECX=0):EAX=%u, EBX=%u, ECX=%u, EDX=%u",
+		CPUID_LEAF_XSTATE, eax, ebx, ecx, edx);
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		TST_CHECKPOINT_WAKE(0);
@@ -102,12 +116,15 @@ static void do_test(void)
 	sched_yield();
 
 	TEST(ptrace(PTRACE_ATTACH, pid, 0, 0));
-	if (TST_RET != 0)
+	if (TST_RET != 0) {
+		free(xstate);
 		tst_brk(TBROK | TTERRNO, "PTRACE_ATTACH failed");
+	}
 
 	SAFE_WAITPID(pid, NULL, 0);
 	TEST(ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov));
 	if (TST_RET != 0) {
+		free(xstate);
 		if (TST_ERR == EIO)
 			tst_brk(TCONF, "GETREGSET/SETREGSET is unsupported");
 
@@ -138,6 +155,7 @@ static void do_test(void)
 		tst_res(TINFO,
 			"PTRACE_SETREGSET with reserved bits failed with EINVAL");
 	} else {
+		free(xstate);
 		tst_brk(TBROK | TTERRNO,
 			"PTRACE_SETREGSET failed with unexpected error");
 	}
@@ -152,8 +170,10 @@ static void do_test(void)
 	 * worry about potential stops after this point.
 	 */
 	TEST(ptrace(PTRACE_DETACH, pid, 0, 0));
-	if (TST_RET != 0)
+	if (TST_RET != 0) {
+		free(xstate);
 		tst_brk(TBROK | TTERRNO, "PTRACE_DETACH failed");
+	}
 
 	/* If child 'pid' crashes, only report it as info. */
 	SAFE_WAITPID(pid, &status, 0);
@@ -173,6 +193,7 @@ static void do_test(void)
 	}
 	if (okay)
 		tst_res(TPASS, "wasn't able to set invalid FPU state");
+	free(xstate);
 }
 
 static struct tst_test test = {
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
