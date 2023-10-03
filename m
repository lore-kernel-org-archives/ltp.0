Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A52E7AD46
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 13:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 392CF3CF019
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 15:38:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56CF3CC38E
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 15:38:02 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD28D600BC0
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 15:38:00 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 393DWf1F029551 for <ltp@lists.linux.it>; Tue, 3 Oct 2023 13:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=63+VVA2t1iylV4fxjgi6QTcxBywGXg+1zL8IHHXojkI=;
 b=QwflXvg5bY69hhIbBgakDb74tJig//LvQ/8b0Eeiu7HKhEGEJW9pbkkP3a6yT7/ZzlH/
 nHCIytdlUYu7bGR8mn7rz/BhDBaFb2DArbpj8Oa8L78/+nildy7NoOCOFTS80tMX+9Un
 vUDoFiKAd2Scypou4p/90/m0jMOeH/+QIWKe3mb9uouhYi1JJVxAs+Dt7gF84TmKM1FR
 hEJbt7Djd5kmax7iNa5lBnTTqfOMRHKzKzIp8FLOsTq4R1tsRhyhTyklVFPGhyJBkH5u
 UqGsNSDk0+Tu1Tgu3e81HHpd8pssgY4lNABN1AwU2t5TGnjpGKr5MEko9iDDc/RTO+Ul bg== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgkww0fp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 03 Oct 2023 13:37:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 393DEG50005869 for <ltp@lists.linux.it>; Tue, 3 Oct 2023 13:37:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0sjjkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 03 Oct 2023 13:37:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 393Dblj320579050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Oct 2023 13:37:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2769920040;
 Tue,  3 Oct 2023 13:37:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD4320043;
 Tue,  3 Oct 2023 13:37:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.46.125])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  3 Oct 2023 13:37:46 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  3 Oct 2023 19:07:03 +0530
Message-Id: <20231003133703.98552-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bKLIXdo5iJbDmn5JaR2zGjEoe-ICEyD1
X-Proofpoint-ORIG-GUID: bKLIXdo5iJbDmn5JaR2zGjEoe-ICEyD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=494 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030099
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH] Migrating the
 libhugetlbfs/testcases/straddle_4GB.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test Description:
This test tries to allocate hugepages to cover a memory range
that straddles the 4GB boundary.

Signed-off-by: Geetika <geetika@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap40.c  | 145 ++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  42 +++++
 4 files changed, 189 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..da37dc815 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap40 hugemmap40
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..dd1858a4a 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap40
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
new file mode 100644
index 000000000..1ba070831
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
+ */
+
+/*\
+ * [Description]
+ * This test tries to allocate hugepages to cover a memory range
+ * that straddles the 4GB boundary.
+ * Scenario 1 : mmap without MAP_FIXED
+ * Scenario 2 : mmap with MAP_FIXED
+ *
+ */
+
+#define MAPS_BUF_SZ 4096
+#define FOURGB (1UL << 32)
+#define MNTPOINT "hugetlbfs/"
+#define HUGETLBFS_MAGIC	0x958458f6
+#define _LARGEFILE64_SOURCE /* Need this for statfs64 */
+
+#include "hugetlb.h"
+
+static long hpage_size;
+static int fd = -1;
+static unsigned long straddle_addr;
+
+static int test_addr_huge(void *p)
+{
+	char name[256];
+	char *dirend;
+	int ret;
+	struct statfs64 sb;
+
+	ret = read_maps((unsigned long)p, name);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		tst_res(TINFO, "Couldn't find address %p in /proc/self/maps\n", p);
+		return -1;
+	}
+	/* looks like a filename? */
+	if (name[0] != '/')
+		return 0;
+
+	/* Truncate the filename portion */
+
+	dirend = strrchr(name, '/');
+	if (dirend && dirend > name)
+		*dirend = '\0';
+
+	ret = statfs64(name, &sb);
+	if (ret)
+		return -1;
+
+	return (sb.f_type == HUGETLBFS_MAGIC);
+}
+
+static void run_test(void)
+{
+	void *p;
+
+	/* We first try to get the mapping without MAP_FIXED */
+	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (p == (void *)straddle_addr) {
+		/* These tests irrelevant if we didn't get the straddle address*/
+		if (test_addr_huge(p) != 1) {
+			tst_brk(TFAIL, "1st Mapped address is not hugepage");
+			goto windup;
+		}
+		if (test_addr_huge(p + hpage_size) != 1) {
+			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
+			goto windup;
+		}
+		memset(p, 0, hpage_size);
+		memset(p + hpage_size, 0, hpage_size);
+		tst_res(TPASS, "Mapping without MAP_FIXED at %lx... completed", straddle_addr);
+	} else {
+		tst_res(TINFO, "Got %p instead, never mind, let's move to mapping with MAP_FIXED\n", p);
+		munmap(p, 2*hpage_size);
+	}
+	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+				MAP_SHARED|MAP_FIXED, fd, 0);
+	if (p == MAP_FAILED) {
+		/* this area crosses last low slice and first high slice */
+		unsigned long below_start = FOURGB - 256L*1024*1024;
+		unsigned long above_end = 1024L*1024*1024*1024;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			tst_res(TINFO, "region (4G-256M)-1T is not free");
+			tst_res(TINFO, "mmap() failed: %s\n", strerror(errno));
+			tst_res(TWARN, "Pass Inconclusive!");
+			goto windup;
+		} else
+			tst_res(TFAIL, "mmap() FIXED failed: %s\n", strerror(errno));
+	}
+		if (p != (void *)straddle_addr) {
+			tst_res(TINFO, "got %p instead\n", p);
+			tst_res(TFAIL, "Wrong address with MAP_FIXED");
+			goto windup;
+		}
+
+		if (test_addr_huge(p) != 1) {
+			tst_brk(TFAIL, "1st Mapped address is not hugepage");
+			goto windup;
+		}
+		if (test_addr_huge(p + hpage_size) != 1) {
+			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
+			goto windup;
+		}
+		memset(p, 0, hpage_size);
+		memset(p + hpage_size, 0, hpage_size);
+		tst_res(TPASS, "Mapping with MAP_FIXED at %lx... completed", straddle_addr);
+
+windup:
+	SAFE_MUNMAP(p, 2*hpage_size);
+}
+
+static void setup(void)
+{
+	straddle_addr = FOURGB - hpage_size;
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	if (hpage_size > FOURGB)
+		tst_brk(TCONF, "Huge page size is too large!");
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
+	.hugepages = {2, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 43a677ce9..39f101517 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -130,3 +130,45 @@ int do_readback(void *p, size_t size, char *desc)
 	}
 	return 0;
 }
+
+#define MAPS_BUF_SZ 4096
+int read_maps(unsigned long addr, char *buf)
+{
+        FILE *f;
+        char line[MAPS_BUF_SZ];
+        char *tmp;
+
+        f = fopen("/proc/self/maps", "r");
+        if (!f) {
+                tst_res(TFAIL, "Failed to open /proc/self/maps: %s\n", strerror(errno));
+                return -1;
+        }
+
+        while (1) {
+                unsigned long start, end, off, ino;
+                int ret;
+
+                tmp = fgets(line, MAPS_BUF_SZ, f);
+                if (!tmp)
+                        break;
+
+                buf[0] = '\0';
+                ret = sscanf(line, "%lx-%lx %*s %lx %*s %ld %255s",
+                             &start, &end, &off, &ino,
+                             buf);
+                if ((ret < 4) || (ret > 5)) {
+                        tst_res(TFAIL, "Couldn't parse /proc/self/maps line: %s\n",
+                                        line);
+                        fclose(f);
+                        return -1;
+                }
+
+                if ((start <= addr) && (addr < end)) {
+                        fclose(f);
+                        return 1;
+                }
+        }
+
+        fclose(f);
+        return 0;
+}
-- 
2.39.2 (Apple Git-143)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
