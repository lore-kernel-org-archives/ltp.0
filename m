Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBA1C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:02:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B300A3CAFAD
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:02:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5ACC3CAFA6
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 08AC91000373
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:22 +0200 (CEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G91EJ0000533
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=egzRdzVZRHsejA+8MItldw3awLEQ3N9ah9GRwhmWupI=;
 b=PDNv2aAohp4Q/zsh7yFvtJFDpGw01gVpR/oJR+t/EPf7TfHXVrlltT9yaYWehrZ8Rl0V
 GZE3fnhf6BIN2lRA11QvRTEXKb4xQAFF8QP0JiLFlY+OMoJjvrq5rIg+tTdfMuiYJg7e
 aEA6onZXgSboWnvqfOMdh/Rmu0szFfJvuHRVVlqUIOC/48SGhB1q89u5unp7QYA7uRah
 YCnNIVo7wKdL8QvlRyucpM6FTWszqMxwnz7cJksCyY5EmbEFFmrA4QXBzHmT9C+BNVtu
 ryRhKKpM0EUioFOMe4C2H1FQ4KOZ7l6dnVmCzD5TI3R8sqwDFKRlUODP/1ciCU1ahxEW iA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k866aw3uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpDL8010007
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91kkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCsMCH42008940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:54:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C58C111C04C;
 Sun, 16 Oct 2022 12:59:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F4E911C04A;
 Sun, 16 Oct 2022 12:59:13 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:13 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:19 +0530
Message-Id: <20221016125731.249078-18-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G2C4eiWg-kUzyA7B6wHtVLb7-Qva5tAA
X-Proofpoint-ORIG-GUID: G2C4eiWg-kUzyA7B6wHtVLb7-Qva5tAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=831 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160074
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 17/29] Hugetlb: Migrating libhugetlbfs mlock
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

Migrating the libhugetlbfs/testcases/mlock.c test

Test Description: The test checks that mlocking hugetlb areas works
with all combinations of MAP_PRIVATE and MAP_SHARED with and without
MAP_LOCKED specified.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  | 108 ++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 4da1525a7..2dffa8421 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -21,6 +21,7 @@ hugemmap16 hugemmap16
 hugemmap17 hugemmap17
 hugemmap18 hugemmap18
 hugemmap19 hugemmap19
+hugemmap20 hugemmap20
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b6b3e5ddd..dfd372892 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -20,6 +20,7 @@
 /hugetlb/hugemmap/hugemmap17
 /hugetlb/hugemmap/hugemmap18
 /hugetlb/hugemmap/hugemmap19
+/hugetlb/hugemmap/hugemmap20
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
new file mode 100644
index 000000000..702de7de9
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: mlock
+ *
+ * Test Description: The test checks that mlocking hugetlb areas works
+ * with all combinations of MAP_PRIVATE and MAP_SHARED with and without
+ * MAP_LOCKED specified.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/resource.h>
+
+#include "hugetlb.h"
+
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static unsigned long hpage_size;
+
+static void test_simple_mlock(int flags)
+{
+	void *p;
+	int ret;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE, flags, fd, 0);
+
+	/* Can't use SAFE_MLOCK, as this test requires manual check */
+	ret = mlock(p, hpage_size);
+	if (ret) {
+		tst_res(TFAIL|TERRNO, "mlock() failed (flags=%x)", flags);
+		goto fail;
+	}
+
+	ret = munlock(p, hpage_size);
+	if (ret) {
+		tst_res(TFAIL|TERRNO, "munlock() failed (flags=%x)", flags);
+		goto fail;
+	}
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing to next iteration");
+}
+
+static void run_test(void)
+{
+	struct rlimit limit_info;
+
+	if (getrlimit(RLIMIT_MEMLOCK, &limit_info))
+		tst_res(TWARN|TERRNO, "Unable to read locked memory rlimit");
+	if (limit_info.rlim_cur < hpage_size)
+		tst_brk(TCONF, "Locked memory ulimit set below huge page size");
+
+	test_simple_mlock(MAP_PRIVATE);
+	test_simple_mlock(MAP_SHARED);
+	test_simple_mlock(MAP_PRIVATE|MAP_LOCKED);
+	test_simple_mlock(MAP_SHARED|MAP_LOCKED);
+
+	tst_res(TPASS, "Successful");
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
