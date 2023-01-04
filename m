Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49070C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:23:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A16363CCDD5
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:23:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DF473CB67E
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:50 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 417B41000231
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:48 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304CCHw8005120; Wed, 4 Jan 2023 12:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kXkhF6puSsB0XxM0EbSZ47kRiDmUYhhLcPz9RllHzA8=;
 b=RQHksTOfgK2yCo5wzdf1bUdJYsfs0iijtaB+i0b8XmpDM1ddjsfT8Vr/btICfKQfapEc
 xcP7XLBucWZ8loncapAZRJk6TKtvv1pS80xF2+1jMJ7hlA2kNCtfroqT4wzP1lySaBPW
 6TeUmDHNMttPPCDoIOYoXIEZpLg4z2aZEi8+tOG+K0oD9hjAWpAzUI2gop2i9ZrvxZmp
 ZqEZ0qb2IZmNOoqZjL4PaYKwC+O2KqiNbxP9vZ8AF02aTuE+xLsJ21jM+CO5jAANDL1e
 hjUdo0z33EW/9aMGnr+jZomlAFGChJuzfa5x9uefZGMJ68OmfKk4o4DrqC+9kfGOL02B /A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw98eg7c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:46 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CEtIB015737;
 Wed, 4 Jan 2023 12:22:46 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw98eg7b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303M1ZpC020484;
 Wed, 4 Jan 2023 12:22:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d95d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMeA950266418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01D602004B;
 Wed,  4 Jan 2023 12:22:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14C8420049;
 Wed,  4 Jan 2023 12:22:36 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:35 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:13 +0530
Message-Id: <20230104122224.369467-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vZBzjl2QoBWRi3i0JA2D70GAIc1pmWRk
X-Proofpoint-GUID: STKaDUtwopkXMlU661VA-t4qRZKEW0sZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/13] Hugetlb: Migrating libhugetlbfs mmap-cow
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

Migrating the libhugetlbfs/testcases/mmap-cow.c test

Test Description: Tests copy-on-write semantics of large pages where a
number of threads map the same file with the MAP_PRIVATE flag. The threads
then write into their copy of the mapping and recheck the contents to
ensure they were not corrupted by the other threads.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Li Wang <liwang@redhat.com>

---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 116 ++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2dffa8421..71b4d57e4 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -22,6 +22,7 @@ hugemmap17 hugemmap17
 hugemmap18 hugemmap18
 hugemmap19 hugemmap19
 hugemmap20 hugemmap20
+hugemmap21 hugemmap21
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index dfd372892..74edfa392 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -21,6 +21,7 @@
 /hugetlb/hugemmap/hugemmap18
 /hugetlb/hugemmap/hugemmap19
 /hugetlb/hugemmap/hugemmap20
+/hugetlb/hugemmap/hugemmap21
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
new file mode 100644
index 000000000..ce3c5866e
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests copy-on-write semantics of large pages where a number of threads
+ * map the same file with the MAP_PRIVATE flag. The threads then write
+ * into their copy of the mapping and recheck the contents to ensure they
+ * were not corrupted by the other threads.
+ */
+
+#include "hugetlb.h"
+
+#define THREADS 5
+#define NR_HUGEPAGES 6
+#define MNTPOINT "hugetlbfs/"
+
+static int fd = -1;
+static long hpage_size;
+
+static void do_work(int thread, size_t size, int fd)
+{
+	char *addr;
+	size_t i;
+	char pattern = thread+65;
+
+	addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	tst_res(TINFO, "Thread %d (pid %d): Mapped at address %p",
+	       thread, getpid(), addr);
+
+	for (i = 0; i < size; i++)
+		memcpy((char *)addr+i, &pattern, 1);
+
+	if (msync(addr, size, MS_SYNC))
+		tst_brk(TBROK|TERRNO, "Thread %d (pid %d): msync() failed",
+				thread, getpid());
+
+	for (i = 0; i < size; i++)
+		if (addr[i] != pattern) {
+			tst_res(TFAIL, "thread %d (pid: %d): Corruption at %p; "
+				   "Got %c, Expected %c", thread, getpid(),
+				   &addr[i], addr[i], pattern);
+			goto cleanup;
+		}
+	tst_res(TINFO, "Thread %d (pid %d): Pattern verified",
+			thread, getpid());
+
+cleanup:
+	SAFE_MUNMAP(addr, size);
+	exit(0);
+}
+
+static void run_test(void)
+{
+	char *addr;
+	size_t size, itr;
+	int i, pid;
+	pid_t *wait_list;
+
+	wait_list = SAFE_MALLOC(THREADS * sizeof(pid_t));
+	size = (NR_HUGEPAGES / (THREADS+1)) * hpage_size;
+
+
+	/* First, mmap the file with MAP_SHARED and fill with data
+	 * If this is not done, then the fault handler will not be
+	 * called in the kernel since private mappings will be
+	 * created for the children at prefault time.
+	 */
+	addr = SAFE_MMAP(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	for (itr = 0; itr < size; itr += 8)
+		memcpy(addr+itr, "deadbeef", 8);
+
+	for (i = 0; i < THREADS; i++) {
+		pid = SAFE_FORK();
+
+		if (pid == 0)
+			do_work(i, size, fd);
+
+		wait_list[i] = pid;
+	}
+	tst_reap_children();
+
+	SAFE_MUNMAP(addr, size);
+	free(wait_list);
+	tst_res(TPASS, "mmap COW working as expected.");
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 1)
+		SAFE_CLOSE(fd);
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
