Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A63C982EA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 08:33:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9B0E3E6C01
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 10:33:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0833E2FE6
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 10:33:18 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 18A591A00666
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 10:33:17 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N77aG82731352
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=EBxa23JjcVOjfqAbS7rakZoE8qEzl1PJQjWwk5At+
 fk=; b=eWJ560MX9SVMVk9GnghqxFEnoTgp6Kj+zvvKgPD0vLMFRz8r82DN9WHoQ
 q8pN9QrjIGs5Gf3G1TJ1VvvxnA3YydRmgbZujgRfrVMRzfLB7zt4cOs+bZp5WJsk
 tn7+v3eIsbKrgMoLCr9dUAm0oHklpVAmuiSNgrieLQV0hPhqohQlrKqDSMAnFUkX
 WvfgWnMf2H8p4+BMsDx3QEkDjdhC0AB/MsyLKEqKo4wQWRzFx59ZG5PSEnSdQJjY
 03oWDxk4h4FJFLDE4AxC+iX+oxvQSrzHSXvehmOgroIxRswzxlgju3918WByQzxu
 nIQKwI5V6L2ccIk25ES5U2BSTPk9A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2j4nu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:33:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8HiUQ4133874
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:33:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vnhwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 08:33:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N8XAAZ17433008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 08:33:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AA8920043;
 Wed, 23 Sep 2026 08:33:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F2A920040;
 Wed, 23 Sep 2026 08:33:05 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.bl1-in.ibm.com (unknown
 [9.123.11.80]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 08:33:05 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 23 Sep 2026 14:03:00 +0530
Message-ID: <20260923083300.54026-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VMbTuWlSy1-YPGVGJ19FAfD5cMHOzD-R
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab38ecb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-NR2oiCehLwdWjwvT2wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX/SRk+sqyHmec
 ApufNC5w8kgJ/W9iQmXmEZqGnlmYvMlpm+NaHKQRA4sZpI5x5IYLQljOW1ejwT1LU6CeWA2Yy8/
 K41EkEQRjTmfnwEmPkZYDP8+6eAhV4SCB7F0iXgulK3Kt4c8fTDV5NCerKb7/bVrvGPPKP4HgD2
 lxmgtrYv/ve+TZEM4kTj95deFnREKruuvdzKIG4KUwvl+eLYyOtsd9Cd8H61XezWCWbxwZBN0BG
 H8w8qeZJ91kOcUTPdhvTW0LyaWiuwNOLLPGoCBtWHGD1qabPqK4ldSXUt/iztG4Db1TAGJVIwJy
 maZf/MMEWHknEYScXIa2eIHrhldtseNJifbkV79hHkD0TRTVIIsv6VfjLKQ19Za2JOt4vJ+gQgn
 +NgiS7V6bw7JKS8yyauytsRc4oLTq0wEUpqgYnuVdeuulujHVNZpxzM/H1LZe6q7OTcQAvc4l6P
 NaVFwuj4cVnD1e2RLQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX8IZpXRTdv+JO
 d6PaT8222t4fQajNScpc4oxXZJ/fzE1TBWqMF5yWfMZ/wU858CgY/3IQcIuKIhj7R4eMmVL5wV5
 q4pe7FtjRcIMe7OYJbQaE6xZLdmEW0k=
X-Proofpoint-GUID: VMbTuWlSy1-YPGVGJ19FAfD5cMHOzD-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230031
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] hugetlb/hugeshmget: Add hugeshmget07 to test
 SHM_HUGETLB with /dev/zero read
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

Test that a hugepage-backed shared memory segment can be created,
attached, read into via /dev/zero, detached and removed without
errors.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v7 -> v8:
- Move test from syscalls/shmget/shmget07.c to hugetlb/hugeshmget/hugeshmget07.c
- Remove redundant #include "tst_hugepage.h"
- Rename raw_fd to zero_fd
- Replace TEST()/if/tst_res() block with TST_EXP_VAL()
Link to v7: https://lore.kernel.org/ltp/20260919151602.1039825-1-pavrampu@linux.ibm.com/
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget07.c     | 69 +++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 621c9718a..d090cddec 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -62,3 +62,4 @@ hugeshmget02 hugeshmget02 -i 10
 hugeshmget03 hugeshmget03 -i 10
 hugeshmget05 hugeshmget05 -i 10
 hugeshmget06 hugeshmget06 -i 10
+hugeshmget07 hugeshmget07 -i 10
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 9e706e1c8..67f9c23a5 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -55,6 +55,7 @@
 /hugetlb/hugeshmget/hugeshmget03
 /hugetlb/hugeshmget/hugeshmget05
 /hugetlb/hugeshmget/hugeshmget06
+/hugetlb/hugeshmget/hugeshmget07
 /ksm/ksm01
 /ksm/ksm02
 /ksm/ksm03
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c
new file mode 100644
index 000000000..1a85b87e4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget07.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
+ */
+
+/*\
+ * Test :manpage:`shmget(2)` shared memory segment with hugepages.
+ *
+ * A hugepage-backed shared memory segment is created and attached to
+ * the process address space. The test reads one hugepage at a time
+ * from ``/dev/zero`` directly into the shared memory region,
+ * verifying that each read delivers the full hugepage worth of data.
+ * The segment is then detached and removed.
+ *
+ * Requires root for :manpage:`shmget(2)` with ``SHM_HUGETLB``.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define NR_HUGEPAGES 2
+
+static int shmid = -1;
+static long hpage_size;
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+}
+
+static void cleanup(void)
+{
+	if (shmid >= 0)
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static void run_test(void)
+{
+	size_t i;
+	size_t size = hpage_size * NR_HUGEPAGES;
+	char *shmaddr;
+	int zero_fd;
+
+	zero_fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+
+	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB | SHM_R | SHM_W);
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p", shmaddr);
+
+	for (i = 0; i < size; i += hpage_size) {
+		TST_EXP_VAL(read(zero_fd, shmaddr + i, hpage_size),
+			(ssize_t)hpage_size);
+	}
+
+	SAFE_CLOSE(zero_fd);
+	SAFE_SHMDT(shmaddr);
+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+	shmid = -1;
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
