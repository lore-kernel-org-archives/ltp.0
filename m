Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A9EC46467
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:23:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6862B3CCE00
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:23:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7883CCDD2
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:58 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6224310006AB
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:56 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304CLfgk002648; Wed, 4 Jan 2023 12:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H5TPspvHGGosCpimHMZiTVno5pWs6cTO8QIjSVrB4AM=;
 b=dnmAf/5wa4UPHNpoyEb9vAuqs/FBSlwemC/38R+P98uld761AQDcBv6UU3d1UvzKg/43
 yofCiDPWgpPf33+2tRDS4LSdBzB6nvYAKvOdUivOL81jkuIcUw236WP4q1aP2P1RvsEf
 RvssIOCgN1vKHSIAgUk3FtzM255MjoI4RTTDSTx9bw+TKHR45EA3npLntxl4Hmj/pqXM
 /XdwYMKb73djTPAK0xVcKrWwLViGEuaCOuuSwhKlfymzrt16DJ3hY1lswHeulYGPcNYk
 AeWSS2DQN7SubTlk7TsZYzjQy4NLrjmTXyDN578z4t7kCPurPdN+vc/0+fZlnlrQ+/sI wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw9d480t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CMsMM006444;
 Wed, 4 Jan 2023 12:22:54 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw9d480sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:54 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303JUKKo023379;
 Wed, 4 Jan 2023 12:22:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6buj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMmUx41091568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5218E20049;
 Wed,  4 Jan 2023 12:22:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCEC520043;
 Wed,  4 Jan 2023 12:22:44 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:44 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:15 +0530
Message-Id: <20230104122224.369467-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kHnagEeYceoFSAZVlHIUDUAofF73OQ3a
X-Proofpoint-ORIG-GUID: qm9IsbwITIx0pM003BS87IUXL4ui1qsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=792 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/13] Hugetlb: Migrating libhugetlbfs mprotect
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

Migrating the libhugetlbfs/testcases/mprotect.c test

Test Description: This test uses mprotect to change protection of
hugepage mapping and perform read/write operation. It checks if the
operation results in expected behaviour as per the protection.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 226 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   9 +
 4 files changed, 237 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8e80db140..8ade3c9ec 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -24,6 +24,7 @@ hugemmap19 hugemmap19
 hugemmap20 hugemmap20
 hugemmap21 hugemmap21
 hugemmap22 hugemmap22
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
index 000000000..dcb9abff7
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * This test uses mprotect to change protection of hugepage mapping and
+ * perform read/write operation. It checks if the operation results in
+ * expected behaviour as per the protection.
+ */
+#include <setjmp.h>
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define RANDOM_CONSTANT 0x1234ABCD
+
+static int fd = -1;
+static sigjmp_buf sig_escape;
+static void *sig_expected = MAP_FAILED;
+static long hpage_size;
+static void *addr;
+static struct testcase {
+	char *tname;
+	unsigned long len1;
+	int prot1;
+	char *prot1_str;
+	unsigned long len2;
+	int prot2;
+	char *prot2_str;
+} tcases[] = {
+	{"R->RW", 1, PROT_READ, "PROT_READ",
+		1, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"},
+
+	{"RW->R", 1, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE",
+		1, PROT_READ, "PROT_READ"},
+
+	{"R->RW 1/2", 2, PROT_READ, "PROT_READ",
+		1, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"},
+
+	{"RW->R 1/2", 2, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE",
+		1, PROT_READ, "PROT_READ"},
+
+	{"NONE->R", 1, PROT_NONE, "PROT_NONE",
+		1, PROT_READ, "PROT_READ"},
+
+	{"NONE->RW", 1, PROT_NONE, "PROT_NONE",
+		1, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"},
+};
+
+static void sig_handler(int signum, siginfo_t *si, void *uc)
+{
+	(void)uc;
+	if (signum == SIGSEGV) {
+		tst_res(TINFO, "SIGSEGV at %p (sig_expected=%p)", si->si_addr,
+		       sig_expected);
+		if (si->si_addr == sig_expected)
+			siglongjmp(sig_escape, 1);
+		tst_res(TFAIL, "SIGSEGV somewhere unexpected");
+	} else
+		tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
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
+	tst_res(TINFO, "Read back %lu", x);
+	barrier();
+	sig_expected = MAP_FAILED;
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
+static int test_prot(void *p, int prot, char *prot_str)
+{
+	int r, w;
+
+	r = test_read(p);
+	tst_res(TINFO, "On Read: %d", r);
+	w = test_write(p, RANDOM_CONSTANT);
+	tst_res(TINFO, "On Write: %d", w);
+
+	if (prot & PROT_READ) {
+		if (r != 0) {
+			tst_res(TFAIL, "read failed on mmap(prot %s)", prot_str);
+			return -1;
+		}
+
+	} else {
+		if (r != -1) {
+			tst_res(TFAIL, "read succeeded on mmap(prot %s)", prot_str);
+			return -1;
+		}
+	}
+
+	if (prot & PROT_WRITE) {
+		switch (w) {
+		case -1:
+			tst_res(TFAIL, "write failed on mmap(prot %s)", prot_str);
+			return -1;
+		case 0:
+			break;
+		case 1:
+			tst_res(TFAIL, "write mismatch on mmap(prot %s)", prot_str);
+			return -1;
+		default:
+			tst_res(TWARN, "Bug in test");
+			return -1;
+		}
+	} else {
+		switch (w) {
+		case -1:
+			break;
+		case 0:
+			tst_res(TFAIL, "write succeeded on mmap(prot %s)", prot_str);
+			return -1;
+		case 1:
+			tst_res(TFAIL, "write mismatch on mmap(prot %s)", prot_str);
+			return -1;
+		default:
+			tst_res(TWARN, "Bug in test");
+			break;
+		}
+	}
+	return 0;
+}
+
+static void run_test(unsigned int num)
+{
+	void *p;
+	int ret;
+
+	tst_res(TINFO, "Test Name: %s", tcases[num].tname);
+
+	p = SAFE_MMAP(NULL, tcases[num].len1*hpage_size,
+			tcases[num].prot1, MAP_SHARED, fd, 0);
+
+	ret = test_prot(p, tcases[num].prot1, tcases[num].prot1_str);
+	if (ret)
+		goto cleanup;
+	ret = mprotect(p, tcases[num].len2*hpage_size, tcases[num].prot2);
+	if (ret != 0) {
+		tst_res(TFAIL|TERRNO, "%s: mprotect(prot %s)",
+				tcases[num].tname, tcases[num].prot2_str);
+		goto cleanup;
+	}
+
+	ret = test_prot(p, tcases[num].prot2, tcases[num].prot2_str);
+	if (ret)
+		goto cleanup;
+	if (tcases[num].len2 < tcases[num].len1)
+		ret = test_prot(p + tcases[num].len2*hpage_size, tcases[num].prot1,
+				tcases[num].prot1_str);
+
+	tst_res(TPASS, "Successfully tested mprotect %s", tcases[num].tname);
+cleanup:
+	SAFE_MUNMAP(p, tcases[num].len1*hpage_size);
+}
+
+static void setup(void)
+{
+	struct sigaction sa = {
+		.sa_sigaction = sig_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	hpage_size = tst_get_hugepage_size();
+	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	addr = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	memset(addr, 0, hpage_size);
+	SAFE_MUNMAP(addr, hpage_size);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(addr+hpage_size, hpage_size);
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index a4300f40f..efca65cd6 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -30,6 +30,15 @@
 #define SHM_HUGETLB	04000	/* segment is mapped via hugetlb */
 #endif
 
+#ifndef barrier
+# ifdef mb
+	/* Redefining the mb() */
+#   define barrier() mb()
+# else
+#   define barrier() __asm__ __volatile__ ("" : : : "memory")
+# endif
+#endif
+
 /*
  * to get the lower nine permission bits
  * from shmid_ds.ipc_perm.mode
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
