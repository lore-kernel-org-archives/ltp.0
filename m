Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437F0C25B5F
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 14:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336B13CE4F6
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 16:07:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45CED3CC2F5
 for <ltp@lists.linux.it>; Fri, 10 May 2024 16:06:44 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=spoorthy@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A78D86032A8
 for <ltp@lists.linux.it>; Fri, 10 May 2024 16:06:42 +0200 (CEST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44ADQJ8R026194
 for <ltp@lists.linux.it>; Fri, 10 May 2024 14:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r6DVyB9SfC1nhheok/C3KJRcAxNglZTyql22IczI0v4=;
 b=jKszrphbOHJ5jsMN4PdCvoD/fZ7jb4O8qgRhkfCN/F2ZW8mBmnd99Y6NEjdI+VvnTnXK
 f5VaqDbMOzm+bsjNpUGIbcXdz3ROe0k6x3omykvIfOkNp5OG/lqZNGrPaPCaNb6rxz5d
 AgufppKXS/c2lCmUcnVuvwbTheBZ89w+uvOqRzlT5s3p9ESNn+tdHYc+3DsovE5xLulh
 /33AHDrJv1muoMHeICm6xt+9+rvL6m0uoIofOMjbvdUXm70NwCWMX1hWxunYfHAf19oH
 IjJlJfiN+l3T4ii9EA5H4hyEx70AzMLlr/bpbOLi6LAyyvRi+bWKCdSYVxYqBXWSuH35 uA== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1mf2g3ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 May 2024 14:06:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44AB3cK6009218
 for <ltp@lists.linux.it>; Fri, 10 May 2024 14:06:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xyshthjdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 May 2024 14:06:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44AE6XFM55443758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2024 14:06:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89D7E20040;
 Fri, 10 May 2024 14:06:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADAEA2004B;
 Fri, 10 May 2024 14:06:32 +0000 (GMT)
Received: from li-c3823c75-1373-11ec-80f0-84a93810363e.ibm.com.com (unknown
 [9.43.57.9]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 May 2024 14:06:32 +0000 (GMT)
From: Spoorthy <spoorthy@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 10 May 2024 19:36:14 +0530
Message-Id: <20240510140614.188795-1-spoorthy@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tnXpfdSzvDtwQTZe0zxnh-aFpHl6hCtp
X-Proofpoint-GUID: tnXpfdSzvDtwQTZe0zxnh-aFpHl6hCtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405100100
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Test Description: Tests the behavior of shared
 memory when multiple threads attach to a segment with different
 permissions. At one stage,
 the reservation accounting of free hugepages allocated to parent and child's
 process may mess up during the memory operations.
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

Creates 4 hugepages in parent and a shared memory segment of size segment_size with 0640 permission,
The segment attaches to process address space and it is partially initialized by filling four parts of the segment with a pattern(0x55).
The segment is detached from the process's address space.
Next create child processes in a loop, Each child process reattaches to the shared memory segment as read-only by calling attach_segment() with the SHM_RDONLY flag. After attaching, the child process detaches from the segment using shmdt() and exits. If either attach or detach fails, the test fails
Also if the reservation accounting calculated by comparing the free hugepage memory in parent's and child's process does not match, the test fails
The parent process waits for all the child processes to exit. If all child processes exit successfully and the reservation accounting of parent and childprocess matches then the test passes

Tested and verified the success of test case

Signed-off-by: Spoorthy <spoorthy@linux.ibm.com>
-------
Changes in v2:
1)Make check errors are taken care
2)segment_size is not static
3)Added check to compare the free hugepage memory
-------
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../mem/hugetlb/hugeshmat/hugeshmat06.c       | 105 ++++++++++++++++++
 3 files changed, 107 insertions(+)
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
index 000000000..8b669fb18
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat06.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2005-2006, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+/*\
+ * [DESCRIPTION]
+ *	Test shared memory behavior when multiple threads are attached
+ *	to a segment with different permissions.  A segment is created
+ *	and children attach read-only to check reservation accounting.
+ */
+
+#include "hugetlb.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define SEGMENT_KEY (0x82ba15ff)
+#define MNTPOINT "hugetlbfs/"
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
+	if (hpage_size > segment_size)
+		tst_res(TCONF, "Page size is too large for configured segment_size");
+}
+
+static void compare_free_hugepage_memory(long free_end, long free_start)
+{
+	if (free_end != free_start) {
+		tst_res(TFAIL, "Free hugepages allocated after multiple threads attached is not equal to initial free hugepages allocated");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void run_test(void)
+{
+	char *p;
+	int i, iterations;
+	pid_t *wait_list;
+	long total_hpages, free_start, free_end, val;
+
+	total_hpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
+	iterations = (total_hpages * hpage_size) / segment_size+1;
+	wait_list = SAFE_MALLOC(sizeof(pid_t) * iterations);
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
+		if (pid) {
+			wait_list[i] = pid;
+		} else {
+			attach_segment(0, 0, SHM_RDONLY);
+			for (i = 0; i < 4; i++)
+				val = *((char *)shmaddr + (i * hpage_size));
+			SAFE_SHMDT(((const void *)shmaddr));
+			free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+			compare_free_hugepage_memory(free_end, free_start);
+			exit(EXIT_SUCCESS);
+		}
+	}
+	free_end = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	compare_free_hugepage_memory(free_end, free_start);
+	for (i = 0; i < iterations; i++)
+		tst_reap_children();
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
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
