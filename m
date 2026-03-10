Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFEBEB104A
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 11:21:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 523D23E57EF
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 12:21:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4516B3CD52A
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:21:15 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDCD16009E0
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:21:12 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AA9MJP1609981; Tue, 10 Mar 2026 11:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=M4KhulekpfOp/3hpWHbue4gWxZ/50QW5qT6TiE+qg
 Mw=; b=kg7IFHvzX3pWUh6SnozQeX7YBE3fjVJJaKzBp0qlpeqRJBXkqI1l1iBmt
 ktKLYvDLGC+iU2YIPYA/n7HHnydOKpMpSNU2CRjNFlG+c3FDrcyBK8HtipduykUL
 xf+5Rx1nRl85g1ka/5I64g8g80nXYWErltye5NjLdeBgoJ38wqkFbjIfHwafEq20
 DCBD0ee8AdkHw2cb/9Szu91uA59b7foWj552jWBVnVDcp+BQMAcl64BzpAXAf3rx
 Ws4c6ELVjyq0TTEexrpdwd7NshA7ZYsqDS2V47SPvOa/ZW4aB/MBwz2boIcV/zx8
 e9Hhv0PWJoMG1pFTf/cxp7BPpCBhg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuna7vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 11:21:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A7K7fH024657;
 Tue, 10 Mar 2026 11:21:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk0mje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 11:21:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62ABL6Qx23331088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 11:21:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38F182004B;
 Tue, 10 Mar 2026 11:21:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20FCC20040;
 Tue, 10 Mar 2026 11:21:02 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.23.32]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 11:21:00 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 10 Mar 2026 16:50:44 +0530
Message-ID: <20260310112044.123827-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nh_MpOf8nyiwGLseLhx_3Ckjtj62duCf
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69affea6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mPJGfP9KAAAA:20 a=VnNF1IyMAAAA:8
 a=RDo9DhFS7UVv00m3CQsA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5NSBTYWx0ZWRfXw3woFriiNyVP
 xBKfTacwS9xt/Sp13RZt0nTBgZ9/+Qff1hvsl0c17h6/V4P5AYdT8o+MCk0gN2OFDDkhM3iMtBl
 6cYrEK91rjjaQSVpKgZRDUiTBM0X6Mv4SjejDGWs1cHWx/YVeRPna7p4eCN355FcPY2XgLu/2aR
 dhUIjFa0yCFpmd4PB4c2IuYDOFZa0eY76pBJqL5HKGXWctbQsGVN2/MuiBKqFasqwIqXNJq4sml
 MMk1oZznV8xH9u6Vbz/zfBY+RfhJ2Y8HZ35b7/soDerpvbenUbwxJx+hdUkj1feufP/4Dwg2dVy
 4lOy12wZkfObyhsEkh4V0O/w4LBjKonqDo2I6zEwzlqIeOFD4zaJ+7LURjh6ie4k8VAV2uUdSmU
 eIg6PMQXV6HmD0OynDFeuQ0+gTCY3uijEALFch+5IWKwpakbzo0oPWvCXofYDVNAT/j6SY7qBsK
 pBlUxkDbikRnjLsFFzg==
X-Proofpoint-ORIG-GUID: nh_MpOf8nyiwGLseLhx_3Ckjtj62duCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100095
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH] [PATCH v5] Hugetlb: Migrating libhugetlbfs
 test truncate_reserve_wraparound.c
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

Changes in v5:
- removed unused parameters from sigbus_handler call
- Added check for after_mmap_rsvd == initial_rsvd + 1
- Used TST_EXP_EQ_LU for comparsion

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap35.c  | 125 ++++++++++++++++++
 3 files changed, 127 insertions(+)
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
index 000000000..dc678661e
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * [Description]
+ *
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
+ *
+ * At one stage, improper handling of tests against i_size could mess
+ * up accounting of reserved hugepages on certain truncate
+ * operations.
+ *
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
+
+	static int sigbus_count;
+	unsigned long initial_rsvd, after_map_rsvd, after_touch_rsvd;
+	unsigned long after_trunc_rsvd, after_unmap_rsvd, after_sigbus_rsvd;
+	volatile unsigned int *q;
+	void *p;
+
+	sigbus_count = 0;
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
+	tst_res(TINFO, "Reserve count after munmap: %lu", after_unmap_rsvd);
+
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
+	if (fd >= 0)
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
