Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34595C4450A
	for <ltp@archiver.kernel.org>; Sat, 18 Jul 2026 06:38:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2059D3E24A5
	for <ltp@archiver.kernel.org>; Sat, 18 Jul 2026 08:38:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 149CF3C9911
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 08:38:28 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E41C60008A
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 08:38:27 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66I3XX5a3888322
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 06:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=IOKCB3EAlXCzz935Wi5YvzdpCiZDvKSWOfEUNIuLD
 mI=; b=FUd/OWj23ABgA0qmKYVwP6uRq/4VllZDo1ybkrBmCTrs/Z6Hnacgvbngc
 JvTcLXZeHw953bP480foty89dxwkJ3hz1fB3bdy5lzH6tm8rLt5w3TXWw88xzZVc
 4V6YhyjCJrMtt89huM0a74+5v5j3e71Vy8igUnhElCteLNABLHFJr3gJv2pDrgYS
 oUgQr7XvVZyLMeN9kyxGpmtxHCZ7bxV+dwzc6C7IyECtwHnT3FBkBsAxasZb905Y
 UBICnV2HDa1K1E1cfhGcdREkivOfWQ13po3fqGwZzS+NZke8TjXeVTl74Yz5ZRNZ
 MpjSNU7uSTl5qAdr2XMIJg9+cDzHQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg1pa8cjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 06:38:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66I6Z50C019466
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 06:38:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgvqrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 06:38:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66I6cLWq20119906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Jul 2026 06:38:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F01720043;
 Sat, 18 Jul 2026 06:38:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0110A20040;
 Sat, 18 Jul 2026 06:38:20 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.189]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Jul 2026 06:38:19 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 18 Jul 2026 12:08:15 +0530
Message-ID: <20260718063815.1260992-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDA2MiBTYWx0ZWRfX97vWJPWJ9ocI
 Dq4NTfVW/nl+vcxdJCR1CUm3P1UtgBz51mo3tfdzht+3Pr9zOwANg0w7ahCNcWxe29RZwVtUZFj
 4BF9Klhj434kUgVpEZ9ddHwiRYdTvlkwtl9zIu7md2WaMUVSMS6ijtMIeJcafzLmBua5qbnEri6
 XoyqY2+BwPctop0T+zJ5bL853cM7yOq6bmnyum1ergSjEuv+aFNuni/hHii/NeCbwiyXopJslht
 EuhgkqLvNvF1eQz2DPV3UNHzOf9YCA9D+M0fnlP3KrkumYpAvux3rEqSv2cryBR/B1IfBRx5GaH
 Nik+ive9VGbAzU0Kob12r4o9l6Ea98W6c1Ah3v0CowpwO2V4lWLz+Wwyx/gCpvLruDRq3boqD9o
 CI6QvIdWQyXJezeo5hnVfyIJ+02wn1mVCKw8q2dvWGvZOaizpGZLM7l3Yfl+juvdCMaMVWUU9tr
 gvYiR1WQyDr5l9XSuXg==
X-Proofpoint-GUID: 2K9RcxTJD-amn-z8EbW0U_BuSEKxVxLn
X-Proofpoint-ORIG-GUID: 2K9RcxTJD-amn-z8EbW0U_BuSEKxVxLn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDA2MiBTYWx0ZWRfX19Va7oMa2O2L
 7vMstXtKHKM8OPs6k8flbbrwb/NU5u+Ie8N2RYQtMcyb6990Zaecw61jO/9DB9+pkGqIsIRU7io
 bxFPYWvYXzeLgQKYFLrQV6ulvsUnExY=
X-Authority-Analysis: v=2.4 cv=a/4AM0SF c=1 sm=1 tr=0 ts=6a5b1f62 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=MZnfsXp6x2x5Sfp_G2oA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180062
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap/hugemmap38: migrate libhugetlbfs test
 truncate_reserve_wraparound.c
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

This test verifies that the kernel correctly maintains hugepage reservation
accounting when truncating a hugetlbfs file. It ensures that reserved
hugepages are properly tracked through the complete lifecycle

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap38.c  | 127 ++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8ee0e6f82..9dbee8555 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -37,6 +37,7 @@ hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
 hugemmap35 hugemmap35
+hugemmap38 hugemmap38
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0e59035df..0e9547d99 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -37,6 +37,7 @@
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
 /hugetlb/hugemmap/hugemmap35
+/hugetlb/hugemmap/hugemmap38
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
new file mode 100644
index 000000000..615de72b4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
+ */
+
+/*\
+ * Test that hugepage reservation accounting is correctly maintained when
+ * truncating a hugetlbfs file. This verifies that reserved hugepages are
+ * properly tracked through the sequence of: mmap (reserves page), touch
+ * (instantiates page), truncate (releases page), and attempted access
+ * (triggers SIGBUS). A bug in i_size handling could cause the reservation
+ * count to become incorrect, leading to resource leaks or allocation failures.
+ *
+ * Requires root to mount hugetlbfs.
+ */
+
+#include <signal.h>
+#include <setjmp.h>
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1;
+
+static sigjmp_buf sig_escape;
+
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
+{
+	siglongjmp(sig_escape, 17);
+}
+
+static void run_test(void)
+{
+	volatile int sigbus_count = 0;
+	unsigned long initial_rsvd, after_map_rsvd, after_touch_rsvd;
+	unsigned long after_trunc_rsvd, after_unmap_rsvd, after_sigbus_rsvd;
+	volatile unsigned int *q;
+	void *p;
+
+	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			fd, 0);
+	q = p;
+
+	after_map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(initial_rsvd + 1, after_map_rsvd);
+	if (!TST_PASS)
+		goto windup;
+
+	*q = 0;
+	after_touch_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(initial_rsvd, after_touch_rsvd);
+	if (!TST_PASS)
+		goto windup;
+
+	SAFE_FTRUNCATE(fd, 0);
+	after_trunc_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(initial_rsvd, after_trunc_rsvd);
+	if (!TST_PASS)
+		goto windup;
+
+	if (sigsetjmp(sig_escape, 1) == 0)
+		*q; /* Fault, triggering a SIGBUS */
+	else
+		sigbus_count++;
+
+	if (sigbus_count != 1) {
+		tst_res(TFAIL, "Didn't SIGBUS after truncate");
+		goto windup;
+	}
+
+	after_sigbus_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(initial_rsvd, after_sigbus_rsvd);
+	if (!TST_PASS)
+		goto windup;
+
+windup:
+	SAFE_MUNMAP(p, hpage_size);
+	after_unmap_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(initial_rsvd, after_unmap_rsvd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+
+	struct sigaction sa = {
+		.sa_handler = sigbus_handler,
+		.sa_flags = 0,
+	};
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
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
+		{"linux-git", "ebed4bfc8da8"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {1, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
