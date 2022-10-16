Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D240C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:01:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE6D73CAF9F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:01:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501FC3CAFC2
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:09 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C5B360064D
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:07 +0200 (CEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9C76H034424
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mOksoO+cv5a9UE8zSVSsuxAoOEBw2IzRjf4rUW+n6cM=;
 b=HtDTNHY3BB0H95URwYrAD/MVH6R3iMcmwKXxtyPoZ4+HyL7I9YwOK6miJNgWoLiwKObc
 W2lmtmAIDAItO1H5pZTfZ+rtn0CMKihZYxUjJcXp9BqsoDAXLMdgz0oCCF124Y0lGjOv
 t9AOp2p0gPnBw3SRFbP6MrSzPK+80lNF2uxW/JiO5lQTcCPi+6wkCcFy5rLo8VKhGHBv
 Qt2C/EbkpIHTVMnJ7SxSIiAR/VMOWlEkid7wyMzxbgv5C4DpQ6/j//s9nd6NJ5JOCOKH
 ynqUhG3zXkUtHc6OX8tmJFtBE/sbLG3nbdwKcHRT2Jc8AbZoI7jsve25RtoBoFemw7Hz rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86ufmcxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCopQi009285
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jhm2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCxXhR53084554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B52EA11C04C;
 Sun, 16 Oct 2022 12:59:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7094511C04A;
 Sun, 16 Oct 2022 12:58:58 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:58 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:13 +0530
Message-Id: <20221016125731.249078-12-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NRCYdfmHe6QdY0jXKP5hV9LsrYPIlBWd
X-Proofpoint-ORIG-GUID: NRCYdfmHe6QdY0jXKP5hV9LsrYPIlBWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 11/29] Hugetlb: Migrating libhugetlbfs
 huge_below_4GB_normal_above
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

Migrating the libhugetlbfs/testcases/huge_below_4GB_normal_above.c test

Test Description: Designed to pick up a bug on ppc64 where
touches_hugepage_low_range() could give false positives because of the
peculiar (undefined) behaviour of << for large shifts

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 204 ++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2029ee4b3..796ebe7fa 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -15,6 +15,7 @@ hugemmap10 hugemmap10
 hugemmap11 hugemmap11
 hugemmap12 hugemmap12
 hugemmap13 hugemmap13
+hugemmap14 hugemmap14
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 5955ed613..3106579ce 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -14,6 +14,7 @@
 /hugetlb/hugemmap/hugemmap11
 /hugetlb/hugemmap/hugemmap12
 /hugetlb/hugemmap/hugemmap13
+/hugetlb/hugemmap/hugemmap14
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
new file mode 100644
index 000000000..c49f13935
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Huge_below_4GB_normal_above
+ *
+ * Test Description: Designed to pick up a bug on ppc64 where
+ * touches_hugepage_low_range() could give false positives because of the
+ * peculiar (undefined) behaviour of << for large shifts
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed.  Don't mess with them
+ * unless you *really* know what you're doing.
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
+
+#include "hugetlb.h"
+
+#define FOURGB (1UL << 32)
+
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static unsigned long hpage_size;
+static char *verbose;
+
+static void run_test(void)
+{
+	int page_size;
+	void *p, *q, *r;
+	unsigned long lowaddr, highaddr;
+	int err;
+
+	page_size = getpagesize();
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	/* We use a low address right below 4GB so we can test for
+	 * off-by-one errors
+	 */
+	lowaddr = FOURGB - hpage_size;
+	if (verbose)
+		tst_res(TINFO, "Mapping hugepage at %lx...", lowaddr);
+	p = mmap((void *)lowaddr, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED, fd, 0);
+	if (p == MAP_FAILED) {
+		/* This is last low slice - 256M just before 4G */
+		unsigned long below_start = FOURGB - 256L*1024*1024;
+		unsigned long above_end = FOURGB;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			if (verbose) {
+				tst_res(TINFO, "region (4G-256M)-4G is not free");
+				tst_res(TINFO|TERRNO, "mmap() failed");
+			}
+			tst_res(TPASS, "Successful but inconclusive");
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL|TERRNO, "mmap() huge");
+		goto fail;
+	}
+	if (p != (void *)lowaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED huge");
+		goto fail;
+	}
+	if (verbose)
+		tst_res(TINFO, "done");
+	memset(p, 0, hpage_size);
+
+	err = test_addr_huge(p);
+	if (err != 1) {
+		tst_res(TFAIL, "Mapped address is not hugepage");
+		goto fail;
+	}
+
+	/* Test for off by one errors */
+	highaddr = FOURGB;
+	if (verbose)
+		tst_res(TINFO, "Mapping normal page at %lx...", highaddr);
+	q = mmap((void *)highaddr, page_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
+	if (q == MAP_FAILED) {
+		unsigned long below_start = FOURGB;
+		unsigned long above_end = FOURGB + page_size;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			if (verbose) {
+				tst_res(TINFO, "region 4G-(4G+page) is not free\n");
+				tst_res(TINFO|TERRNO, "mmap() failed");
+			}
+			tst_res(TPASS, "Successful but inconclusive");
+			SAFE_MUNMAP(p, hpage_size);
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL|TERRNO, "mmap() normal 1");
+		goto fail;
+	}
+	if (q != (void *)highaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED normal 2");
+		goto fail;
+	}
+	if (verbose)
+		tst_res(TINFO, "done");
+
+	memset(q, 0, page_size);
+
+	/* Why this address?  Well on ppc64, we're working with 256MB
+	 * segment numbers, hence >>28.  In practice the shift
+	 * instructions only start wrapping around with shifts 128 or
+	 * greater.
+	 */
+	highaddr = ((lowaddr >> 28) + 128) << 28;
+	if (verbose)
+		tst_res(TINFO, "Mapping normal page at %lx...", highaddr);
+	r = mmap((void *)highaddr, page_size, PROT_READ|PROT_WRITE,
+		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
+	if (r == MAP_FAILED) {
+		unsigned long below_start = highaddr;
+		unsigned long above_end = highaddr + page_size;
+
+		if (range_is_mapped(below_start, above_end) == 1) {
+			if (verbose) {
+				tst_res(TINFO, "region haddr-(haddr+page) not free");
+				tst_res(TINFO|TERRNO, "mmap() failed");
+			}
+			tst_res(TPASS, "Successful but inconclusive");
+			SAFE_MUNMAP(p, hpage_size);
+			SAFE_MUNMAP(q, page_size);
+			SAFE_CLOSE(fd);
+			return;
+		}
+		tst_res(TFAIL|TERRNO, "mmap() normal 2");
+		goto fail;
+	}
+	if (r != (void *)highaddr) {
+		tst_res(TFAIL, "Wrong address with MAP_FIXED normal 2");
+		goto fail;
+	}
+	if (verbose)
+		tst_res(TINFO, "done");
+
+	memset(r, 0, page_size);
+	tst_res(TPASS, "Successful");
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, page_size);
+	SAFE_MUNMAP(r, page_size);
+	SAFE_CLOSE(fd);
+	return;
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
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (sizeof(void *) <= 4)
+		tst_brk(TCONF, "Machine must be >32 bit");
+
+	if (hpage_size > FOURGB)
+		tst_brk(TCONF, "Huge page size is too large");
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
