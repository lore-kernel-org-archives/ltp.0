Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940B8C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:00:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A793CAFB4
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:00:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E20033CAFAC
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:00 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DAC53100037D
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:59 +0200 (CEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9ffl0021454
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aOWR5FumKTplirTecXx9gacoknrQs/rTniZm/b2c8Ag=;
 b=LLuz0mply5qPzqEw34V7gBWGFn9QJkb2d7F93pCpCBkPMJc8fbA0Vy4WZsdywxgPppLO
 UxvAonvnTCtTk6OOaxZILgatEFYPaNqBjAy8cEV5yl/jDlwpyFtrNG8UIf6cxXkA6oyo
 rdbMcU9x09HXkMv6/iA2LUW45P+vd0TG/tvBJD7DDOVi0VdRd9Beg3euRMwVjnApxWyq
 45YfjzHXheSDRotLyDoT1+KBYLViIX4jSoHFn8/GWkDu6dctkq735HVR+w7fBNDFRCfW
 wUL0O8q/JAG4DXVqWRQyZrq+Wcy6oN4PR4O896CvVADiTNGzaV3WlUTJ3V8aDsx6YIZU uA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g54jth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:58 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpsO1004077
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma02fra.de.ibm.com with ESMTP id 3k7mg917m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCxPk745810058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2418F11C050;
 Sun, 16 Oct 2022 12:58:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0586911C04A;
 Sun, 16 Oct 2022 12:58:51 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:50 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:10 +0530
Message-Id: <20221016125731.249078-9-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O1XpnjJPHv0qJMFDnlW4pXtUMCKMLJjb
X-Proofpoint-ORIG-GUID: O1XpnjJPHv0qJMFDnlW4pXtUMCKMLJjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=845 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/29] Hugetlb: Migrating libhugetlbfs fallocate_basic
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

Migrating the libhugetlbfs/testcases/fallocate_basic.c test

Test Description: It tests basic fallocate functionality in hugetlbfs.
Preallocate huge pages to a file in hugetlbfs, and then remove the pages
via hole punch.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../hugetlb/hugefallocate/hugefallocate02.c   | 116 ++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index ca92dfcff..ec1fc2515 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,4 +1,5 @@
 hugefallocate01 hugefallocate01
+hugefallocate02 hugefallocate02
 
 hugemmap01 hugemmap01
 hugemmap02 hugemmap02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index cafdb5259..c0906f3d3 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,5 +1,6 @@
 /cpuset/cpuset01
 /hugetlb/hugefallocate/hugefallocate01
+/hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugemmap/hugemmap01
 /hugetlb/hugemmap/hugemmap02
 /hugetlb/hugemmap/hugemmap04
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
new file mode 100644
index 000000000..54e1e42f4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2015 Mike Kravetz, Oracle Corporation
+ *
+ * Test Name: fallocate_basic
+ *
+ * Test Description: It tests basic fallocate functionality in hugetlbfs.
+ * Preallocate huge pages to a file in hugetlbfs, and then remove the pages
+ * via hole punch.
+ *
+ * HISTORY
+ *  Written by Mike Kravetz
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
+#define MAX_PAGES_TO_USE 5
+
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static void run_test(void)
+{
+	long nr_hpages_free;
+	int err;
+	unsigned long max_iterations;
+	unsigned long free_before, free_after;
+
+	nr_hpages_free = SAFE_READ_MEMINFO("HugePages_Free:");
+	max_iterations = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	free_before = SAFE_READ_MEMINFO("HugePages_Free:");
+
+	/* First preallocate file with max_iterations pages */
+	err = fallocate(fd, 0, 0, hpage_size * max_iterations);
+	if (err) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate() Operation is not supported");
+		tst_res(TFAIL|TERRNO, "fallocate()");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_before - free_after != max_iterations) {
+		tst_res(TFAIL, "fallocate did not preallocate %lu huge pages",
+							max_iterations);
+		goto fail;
+	}
+
+	/* Now punch a hole of the same size */
+	err = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0, hpage_size * max_iterations);
+	if (err) {
+		tst_res(TFAIL|TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_after != free_before) {
+		tst_res(TFAIL, "fallocate hole punch did not release %lu huge pages",
+							max_iterations);
+		goto fail;
+	}
+
+	tst_res(TPASS, "Successful");
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 2)
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
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
