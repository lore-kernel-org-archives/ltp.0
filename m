Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E661FD0636
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 07:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADC743E23A1
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 08:03:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32AD03E1D5C
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 08:02:51 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5EADB200AE1
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 08:02:49 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AN4kf11808765; Wed, 11 Mar 2026 07:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=BrbtC502Kp28RZKQmAnm1ZTqXMIA
 AwKbgJi894y9Xc8=; b=k+YbytkoTM8kpGxeVxVkAwhE3GcONnnJemgXsQ1AAQy6
 CqgpLCofZBrgKEWyZnWa4jfpkN9w8vmlzYGvdVA/Femev+AAtAngNytP0S/mHIsn
 Wzj1fJTfNtOVKVRhEQc/sSZiuvu59UOJWiSluE59BRDuJsSKyiYs5k7IYE/etiEr
 HFIZqtSOwYoHSNqleO3HTAhXNWDAmSAkc1H0qh519GUxp+gOQXZ43G+r/wjkOfmS
 aDytRriiI3PKERmyCvDD1duFjpYL9hoPInbdr4WW7snFKlXWT+PGn9TdHw0QIG3l
 WsBNCMJarK0YZ3PKvwPyce71o+0v5JRE09gKwJbEKg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywekts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 07:02:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B6fqtk029850;
 Wed, 11 Mar 2026 07:02:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6us126-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 07:02:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62B72g3O41156968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 07:02:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6A9C20040;
 Wed, 11 Mar 2026 07:02:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 033DB20065;
 Wed, 11 Mar 2026 07:02:41 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.22.216]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2026 07:02:40 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 11 Mar 2026 12:32:31 +0530
Message-ID: <20260311070235.206921-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1OCBTYWx0ZWRfX65TWLGYiNjhV
 eA4Hn9ZMqhk7L+CL+yL7zogEoTCtsuJU4bAK3AfdQHXopGjn6kYXrwaEvfUhgElxlu2+TLgXrwJ
 Fqr7vhmNpUaVeyMAFpunPKv6zthU3OZfT2sR/1QTcPvPiQFwXEpSRFRmmtbhMrugKtN+Tqj5pxV
 NoU4oXgNuGnLdVolfkwyQGQwgStsMvHOqg5xQgEvV9BWFgPNVPufO3gHCFupJIBQNHkUUvn7XPF
 Ft3neu82v43V49GBMCkjymo9wPS5hqbdo7HyV2wdW9G2TJyuqBxYhUFWujcSaiHuz6NUZzeR5Xq
 6Dg0xcCwCW5ozW67it8J7glfNBb0vFbJFc2JZSMi/jyB8l2//7pgbeLt7mN9FBbcZGJb/WqCNEN
 AIie58ENHZCHvBJg65uL5RxTOK22oulRci9eu7g44vghQJzMLDdfiDLQul4UDQhXjMQcdWrvAPy
 HjbomjRZPpgMkEpTqfg==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b11397 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=qf4gfuq51q0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mPJGfP9KAAAA:20
 a=VnNF1IyMAAAA:8 a=qlThe8qJfWNvhCPcO8wA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: v2L2bUIolzhT5Uwdrn1J1qVoptcpnBIk
X-Proofpoint-ORIG-GUID: v2L2bUIolzhT5Uwdrn1J1qVoptcpnBIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110058
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH]  [PATCH V6] syscalls: ipc: Add shmget hugepage test
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
Content-Type: multipart/mixed; boundary="===============1824249566=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1824249566==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Changes in v6:
- Added "tst_test.h" and "tst_hugepage.h" instead of hugetlb.h
- Modified code to use TEST() macro

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/ipc/shmget/.gitignore     |  1 +
 .../kernel/syscalls/ipc/shmget/shmget07.c     | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmget/shmget07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2179e007c..1d5e0f214 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1547,6 +1547,7 @@ shmget03 shmget03
 shmget04 shmget04
 shmget05 shmget05
 shmget06 shmget06
+shmget07 shmget07
 
 shutdown01 shutdown01
 shutdown02 shutdown02
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
index 768d1c69d..23ba002b5 100644
--- a/testcases/kernel/syscalls/ipc/shmget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
@@ -3,3 +3,4 @@
 /shmget04
 /shmget05
 /shmget06
+/shmget07
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget07.c b/testcases/kernel/syscalls/ipc/shmget/shmget07.c
new file mode 100644
index 000000000..c6e4068d8
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget07.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ */
+
+/*\
+ * [Descripiton]
+ *
+ * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/shm-getraw.c
+ *
+ * The test creates a shared memory segment, then attaches it to the process’s address space.
+ * It writes a string to the shared memory from raw device and detaches the shared memory
+ * segment and finally removes it.
+ * The purpose of this test is to ensure that the shared memory subsystem is working correctly
+ * with hugepages. It checks that shared memory segments can be created, attached, written to,
+ * read from, detached, and removed without errors
+ *
+ */
+
+#include "tst_test.h"
+#include "tst_hugepage.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define NR_HUGEPAGES 2
+
+static int shmid = -1;
+static size_t size;
+static size_t i;
+
+static char *shmaddr;
+static int raw_fd;
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
+	size = hpage_size * NR_HUGEPAGES;
+	raw_fd = SAFE_OPEN("/dev/zero", O_RDONLY);
+
+	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB|SHM_R|SHM_W);
+
+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+	tst_res(TINFO, "shmaddr: %p\n", shmaddr);
+
+	/* Read a page from device and write to shm segment */
+
+	for (i = 0; i < size; i += hpage_size) {
+		TEST(read(raw_fd, shmaddr, hpage_size));
+		if (TST_RET != hpage_size)
+			tst_res(TFAIL | TERRNO, "Can't read full page from raw device!");
+		else
+			tst_res(TPASS, "Read full page from raw device");
+	}
+
+	SAFE_SHMDT(shmaddr);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.53.0


--===============1824249566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1824249566==--
