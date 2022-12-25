Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FACC3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2B3A3CB8E6
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:45:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D95873CB8C1
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:19 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ECA5B1A002D8
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:18 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFGBOP031191; Sun, 25 Dec 2022 15:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UKtr2aiYnf8xP6MXSROJWIFy4w5aOxzcAzBYMYBP1Ow=;
 b=WJnFrlXFfIrFyWUtt1z1ofv6A5RxXIj2pa9FvF6ywgPMGRwO3AGox0CVtJtjogWsWeTT
 pOuD6kJHDTAXLartJxKBkyl5nc4Ua1mWdn/TfipMaXaU65/8IIQJyCpQqRa3kFLrL7i2
 1YdtwEURNaPcS+dTjQivZYTlZZ/FgMSpw30a33QpwVBLnGwae3AA6e5cX3YUDN3eIwvD
 SIv5M7PLk64vGNAZsU6SH3zT9aAA5w4iBp4BC5e5/rOTmG2fYTuI8WEf6jmezLx/+bko
 5fcgRNYPLYiZc+sWm5cGEx5tnYkucqFjumRZhJ0eMRhy3IARUFoyn8GfV8bjrCaSNvvo Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mps0sgkhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:16 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFfvU4025597;
 Sun, 25 Dec 2022 15:43:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mps0sgkh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:15 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BOFcCor025623;
 Sun, 25 Dec 2022 15:43:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mns26s1mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFh9JP23265918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:43:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B19A20040;
 Sun, 25 Dec 2022 15:43:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C4C420043;
 Sun, 25 Dec 2022 15:43:06 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:43:06 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:12 +0530
Message-Id: <20221225154213.84183-13-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BFyOkgg8mQQxtoRHjFYJwumnFi1Mxpmz
X-Proofpoint-GUID: Lm-RQ_-4H3V_esDxVCZrqMMueUrCePrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/13] Hugetlb: Migrating libhugetlbfs shm-fork
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
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 104 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 33fd384b4..348a7dc5f 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -2,6 +2,7 @@ hugefallocate01 hugefallocate01
 hugefallocate02 hugefallocate02
 
 hugefork01 hugefork01
+hugefork02 hugefork02 -P 3 -s 5
 
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
index 000000000..6596bf81f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -0,0 +1,104 @@
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
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <setjmp.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/shm.h>
+
+#include "tst_safe_sysv_ipc.h"
+#include "hugetlb.h"
+
+static int shmid = -1;
+
+#define NR_HUGEPAGES 5
+#define NUMPROCS 20
+#define MNTPOINT "hugetlbfs/"
+#define MAX_PROCS 200
+#define BUF_SZ 256
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
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
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
