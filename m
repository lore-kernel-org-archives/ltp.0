Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC974C433FE
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 19:16:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D78833CCCA3
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 20:16:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83E1E3CCCB0
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 687041385625
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:54 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AKJ8PnL022033; Sun, 20 Nov 2022 19:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZCPEJhDwxcwvxYcoVmE32tU9y3IjuqkkXFn6fmnZfuE=;
 b=Em6wdthi5s25ZUNYRduFXheRjRCPiJmXwdO5iR3syOl/Th7GRteyWCaE66gkOJxcrlA1
 6xUVrKCPbM4M+D9fp+XMhJWogXMDBWdOZMo7jYqcvF5JLGvyuyPGRaN9m7fT49iaSDFC
 l/QMQ5kEjBcavUtbmMk1Hrt4BWhEi7vWY2JROPf9RltDEyxx9vthtZaqvZBYssYJ5NbY
 gv5oY+FjhPI1MZh5ZSCPyr2GVim1OLrg3Fr1ccVIxMrXhprm60311EDAkomE8gLnmYi6
 26sHQAvnK+Ue48t8rcKCb53t+yfwpI8PIjuyrOCf5fqdEo/4q+JKGDosmgFbz3dl8vFp fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky91jxnju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:53 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKJFLxV005318;
 Sun, 20 Nov 2022 19:15:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky91jxnjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKJ58IW027659;
 Sun, 20 Nov 2022 19:15:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 3kxpdhsmhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AKJFkNW64815420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Nov 2022 19:15:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC4345204F;
 Sun, 20 Nov 2022 19:15:46 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.36.159])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7E5C952051;
 Sun, 20 Nov 2022 19:15:43 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 00:45:28 +0530
Message-Id: <20221120191533.164848-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MaTqlrr24kYiA1q_C-htZDccs0s465pF
X-Proofpoint-GUID: G7RZO55DmeW5cipqd8b5pAQF-JsaB482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211200162
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/7] Hugetlb: Migrating libhugetlbfs counters
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

Test Description: This Test perform mmap, munmap and write operation on
hugetlb file based mapping. Mapping can be shared or private. and it
checks for Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo
and compare them with expected (calculated) value. If all checks are
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
index 000000000..b1b4de716
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
+ * This Test perform mmap, munmap and write operation on hugetlb file
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
+	void *p;
+
+	read_meminfo_huge(&t, &f, &r, &s);
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+
+	read_meminfo_huge(&nt, &nf, &nr, &ns);
+
+	SAFE_MUNMAP(p, hpage_size);
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
+		tst_res_(__FILE__, line, TFAIL, "While %s: Bad "MEMINFO_HPAGE_TOTAL
+				" expected %li, actual %li", desc, et, t);
+		fail++;
+	}
+	if (f != ef) {
+		tst_res_(__FILE__, line, TFAIL, "While %s: Bad "MEMINFO_HPAGE_FREE
+				" expected %li, actual %li", desc, ef, f);
+		fail++;
+	}
+	if (r != er) {
+		tst_res_(__FILE__, line, TFAIL, "While %s: Bad "MEMINFO_HPAGE_RSVD
+				" expected %li, actual %li", desc, er, r);
+		fail++;
+	}
+	if (s != es) {
+		tst_res_(__FILE__, line, TFAIL, "While %s: Bad "MEMINFO_HPAGE_SURP
+				" expected %li, actual %li", desc, es, s);
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
+#define SET_NR_HUGEPAGES(c, d) set_nr_hugepages_(c, d, __LINE__)
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
+#define MAP(s, h, f, d) map_(s, h, f, d, __LINE__)
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
+#define UNMAP(s, h, f, d) unmap_(s, h, f, d, __LINE__)
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
+#define TOUCH(s, h, f, d) touch_(s, h, f, d, __LINE__)
+
+static int test_counters(char *desc, int base_nr)
+{
+	tst_res(TINFO, "%s...", desc);
+
+	if (SET_NR_HUGEPAGES(base_nr, "initializing hugepages pool"))
+		return -1;
+
+	/* untouched, shared mmap */
+	if (MAP(SL_TEST, 1, MAP_SHARED, "doing mmap shared with no touch") ||
+		UNMAP(SL_TEST, 1, MAP_SHARED, "doing munmap on shared with no touch"))
+		return -1;
+
+	/* untouched, private mmap */
+	if (MAP(SL_TEST, 1, MAP_PRIVATE, "doing mmap private with no touch") ||
+		UNMAP(SL_TEST, 1, MAP_PRIVATE, "doing munmap private with on touch"))
+		return -1;
+
+	/* touched, shared mmap */
+	if (MAP(SL_TEST, 1, MAP_SHARED, "doing mmap shared followed by touch") ||
+		TOUCH(SL_TEST, 1, MAP_SHARED, "touching the addr after mmap shared") ||
+		UNMAP(SL_TEST, 1, MAP_SHARED, "doing munmap shared after touch"))
+		return -1;
+
+	/* touched, private mmap */
+	if (MAP(SL_TEST, 1, MAP_PRIVATE, "doing mmap private followed by touch") ||
+		TOUCH(SL_TEST, 1, MAP_PRIVATE, "touching the addr after mmap private") ||
+		UNMAP(SL_TEST, 1, MAP_PRIVATE, "doing munmap private after touch"))
+		return -1;
+
+	/*
+	 * Explicit resizing during outstanding surplus
+	 * Consume surplus when growing pool
+	 */
+	if (MAP(SL_TEST, 2, MAP_SHARED, "doing mmap to consume surplus") ||
+		SET_NR_HUGEPAGES(MAX(base_nr, 1), "setting hugepages pool to consume surplus"))
+		return -1;
+
+	/* Add pages once surplus is consumed */
+	if (SET_NR_HUGEPAGES(MAX(base_nr, 3), "adding more pages after consuming surplus"))
+		return -1;
+
+	/* Release free huge pages first */
+	if (SET_NR_HUGEPAGES(MAX(base_nr, 2), "releasing free huge pages"))
+		return -1;
+
+	/* When shrinking beyond committed level, increase surplus */
+	if (SET_NR_HUGEPAGES(base_nr, "increasing surplus counts"))
+		return -1;
+
+	/* Upon releasing the reservation, reduce surplus counts */
+	if (UNMAP(SL_TEST, 2, MAP_SHARED, "reducing surplus counts"))
+		return -1;
+
+	tst_res(TINFO, "OK");
+	return 0;
+}
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
+static int test_per_base_nr(int base_nr)
+{
+	tst_res(TINFO, "Base pool size: %i", base_nr);
+
+	/* Run the tests with a clean slate */
+	if (test_counters("Clean", base_nr))
+		return -1;
+
+	/* Now with a pre-existing untouched, shared mmap */
+	if (MAP(SL_SETUP, 1, MAP_SHARED, "mmap for test having prior untouched shared mmap") ||
+		test_counters("Untouched, shared", base_nr) ||
+		UNMAP(SL_SETUP, 1, MAP_SHARED, "unmap after test having prior untouched shared mmap"))
+		return -1;
+
+	/* Now with a pre-existing untouched, private mmap */
+	if (MAP(SL_SETUP, 1, MAP_PRIVATE, "mmap for test having prior untouched private mmap") ||
+		test_counters("Untouched, private", base_nr) ||
+		UNMAP(SL_SETUP, 1, MAP_PRIVATE, "unmap after test having prior untouched private mmap"))
+		return -1;
+
+	/* Now with a pre-existing touched, shared mmap */
+	if (MAP(SL_SETUP, 1, MAP_SHARED, "mmap for test having prior touched shared mmap") ||
+		TOUCH(SL_SETUP, 1, MAP_SHARED, "touching for test having prior touched shared mmap") ||
+		test_counters("Touched, shared", base_nr) ||
+		UNMAP(SL_SETUP, 1, MAP_SHARED, "unmap after test having prior touched shared mmap"))
+		return -1;
+
+	/* Now with a pre-existing touched, private mmap */
+	if (MAP(SL_SETUP, 1, MAP_PRIVATE, "mmap for test with having touched private mmap") ||
+		TOUCH(SL_SETUP, 1, MAP_PRIVATE, "touching for test with having touched private mmap") ||
+		test_counters("Touched, private", base_nr) ||
+		UNMAP(SL_SETUP, 1, MAP_PRIVATE,	"unmap after test having prior touched private mmap"))
+		return -1;
+	return 0;
+}
+
+static void run_test(void)
+{
+	int base_nr;
+
+	for (base_nr = 0; base_nr <= 3; base_nr++) {
+		if (test_per_base_nr(base_nr))
+			break;
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
