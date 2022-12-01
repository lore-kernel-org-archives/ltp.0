Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A31BC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68B5F3CC4B4
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:03:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45F5C3CC4C8
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:09 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D202A20E765
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:08 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1C2v8f035647; Thu, 1 Dec 2022 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=77vBXbgf4Cj2IWhWCzM3tp1RiLzeueqfc6JabtPd+oM=;
 b=IX3OkP7nKxULERPAEguqWrIzsqlbnte43nEn/akIkjxYx8BRXwthXEJqa+kSzHLb6gXs
 DR1PnvcV2hCSHG6pl+zmzldd2QPV1skIqeAD7zZ0C14eSNl6lZQQ6lZpKz+sbzxFx6uH
 e2Ic+Sp9LnRgynbpg7wY2EODF+ilL0n9eMdMZPqTjJbryNnH9H21LFzE3B5lBtvtcHng
 DYOeOCID/6MUiHavaZrbuJ4WXbVc4Pa0XKqmLhyc2XqWnYJp/DgrPHSkqyWq9oi4ZTCv
 PklHOZG2tVN8rLCiyIscrLBv0DzI4aYloE2xZgD2GT565PLVDEMvEf2j7ZUyRBrZluPT gA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ux9r06d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:03:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1Bp46R009385;
 Thu, 1 Dec 2022 12:03:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 3m3a2hyany-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:03:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2B1C32Ck3736156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:03:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5410A4054;
 Thu,  1 Dec 2022 12:03:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1CE6A405B;
 Thu,  1 Dec 2022 12:02:59 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  1 Dec 2022 12:02:59 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:32:44 +0530
Message-Id: <20221201120248.139396-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201120248.139396-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221201120248.139396-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y9XgbRDklptR88B0AFkxyVjhvXtCnvXb
X-Proofpoint-ORIG-GUID: Y9XgbRDklptR88B0AFkxyVjhvXtCnvXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=883 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/8] Hugetlb: Migrating libhugetlbfs icache-hygiene
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/icache-hygiene.c test

Test Description: Older ppc64 kernels don't properly flush dcache to
icache before giving a cleared page to userspace.  With some exceedingly
hairy code, this attempts to test for this bug.

This test will never trigger (obviously) on machines with coherent
icache and dcache (including x86 and POWER5).  On any given run,
even on a buggy kernel there's a chance the bug won't trigger -
either because we don't get the same physical page back when we
remap, or because the icache happens to get flushed in the interim.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 239 ++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 796ebe7fa..0714ed34c 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -16,6 +16,7 @@ hugemmap11 hugemmap11
 hugemmap12 hugemmap12
 hugemmap13 hugemmap13
 hugemmap14 hugemmap14
+hugemmap15 hugemmap15
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 3106579ce..d59b60fd4 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -15,6 +15,7 @@
 /hugetlb/hugemmap/hugemmap12
 /hugetlb/hugemmap/hugemmap13
 /hugetlb/hugemmap/hugemmap14
+/hugetlb/hugemmap/hugemmap15
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
new file mode 100644
index 000000000..8be4d194f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Older ppc64 kernels don't properly flush dcache to icache before
+ * giving a cleared page to userspace.  With some exceedingly
+ * hairy code, this attempts to test for this bug.
+ *
+ * This test will never trigger (obviously) on machines with coherent
+ * icache and dcache (including x86 and POWER5).  On any given run,
+ * even on a buggy kernel there's a chance the bug won't trigger -
+ * either because we don't get the same physical page back when we
+ * remap, or because the icache happens to get flushed in the interim.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define SUCC_JMP 1
+#define FAIL_JMP 2
+#define COPY_SIZE	128
+
+/* Seems to be enough to trigger reliably */
+#define NUM_REPETITIONS	64
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int  fd = -1;
+
+static void cacheflush(void *p)
+{
+#if defined(__powerpc__)
+	asm volatile("dcbst 0,%0; sync; icbi 0,%0; isync" : : "r"(p));
+#elif defined(__arm__) || defined(__aarch64__)
+	__clear_cache(p, p + COPY_SIZE);
+#else
+	(void)p;
+#endif
+}
+
+static void jumpfunc(int copy, void *p)
+{
+	/*
+	 * gcc bug workaround: if there is exactly one &&label
+	 * construct in the function, gcc assumes the computed goto
+	 * goes there, leading to the complete elision of the goto in
+	 * this case
+	 */
+	void *l = &&dummy;
+
+	l = &&jumplabel;
+
+	if (copy) {
+		memcpy(p, l, COPY_SIZE);
+		cacheflush(p);
+	}
+
+	goto *p;
+ dummy:
+	tst_res(TWARN, "unreachable?");
+
+ jumplabel:
+	return;
+}
+
+static sigjmp_buf sig_escape;
+static void *sig_expected;
+
+static void sig_handler(int signum, siginfo_t *si, void *uc)
+{
+#if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
+	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
+	defined(__aarch64__) || (defined(__riscv) && __riscv_xlen == 64)
+	/* On powerpc, ia64, s390 and Aarch64, 0 bytes are an illegal
+	 * instruction, so, if the icache is cleared properly, we SIGILL
+	 * as soon as we jump into the cleared page
+	 */
+	if (signum == SIGILL) {
+		tst_res(TINFO, "SIGILL at %p (sig_expected=%p)", si->si_addr,
+				sig_expected);
+		if (si->si_addr == sig_expected)
+			siglongjmp(sig_escape, SUCC_JMP);
+		siglongjmp(sig_escape, FAIL_JMP + SIGILL);
+	}
+#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)
+	/* On x86, zero bytes form a valid instruction:
+	 *	add %al,(%eax)		(i386)
+	 * or	add %al,(%rax)		(x86_64)
+	 *
+	 * So, behaviour depends on the contents of [ER]AX, which in
+	 * turn depends on the details of code generation.  If [ER]AX
+	 * contains a valid pointer, we will execute the instruction
+	 * repeatedly until we run off that hugepage and get a SIGBUS
+	 * on the second, truncated page.  If [ER]AX does not contain
+	 * a valid pointer, we will SEGV on the first instruction in
+	 * the cleared page.  We check for both possibilities
+	 * below.
+	 *
+	 * On 32 bit ARM, zero bytes are interpreted as follows:
+	 *  andeq	r0, r0, r0	(ARM state, 4 bytes)
+	 *  movs	r0, r0		(Thumb state, 2 bytes)
+	 *
+	 * So, we only expect to run off the end of the huge page and
+	 * generate a SIGBUS.
+	 */
+	if (signum == SIGBUS) {
+		tst_res(TINFO, "SIGBUS at %p (sig_expected=%p)", si->si_addr,
+				sig_expected);
+		if (sig_expected
+		    && (PALIGN(sig_expected, hpage_size)
+			== si->si_addr)) {
+			siglongjmp(sig_escape, SUCC_JMP);
+		}
+		siglongjmp(sig_escape, FAIL_JMP + SIGBUS);
+	}
+#if defined(__x86_64__) || defined(__i386__)
+	if (signum == SIGSEGV) {
+#ifdef __x86_64__
+		void *pc = (void *)((ucontext_t *)uc)->uc_mcontext.gregs[REG_RIP];
+#else
+		void *pc = (void *)((ucontext_t *)uc)->uc_mcontext.gregs[REG_EIP];
+#endif
+		tst_res(TINFO, "SIGSEGV at %p, PC=%p (sig_expected=%p)",
+				si->si_addr, pc, sig_expected);
+		if (sig_expected == pc)
+			siglongjmp(sig_escape, SUCC_JMP);
+		siglongjmp(sig_escape, FAIL_JMP + SIGSEGV);
+	}
+#endif
+#else
+#error "Need to setup signal conditions for this arch"
+#endif
+}
+
+static int test_once(int fd)
+{
+	void *p, *q;
+
+	SAFE_FTRUNCATE(fd, 0);
+
+	switch (sigsetjmp(sig_escape, 1)) {
+	case SUCC_JMP:
+		sig_expected = NULL;
+		SAFE_FTRUNCATE(fd, 0);
+		return 0;
+	case FAIL_JMP + SIGILL:
+		tst_res(TFAIL, "SIGILL somewhere unexpected");
+		return -1;
+	case FAIL_JMP + SIGBUS:
+		tst_res(TFAIL, "SIGBUS somewhere unexpected");
+		return -1;
+	case FAIL_JMP + SIGSEGV:
+		tst_res(TFAIL, "SIGSEGV somewhere unexpected");
+		return -1;
+	default:
+		break;
+	}
+	p = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_SHARED, fd, 0);
+
+	SAFE_FTRUNCATE(fd, hpage_size);
+
+	q = p + hpage_size - COPY_SIZE;
+
+	jumpfunc(1, q);
+
+	SAFE_FTRUNCATE(fd, 0);
+	p = SAFE_MMAP(p, hpage_size, PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_SHARED|MAP_FIXED, fd, 0);
+
+	q = p + hpage_size - COPY_SIZE;
+	sig_expected = q;
+
+	jumpfunc(0, q); /* This should blow up */
+
+	tst_res(TFAIL, "icache unclean");
+	return -1;
+}
+
+static void run_test(void)
+{
+	int i;
+
+	struct sigaction sa = {
+		.sa_sigaction = sig_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	SAFE_SIGACTION(SIGILL, &sa, NULL);
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+
+	for (i = 0; i < NUM_REPETITIONS; i++)
+		if (test_once(fd))
+			goto cleanup;
+
+	tst_res(TPASS, "Successfully tested dcache to icache flush");
+cleanup:
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
