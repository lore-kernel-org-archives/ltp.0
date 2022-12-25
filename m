Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE464C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B49963CB8C7
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:43:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FEEC3CB8E7
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:45 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6998A14001ED
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:43 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFcW8K003771; Sun, 25 Dec 2022 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=euMeBK8u4Dm1/V5YCK1r5UcsIKyeFoUP9SvivxAFQ2o=;
 b=coSeVFLSvBaCePfEEmRpb4RDm4j9TyIo9s0J1Tt59e9hWzSglQ69GD93hP0k86lNdUgL
 s/oak5LbTKqVSRMBf2jjPlQN8VwrHn7Ph/FOsf5njWTKJruH27nmIn6uypt3026yGsz9
 LuFHyQH3f6EwmbqBh8o8szbixU8soFBCCafNjliNLXzDjkyrwZmxR5w8XoQwXRP/uNZO
 jVJKWJcBkf1GPtubWtQ+bqHy8GIgl8CyC+qCYYobqtmQJKdOEO3ZROOPi3PSNwElm6lA
 iw2/uZuLDvTDMRuKahmR7Sc4+/1JKtWUkx4MAikHtAXAuhaMdqWGatRimrEWDD9d4cYH Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mprjcrmhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFggg2020653;
 Sun, 25 Dec 2022 15:42:42 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mprjcrmh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:41 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPEQifu014657;
 Sun, 25 Dec 2022 15:42:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mns2691r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgaf252560366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F20020043;
 Sun, 25 Dec 2022 15:42:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11B4D20040;
 Sun, 25 Dec 2022 15:42:33 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:32 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:04 +0530
Message-Id: <20221225154213.84183-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Ae_1tUWz8mCYDtfxiurTJHfuH7hoJYD
X-Proofpoint-GUID: VMvoWWYvdi2V3uXDlD8MMxtxKHnHMyX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=947 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/13] Hugetlb: Migrating libhugetlbfs mprotect
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 244 ++++++++++++++++++
 3 files changed, 246 insertions(+)
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
index 000000000..687b192ae
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -0,0 +1,244 @@
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
+
+#include <stdio.h>
+#include <sys/mount.h>
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
+#define MNTPOINT "hugetlbfs/"
+#define RANDOM_CONSTANT	0x1234ABCD
+
+static int  fd = -1;
+static sigjmp_buf sig_escape;
+static void *sig_expected = MAP_FAILED;
+static long hpage_size;
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
+static int test_mprotect(int fd, char *testname,
+			  unsigned long len1, int prot1, char *prot1_str,
+			  unsigned long len2, int prot2, char *prot2_str)
+{
+	void *p;
+	int ret;
+
+	tst_res(TINFO, "Testing %s", testname);
+	tst_res(TINFO, "Mapping with prot %s", prot1_str);
+	p = SAFE_MMAP(NULL, len1, prot1, MAP_SHARED, fd, 0);
+
+	ret = test_prot(p, prot1, prot1_str);
+	if (ret)
+		goto cleanup;
+	tst_res(TINFO, "mprotect()ing to prot %s", prot2_str);
+	ret = mprotect(p, len2, prot2);
+	if (ret != 0) {
+		tst_res(TFAIL|TERRNO, "%s: mprotect(prot %s)", testname, prot2_str);
+		goto cleanup;
+	}
+
+	ret = test_prot(p, prot2, prot2_str);
+	if (ret)
+		goto cleanup;
+	if (len2 < len1)
+		ret = test_prot(p + len2, prot1, prot1_str);
+
+cleanup:
+	SAFE_MUNMAP(p, len1);
+	return ret;
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
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	memset(p, 0, hpage_size);
+	SAFE_MUNMAP(p, hpage_size);
+
+	if (test_mprotect(fd, "R->RW", hpage_size, PROT_READ, "PROT_READ",
+		      hpage_size, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"))
+		goto cleanup;
+	if (test_mprotect(fd, "RW->R", hpage_size, PROT_READ|PROT_WRITE,
+		     "PROT_READ|PROT_WRITE", hpage_size, PROT_READ, "PROT_READ"))
+		goto cleanup;
+
+	if (test_mprotect(fd, "R->RW 1/2", 2*hpage_size, PROT_READ, "PROT_READ",
+		      hpage_size, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"))
+		goto cleanup;
+	if (test_mprotect(fd, "RW->R 1/2", 2*hpage_size, PROT_READ|PROT_WRITE,
+		      "PROT_READ|PROT_WRITE", hpage_size, PROT_READ, "PROT_READ"))
+		goto cleanup;
+
+	if (test_mprotect(fd, "NONE->R", hpage_size, PROT_NONE, "PROT_NONE",
+		      hpage_size, PROT_READ, "PROT_READ"))
+		goto cleanup;
+	if (test_mprotect(fd, "NONE->RW", hpage_size, PROT_NONE, "PROT_NONE",
+		      hpage_size, PROT_READ|PROT_WRITE, "PROT_READ|PROT_WRITE"))
+		goto cleanup;
+
+	tst_res(TPASS, "Successfully tested mprotect with hugetlb area");
+cleanup:
+	SAFE_MUNMAP(p+hpage_size, hpage_size);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
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
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
