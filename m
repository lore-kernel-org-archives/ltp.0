Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF91CAC5A5
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 06:05:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18ED3CDCCB
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 08:05:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49C183C29E9
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:05:26 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7621D20007D
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 08:05:22 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0lEvZ007713;
 Thu, 25 Sep 2025 06:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hTpkAbgW5mseRx4Vv88QthSD9Gsq7Z2v7BKBAwByl
 VQ=; b=FGIvbEGyzSqbz6Eh7ot1CnL+0GmMu2BVoSMLo2OPLFgqr1c1sHS+ZAnLk
 YBCkwRPNz+W1Csg7lrw0KL/LpzzDwK6mFiFQvg5zkiD1fjSXZd65ubNCZT786AEf
 mXgQqZt4WW4mg+s7DjXZvQEPRbdE1M7eLMIBUyG8b+UE4wegziv+ieHEuXQ4Aomt
 zwmoNDfMktvyuTgmBvRwyOrll4YVEwr3dLCt5d6tEcgtzXb4QPDeE1P1pO5GBQRo
 1zGkfSTIROMOrSy1d6ciiXGM95t+0SMV6t1LnvTdYooIyoBSsVk1AP5w73nkHkSG
 tEMlwlIk3X0oZW25JU0iZIDublsxQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0juqju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:05:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P5AbbJ031153;
 Thu, 25 Sep 2025 06:05:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vddbev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 06:05:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58P65Hwf61473156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 06:05:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1E3F2004B;
 Thu, 25 Sep 2025 06:05:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C56F920040;
 Thu, 25 Sep 2025 06:05:16 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.in.ibm.com (unknown
 [9.109.212.52]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 06:05:16 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 25 Sep 2025 11:35:14 +0530
Message-ID: <20250925060514.1009709-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX6vHVVJjtd4kS
 EBXtc1rvfW7DQe8vb3ZijA9edFgWUvnQEa3Lj4pNqggE6G0bzkQKDAP0rVRN/58XF+mfqCx8M81
 MxIFThkrvCO+y7Cn4qY4iTmVuEMSsFduB7ZdhxKi//FB48MD6PAipuFlZY0kNIM788pOLBRNprt
 iBtjvrpsbD/GLnKeQAhYOxGeOWALFLWvJDCOARnTq2yZalFjIQQH6lqL6AKj25UseUAoxWbC82P
 W67DZsc+rASqd7zjU8Acd8Xl4nWPKpxCTKTfNvG8dLCRIRdQuBEIp6fi9wsTQPhjDi+TzK48oXR
 gzC710ZB7RQVOjJ9vZssZKgLfRoqu0Iyubihk22QQIDrrqTWF/fECiw50iJLd5Hs0zCi8/FJ54Y
 DCYOK64u
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d4dba0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=Rdwaqp5c8bHwGkfL22sA:9
X-Proofpoint-ORIG-GUID: MQ882GVhTZIeQzDmAD8dIkoVw21oJFKz
X-Proofpoint-GUID: MQ882GVhTZIeQzDmAD8dIkoVw21oJFKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH v4] Hugetlb: Migrating libhugetlbfs test
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
Cc: pavrampu@linux.ibm.com, Pavithra <pavrampu@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:
Test to verify the Hugepages_Rsvd before and after mmap, truncate and sigbus operations.
At one stage, improper handling of tests against i_size could mess
up accounting of reserved hugepages on certain truncate operations.

Tested and verified that test passes for iterations: i10

Signed-off-by: Pavithra <pavrampu@linux.vnet.ibm.com>
---
Changes in v4:
- Moved local variables to run_test()
- Moved signal handler setup to setup()
- Added check for after_touch_rsvd == initial_rsvd
- Modified TFAIL messages based on review comments 
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap35.c  | 130 ++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 000000000..b7d63fd1a
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ *[Descripiton]
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
+static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t *si LTP_ATTRIBUTE_UNUSED, void *uc LTP_ATTRIBUTE_UNUSED)
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
+	tst_res(TINFO, "Reserve count after map: %lu", after_map_rsvd);
+
+	*q = 0;
+	after_touch_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after touch: %lu", after_touch_rsvd);
+
+	if (after_touch_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved after touch %lu instead of %lu", after_touch_rsvd, initial_rsvd);
+		goto windup;
+	}
+
+	SAFE_FTRUNCATE(fd, 0);
+	after_trunc_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after truncate: %lu", after_trunc_rsvd);
+
+	if (after_trunc_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved after truncate %lu instead of %lu", after_trunc_rsvd, initial_rsvd);
+		goto windup;
+	}
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
+	tst_res(TINFO, "Reserve count after sigbus: %lu", after_sigbus_rsvd);
+
+	if (after_sigbus_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserved after SIGBUS %lu instead of %lu", after_sigbus_rsvd, initial_rsvd);
+		goto windup;
+	}
+
+	tst_res(TPASS, "Test passed!");
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
+		.sa_sigaction = sigbus_handler,
+		.sa_flags = SA_SIGINFO,
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
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
