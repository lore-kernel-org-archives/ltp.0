Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67271C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A3EB3CCDF3
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:23:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 105353CCDD9
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:01 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38EC81A00881
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:59 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304CEigY014753; Wed, 4 Jan 2023 12:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gLXstMwmzLJPRhNSzXt908nHrg3Qc100MWyU3ltVVp4=;
 b=DjSM25YyzkTzeUH2j7hZ0kXGjOs+AUcujcOs4Vg6X0YV5IQvduANRPlXGVhp7o1+pyQp
 Qj9KFH+wQ8jfuF32kDl0m4124+RREQeN1nNeLhCGDUf7IInssLOXAdOKpBAhja4lR5E1
 yZngrwxOLwkz0DJDAwqEdOMPPkoVjx/KqrRhMQ4pN7ZX2qGiZ9VhP2VNc619d160w4Zo
 ohST9Z0sn35SPZCEXtcauGrGobMZ8KYG0zr/Wonnq10AZOZbx/Ax8IgFGSnhGZqC+eLS
 22hX+O29wzHE0DqJGayxBF174jhf/2QbZllknfy96xlfLIpL9I8gkf+DmlQuYV0X+Slw fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw99p85ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:58 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CFMrY018522;
 Wed, 4 Jan 2023 12:22:57 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw99p85ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303H2vPC028210;
 Wed, 4 Jan 2023 12:22:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6uukh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMq3h24314250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4663A20040;
 Wed,  4 Jan 2023 12:22:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E087E20049;
 Wed,  4 Jan 2023 12:22:48 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:48 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:16 +0530
Message-Id: <20230104122224.369467-6-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -9UR3kCblDfwY7gmqU8OfjL2mHIVzv7x
X-Proofpoint-ORIG-GUID: 7uvG5b3oZ62JC5bimAYgF0whsCh3RSt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040102
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/13] Hugetlb: Migrating libhugetlbfs
 mremap-fixed-huge-near-normal
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

Migrating the libhugetlbfs/testcases/mremap-fixed-huge-near-normal.c test

Test Description: The kernel has bug for mremap() on some architecture.
mremap() can cause crashes on architectures with holes in the address
space (like ia64) and on powerpc with it's distinct page size "slices".

This test get the normal mapping address and mremap() hugepage mapping
near to this normal mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  | 118 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  19 +++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   2 +-
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8ade3c9ec..65265b0fe 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -25,6 +25,7 @@ hugemmap20 hugemmap20
 hugemmap21 hugemmap21
 hugemmap22 hugemmap22
 hugemmap23 hugemmap23
+hugemmap25 hugemmap25
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ffd831f2e..c865a1e55 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -24,6 +24,7 @@
 /hugetlb/hugemmap/hugemmap21
 /hugetlb/hugemmap/hugemmap22
 /hugetlb/hugemmap/hugemmap23
+/hugetlb/hugemmap/hugemmap25
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
new file mode 100644
index 000000000..055a430e2
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2009 IBM Corporation.
+ * Author: David Gibson
+ */
+
+/*\
+ * [Description]
+ *
+ * The kernel has bug for mremap() on some architecture. mremap() can
+ * cause crashes on architectures with holes in the address space
+ * (like ia64) and on powerpc with it's distinct page size "slices".
+ *
+ * This test get the normal mapping address and mremap() hugepage mapping
+ * near to this normal mapping.
+ */
+
+#define _GNU_SOURCE
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static int fd = -1;
+static long hpage_size;
+
+static int do_remap(int fd, void *target)
+{
+	void *a, *b;
+	int ret;
+
+	a = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	ret = do_readback(a, hpage_size, "base huge");
+	if (ret)
+		goto cleanup;
+	b = mremap(a, hpage_size, hpage_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		   target);
+
+	if (b != MAP_FAILED) {
+		ret = do_readback(b, hpage_size, "remapped");
+		a = b;
+	} else
+		tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
+cleanup:
+	SAFE_MUNMAP(a, hpage_size);
+	return ret;
+}
+
+static void *map_align(size_t size, size_t align)
+{
+	unsigned long xsize = size + align - getpagesize();
+	size_t t;
+	void *p, *q;
+
+	p = SAFE_MMAP(NULL, xsize, PROT_READ|PROT_WRITE,
+		 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	q = PALIGN(p, align);
+
+	t = q - p;
+	if (t)
+		SAFE_MUNMAP(p, t);
+
+	t = p + xsize - (q + size);
+	if (t)
+		SAFE_MUNMAP(q + size, t);
+
+	return q;
+}
+
+static void run_test(void)
+{
+	void *p;
+	int ret;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = map_align(3*hpage_size, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(p + 2*hpage_size, hpage_size);
+
+	p = p + hpage_size;
+
+	tst_res(TINFO, "Normal mapping at %p", p);
+	ret = do_readback(p, hpage_size, "base normal page");
+	if (ret)
+		goto cleanup;
+	ret = do_remap(fd, p - hpage_size);
+	if (ret)
+		goto cleanup;
+	ret = do_remap(fd, p + hpage_size);
+	if (ret == 0)
+		tst_res(TPASS, "Successfully tested mremap hpage near normal mapping");
+cleanup:
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
+	.hugepages = {3, TST_NEEDS},
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 1204f21d2..43a677ce9 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -111,3 +111,22 @@ void rm_shm(int shm_id)
 		tst_res(TINFO, "id = %d", shm_id);
 	}
 }
+
+#define RANDOM_CONSTANT 0x1234ABCD
+int do_readback(void *p, size_t size, char *desc)
+{
+	unsigned int *q = p;
+	size_t i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++)
+		q[i] = RANDOM_CONSTANT ^ i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++) {
+		if (q[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "At \"%s\": Mismatch at offset 0x%lx: 0x%x "
+					"instead of 0x%lx", desc, i, q[i], RANDOM_CONSTANT ^ i);
+			return -1;
+		}
+	}
+	return 0;
+}
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index efca65cd6..241dab708 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -50,5 +50,5 @@ extern key_t shmkey;			/* an IPC key generated by ftok() */
 int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
-
+int do_readback(void *p, size_t size, char *desc);
 #endif /* hugetlb.h */
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
