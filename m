Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BE6C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:26:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E717B3CD03D
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 12:26:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DACF3CD047
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:27 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F259A60042C
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:26 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AGAp1qt015165; Wed, 16 Nov 2022 11:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BpGAA/UZtoo5NDRggMJcFdUeQMojpgbdfMqLOhfvezc=;
 b=stDu8Y8CpMdkcA9Ly48LNobMPUCVdSDo1pNiBr4JtwvxoKrfYIDfMePI5ZQ2bAugHSeD
 PxBlFSu/tVKMDx5oIN21m941tNpbBqJx3PEo+X3uBUlngUJKwE8JhxwraaYhT4qns0Ef
 kyXkToVpNbbINQdYqxKZ8ypDAw7HKSt2u7x/FiBBhtc/phsAixImJn37O55fx6tJHivV
 Na8z2+zuA9oMyo9xf03/eyUE8Q8BB2OlKPp/f40wSmRSnLf8Wo1RG3H5XJ6AuIteO0z8
 oltMj5rOSVwtMYSnZIWEpfwgL1wwODAgkMRHNlUYFzQYmj3fAkVJGzG81pek6WeK3RsI 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxfmgw06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:25 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGAxBNk015719;
 Wed, 16 Nov 2022 11:26:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxfmgvyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGBLgEO008349;
 Wed, 16 Nov 2022 11:26:22 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3kt348wt25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2AGBQxXa40632596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Nov 2022 11:26:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69B6242041;
 Wed, 16 Nov 2022 11:26:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 214744203F;
 Wed, 16 Nov 2022 11:26:17 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Nov 2022 11:26:16 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 16 Nov 2022 16:55:11 +0530
Message-Id: <20221116112516.261535-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116112516.261535-1-tsahu@linux.ibm.com>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sNxNPnInZbydeCQGoezry2jjkJP8oy1G
X-Proofpoint-GUID: vFXqvKRBG8Nx-0FIYPHfUgSXaRV1bpVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_02,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160078
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/7] Hugetlb: Migrating libhugetlbfs counters
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
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/counters.c test

Test Description: This Test perform mmap and unmap and write operation on
hugetlb file based mapping. Mapping can be shared or private. and it
checks for Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo
and compare them with expected (calculated) value. if all checks are
successful, the test passes.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 462 ++++++++++++++++++
 3 files changed, 464 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index e2ada7a97..8a56d52a3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -6,6 +6,7 @@ hugemmap06 hugemmap06
 hugemmap07 hugemmap07
 hugemmap08 hugemmap08
 hugemmap09 hugemmap09
+hugemmap10 hugemmap10
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 1a242ffe0..e7def68cb 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -7,6 +7,7 @@
 /hugetlb/hugemmap/hugemmap07
 /hugetlb/hugemmap/hugemmap08
 /hugetlb/hugemmap/hugemmap09
+/hugetlb/hugemmap/hugemmap10
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
new file mode 100644
index 000000000..a77db660f
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2007 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * This Test perform mmap and unmap and write operation on hugetlb file
+ * based mapping. Mapping can be shared or private. and it checks for
+ * Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo and
+ * compare them with expected (calculated) value. if all checks are
+ * successful, the test passes.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+#define CHECK_(fun)	\
+		{			\
+		if (fun)	\
+			break;	\
+	}
+
+static long hpage_size;
+static int private_resv;
+
+#define NR_SLOTS	2
+#define SL_SETUP	0
+#define SL_TEST		1
+static int map_fd[NR_SLOTS];
+static char *map_addr[NR_SLOTS];
+static unsigned long map_size[NR_SLOTS];
+static unsigned int touched[NR_SLOTS];
+
+static long prev_total;
+static long prev_free;
+static long prev_resv;
+static long prev_surp;
+
+static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
+{
+	*total = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
+	*free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+	*resv = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	*surp = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
+}
+
+static int kernel_has_private_reservations(void)
+{
+	int fd;
+	long t, f, r, s;
+	long nt, nf, nr, ns;
+	void *map;
+
+	read_meminfo_huge(&t, &f, &r, &s);
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+
+	map = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	read_meminfo_huge(&nt, &nf, &nr, &ns);
+
+	SAFE_MUNMAP(map, hpage_size);
+	SAFE_CLOSE(fd);
+
+	/*
+	 * There are only three valid cases:
+	 * 1) If a surplus page was allocated to create a reservation, all
+	 *    four pool counters increment
+	 * 2) All counters remain the same except for Hugepages_Rsvd, then
+	 *    a reservation was created using an existing pool page.
+	 * 3) All counters remain the same, indicates that no reservation has
+	 *    been created
+	 */
+	if ((nt == t + 1) && (nf == f + 1) && (ns == s + 1) && (nr == r + 1))
+		return 1;
+	else if ((nt == t) && (nf == f) && (ns == s)) {
+		if (nr == r + 1)
+			return 1;
+		else if (nr == r)
+			return 0;
+	}
+	tst_brk(TCONF, "bad counter state - "
+	      "T:%li F:%li R:%li S:%li -> T:%li F:%li R:%li S:%li",
+		  t, f, r, s, nt, nf, nr, ns);
+	return -1;
+}
+
+static int verify_counters(int line, char *desc, long et, long ef, long er, long es)
+{
+	long t, f, r, s;
+	long fail = 0;
+
+	read_meminfo_huge(&t, &f, &r, &s);
+
+	if (t != et) {
+		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_TOTAL
+				" expected %li, actual %li", line, desc, et, t);
+		fail++;
+	}
+	if (f != ef) {
+		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_FREE
+				" expected %li, actual %li", line, desc, ef, f);
+		fail++;
+	}
+	if (r != er) {
+		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_RSVD
+				" expected %li, actual %li", line, desc, er, r);
+		fail++;
+	}
+	if (s != es) {
+		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_SURP
+				" expected %li, actual %li", line, desc, es, s);
+		fail++;
+	}
+
+	if (fail)
+		return -1;
+
+	prev_total = t;
+	prev_free = f;
+	prev_resv = r;
+	prev_surp = s;
+	return 0;
+}
+
+/* Memory operations:
+ * Each of these has a predefined effect on the counters
+ */
+static int set_nr_hugepages_(long count, char *desc, int line)
+{
+	long min_size;
+	long et, ef, er, es;
+
+	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", count);
+
+	/* The code below is based on set_max_huge_pages in mm/hugetlb.c */
+	es = prev_surp;
+	et = prev_total;
+	ef = prev_free;
+	er = prev_resv;
+
+	/*
+	 * Increase the pool size
+	 * First take pages out of surplus state.  Then make up the
+	 * remaining difference by allocating fresh huge pages.
+	 */
+	while (es && count > et - es)
+		es--;
+	while (count > et - es) {
+		et++;
+		ef++;
+	}
+	if (count >= et - es)
+		goto out;
+
+	/*
+	 * Decrease the pool size
+	 * First return free pages to the buddy allocator (being careful
+	 * to keep enough around to satisfy reservations).  Then place
+	 * pages into surplus state as needed so the pool will shrink
+	 * to the desired size as pages become free.
+	 */
+	min_size = MAX(count, er + et - ef);
+	while (min_size < et - es) {
+		ef--;
+		et--;
+	}
+	while (count < et - es)
+		es++;
+
+out:
+	return verify_counters(line, desc, et, ef, er, es);
+}
+#define set_nr_hugepages(c, d) CHECK_(set_nr_hugepages_(c, d, __LINE__))
+
+static int map_(int s, int hpages, int flags, char *desc, int line)
+{
+	long et, ef, er, es;
+
+	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0);
+	map_size[s] = hpages * hpage_size;
+	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
+				map_fd[s], 0);
+	touched[s] = 0;
+
+	et = prev_total;
+	ef = prev_free;
+	er = prev_resv;
+	es = prev_surp;
+	/*
+	 * When using MAP_SHARED, a reservation will be created to guarantee
+	 * pages to the process.  If not enough pages are available to
+	 * satisfy the reservation, surplus pages are added to the pool.
+	 * NOTE: This code assumes that the whole mapping needs to be
+	 * reserved and hence, will not work with partial reservations.
+	 *
+	 * If the kernel supports private reservations, then MAP_PRIVATE
+	 * mappings behave like MAP_SHARED at mmap time.  Otherwise,
+	 * no counter updates will occur.
+	 */
+	if ((flags & MAP_SHARED) || private_resv) {
+		unsigned long shortfall = 0;
+
+		if (hpages + prev_resv > prev_free)
+			shortfall = hpages - prev_free + prev_resv;
+		et += shortfall;
+		ef += shortfall;
+		er += hpages;
+		es += shortfall;
+	}
+
+	return verify_counters(line, desc, et, ef, er, es);
+}
+#define map(s, h, f, d) CHECK_(map_(s, h, f, d, __LINE__))
+
+static int unmap_(int s, int hpages, int flags, char *desc, int line)
+{
+	long et, ef, er, es;
+	unsigned long i;
+
+	SAFE_MUNMAP(map_addr[s], map_size[s]);
+	SAFE_CLOSE(map_fd[s]);
+	map_addr[s] = NULL;
+	map_size[s] = 0;
+
+	et = prev_total;
+	ef = prev_free;
+	er = prev_resv;
+	es = prev_surp;
+
+	/*
+	 * When a VMA is unmapped, the instantiated (touched) pages are
+	 * freed.  If the pool is in a surplus state, pages are freed to the
+	 * buddy allocator, otherwise they go back into the hugetlb pool.
+	 * NOTE: This code assumes touched pages have only one user.
+	 */
+	for (i = 0; i < touched[s]; i++) {
+		if (es) {
+			et--;
+			es--;
+		} else
+			ef++;
+	}
+
+	/*
+	 * mmap may have created some surplus pages to accommodate a
+	 * reservation.  If those pages were not touched, then they will
+	 * not have been freed by the code above.  Free them here.
+	 */
+	if ((flags & MAP_SHARED) || private_resv) {
+		int unused_surplus = MIN(hpages - touched[s], es);
+
+		et -= unused_surplus;
+		ef -= unused_surplus;
+		er -= hpages - touched[s];
+		es -= unused_surplus;
+	}
+
+	return verify_counters(line, desc, et, ef, er, es);
+}
+#define unmap(s, h, f, d) CHECK_(unmap_(s, h, f, d, __LINE__))
+
+static int touch_(int s, int hpages, int flags, char *desc, int line)
+{
+	long et, ef, er, es;
+	int nr;
+	char *c;
+
+	for (c = map_addr[s], nr = hpages;
+			hpages && c < map_addr[s] + map_size[s];
+			c += hpage_size, nr--)
+		*c = (char) (nr % 2);
+	/*
+	 * Keep track of how many pages were touched since we can't easily
+	 * detect that from user space.
+	 * NOTE: Calling this function more than once for a mmap may yield
+	 * results you don't expect.  Be careful :)
+	 */
+	touched[s] = MAX(touched[s], hpages);
+
+	/*
+	 * Shared (and private when supported) mappings and consume resv pages
+	 * that were previously allocated. Also deduct them from the free count.
+	 *
+	 * Unreserved private mappings may need to allocate surplus pages to
+	 * satisfy the fault.  The surplus pages become part of the pool
+	 * which could elevate total, free, and surplus counts.  resv is
+	 * unchanged but free must be decreased.
+	 */
+	if (flags & MAP_SHARED || private_resv) {
+		et = prev_total;
+		ef = prev_free - hpages;
+		er = prev_resv - hpages;
+		es = prev_surp;
+	} else {
+		if (hpages + prev_resv > prev_free)
+			et = prev_total + (hpages - prev_free + prev_resv);
+		else
+			et = prev_total;
+		er = prev_resv;
+		es = prev_surp + et - prev_total;
+		ef = prev_free - hpages + et - prev_total;
+	}
+	return verify_counters(line, desc, et, ef, er, es);
+}
+#define touch(s, h, f, d) CHECK_(touch_(s, h, f, d, __LINE__))
+
+static int test_counters_(char *desc, int base_nr)
+{
+	int fail = 1;
+
+	tst_res(TINFO, "%s...", desc);
+
+	do {
+		set_nr_hugepages(base_nr, "initializing hugepages pool");
+
+		/* untouched, shared mmap */
+		map(SL_TEST, 1, MAP_SHARED, "doing mmap shared with no touch");
+		unmap(SL_TEST, 1, MAP_SHARED, "doing munmap on shared with no touch");
+
+		/* untouched, private mmap */
+		map(SL_TEST, 1, MAP_PRIVATE, "doing mmap private with no touch");
+		unmap(SL_TEST, 1, MAP_PRIVATE, "doing munmap private with on touch");
+
+		/* touched, shared mmap */
+		map(SL_TEST, 1, MAP_SHARED, "doing mmap shared followed by touch");
+		touch(SL_TEST, 1, MAP_SHARED, "touching the addr after mmap shared");
+		unmap(SL_TEST, 1, MAP_SHARED, "doing munmap shared after touch");
+
+		/* touched, private mmap */
+		map(SL_TEST, 1, MAP_PRIVATE, "doing mmap private followed by touch");
+		touch(SL_TEST, 1, MAP_PRIVATE, "touching the addr after mmap private");
+		unmap(SL_TEST, 1, MAP_PRIVATE, "doing munmap private after touch");
+
+		/* Explicit resizing during outstanding surplus */
+		/* Consume surplus when growing pool */
+		map(SL_TEST, 2, MAP_SHARED, "doing mmap to consume surplus");
+		set_nr_hugepages(MAX(base_nr, 1), "setting hugepages pool to consume surplus");
+
+		/* Add pages once surplus is consumed */
+		set_nr_hugepages(MAX(base_nr, 3), "Adding more pages after consuming surplus");
+
+		/* Release free huge pages first */
+		set_nr_hugepages(MAX(base_nr, 2), "Releasing free huge pages");
+
+		/* When shrinking beyond committed level, increase surplus */
+		set_nr_hugepages(base_nr, "increasing surplus counts");
+
+		/* Upon releasing the reservation, reduce surplus counts */
+		unmap(SL_TEST, 2, MAP_SHARED, "reducing surplus counts");
+		fail = 0;
+	} while (0);
+
+	if (fail)
+		return -1;
+	tst_res(TINFO, "OK");
+	return 0;
+}
+
+#define test_counters(a, b) CHECK_(test_counters_(a, b))
+
+static void per_iteration_cleanup(void)
+{
+	int nr;
+
+	prev_total = 0;
+	prev_free = 0;
+	prev_resv = 0;
+	prev_surp = 0;
+	for (nr = 0; nr < NR_SLOTS; nr++) {
+		if (map_addr[nr])
+			SAFE_MUNMAP(map_addr[nr], map_size[nr]);
+		if (map_fd[nr] > 0)
+			SAFE_CLOSE(map_fd[nr]);
+	}
+}
+
+static void run_test(void)
+{
+	int base_nr;
+
+	for (base_nr = 0; base_nr <= 3; base_nr++) {
+		tst_res(TINFO, "Base pool size: %i", base_nr);
+		/* Run the tests with a clean slate */
+		test_counters("Clean", base_nr);
+
+		/* Now with a pre-existing untouched, shared mmap */
+		map(SL_SETUP, 1, MAP_SHARED,
+				"doing mmap for running pre-existing untouched shared mapping test");
+		test_counters("Untouched, shared", base_nr);
+		unmap(SL_SETUP, 1, MAP_SHARED,
+				"doing munmap after running pre-existing untouched shared mapping test");
+
+		/* Now with a pre-existing untouched, private mmap */
+		map(SL_SETUP, 1, MAP_PRIVATE,
+				"doing mmap for running pre-existing untouched private mapping test");
+		test_counters("Untouched, private", base_nr);
+		unmap(SL_SETUP, 1, MAP_PRIVATE,
+				"doing munmap after running pre-existing untouced private mapping test");
+
+		/* Now with a pre-existing touched, shared mmap */
+		map(SL_SETUP, 1, MAP_SHARED,
+				"doing mmap for running pre-existing touched shared mapping test");
+		touch(SL_SETUP, 1, MAP_SHARED,
+				"touching for running pre-existing touched shared mapping test");
+		test_counters("Touched, shared", base_nr);
+		unmap(SL_SETUP, 1, MAP_SHARED,
+				"doing munmap after running pre-existing touched shared mapping test");
+
+		/* Now with a pre-existing touched, private mmap */
+		map(SL_SETUP, 1, MAP_PRIVATE,
+				"doing mmap for running pre-existing touched private mapping test");
+		touch(SL_SETUP, 1, MAP_PRIVATE,
+				"touching for running pre-existing touched private mapping test");
+		test_counters("Touched, private", base_nr);
+		unmap(SL_SETUP, 1, MAP_PRIVATE,
+				"doing munmap after running pre-existing touched private mapping test");
+	}
+	if (base_nr > 3)
+		tst_res(TPASS, "Hugepages Counters works as expected.");
+	per_iteration_cleanup();
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%lu", tst_hugepages);
+	private_resv = kernel_has_private_reservations();
+}
+
+static void cleanup(void)
+{
+	per_iteration_cleanup();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_OC_HPAGES, NULL},
+		{PATH_NR_HPAGES, NULL},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
+
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
