Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F71AC433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:04:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0D533CAFDD
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:03:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DB173CAFAA
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:50 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F10992001A2
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:49 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9jFHt005675
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PrQdhwzSOIECFdCoOYLJcTA48a0UAYDjW8yz8gzKigw=;
 b=jyvscLnmIvnPuA/MBiqsCK2X7R0oHXm1hMSZB8W/PZbt4NYHdDs5E2QmbyEl7xTGboLz
 WUf1kUpjT5mZ3Tgr48dYIH4YEkBb/HKsmOQHtPaL8drOYEJkR/toz1iMBPAqpY0n+GbR
 Dr7A+LGzVS4pyAKL51gL8wFl1JznFBiqsCKYPbT1+yXXdRt5S5XmjFRtvTTW82zSp7dD
 zSO6yZKgNgkZvmSJw+phK6jvInYeXuZSmdf4h0MKyjeiW67wMSpEESrC5bxNB2fGJDi7
 Zh0k7s0bjYjAAvCAVpevL1HaPUCR8HDuRguHHsWxiWSsr3mSxLzWrFLzQ5SYTxe2vjzF nA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86shvkjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpfbF010060
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91km8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GD0E4m15925508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 13:00:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A13811C04A;
 Sun, 16 Oct 2022 12:59:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DA3911C058;
 Sun, 16 Oct 2022 12:59:40 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:39 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:28 +0530
Message-Id: <20221016125731.249078-27-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LfAvia-_jL-ru3XDguqCzM_I2wd9OzKo
X-Proofpoint-GUID: LfAvia-_jL-ru3XDguqCzM_I2wd9OzKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 26/29] Hugetlb: Migrating libhugetlbfs
 readahead_reserve
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/readahead_reserve.c test

Test Description: readahead() on some kernels can cause the reservation
counter to get corrupted. The problem is that the patches are allocated
for the reservation but not faulted in at the time of allocation. The
counters do not get updated and effectively "leak". This test
identifies whether the kernel is vulnerable to the problem or not.
It's fixed in kernel by 'commit f2deae9d4e70
("Remove implementation of readpage from the hugetlbfs_aops")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  | 120 ++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 906acb266..76ff1a3dd 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -30,6 +30,7 @@ hugemmap26 hugemmap26
 hugemmap27 hugemmap27
 hugemmap28 hugemmap28
 hugemmap29 hugemmap29
+hugemmap30 hugemmap30
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index fef0a76d6..bb9720452 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -29,6 +29,7 @@
 /hugetlb/hugemmap/hugemmap27
 /hugetlb/hugemmap/hugemmap28
 /hugetlb/hugemmap/hugemmap29
+/hugetlb/hugemmap/hugemmap30
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
new file mode 100644
index 000000000..030dbb851
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ *
+ * Test Name: Readahead Reserve
+ *
+ * Test Description: readahead() on some kernels can cause the reservation
+ * counter to get corrupted. The problem is that the patches are allocated
+ * for the reservation but not faulted in at the time of allocation. The
+ * counters do not get updated and effectively "leak". This test
+ * identifies whether the kernel is vulnerable to the problem or not.
+ * It's fixed in kernel by commit f2deae9d4e70793568ef9e85d227abb7bef5b622.
+ *
+ * HISTORY
+ *  Written by Mel Gorman & Eric B Munson
+ *
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+static char *verbose;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p;
+	unsigned long initial_rsvd, map_rsvd, readahead_rsvd, end_rsvd;
+
+	/* Setup */
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	initial_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
+
+	/* mmap a region and record reservations */
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+	map_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Reserve count after map: %lu", map_rsvd);
+
+	/* readahead the region and record reservations */
+	readahead(fd, 0, hpage_size);
+	readahead_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Reserve count after readahead: %lu", readahead_rsvd);
+
+	/* Write the region */
+	memset(p, 1, hpage_size);
+
+	/* Free region */
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	end_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Reserve count after close(): %lu\n", end_rsvd);
+
+	/* Reserve count should match initial reserve count */
+	if (end_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserve leaked: %lu != %lu\n", end_rsvd, initial_rsvd);
+		goto fail;
+	}
+
+	tst_res(TPASS, "Successful");
+	return;
+
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 1)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
