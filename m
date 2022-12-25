Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB4C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:43:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D26F3CB8AC
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:43:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DC013CB8EA
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:49 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F1C001A002CA
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:48 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFcW4M003758; Sun, 25 Dec 2022 15:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KAsaxkz6Tae9ZRGR7AAOSv+ZhIC1lFNIQpJdTzqPEV0=;
 b=YtC2ztshSmbEyUd63EOQgoJMTFQDMIcgKW4RlOXIo2wt8HE+r3TIUtOcXovgRi4YQi7L
 /zP+UqTCyFqbr137MRaSwFXYTBDy9ZqkW+vz+kQJi3mG1JfwzO3BYc7i+8zjccUsnsaP
 Aq0hlH7lG01xjkdrdfotv065WcuajFrmkJ1zxiO7UjezvbA58cVZI7MOXGbHTEEuZczr
 +Au4VrcE0p3zijMZBS37IzH1Uc+sG8ZfW8jGw+xCgJ2bPdYStjl190B592lXZuqKIFva
 KPi6q91w9HAZ2u2n3mhaORoUYUipPCRmp/BEP6qi7HJr3d1Xi+Y8GPKg/OdIJiLrKqxd UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mprjcrmj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:47 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFeawh009976;
 Sun, 25 Dec 2022 15:42:46 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mprjcrmht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:46 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPAc2uM031312;
 Sun, 25 Dec 2022 15:42:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mns2691mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFge8j42795412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B633A20049;
 Sun, 25 Dec 2022 15:42:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CCD520040;
 Sun, 25 Dec 2022 15:42:37 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:36 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:05 +0530
Message-Id: <20221225154213.84183-6-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nUVnp5MO1DJZYZvdhUIYi0ivg586Q25l
X-Proofpoint-GUID: x_KaNIpjLAuR66NjAZ3y_9FzOXROOgUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/13] Hugetlb: Migrating libhugetlbfs
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  | 146 ++++++++++++++++++
 3 files changed, 148 insertions(+)
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
index 000000000..f8e99faf6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -0,0 +1,146 @@
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
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define RANDOM_CONSTANT	0x1234ABCD
+#define MNTPOINT "hugetlbfs/"
+
+static int  fd = -1;
+static long hpage_size;
+
+static int do_readback(void *p, size_t size, const char *stage)
+{
+	unsigned int *q = p;
+	size_t i;
+
+	tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
+	       (unsigned long)size, stage);
+
+	for (i = 0; i < (size / sizeof(*q)); i++)
+		q[i] = RANDOM_CONSTANT ^ i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++) {
+		if (q[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Stage \"%s\": Mismatch at offset 0x%lx: 0x%x "
+					"instead of 0x%lx", stage, i, q[i], RANDOM_CONSTANT ^ i);
+			return -1;
+		}
+	}
+	return 0;
+}
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
+	.hugepages = {3, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
