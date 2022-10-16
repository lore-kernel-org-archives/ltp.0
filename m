Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E3FC4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 270F23CAFDD
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:02:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C5203CAFB7
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:33 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CFB79600675
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:31 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9hZlA027013
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CTJAMLU9/n7GYbOuMm8Ot3jRCh78sLGewNEC04xMVzw=;
 b=aoGFEklGsC0IVBhr3VrsbpL7++Vplap8oUiAKIt4SLXdBRI09Ium5j+gUQs2bTIu2DLU
 eDTBc/uw2D8cEKThwLBB4K/hLoRZr1+3SuaxcSH0EIcn5RMJOMWjrYYWQ1uYkLEtlY14
 L34F6R1mMGbql7Y4LF9vOkleBsrpIwPoGVX8ypneqw/b97movP0az6SgYXf5Yg2+HBw/
 O9h8dRQzXLf7/wSsUsFo0AGuV6xKbm9mm6lHM8rT3nYK8b/BeWXV5wIltLpNV8LBIxFu
 FRVCJq9XAArkISxNadyAHpms5g6be1x2W2NhcQzPl19h0ySaJrROSKVTdqJKyjYe1KQJ 0A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86shvke9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCq1gq016870
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 3k7mg997a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxOrT48955750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED59311C050;
 Sun, 16 Oct 2022 12:59:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DFB411C04A;
 Sun, 16 Oct 2022 12:59:21 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:21 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:22 +0530
Message-Id: <20221016125731.249078-21-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rzbs04qyP8kpWoIrVtZB_to_DWkfeNz2
X-Proofpoint-GUID: Rzbs04qyP8kpWoIrVtZB_to_DWkfeNz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=878 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 20/29] Hugetlb: Migrating libhugetlbfs mprotect
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/mprotect.c test

Test Description: This test uses mprotect to change protection of
hugepage mapping and perform read/write operation. It checks if the
operation results in expected behaviour as per the protection.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 283 ++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 5d06c8679..2e8d58857 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -24,6 +24,7 @@ hugemmap19 hugemmap19
 hugemmap20 hugemmap20
 hugemmap21 hugemmap21 -T 2 -s 5
 hugemmap22 hugemmap22 -T 2 -s 5
+hugemmap23 hugemmap23
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0fd01dbce..ffd831f2e 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -23,6 +23,7 @@
 /hugetlb/hugemmap/hugemmap20
 /hugetlb/hugemmap/hugemmap21
 /hugetlb/hugemmap/hugemmap22
+/hugetlb/hugemmap/hugemmap23
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
new file mode 100644
index 000000000..e93f85669
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: mprotect
+ *
+ * Test Description: This test uses mprotect to change protection of hugepage
+ * mapping and perform read/write operation. It checks if the operation results
+ * in expected behaviour as per the protection.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
+ *
+ */
+
+/* TODO: resolve mmap ENOMEM failure on more iteration */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <setjmp.h>
+#include <signal.h>
+
+#include "hugetlb.h"
+
+#ifndef barrier
+# ifdef mb
+	/* Redefining the mb() */
+#   define barrier() mb()
+# else
+#   define barrier() __asm__ __volatile__ ("" : : : "memory")
+# endif
+#endif
+
+static char *verbose;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static sigjmp_buf sig_escape;
+static void *sig_expected = MAP_FAILED;
+static long hpage_size;
+
+static void sig_handler(int signum, siginfo_t *si, void *uc)
+{
+	(void)uc;
+	if (signum == SIGSEGV) {
+		if (verbose)
+			tst_res(TINFO, "SIGSEGV at %p (sig_expected=%p)\n", si->si_addr,
+			       sig_expected);
+		if (si->si_addr == sig_expected)
+			siglongjmp(sig_escape, 1);
+		tst_res(TFAIL, "SIGSEGV somewhere unexpected");
+		goto fail;
+	}
+	tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
+fail:
+	tst_brk(TBROK, "Once failed, No point in continue the test.");
+}
+
+static int test_read(void *p)
+{
+	volatile unsigned long *pl = p;
+	unsigned long x;
+
+	if (sigsetjmp(sig_escape, 1)) {
+		/* We got a SEGV */
+		sig_expected = MAP_FAILED;
+		return -1;
+	}
+
+	sig_expected = p;
+	barrier();
+	x = *pl;
+	if (verbose)
+		tst_res(TINFO, "Read back %lu", x);
+	barrier();
+	sig_expected = MAP_FAILED;
+	/*
+	 * gcc 5 complains about x not ever being used, the following
+	 * statement is solely here to shut it up
+	 */
+	pl = (unsigned long *)x;
+
+	return 0;
+}
+
+static int test_write(void *p, unsigned long val)
+{
+	volatile unsigned long *pl = p;
+	unsigned long x;
+
+	if (sigsetjmp(sig_escape, 1)) {
+		/* We got a SEGV */
+		sig_expected = MAP_FAILED;
+		return -1;
+	}
+
+	sig_expected = p;
+	barrier();
+	*pl = val;
+	x = *pl;
+	barrier();
+	sig_expected = MAP_FAILED;
+
+	return (x != val);
+}
+
+#define RANDOM_CONSTANT	0x1234ABCD
+
+static void test_prot(void *p, int prot)
+{
+	int r, w;
+
+	r = test_read(p);
+	if (verbose)
+		tst_res(TINFO, "On Read: %d\n", r);
+	w = test_write(p, RANDOM_CONSTANT);
+	if (verbose)
+		tst_res(TINFO, "On Write: %d\n", w);
+
+	if (prot & PROT_READ) {
+		if (r != 0) {
+			tst_res(TFAIL, "read failed on mmap(prot=%x)", prot);
+			goto fail;
+		}
+
+	} else {
+		if (r != -1) {
+			tst_res(TFAIL, "read succeeded on mmap(prot=%x)", prot);
+			goto fail;
+		}
+	}
+
+	if (prot & PROT_WRITE) {
+		switch (w) {
+		case -1:
+			tst_res(TFAIL, "write failed on mmap(prot=%x)", prot);
+			goto fail;
+		case 0:
+			break;
+		case 1:
+			tst_res(TFAIL, "write mismatch on mmap(prot=%x)", prot);
+			goto fail;
+		default:
+			tst_res(TWARN, "Bug in test");
+			goto fail;
+		}
+	} else {
+		switch (w) {
+		case -1:
+			break;
+		case 0:
+			tst_res(TFAIL, "write succeeded on mmap(prot=%x)", prot);
+			goto fail;
+		case 1:
+			tst_res(TFAIL, "write mismatch on mmap(prot=%x)", prot);
+			goto fail;
+		default:
+			tst_res(TWARN, "Bug in test");
+			break;
+		}
+	}
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continue to the test");
+}
+
+static void test_mprotect(int fd, char *testname,
+			  unsigned long len1, int prot1,
+			  unsigned long len2, int prot2)
+{
+	void *p;
+	int err;
+
+	if (verbose) {
+		tst_res(TINFO, "Testing %s\n", testname);
+		tst_res(TINFO, "Mapping with prot=%x\n", prot1);
+	}
+	p = SAFE_MMAP(NULL, len1, prot1, MAP_SHARED, fd, 0);
+
+	test_prot(p, prot1);
+
+	if (verbose)
+		tst_res(TINFO, "mprotect()ing to prot=%x\n", prot2);
+	err = mprotect(p, len2, prot2);
+	if (err != 0) {
+		tst_res(TFAIL|TERRNO, "%s: mprotect(prot=%x)", testname, prot2);
+		goto fail;
+	}
+
+	test_prot(p, prot2);
+
+	if (len2 < len1)
+		test_prot(p + len2, prot1);
+
+	SAFE_MUNMAP(p, len1);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continue the test");
+}
+
+static void run_test(void)
+{
+	void *p;
+
+	struct sigaction sa = {
+		.sa_sigaction = sig_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	memset(p, 0, hpage_size);
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* Basic protection change tests */
+	test_mprotect(fd, "R->RW", hpage_size, PROT_READ,
+		      hpage_size, PROT_READ|PROT_WRITE);
+	test_mprotect(fd, "RW->R", hpage_size, PROT_READ|PROT_WRITE,
+		      hpage_size, PROT_READ);
+
+	/* Tests which require VMA splitting */
+	test_mprotect(fd, "R->RW 1/2", 2*hpage_size, PROT_READ,
+		      hpage_size, PROT_READ|PROT_WRITE);
+	test_mprotect(fd, "RW->R 1/2", 2*hpage_size, PROT_READ|PROT_WRITE,
+		      hpage_size, PROT_READ);
+
+	/* PROT_NONE tests */
+	test_mprotect(fd, "NONE->R", hpage_size, PROT_NONE,
+		      hpage_size, PROT_READ);
+	test_mprotect(fd, "NONE->RW", hpage_size, PROT_NONE,
+		      hpage_size, PROT_READ|PROT_WRITE);
+
+	tst_res(TPASS, "Successful");
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 2)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Run test with verbose"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
