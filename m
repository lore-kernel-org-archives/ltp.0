Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D45C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D0A93CB8D7
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:44:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F0423CB8C5
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:14 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0E17600097
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:13 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFIPFR023286; Sun, 25 Dec 2022 15:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=evn2KvySvOJHdklM5saRc3qrfZFrxM2kssaBy3EvhDk=;
 b=b3iB7T145v/b8U3r1VslSuNtMrB64RPa7Xrc7lxDk9tIUiWo+Be0OQnPoWNYpyXhlFjV
 9inP16iMJsVG5IZRrltSBByxu1htZCG+M6+Ez+JgxcRhnoAEwhInAfakgjLzmEAeigDl
 kafzxSMYDqK2ZiQy7m3PNwruK8uHNKkRI5uciqjHKU+3XwuAP1CQdGMpc3n7mYJDp/qb
 8k97UOfE5W//Yzzk4raB4akYbAk8aNf1/4o3IKzebwnC+w3FEovUxWsL4AsMHyZBXEOs
 gm9VIFOQxRg9Cng5W7T/AqOrNj5oIKrC+cpWQORc/3kD4cvrCBYhgBUTv0wy+IBfKF0e WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mps1ugb0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:12 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFcxQv020236;
 Sun, 25 Dec 2022 15:43:11 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mps1ugb03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPAcL0N019869;
 Sun, 25 Dec 2022 15:43:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3mns26h1mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFh5Bh45220160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:43:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE9E220043;
 Sun, 25 Dec 2022 15:43:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D70920040;
 Sun, 25 Dec 2022 15:43:02 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:43:02 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:11 +0530
Message-Id: <20221225154213.84183-12-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Bqn3twhRTv6Qj_VDQD5n0Z-Mq0TQ_1U
X-Proofpoint-GUID: sflJuUvnz3TMzTg17shOjqlucYdSxyeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=961
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 11/13] Hugetlb: Migrating libhugetlbfs shared
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

Migrating the libhugetlbfs/testcases/shared.c test

Test Description: This test is basic shared mapping test. Two shared
mappings are created with same offset on a file. It checks if writing
to one mapping can be seen to other mapping or not?

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  | 84 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 60cca4eb7..33fd384b4 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -31,6 +31,7 @@ hugemmap27 hugemmap27
 hugemmap28 hugemmap28
 hugemmap29 hugemmap29
 hugemmap30 hugemmap30
+hugemmap31 hugemmap31
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index bb9720452..8375389cd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -30,6 +30,7 @@
 /hugetlb/hugemmap/hugemmap28
 /hugetlb/hugemmap/hugemmap29
 /hugetlb/hugemmap/hugemmap30
+/hugetlb/hugemmap/hugemmap31
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
new file mode 100644
index 000000000..a09905023
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is basic shared mapping test. Two shared mappings are created
+ * with same offset on a file. It checks if writing to one mapping can be
+ * seen to other mapping or not?
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <setjmp.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define RANDOM_CONSTANT	0x1234ABCD
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned long *pl, *ql;
+	unsigned long i;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	q = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	pl = p;
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++)
+		pl[i] = RANDOM_CONSTANT ^ i;
+
+	ql = q;
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Mismatch at offset %lu, Got: %lu, Expected: %lu",
+					i, ql[i], RANDOM_CONSTANT ^ i);
+			goto cleanup;
+		}
+	}
+
+	tst_res(TPASS, "Successfully tested data between two shared mappings");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, hpage_size);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
