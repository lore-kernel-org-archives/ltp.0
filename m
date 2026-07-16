Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9485C44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 09:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC113E55EC
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 11:51:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF22E3E1CD6
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 11:50:16 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 285C110007C4
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 11:50:14 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7CYCL2515781; Thu, 16 Jul 2026 09:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3YKg5CvR7tsKMuuYK
 7TuonP4gChJyx+iQBGSuTGfrfo=; b=aqZyQpnpvEdKl7+nC/h20PIkBkxRGrPd+
 wE+KBmwwoH1ETpJnNORdAEAKYqZnfZoxqZhRDCu9db4SpeCwhvPk4CSPTyGjdhDj
 J/Cyhr9svvO0Wan6bmPx7N+JvwZFxtEI8kNWjueY1cd/8kCP/bCxJqMzHYoPX0j4
 /KGbUUfwP9dE3igeAFC4sLKHNvN20qZ8FJGSxsyVzGsyP0uVRLzHxi/MWPGVTQm9
 6PMk5z7dwBifmeNbPkiootjWHOlasWrOnz+uQquEqaVuMp/rPXurXSWmafwn8Q9U
 lJdvIBkayvl0LVtZ+HzbrLkhCiq6knMQ/MsH+3yMasbrJJsxmLDmQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbyff7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 09:50:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G9nbcx029600;
 Thu, 16 Jul 2026 09:50:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgm73p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 09:50:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66G9o8R448955746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 09:50:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DDB020040;
 Thu, 16 Jul 2026 09:50:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8CF120043;
 Thu, 16 Jul 2026 09:50:07 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.74.245]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 09:50:07 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 11:50:01 +0200
Message-ID: <20260716095004.92793-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716095004.92793-1-japo@linux.ibm.com>
References: <20260716095004.92793-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58a954 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=aKpMiE9gd_-pdFYVdXcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX9PoGXx1oTlNm
 ayWxBcI/TwtPwat91C/eacmJv6MrMRmHlTQt0B2BitGsRrZAmX03OkufthKepKG8NUARh9Pvpto
 kYSh5SAJZZBibFdGCwi0K6EHB5PHUZyzOjQH7gG9vz55B5Kpt4MOA5YB4oTCcVq6k8ZKOfMLrPQ
 gJvWs0MVtKCNMz/t2cSG9B14Jio/qkGzf8KvDP6PHMyojT8CxteZI2GnPjazuliYdCxteFPHNY8
 Hgh7PdvVGbGmVqG9q5uGTidmQKB4MFdL0PtrIu3JPFtjeKeCX68lkCZ995wNc03p8luuXIxyPJM
 tLCDX2UAdwA3VrnaLRswVv8tC3Uj/bw94pkuDrCXit3D6ntEkujnHpt5PkQU/fmlrfaah7JR/jJ
 8+thYFiiXVWqyhM2hrIT6ipmTP/CqNnAXAKtUbobtLqGrSL2l0HrsJyxFfYDimoKRFV030hw8H1
 q3khRm6Boop3U2FaKeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX8ZUQ72LNETy5
 JPCF6Cub3ibkl4CLAtwAxEIwoTKulyoWe14fHrGlxuUK+NQBKQUhpoKy8Y41CiCsPLE913PHwF8
 Vevb/Xa2rteYjz+rfmvUSiIVTYtXKxY=
X-Proofpoint-GUID: YDLsBjmNj00UVi61WLmDg7a_eGgi3Uwg
X-Proofpoint-ORIG-GUID: YDLsBjmNj00UVi61WLmDg7a_eGgi3Uwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160099
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] thp04: Simplify to focus on CVE-2017-1000405
 race test only
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

Remove ptrace mode support from thp04.c to keep the test focused on
its original purpose: testing the CVE-2017-1000405 race condition.

The ptrace-based /proc/pid/mem write functionality is now covered by
dedicated tests in testcases/kernel/syscalls/ptrace/:
- ptrace12: Tests that CONFIG_PROC_MEM_FORCE_PTRACE blocks self-writes
- ptrace13: Tests that ptrace allows parent-to-child memory writes

This separation follows the principle of one test per feature and makes
the test suite more maintainable.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/mem/thp/thp04.c | 166 +++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index 16d766c349b7..c8d71289e005 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
+/*\
  * CVE-2017-1000405
  *
  * Check for the Huge Dirty Cow vulnerability which allows a userspace process
@@ -21,27 +21,40 @@
  * On old kernel such as 4.9, it has fixed the Dirty Cow bug but a similar check
  * in huge_memory.c was forgotten.  As a result, remote memory writes to ro regions
  * of memory backed by transparent huge pages cause an infinite loop in the kernel.
- * While in this state the process is stil SIGKILLable, but little else works.
+ * While in this state the process is still SIGKILLable, but little else works.
  * It is also a regression test about kernel
  * commit 8310d48b125d("huge_memory.c: respect FOLL_FORCE/FOLL_COW for thp").
+ *
+ * This test uses direct writes to /proc/self/mem with fuzzy-sync to trigger
+ * the race condition. If direct writes are not available (e.g., when
+ * CONFIG_PROC_MEM_FORCE_PTRACE=y is set), the test reports TCONF.
+ * For ptrace-based /proc/pid/mem testing, see testcases/kernel/syscalls/ptrace/.
  */
 
-#include "tst_test.h"
+#include <string.h>
+
 #include "lapi/mmap.h"
 #include "tst_fuzzy_sync.h"
+#include "tst_test.h"
 
-static char *write_thp, *read_thp;
-static int *write_ptr, *read_ptr;
-static size_t thp_size;
-static int writefd = -1, readfd = -1;
-static struct tst_fzsync_pair fzsync_pair;
+struct thp_state {
+	char *write_thp;
+	char *read_thp;
+	int *write_ptr;
+	int *read_ptr;
+	size_t thp_size;
+	int writefd;
+	int readfd;
+	struct tst_fzsync_pair fzsync_pair;
+};
 
-static void *alloc_zero_page(void *baseaddr)
+static struct thp_state *state;
+
+static void *alloc_zero_page(void *baseaddr, size_t thp_size)
 {
 	int i;
 	void *ret;
 
-	/* Find aligned chunk of address space. MAP_HUGETLB doesn't work. */
 	for (i = 0; i < 16; i++, baseaddr += thp_size) {
 		ret = mmap(baseaddr, thp_size, PROT_READ,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -67,47 +80,70 @@ static void *alloc_zero_page(void *baseaddr)
 	}
 
 	tst_brk(TBROK, "Cannot map huge zero page near the specified address");
-	return NULL;	/* Silence compiler warning */
+	return NULL;
 }
 
-static void setup(void)
+static void thp_cleanup(void)
+{
+	if (!state)
+		return;
+
+	tst_fzsync_pair_cleanup(&state->fzsync_pair);
+
+	if (state->readfd >= 0)
+		SAFE_CLOSE(state->readfd);
+
+	if (state->writefd >= 0)
+		SAFE_CLOSE(state->writefd);
+
+	if (state->read_thp)
+		SAFE_MUNMAP(state->read_thp, state->thp_size);
+
+	if (state->write_thp)
+		SAFE_MUNMAP(state->write_thp, state->thp_size);
+}
+
+static void thp_setup(void)
 {
 	size_t i;
 
-	thp_size = tst_get_hugepage_size();
+	state->thp_size = tst_get_hugepage_size();
 
-	if (!thp_size)
+	if (!state->thp_size)
 		tst_brk(TCONF, "Kernel does not support huge pages");
 
-	write_thp = alloc_zero_page((void *)thp_size);
+	state->write_thp = alloc_zero_page((void *)state->thp_size,
+		state->thp_size);
 
-	for (i = 0; i < thp_size; i++) {
-		if (write_thp[i])
+	for (i = 0; i < state->thp_size; i++) {
+		if (state->write_thp[i])
 			tst_brk(TCONF, "Huge zero page is pre-polluted");
 	}
 
-	/* leave a hole between read and write THP to prevent merge */
-	read_thp = alloc_zero_page(write_thp + 2 * thp_size);
-	write_ptr = (int *)(write_thp + thp_size - sizeof(int));
-	read_ptr = (int *)(read_thp + thp_size - sizeof(int));
-	writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
-	readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	state->read_thp = alloc_zero_page(state->write_thp + 2 * state->thp_size,
+		state->thp_size);
+	/* write_ptr points to last int in write_thp page */
+	state->write_ptr = (int *)(state->write_thp + state->thp_size - sizeof(int));
+	/* read_ptr points to last int in read_thp page */
+	state->read_ptr = (int *)(state->read_thp + state->thp_size - sizeof(int));
 
-	fzsync_pair.exec_loops = 100000;
-	tst_fzsync_pair_init(&fzsync_pair);
+	state->writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	state->readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	state->fzsync_pair.exec_loops = 100000;
+	tst_fzsync_pair_init(&state->fzsync_pair);
 }
 
 static void *thread_run(void *arg)
 {
 	int c;
 
-	while (tst_fzsync_run_b(&fzsync_pair)) {
-		tst_fzsync_start_race_b(&fzsync_pair);
-		madvise(write_thp, thp_size, MADV_DONTNEED);
-		memcpy(&c, write_ptr, sizeof(c));
-		SAFE_LSEEK(readfd, (off_t)write_ptr, SEEK_SET);
-		SAFE_READ(1, readfd, &c, sizeof(int));
-		tst_fzsync_end_race_b(&fzsync_pair);
+	while (tst_fzsync_run_b(&state->fzsync_pair)) {
+		tst_fzsync_start_race_b(&state->fzsync_pair);
+		madvise(state->write_thp, state->thp_size, MADV_DONTNEED);
+		memcpy(&c, state->write_ptr, sizeof(c));
+		SAFE_LSEEK(state->readfd, (off_t)state->write_ptr, SEEK_SET);
+		SAFE_READ(1, state->readfd, &c, sizeof(int));
+		tst_fzsync_end_race_b(&state->fzsync_pair);
 		/* Wait for dirty page handling before next madvise() */
 		usleep(10);
 	}
@@ -119,20 +155,20 @@ static void run(void)
 {
 	int c = 0xdeadbeef;
 
-	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+	tst_fzsync_pair_reset(&state->fzsync_pair, thread_run);
 
-	while (tst_fzsync_run_a(&fzsync_pair)) {
+	while (tst_fzsync_run_a(&state->fzsync_pair)) {
 		/* Write into the main huge page */
-		tst_fzsync_start_race_a(&fzsync_pair);
-		SAFE_LSEEK(writefd, (off_t)write_ptr, SEEK_SET);
-		madvise(write_thp, thp_size, MADV_DONTNEED);
-		SAFE_WRITE(SAFE_WRITE_ALL, writefd, &c, sizeof(int));
-		tst_fzsync_end_race_a(&fzsync_pair);
+		tst_fzsync_start_race_a(&state->fzsync_pair);
+		SAFE_LSEEK(state->writefd, (off_t)state->write_ptr, SEEK_SET);
+		madvise(state->write_thp, state->thp_size, MADV_DONTNEED);
+		SAFE_WRITE(SAFE_WRITE_ALL, state->writefd, &c, sizeof(int));
+		tst_fzsync_end_race_a(&state->fzsync_pair);
 
 		/* Check the other huge zero page for pollution */
-		madvise(read_thp, thp_size, MADV_DONTNEED);
+		madvise(state->read_thp, state->thp_size, MADV_DONTNEED);
 
-		if (*read_ptr != 0) {
+		if (*state->read_ptr != 0) {
 			tst_res(TFAIL, "Huge zero page was polluted");
 			return;
 		}
@@ -141,20 +177,45 @@ static void run(void)
 	tst_res(TPASS, "Huge zero page is still clean");
 }
 
+static void setup(void)
+{
+	int test_val = 0;
+
+	state = SAFE_MMAP(NULL, sizeof(*state), PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	memset(state, 0, sizeof(*state));
+	state->writefd = -1;
+	state->readfd = -1;
+
+	thp_setup();
+
+	/* Verify that direct writes to /proc/self/mem work */
+	TEST(lseek(state->writefd, (off_t)state->write_ptr, SEEK_SET));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");
+
+	TEST(write(state->writefd, &test_val, sizeof(test_val)));
+
+	if (TST_RET == -1 && TST_ERR == EIO) {
+		tst_brk(TCONF,
+			"Direct writes to /proc/self/mem disabled "
+			"(CONFIG_PROC_MEM_FORCE_PTRACE=y). "
+			"See testcases/kernel/syscalls/ptrace/ptrace12 and ptrace13 for ptrace coverage.");
+	}
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "test write to /proc/self/mem failed");
+
+	if (TST_RET != sizeof(test_val))
+		tst_brk(TBROK, "short write to /proc/self/mem: %ld bytes", TST_RET);
+}
+
 static void cleanup(void)
 {
-	tst_fzsync_pair_cleanup(&fzsync_pair);
+	thp_cleanup();
 
-	if (readfd >= 0)
-		SAFE_CLOSE(readfd);
-
-	if (writefd >= 0)
-		SAFE_CLOSE(writefd);
-
-	if (read_thp)
-		SAFE_MUNMAP(read_thp, thp_size);
-	if (write_thp)
-		SAFE_MUNMAP(write_thp, thp_size);
+	if (state)
+		SAFE_MUNMAP(state, sizeof(*state));
 }
 
 static struct tst_test test = {
@@ -162,6 +223,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 150,
+
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a8f97366452e"},
 		{"linux-git", "8310d48b125d"},
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
