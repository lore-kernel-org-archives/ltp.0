Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FB1C44515
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 15:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0573E92F3
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 17:32:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DECCF3CD61D
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 17:31:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CCEC200AE2
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 17:31:42 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HEBjtd359575
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=NDJJIH1qBYJbgqYYEdJGVxzCFWYKxz3FjyNYzDtyL
 90=; b=A9NokyZGvtQFeFjPqLYhqx2s/XZ79xHCciyxlOWiM7G+VWMJ3NxNh4uS9
 ZOvbaUrtEFlHTtv5YPt5fHZKlGDK+cihhaqYaA1zCH/izqOctY+D/qmpwJdID7Mf
 ameumFe2/80/WPOOtXSOJ3V7z0rcObkaksalChDTn8TFLci7IzGvzHXCCwPtW8oC
 qgl5VlTYxrD6WVB/FE5DtcdlA4APn33o6yuXxbrJj8bQlhCk7ogzEK8x3FLcRkq4
 RyCeBXDsEXvn8XtUOzNOPvBU1Sb+68KrdM5ry50koZHqm6y/56azoHHiWeYXkSb/
 n7GouGIFwBdPx+XmXW3ryF3m83/5Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33qqh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:31:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HFJaE2031236
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:31:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwjd2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:31:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HFVZQv46793146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 15:31:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C796220040;
 Fri, 17 Jul 2026 15:31:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC06E20043;
 Fri, 17 Jul 2026 15:31:34 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.17.226]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 15:31:34 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 21:01:31 +0530
Message-ID: <20260717153131.1154339-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1NSBTYWx0ZWRfXw5TPK1cNnWnK
 qvibO3Jkj1i/NHHNxr0xDgjTcL4rJ3jDWTlJiPeMkzKSRmZD9ilP4oBtH0l1WCgdwSJmKrpFLJd
 f5xUcJn9NlNFsoPyMtUy6xYkcGgWgR0=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a4add cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=MZnfsXp6x2x5Sfp_G2oA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 5Yrl1b8CK0YfzPIBzKbwEeRKBfedY3vY
X-Proofpoint-ORIG-GUID: 5Yrl1b8CK0YfzPIBzKbwEeRKBfedY3vY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1NSBTYWx0ZWRfX94TA+dfDL6oi
 X1c3c3qgXCWMgB9xf4xFp3gr32nNWH5hNYimLIPXIvLui1jcQi42MxjxL7s95CZchh2HiKTalit
 wviluXRZzmCXmCeaULYgnToU6xUze0G9RQWYc+SYlQ9c/Ijd47P4wUB8Rep+OhnXwvhEslqtd33
 iir/iFmVagdeMV2QI7E0058YNZEHzgoNtG0csq5BI5DyjKadr3dbShKyA+vvucePoECAIJB7fU+
 R/CTgks0YGN1p7U9Y3sodH2xLIQ4wEs4FzQRmBIT3qwdaXv3rn3/0M8KIPOs4q9b3li5h6XRZIf
 7RdI93bSN7C8lllZme4n+0HijGeUw7kHpmP6250eaQi6bWEd4Ds0auVv6wyAsjJUnXcJbWvhAnl
 BhTr+04katGFKOlep59G8j0up5vl3n0iciEa1yEdEjoNFkn99HR6nLkUNaDxKxWGFzAO5KJYDwY
 KWcQVXB8cDbgDdSMfYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170155
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap/hugemmap35: migrate libhugetlbfs test
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap38.c  | 128 ++++++++++++++++++
 3 files changed, 130 insertions(+)
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
index 000000000..4cefb5f78
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
@@ -0,0 +1,128 @@
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
