Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A08E63FE0
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 16:54:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05B4E3E29F8
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 18:54:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEF243E2175
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 18:53:58 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD51A200339
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 18:53:57 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634DDYrq4193079; Sat, 4 Apr 2026 16:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=sjhhTXEBwDISydHNZZ6RpevCz/y04m5v9Qu+SWn3H
 0A=; b=mWlRGdSAJEyMp9fzg9R7gT7Z4rKtB9Zov9qno/QOei4Q1YZIDCSupyOhP
 cUMaV63logyEDmiPF82GLxLNy8+Bvw4ZkbQasDiLJRvQnYHYJulQ3AdzczJ9MTVy
 MShYxGkGT+HtCoYZ3PWL8Gwfd7jwGaiBFNwyhPvfHE58x7Uo+wChAzHM0MyStzaO
 pq2bAKsw8UvQigTmmQI5YC3kcBPuBf+xQyBeQEfgbpuq79qqGu3+rtT3TdNcQjTK
 7PTpsj/0zI5QsSp+p1cyD2r8CfAG7NRn2zWtO05XZrK74uucKrSJVHtyvodQt9pT
 Ign3xt0X/KYRwxF6wXIIJZNVWdT1w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9r9bjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 16:53:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 634EuFer005977;
 Sat, 4 Apr 2026 16:53:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyhykc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 16:53:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 634Grpxi60031414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Apr 2026 16:53:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA67820043;
 Sat,  4 Apr 2026 16:53:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A4AB20040;
 Sat,  4 Apr 2026 16:53:49 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.20.67]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Apr 2026 16:53:49 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 22:23:46 +0530
Message-ID: <20260404165346.1689061-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yktndNt1mIiDSO4S0xg9UQNIkcCcHBN_
X-Proofpoint-ORIG-GUID: yktndNt1mIiDSO4S0xg9UQNIkcCcHBN_
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d14224 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=h2lposdKRXGXhkCZEYUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE1OCBTYWx0ZWRfX0fnVeA7ErGmO
 Rko4aXDYgjYf8t/Zne4g9xOKyb/iW5hoiOJnYIA6DB2G8hk8B39sNrlwqTFHvBm8FSoCMqvC5Dc
 xeAalaoUkcDM5SZ3gQ1e59PUP8Ukm9UObqfzlt4CdVuBFm1EHGhb2UMUV8YskubTyXzkb6pxNVC
 xSJXkPMfxEIcEJzmn0QbHuFJMSPGTx2FA8i/Mu36+qqtSkTKKUr5rYscOOq4Hd7ABEv/jF/i8PV
 Jd3hWi2+UTpfFrDo1G4Fu/pmwlwg19YxyKF3ef6ff7qBJsHKaQXl+jZYXsb7UXCNaKs2b3NLPyH
 QxMJWzVg1urnVJfSGf64kG5e9RR5yDtOSvtL4LCV6Qt2B4hpMRir74e7EVSv/8vsNQAWs3Qf/EG
 0OZgHG05/0kyIJK0sk6rQUdb39TX2KO8j0rlTl+VY69rI2DEPv3VkpvgRTtocmaqJege9yIHgjL
 3uo0e6tJcYq8qpqR7bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040158
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap36: Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test v6
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test for a bug where truncating hugepage files at offsets >= 4GB on
32-bit systems could incorrectly truncate lower pages due to a
misconversion of hugetlb_vmtruncate_list to a prio_tree.
This test verifies that:
- Pages below 4GB remain accessible after truncation at 4GB
- Pages at or above the truncation point correctly trigger SIGBUS

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 153 ++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..bd40a7a30 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap36 hugemmap36
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..2ddef6bf1 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap36
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..7cf4c55db
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Test for a bug where truncating hugepage files at offsets >= 4GB on
+ * 32-bit systems could incorrectly truncate lower pages due to a
+ * misconversion of hugetlb_vmtruncate_list to a prio_tree.
+ *
+ * This test verifies that:
+ * - Pages below 4GB remain accessible after truncation at 4GB
+ * - Pages at or above the truncation point correctly trigger SIGBUS
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed. Don't mess with them
+ * unless you *really* know what you're doing.
+ */
+
+#define _GNU_SOURCE
+#define FOURGIG ((off64_t)0x100000000ULL)
+#define MNTPOINT "hugetlbfs/"
+
+#include <signal.h>
+#include <setjmp.h>
+#include "hugetlb.h"
+
+static int page_size;
+static long hpage_size;
+static int fd = -1;
+static long long buggy_offset;
+static volatile int test_pass;
+static sigjmp_buf sig_escape;
+
+static void sigbus_handler_fail(int signum LTP_ATTRIBUTE_UNUSED,
+				siginfo_t *si LTP_ATTRIBUTE_UNUSED,
+				void *uc LTP_ATTRIBUTE_UNUSED)
+{
+	siglongjmp(sig_escape, 17);
+}
+
+static void sigbus_handler_pass(int signum LTP_ATTRIBUTE_UNUSED,
+				siginfo_t *si LTP_ATTRIBUTE_UNUSED,
+				void *uc LTP_ATTRIBUTE_UNUSED)
+{
+	test_pass = 1;
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	void *p, *q;
+	volatile unsigned int *pi, *qi;
+
+	struct sigaction sa_pass = {
+		.sa_sigaction = sigbus_handler_pass,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	struct sigaction sa_fail = {
+		.sa_sigaction = sigbus_handler_fail,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	test_pass = 0;
+
+	buggy_offset = FOURGIG / (hpage_size / page_size);
+	buggy_offset = (long long)PALIGN(buggy_offset, hpage_size);
+
+	/* First get arena of three hpages size, at file offset 4GB */
+	q = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE,
+		      MAP_PRIVATE, fd, FOURGIG);
+	qi = q;
+	/* Touch the high page */
+	*qi = 0;
+
+	/* This part of the test makes the problem more obvious, but
+	 * is not essential.  It can't be done on segmented powerpc, where
+	 * segment restrictions prohibit us from performing such a
+	 * mapping, so skip it there. Similarly, ia64's address space
+	 * restrictions prevent this.
+	 */
+#if (defined(__powerpc__) && defined(PPC_NO_SEGMENTS)) || \
+	!defined(__powerpc__) && !defined(__powerpc64__) && \
+	!defined(__ia64__)
+	/* Replace middle hpage by tinypage mapping to trigger
+	 * nr_ptes BUG
+	 */
+	p = SAFE_MMAP(q + hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		      MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
+	pi = p;
+	/* Touch one page to allocate its page table */
+	*pi = 0;
+#endif
+
+	/* Replace top hpage by hpage mapping at confusing file offset */
+	p = SAFE_MMAP(q + 2*hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		      MAP_FIXED|MAP_PRIVATE, fd, buggy_offset);
+	pi = p;
+	/* Touch the low page with something non-zero */
+	*pi = 1;
+
+	SAFE_FTRUNCATE(fd, FOURGIG);
+
+	SAFE_SIGACTION(SIGBUS, &sa_fail, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0)
+		if (*pi != 1) {
+			tst_res(TFAIL, "Data 1 has changed!");
+			goto cleanup;
+		}
+
+	SAFE_SIGACTION(SIGBUS, &sa_pass, NULL);
+	if (sigsetjmp(sig_escape, 1) == 0) {
+		*qi;
+		tst_res(TFAIL, "Didn't SIGBUS on truncated page.");
+	}
+
+	if (test_pass)
+		tst_res(TPASS, "Expected SIGBUS");
+
+cleanup:
+	SAFE_MUNMAP(q, 3*hpage_size);
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	if (hpage_size > FOURGIG)
+		tst_brk(TCONF, "Huge page size is too large!");
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "856fc2950555"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {4, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
