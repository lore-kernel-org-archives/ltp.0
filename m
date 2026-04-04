Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A700E63FEA
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 17:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9A723E29F5
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 19:16:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876F33E1C3E
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 19:16:27 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9FAB81A00783
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 19:16:25 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634EOcWM425055; Sat, 4 Apr 2026 17:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=N+BLjWZbKYjlw+F1u96ixTypglDY652VN/BBiTrhH
 Sc=; b=Ta98Ri+EKN+Vu1DTjM3KmVqX9B/nhkK5o5qfslhPaLH9QEPD+RuOT/KdV
 hty4DA06R77HmLUMsxiFcYxJfGLwCCrKI0SEeA3vZCA5YjInjeDiMLdKAg0Ogsg5
 q3994iR5Fk5iquHAp9SJd6nSslkz/46bFUY/PNAqj4vrhkwkz7rL5PdcGb6FJk8a
 U+mzdHmnPiNFAfbuwFSotA7lUw+uWBZ78otCj1GR/bPIB6xeuIhMrK9cQh1LaPgo
 kxgCrFlBK7/nv+mEuhBlODy/ftoKTdxfxQ0L8g4tYwt7qRWIrckuT0zhcZFjyUtB
 II6OlPA+M+Sb7y2nAM5gQfBKzPG4w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat51shp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 17:16:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 634EpZkN021722;
 Sat, 4 Apr 2026 17:16:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sat24wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 17:16:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 634HGIdt14745994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Apr 2026 17:16:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD50320049;
 Sat,  4 Apr 2026 17:16:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9275620040;
 Sat,  4 Apr 2026 17:16:17 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.20.67]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Apr 2026 17:16:17 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  4 Apr 2026 22:46:14 +0530
Message-ID: <20260404171614.1695371-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d14767 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=MZnfsXp6x2x5Sfp_G2oA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: yBKWZpk11HW3iV5ztVier39nh6TwZXwH
X-Proofpoint-ORIG-GUID: yBKWZpk11HW3iV5ztVier39nh6TwZXwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE1OCBTYWx0ZWRfX88LPJ+OxqDcp
 oHVUsV04s6+2i/02y6kh1bon5HSVRRzJNe4bZuP/D3ZxoEr2KDSzhus9Ha+ubURUUVI9GQe7Ylj
 0TEdZhD3luqtWmirr66J613AUQIn7OKM89ngY89BtMPKYr/IsaUjwE3z8fss0Ttc424pjVWDx5Q
 S7EN9jKfc83l+6UAqioGpO1ADhdw5wDyOWXaLWJR7SN3I39fblGa5RcZ2XvGcXSnUUBGX5rwZmt
 eqB289xHtgvLJZsjhhvt4LbBKyEeL1a4Diy+cJFQnPKKErlDHoCaz59u098/GnZepisCow4H3Nc
 NlMuqJEcc//nnwI0+LuGO22oo/YdFfTYtuFDXaNBh/89E4h+B+R6hLTB2P+QA9FfGLX575WsVoR
 Lg/+YgZEbff0lgP3o6eLmq6IadhhKzxxH6vQI0r4WYIV9/8aCbW3VwmRpqfHFEdT+irvdPWFie/
 qEkyBvs9mQlGKEPN27g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040158
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap35: Migrating libhugetlbfs test v6
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap35.c  | 124 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..8ee0e6f82 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap35 hugemmap35
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..0e59035df 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap35
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
new file mode 100644
index 000000000..4b46bdbaa
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
+ *
+ * Test that hugepage reservation accounting is correctly maintained when
+ * truncating a hugetlbfs file. This verifies that reserved hugepages are
+ * properly tracked through the sequence of: mmap (reserves page), touch
+ * (instantiates page), truncate (releases page), and attempted access
+ * (triggers SIGBUS). A bug in i_size handling could cause the reservation
+ * count to become incorrect, leading to resource leaks or allocation failures.
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
+
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
+	.hugepages = {4, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
