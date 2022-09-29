Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C54C32771
	for <ltp@archiver.kernel.org>; Thu, 29 Sep 2022 02:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC7423CA2E9
	for <ltp@archiver.kernel.org>; Thu, 29 Sep 2022 04:30:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66A323C0FA6
 for <ltp@lists.linux.it>; Thu, 29 Sep 2022 04:30:24 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DCB031000954
 for <ltp@lists.linux.it>; Thu, 29 Sep 2022 04:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664418623; x=1695954623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uKVfsxljMmDkqKWmxeA51IFFzQoxWCmK/izTFh3ANwc=;
 b=OKFs/X0Q9j9mm/QX+05udcL9GY6/fz0xpgY5Rv+lhQZWQm4NwoyWlySp
 TDm3kBVY7Z2oMrXNnDsqQhwLTkDujKi8t7UnjjHWCzFi32GjhqgBQlTft
 uUsDpMjx7AfIMM1zqN5CYLPtrN3cxLGO22CHFsTCTklmUt3dvyftgf0++
 zhVy5O53UpnnDiCjswmqUQMvr55nUktqXAu14onvgzx9snVoDAePUj0Hy
 sNbqvNT4PdRy8Sy2Pp2takNqYlidGb5r+yu5H3R2sRSHZDDnjKCxjKGQ6
 0mlcatJUoIJzxsbSCd0TtfHltR+WPxf7DZGQznEAoRrYWrwWbaZsQh1ik Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="281487929"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; d="scan'208";a="281487929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2022 19:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="622164661"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; d="scan'208";a="622164661"
Received: from xpf.sh.intel.com ([10.239.182.112])
 by orsmga002.jf.intel.com with ESMTP; 28 Sep 2022 19:30:18 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Thu, 29 Sep 2022 10:30:20 +0800
Message-Id: <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1664418361.git.pengfei.xu@intel.com>
References: <cover.1664418361.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] ptrace07: should not use a hard-coded xstate
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
 testcases/kernel/syscalls/ptrace/ptrace07.c | 25 +++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index da62cadb0..0accaceb5 100644
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
@@ -83,8 +86,15 @@ static void do_test(void)
 	int i;
 	int num_cpus = tst_ncpus();
 	pid_t pid;
-	uint64_t xstate[512];
-	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
+	uint32_t eax, ebx, ecx = 0, edx;
+	uint64_t *xstate;
+	/*
+	 * CPUID.(EAX=0DH, ECX=0H):EBX: maximum size (bytes, from the beginning
+	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
+	 */
+	cpuid(CPUID_LEAF_XSTATE, &eax, &ebx, &ecx, &edx);
+	xstate = aligned_alloc(64, ebx);
+	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
 	int status;
 	bool okay;
 
@@ -102,12 +112,15 @@ static void do_test(void)
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
 
@@ -138,6 +151,7 @@ static void do_test(void)
 		tst_res(TINFO,
 			"PTRACE_SETREGSET with reserved bits failed with EINVAL");
 	} else {
+		free(xstate);
 		tst_brk(TBROK | TTERRNO,
 			"PTRACE_SETREGSET failed with unexpected error");
 	}
@@ -152,8 +166,10 @@ static void do_test(void)
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
@@ -173,6 +189,7 @@ static void do_test(void)
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
