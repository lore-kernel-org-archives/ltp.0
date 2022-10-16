Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E13C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:01:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A81FC3CAFA6
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:01:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B225E3CAFB4
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:13 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 819181A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:11 +0200 (CEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9CmSC035709
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dOifVoBORfcuo9cNnbXJFmYJDnr1OVUQZCzBKqeNfys=;
 b=FUuf9ywgOc5lELPwZmvH27X8MYVI9+F/0Le8BgwjXk8tliECn9cUbGzqdTJ54voAYAxa
 tIrOfvt0eFIS+li0BdwHXz37pCOhLXJ2t8kRBrfFXZd0r76H+vQmkomc0A7w4VnIVgHA
 u9U076574bldouDTyf/FXP9CZpVa4NM0JvDGUUCPr81KJwIbt5mlja/ZeBxuVFOxa09K
 /Tfdqz45cZXNNxfTJXC7j62svJxmy7YkUQem3D7qwmAluCXQ7GiuGKPeKdbxhc4rDB6O
 oBKrvM/EGz5kIxsKMtt4BhWevMAGdnK90LJAuZew6QwDRFdPSe/L6rKf87huMZIT9EHX kg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86ufmd09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpB2R010001
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91kkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCx4WZ7144170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8597A11C04C;
 Sun, 16 Oct 2022 12:59:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 005ED11C04A;
 Sun, 16 Oct 2022 12:59:03 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:02 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:15 +0530
Message-Id: <20221016125731.249078-14-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hg9wDGG3_evFW2Pbmh_xiYHc-089yy05
X-Proofpoint-ORIG-GUID: Hg9wDGG3_evFW2Pbmh_xiYHc-089yy05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/29] Hugetlb: Migrating libhugetlbfs madvise_reserve
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

Migrating the libhugetlbfs/testcases/madvise_reserve.c test

Test Description: madvise() on some kernels can cause the reservation
counter to get corrupted. The problem is that the patches are allocated
for the reservation but not faulted in at the time of allocation. The
counters do not get updated and effectively "leak". This test
identifies whether the kernel is vulnerable to the problem or not.
It is fixed in kernel by 'commit f2deae9d4e70
("Remove implementation of readpage from the hugetlbfs_aops")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  | 112 ++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0714ed34c..1691ce37d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -17,6 +17,7 @@ hugemmap12 hugemmap12
 hugemmap13 hugemmap13
 hugemmap14 hugemmap14
 hugemmap15 hugemmap15
+hugemmap16 hugemmap16
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index d59b60fd4..eb8e87c40 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -16,6 +16,7 @@
 /hugetlb/hugemmap/hugemmap13
 /hugetlb/hugemmap/hugemmap14
 /hugetlb/hugemmap/hugemmap15
+/hugetlb/hugemmap/hugemmap16
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
new file mode 100644
index 000000000..2b6a5e374
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ *
+ * Test Name: madvise_reserve
+ *
+ * Test Description: madvise() on some kernels can cause the reservation
+ * counter to get corrupted. The problem is that the patches are allocated
+ * for the reservation but not faulted in at the time of allocation. The
+ * counters do not get updated and effectively "leak". This test
+ * identifies whether the kernel is vulnerable to the problem or not.
+ * It is fixed in kernel by commit f2deae9d4e70793568ef9e85d227abb7bef5b622
+ *
+ * HISTORY
+ *  Written by Eric B Munson and Mel Gorman
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+static char *verbose;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static void test_directio(void)
+{
+	void *p;
+	unsigned long initial_rsvd, map_rsvd, madvise_rsvd, end_rsvd;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+	initial_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+
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
+	/* madvise the region and record reservations */
+	if (madvise(p, hpage_size, MADV_WILLNEED) == -1)
+		tst_brk(TBROK|TERRNO, "madvise()");
+	madvise_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Reserve count after madvise: %lu", madvise_rsvd);
+
+	/* Free region */
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	end_rsvd = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Reserve count after close(): %lu", end_rsvd);
+
+	/* Reserve count should match initial reserve count */
+	if (end_rsvd != initial_rsvd) {
+		tst_res(TFAIL, "Reserve leaked: %lu != %lu", end_rsvd, initial_rsvd);
+		goto fail;
+	}
+	tst_res(TPASS, "Successful");
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing to next iteration");
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
+
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
+	.test_all = test_directio,
+	.hugepages = {1, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
