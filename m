Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB562EDE9B8
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 12:20:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 382C13CE716
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 14:20:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62B4E3CB327
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 14:13:55 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41516200979
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 14:13:53 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CC7B8h006850
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 12:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pJptRASp/+M8I1NPbCyHPSiSfWXJpFqjYZqyvOwhNgM=;
 b=FvIARBu/D5YIhdjO+dPMfwJMYY56ZMGkr3Pxk6g8w2jhbD8AQF6O6sr23WNCt6+zKvO2
 k1/lBLTkbrEGGhQpUN0Mv0Au+xSx1bFfrOIengxaoXlLxscTRCSHkKodQa5zjBmHDV3m
 iKl+lgRye5CSLNbzB1lG6wfyVx/JMVUz2D8SZtC0H7z9Nn+YVGABm5NH916am7TqOkmN
 4WEoiKlDRDOAwt3Sil5EUcFeLSYVizgwSfcnEx+4yBK/wAxmQpcmD2ivm4KjsqI4AaTn
 kn+hbaHaPtdmZcL3JptpAq9y+uEqLkDDyORIaosFSJN0Ic3R3L5ZeSDGxvLPFZMdu630 4w== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2p5wb8fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 12:13:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CA9ZeW024080
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 12:13:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131t3ar6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 12:13:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CCDlRE59376106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 12:13:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2F5F2005A;
 Tue, 12 Sep 2023 12:13:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1B7220043;
 Tue, 12 Sep 2023 12:13:46 +0000 (GMT)
Received: from li-c3823c75-1373-11ec-80f0-84a93810363e.ibm.com.com (unknown
 [9.171.49.141]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Sep 2023 12:13:46 +0000 (GMT)
From: Spoorthy <spoorthy@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 12 Sep 2023 17:42:38 +0530
Message-Id: <20230912121238.64692-1-spoorthy@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GR2UikwVHViNY7INb9DS4b0S_DfqcMaU
X-Proofpoint-ORIG-GUID: GR2UikwVHViNY7INb9DS4b0S_DfqcMaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=793 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120099
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 14 Sep 2023 14:20:23 +0200
Subject: [LTP] [PATCH] Hugetlb: Migrating libhugetlbfs shm-perms
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/tests/shm-perms.c test

Test Description: Test shared memory behavior when multiple threads are attached
to a segment with different permissions. A segment is created
and children attach read-only to check reservation accounting.

Signed-off-by: Spoorthy <spoorthy@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmat/hugeshmat06.c       | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..240701b2b 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -44,6 +44,7 @@ hugeshmat02 hugeshmat02 -i 5
 hugeshmat03 hugeshmat03 -i 5
 hugeshmat04 hugeshmat04 -i 5
 hugeshmat05 hugeshmat05 -i 5
+hugeshmat06 hugeshmat06
 
 hugeshmctl01 hugeshmctl01 -i 5
 hugeshmctl02 hugeshmctl02 -i 5
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..9f7fb1e76 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -39,6 +39,7 @@
 /hugetlb/hugeshmat/hugeshmat03
 /hugetlb/hugeshmat/hugeshmat04
 /hugetlb/hugeshmat/hugeshmat05
+/hugetlb/hugeshmat/hugeshmat06
 /hugetlb/hugeshmctl/hugeshmctl01
 /hugetlb/hugeshmctl/hugeshmctl02
 /hugetlb/hugeshmctl/hugeshmctl03
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
new file mode 100644
index 000000000..ca36ae2f4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test shared memory behavior when multiple threads are attached  
+ * to a segment with different permissions.  A segment is created  
+ * and children attach read-only to check reservation accounting.  
+ */
+
+
+#include "tst_safe_sysv_ipc.h"
+#include "hugetlb.h"
+
+#define SEGMENT_SIZE ((size_t) 0x4000000)
+#define SEGMENT_KEY (0x82ba15ff)
+#define STRIDE (0x200000)
+#define MNTPOINT "hugetlbfs/"
+
+static int global_shmid = -1;
+
+void *shm_addr = NULL;
+static long hpage_size;
+
+int attach_segment(size_t segsize, int shmflags, int shmperms)
+{
+    int shmid;
+    shmid = SAFE_SHMGET(SEGMENT_KEY, segsize, shmflags);
+    shm_addr = SAFE_SHMAT(shmid, shm_addr, shmperms); 
+    global_shmid = shmid;
+    return shmid;
+}
+
+static void setup(void)
+{
+    hpage_size = tst_get_hugepage_size();
+}
+
+static void run_test(void)
+{
+    char *p;
+    int i, iterations;
+    long total_hpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
+    if (hpage_size > SEGMENT_SIZE)
+        tst_res(TCONF,"Page size is too large for configured SEGMENT_SIZE");
+    
+    iterations = (total_hpages * hpage_size) / SEGMENT_SIZE + 1;
+    SAFE_MALLOC(sizeof(pid_t) * iterations);
+    attach_segment(SEGMENT_SIZE, IPC_CREAT | SHM_HUGETLB | 0640, 0);
+    p = (char *)shm_addr;
+    for (i = 0; i < 4; i++, p += STRIDE)
+        memset(p, 0x55, STRIDE);
+    
+    SAFE_SHMDT((const void *)shm_addr);
+    for (i = 0; i < iterations; i++)
+    {
+        SAFE_FORK();
+        attach_segment(0, 0, SHM_RDONLY);
+        SAFE_SHMDT((const void *)shm_addr);
+    }
+    tst_reap_children();
+    tst_res(TPASS, "Successfully tested shared memory behavior when multiple threads are attached");
+}
+
+static void cleanup(void)
+{
+    if (global_shmid >= 0)
+        SAFE_SHMCTL(global_shmid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {32, TST_NEEDS},
+};
+
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
