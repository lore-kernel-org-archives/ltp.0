Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0426CC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:32:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 865D33CBA56
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:32:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A5033CBA6A
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:48 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0DDE61400554
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:46 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6C6bD020264; Tue, 20 Dec 2022 06:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CfhFTAGarxIZE6bcvT6QKDH/HzVdVBH0mH07fbxzTsI=;
 b=QqZrNzj6puGqMpd/TpeiPUNMxuLw2nWLoxVXJnfEsVb8fXKVL6WmN4q7tYFErdTy+F+O
 R6GjIZ8/RhNyURW69dPJBD6voD24vhCk9Dmfylo3ECZNjwRQzBqIRFH2oXO4vcQd5P7J
 1QNTxoYZTM0xO0l/Ny41uSW1fed1J1SlcFoi+9fUgp40LE+Y6kqSUNPWil4dcSOf/RbL
 yl4S32kOnCf4JMO1GQlX9DNxuNXAd+O8Cp1tUD7XCtA+R8oOBocbckKn+dQCJQlKKqdX
 yRijoczpaJ/WiTWMY+Dgg2q9LEDLTZY9QaNJebuYzEwfPHpwjTNydAz2iCV87GeqUo6V vA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk7jnrfew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:44 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJBx558025070;
 Tue, 20 Dec 2022 06:31:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mh6yy2j42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VcTd47055300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9D1020049;
 Tue, 20 Dec 2022 06:31:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 240CA20040;
 Tue, 20 Dec 2022 06:31:35 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:34 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:05 +0530
Message-Id: <20221220063109.279007-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220063109.279007-1-tsahu@linux.ibm.com>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lFFzPsg6rCYFMlz1_6z6-FMZCNMZs949
X-Proofpoint-GUID: lFFzPsg6rCYFMlz1_6z6-FMZCNMZs949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 mlxlogscore=978 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200054
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/8] Hugetlb: Migrating libhugetlbfs icache-hygiene
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
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
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
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 243 ++++++++++++++++++
 4 files changed, 246 insertions(+)
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
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 2d651b4aa..6f10807cd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -8,4 +8,5 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
+hugemmap15: CFLAGS+=-O0
 hugemmap06: CFLAGS+=-pthread
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
new file mode 100644
index 000000000..4730d8d18
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -0,0 +1,243 @@
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
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "cbf52afdc0eb"},
+		{}
+	},
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
