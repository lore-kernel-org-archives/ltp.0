Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7486FA3757
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 13:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 227AB3C2805
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 15:41:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39E223C0BBD
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 15:41:32 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=spoorthy@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 491C8146609A
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 15:41:30 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D8HwAg032547
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 13:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=5b8UhtyuTRiXUcFjJnCIlE31r1
 RoaWFoCGWXWNnGLx4=; b=XmFoqrZjAygNu7iK9uOJnrYWfc/9IqOY5IS20cA1Cs
 WjoKwBfbeYzfkMSatpWEGUQMSVFMaCr+In0LLsOaV8Vs67cc6x6Yp3Po0u6iol5w
 2YjMEqMSmA7b7hL6V6gDRpbMoIKIsexaDk8h/0ixefdwEwXuvCJiYjAbFQ0c3zgq
 bfiOqE/ZLv2r5r7ovF/wz1EUsOlb0bTWQRG45yTLQQ730jQgsWKEd83G7dh7gBlj
 q2JygMNB3TFUpAAAwc2CorT2vyjfV9YsJJ9jXfzoj97WGbKckDLD/VKdWn139+DT
 M7kx4GvnyB4G0mhO4mvvkrRxi9ntLN6J7S4sP7MHkHrQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxabq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 13:41:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DD3bQH027303
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 13:41:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3p55a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 13:41:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DDfOLD22282536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 13:41:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D83F20040;
 Fri, 13 Sep 2024 13:41:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5CB620043;
 Fri, 13 Sep 2024 13:41:22 +0000 (GMT)
Received: from
 li-c3823c75-1373-11ec-80f0-84a93810363e.ibm.com.ustream.lldns.net (unknown
 [9.197.229.128])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 13:41:22 +0000 (GMT)
From: Spoorthy <spoorthy@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 13 Sep 2024 19:10:36 +0530
Message-ID: <20240913134036.12078-1-spoorthy@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p8QONQtv6KSv67HOC6R6PKGK9IY7zEmZ
X-Proofpoint-ORIG-GUID: p8QONQtv6KSv67HOC6R6PKGK9IY7zEmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130095
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs shm-perms
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

Test Description: Tests the behavior of shared memory when
multiple threads attach to a segment with different permissions. 

At one point, reservation accounting of free hugepages between the parent
and child processes may become inconsistent during memory operations.
The parent creates 4 hugepages and a shared memory segment
(size segment_size, permission 0640), attaches it, and initializes
four parts with a pattern (0x55), then detaches it. Child processes
are created in a loop, each reattaching the segment in read-only mode
with SHM_RDONLY, detaching, and exiting. If attach/detach fails or
if the reservation accounting of free hugepages doesn't match
between parent and child, the test fails. If all child processes exit
successfully and accounting matches, the test passes.

Tested and verified the success of test case

Signed-off-by: Spoorthy <spoorthy@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../mem/hugetlb/hugeshmat/hugeshmat06.c       | 97 +++++++++++++++++++
 3 files changed, 99 insertions(+)
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
index c96fe8bfc..4ad1dc313 100644
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
index 000000000..bcb31b1d4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+/*\
+ * [DESCRIPTION]
+ * Test shared memory behavior when multiple threads are attached
+ * to a segment with different permissions.  A segment is created
+ * and children attach read-only to check reservation accounting.
+ */
+
+#include "hugetlb.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define SEGMENT_KEY (0x82ba15ff)
+#define MNTPOINT "hugetlbfs/"
+#define HPAGES_IN_SEGMENT 4
+
+static int global_shmid = -1;
+static void *shmaddr;
+static long segment_size, hpage_size, stride;
+
+static int attach_segment(size_t segsize, int shmflags, int shmperms)
+{
+	int shmid;
+
+	shmid = SAFE_SHMGET(SEGMENT_KEY, segsize, shmflags);
+	shmaddr = SAFE_SHMAT(shmid, shmaddr, shmperms);
+	global_shmid = shmid;
+	return shmid;
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	segment_size = 4 * hpage_size;
+	stride = hpage_size;
+}
+
+static void compare_free_hugepage_memory(long free_end, long free_start)
+{
+	if (free_end != free_start)
+		tst_res(TFAIL, "Free hugepages after attaching multiple threads differ from initial allocation");
+}
+
+static void run_test(void)
+{
+	char *p;
+	int i, iterations;
+	long total_hpages, free_start, free_end, val;
+
+	total_hpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
+	iterations = (total_hpages * hpage_size) / segment_size+1;
+	attach_segment(segment_size, IPC_CREAT | SHM_HUGETLB | 0640, 0);
+	p = (char *)shmaddr;
+	for (i = 0; i < 4; i++, p += stride)
+		memset(p, 0x55, stride);
+	free_start = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	SAFE_SHMDT((const void *)shmaddr);
+	for (i = 0; i < iterations; i++) {
+		pid_t pid;
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			attach_segment(0, 0, SHM_RDONLY);
+			for (i = 0; i < HPAGES_IN_SEGMENT; i++)
+				val = *((char *)shmaddr + (i * hpage_size));
+			SAFE_SHMDT(((const void *)shmaddr));
+			free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+			compare_free_hugepage_memory(free_end, free_start);
+			exit(EXIT_SUCCESS);
+		}
+	}
+	free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	compare_free_hugepage_memory(free_end, free_start);
+	tst_reap_children();
+	tst_res(TPASS, "Successfully tested shared memory behavior when multiple threads are attached");
+}
+
+static void cleanup(void)
+{
+	if (global_shmid >= 0)
+		SAFE_SHMCTL(global_shmid, IPC_RMID, NULL);
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
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
