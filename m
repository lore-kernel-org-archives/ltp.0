Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8FDC4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:24:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA2C73CCE06
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:24:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F6FA3CCDE6
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:30 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BFA31000231
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:28 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304BtmXq028031; Wed, 4 Jan 2023 12:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Bo8v0K5NVFIbvVTHsgRzkkicGInGpoSw6oQm+aoNXL8=;
 b=Ak7DG5a3W6aJYIbm0RBrCBUCDH8XvH/VC3bgbYDNTO3kTtA+q6+5WVLvR2IUohsbIhBw
 cT4sd7Z33G9BxaSF9XQI/r8hTfO9Evgr4s1715fZTi0OGYehFdyXaQir6RbRfkhhh4IX
 jqoK0GsXJTGoshaKqCK1THzl3v0aaN2kPmCR776eLOAQDo8Zty37xbAT6fWEpjG/67Rj
 Bm+Ow8AI7VVAwWHRkJootXUqEVrMQFp4GycEuNr0R6MyUFZq+yDyv9+wih7xt/GcrE9A
 KULjm8YJSyR74pMDG0gtnbz2y16wyPHC93qV5DmHA8/Jxo8vUyZh45ObU/xH5SDBmYp8 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw90xrmga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:27 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304Bu77v028421;
 Wed, 4 Jan 2023 12:23:26 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw90xrmfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3047AFF4000437;
 Wed, 4 Jan 2023 12:23:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6ku86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CNLpb49873344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:23:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F0312004B;
 Wed,  4 Jan 2023 12:23:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF81C20040;
 Wed,  4 Jan 2023 12:23:17 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:23:17 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:23 +0530
Message-Id: <20230104122224.369467-13-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KshtRWMXw7K3BoqEwhm23O6zHUgg4JSI
X-Proofpoint-GUID: RETdYzA0pTIYFCru72naqSwrOCqzBm0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/13] Hugetlb: Migrating libhugetlbfs shm-fork
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/shm-fork.c test

Test Description: Test shared memory behavior when multiple threads are
Test shared memory behavior when multiple threads are attached
to a segment.  A segment is created and then children are
spawned which attach, write, read (verify), and detach from the
shared memory segment.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 33fd384b4..6d63fec5d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -2,6 +2,7 @@ hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
 
 hugefork01 hugefork01
+hugefork02 hugefork02
 
 hugemmap01 hugemmap01
 hugemmap02 hugemmap02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 8375389cd..0c1311303 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -2,6 +2,7 @@
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugefork/hugefork01
+/hugetlb/hugefork/hugefork02
 /hugetlb/hugemmap/hugemmap01
 /hugetlb/hugemmap/hugemmap02
 /hugetlb/hugemmap/hugemmap04
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
new file mode 100644
index 000000000..e356a256f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Test shared memory behavior when multiple threads are attached to a
+ * segment. A segment is created and then children are spawned which
+ * attach, write, read (verify), and detach from the shared memory segment.
+ */
+
+#include "tst_safe_sysv_ipc.h"
+#include "hugetlb.h"
+
+static int shmid = -1;
+
+#define NR_HUGEPAGES 5
+#define NUMPROCS MIN(50L, tst_ncpus_available())
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+
+static void do_child(int thread, unsigned long size)
+{
+	volatile char *shmaddr;
+	int j;
+	unsigned long k;
+
+	for (j = 0; j < 5; j++) {
+		shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
+
+		for (k = 0; k < size; k++)
+			shmaddr[k] = (char) (k);
+		for (k = 0; k < size; k++)
+			if (shmaddr[k] != (char)k) {
+				tst_res(TFAIL, "Thread %d, Offset %lu mismatch", thread, k);
+				goto cleanup;
+			}
+
+		SAFE_SHMDT((const void *)shmaddr);
+	}
+cleanup:
+	exit(0);
+}
+
+static void run_test(void)
+{
+	unsigned long size;
+	int pid;
+	int i;
+
+	size = hpage_size * NR_HUGEPAGES;
+	shmid = SAFE_SHMGET(2, size, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W);
+
+	for (i = 0; i < NUMPROCS; i++) {
+		pid = SAFE_FORK();
+
+		if (pid == 0)
+			do_child(i, size);
+	}
+
+	tst_reap_children();
+	tst_res(TPASS, "Successfully tested shared hugetlb memory with multiple procs");
+}
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
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
