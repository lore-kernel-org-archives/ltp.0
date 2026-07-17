Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545F9C4451C
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:53:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FE623E92E9
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:53:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2073E76AE
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:53:10 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E5410600A23
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:53:09 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAg5Sn1797118
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0cOSF8fDYS5ZnULvdvmPZehvZ9HnUd7LARvWWBAqU
 ss=; b=pWCPH7RK1YvkvXOvohHSouzO7+WTYx5qdAs1rk65TkHfgr/Hq7fy0/HfD
 cUVJxRzn/zYMTRFQra+iNAv+HPlGUS0f1S9c+aYMvjZoNMFqzi+ilxWQZG7wW5Lu
 EXKLuAn2hSjfCVV47kCL+J9FD84+svLps78T2W5Rbr04YVjOxcVrbl+Uz/mkjm/d
 2qoRDTayP7e3Ea0ddQ9PAYmSRt3IK04+ek93u31NMo5PSc+cxuIrQveDLyU4eZ8J
 T+SURjW7NoHZ+tgdvzVHfnxlI/LuMszngfSnBC7InQXLAqJMpHTiZmLqALSuybYA
 mfMGncSNuwhVNCAbEdavbgo963+kw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxx7fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:53:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HBncqT001489
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:53:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgsa02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:53:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HBr3Xx27984314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 11:53:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56BA120043;
 Fri, 17 Jul 2026 11:53:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A31520040;
 Fri, 17 Jul 2026 11:53:02 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.226]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 11:53:01 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 17:22:58 +0530
Message-ID: <20260717115258.1087666-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z6yxjRzXslpFndtZStkBIJbIlpYOzUdf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfX8FhCaFPyTljP
 Gi40L6raRaUIwuTC2gCqjlR12iB0MeA6ijNF3YWs8ICcl1vQQKrLVRAqwZPwOUtYOSdpF6jCrxd
 QWy4hl1XDT80YzsGTFbUggAnVPfGAVw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfXxt+446LMar2S
 aPcR0s9GTxzg8groi6f2G+M5/KhgcwFoKLRSFIQcKKUSXmHttcvUxXW7vjzqHQ4nADXPoC1gv6N
 11RgdzOXA30ITyjT67LJjJmbRGJ3tn8WrT6KXd9XXkcbBH+Eyz0g1tKw8VDoan3tYqnixRYnPBk
 EDL2rcsSv62WhDe83njTyJH0nLJVCnOPp9koF8GiMwAb3GrYmrs5cykSlFEEy/1XQSg/VAQVym3
 UkZP/71S2n3yzrEAG6H22K2VsAyhmjI9F8TTfjNXNvlgMNryYl9ocuYmIGGDIqFTp3RZS0/YClO
 QahKHtijq8zwCD+yZCX4oCH3+60GSf1cdB+dnMxIERJM/IMFu3DDKpIqoSbOEWClxCT/CZ9vRXl
 twy2C4UmSwgdS5RtyhOhZZ/PJ9bipWJ+YUo+ahuCaoL6eWlrAALV/xZorn+EZKKcBJuNCuOpBAs
 jTclOWvIml7Ct4XFv7w==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5a17a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=GRDrsndCclCwDrQ3hkYA:9
X-Proofpoint-ORIG-GUID: Z6yxjRzXslpFndtZStkBIJbIlpYOzUdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170118
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap36: Migrate the
 libhugetlbfs/testcases/truncate_above_4GB.c test
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  | 160 ++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8ee0e6f82..5ea76df35 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -37,6 +37,7 @@ hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
 hugemmap35 hugemmap35
+hugemmap36 hugemmap36
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0e59035df..1585b35bd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -37,6 +37,7 @@
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugemmap/hugemmap35
+/hugetlb/hugemmap/hugemmap36
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
new file mode 100644
index 000000000..b48a34f59
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -0,0 +1,160 @@
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
+ *
+ * Requires root to mount hugetlbfs.
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
+	test_pass = -1;
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
+	if (sigsetjmp(sig_escape, 1) == 0) {
+		if (*pi != 1) {
+			tst_res(TFAIL, "Data 1 has changed!");
+			goto cleanup;
+		}
+	} else if (test_pass == -1) {
+		tst_res(TFAIL, "Unexpected SIGBUS on low-offset page (kernel bug present)");
+		goto cleanup;
+	}
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
