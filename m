Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9532BC4708E
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45E4C3CCDFD
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:24:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8FF63CCDDE
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:19 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02E80200742
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:18 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304CCPHX005296; Wed, 4 Jan 2023 12:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=04BdI4ENUa92uDzFFzO+c8VSg8q+ltyexRWmx4UdcNQ=;
 b=UMSPZU7JFyqyOpZpFzFoPx20PRyjl29521AUVJ0LEVq2Y6Noh5dXIX9XNHOQo2Jx4mMi
 Qu9bLx6qpYhpZooyuY1wg7FpVtaYV0d6pnXqp/yWt3wYyQm8b9oooCtJFJEeCnfy6Uhz
 FrEhvVvF9z7qNuYVDVCpRXnZZTWXEWqu5+zTuWi/3JRwCPhi8dliMsKEkvqgBLAJid0f
 Z9PWKMDUcegfQNG0Be/WG0O6Nz7ab8CNMD77lK+J2+lLb9qDQmGxECWJYI7keDPNVZ78
 WrTsETO4mn8jsMqxZxa4Lj9M5SgrEYnFEeAMxZA/9JlN+OxHmlS4yBBdjBZhstmqZrxE AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw98eg7p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:16 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CCEca005035;
 Wed, 4 Jan 2023 12:23:16 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw98eg7n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303Muw0s020202;
 Wed, 4 Jan 2023 12:23:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d960-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CN91K44171742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:23:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FF3820040;
 Wed,  4 Jan 2023 12:23:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FD3A20049;
 Wed,  4 Jan 2023 12:23:06 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:23:05 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:20 +0530
Message-Id: <20230104122224.369467-10-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a_YgjCBsWQFU4qxUwcDpcTlbEk8JNi5d
X-Proofpoint-GUID: A7uNZejsJEPBo6KHVjxBc7iuVOpxbA9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/13] Hugetlb: Migrating libhugetlbfs private
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

Migrating the libhugetlbfs/testcases/private.c test

Test Description: The test do mmap() with shared mapping and write.
It matches the data with private mmap() and then change it with other
data. It checks shared mapping data if data is not contaiminated by
private mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Li Wang <liwang@redhat.com>

---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 95afe009e..6ec8d1018 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -29,6 +29,7 @@ hugemmap25 hugemmap25
 hugemmap26 hugemmap26
 hugemmap27 hugemmap27
 hugemmap28 hugemmap28
+hugemmap29 hugemmap29
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 2f8ed0df0..fef0a76d6 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -28,6 +28,7 @@
 /hugetlb/hugemmap/hugemmap26
 /hugetlb/hugemmap/hugemmap27
 /hugetlb/hugemmap/hugemmap28
+/hugetlb/hugemmap/hugemmap29
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
new file mode 100644
index 000000000..6bff2c8e6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * The test do mmap() with shared mapping and write. It matches the data
+ * with private mmap() and then change it with other data. It checks
+ * shared mapping data if data is not contaiminated by private mapping.
+ * Similiarly checks for private data if it is not contaminated by changing
+ * shared mmap data.
+ */
+
+#include "hugetlb.h"
+
+#define C1 0x1234ABCD
+#define C2 0xFEDC9876
+
+#define MNTPOINT "hugetlbfs/"
+static unsigned long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p, *q;
+	unsigned int *pl, *ql;
+	unsigned long i;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	pl = p;
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++)
+		pl[i] = C1 ^ i;
+
+	q = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+		 fd, 0);
+
+	ql = q;
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (C1 ^ i)) {
+			tst_res(TFAIL, "Mismatch at offset %lu, got: %u, expected: %lu",
+					i, ql[i], C1 ^ i);
+			goto cleanup;
+		}
+	}
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++)
+		ql[i] = C2 ^ i;
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (C2 ^ i)) {
+			tst_res(TFAIL, "PRIVATE mismatch at offset %lu, got: %u, expected: %lu",
+					i, ql[i], C2 ^ i);
+			goto cleanup;
+		}
+	}
+
+	for (i = 0; i < (hpage_size / sizeof(*pl)); i++) {
+		if (pl[i] != (C1 ^ i)) {
+			tst_res(TFAIL, "SHARED map contaminated at offset %lu, "
+					"got: %u, expected: %lu", i, pl[i], C1 ^ i);
+			goto cleanup;
+		}
+	}
+
+	memset(p, 0, hpage_size);
+
+	for (i = 0; i < (hpage_size / sizeof(*ql)); i++) {
+		if (ql[i] != (C2 ^ i)) {
+			tst_res(TFAIL, "PRIVATE map contaminated at offset %lu, "
+					"got: %u, expected: %lu", i, ql[i], C2 ^ i);
+			goto cleanup;
+		}
+	}
+	tst_res(TPASS, "Successfully tested shared/private mmaping and its data");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, hpage_size);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
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
