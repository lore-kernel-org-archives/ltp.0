Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD9C5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:29:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3BBD3E7613
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:29:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB8DE3C57EF
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C11B7600647
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:11 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB3UL23258316; Wed, 12 Aug 2026 13:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Tg4tupdPQvzEHl4a8
 Io2tHRt63QDtYM7YoYgLVf/tgE=; b=FC6s1YP5vF7UHkQLNcfKCWAd3YL2XQO6I
 w40r3liMCi1spnX81CQW2Ite5pDgBRocJZdMtGBWSCxQr987tfJUiKuXsPVFxt+N
 OaSKntAtiIPMaXXV/xTn5R91oWylJjvIAGLzfx9smFnr3zHsHwmtX1pZLky9mHMx
 3JnSjt8KSZG8BnxAf0cmGjymumTzM8B9a4lm9cUucSjCkF7WxgGJ0p1FmCJ/HCxt
 biTn6VfmXO4tVGfvgMW41a9fp5417rHcPMTY8dI0mJ9nLSfmbk92Z6qoERZonmEH
 7z/esND65jFqs7qnYiZB1rnGIQ2lBvdHWIPoGJR7+hZnRvT2qdFnw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9jk5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDQOqh004351;
 Wed, 12 Aug 2026 13:29:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ge1pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CDT4rD34800002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 13:29:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DA3E20043;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4509C20040;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.95]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 12 Aug 2026 15:28:57 +0200
Message-ID: <20260812132901.202632-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812132901.202632-1-japo@linux.ibm.com>
References: <20260812132901.202632-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qISeRfgOzdJ857gQ4UxxWXpWw_lMc91u
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c7525 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=zDy2nzqT-TCeDLKo-nAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX5v13Nsl5QZKN
 U1lSAfAuXuKMM2foJo4blzPTubpBURMdCU7RhZoolTMZ4h8Gdng/8jiLTEuzkEFA/R5lKl4NQkX
 s7+eCSyr+vexS+TAkfqBb7joa5THCIcjdfrgGZM9HiVoco9V/nEcEr7HFD4C/rmTTHrjubcPKM9
 Upa63tZ9A91Ygiun44f4tayLGvHCJvRKIVhcD7OI3NTVv2+TWJElbY3Bamu/984ZVjcxfF6hNvx
 Kup+ztuXnRisu+9osuhMuifaYdCneBUguwoz+tX5roFh7qqMME73asNOn5tH+6cihC47jB9N+5i
 1eYtBjBiDXZZTM0fAN6qLY3tyn7SVmPeB95z+JiRuODqDqnkv3zTjMkea7rEqgYp23vg5ihJA81
 qByPzM+B8oF8tStpn74f+n0QxyS2KT9ZO6gJs2o3VqTVWMtWXvt/O2Ecf50/BPZVHn5qXEr0nP0
 Trr8gGW0k71xx4z0A1g==
X-Proofpoint-ORIG-GUID: qISeRfgOzdJ857gQ4UxxWXpWw_lMc91u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX/B30ZR6tXoWg
 ob8iXvQWoC5aGrCC+n0VYT9cxkZ1YTR6+d7DMBSHL1NmKLgofw6B/556UkfE3dvBHJ9ol+NOh+i
 HCyG5Ex33U4xfMYL50ICkK5LnD5gpo4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120106
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] thp04: group runtime state and skip when
 /proc/self/mem writes are blocked
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

Move thp04 runtime state from static globals into a heap-allocated
struct thp_state. Group write_thp, read_thp, write_ptr, read_ptr,
thp_size, writefd, readfd and fzsync_pair in one object instead of
spreading them across file-scope variables.

Also add a real /proc/self/mem write probe in setup(). If the write
fails with EIO, report TCONF and skip the test cleanly on kernels where
CONFIG_PROC_MEM_FORCE_PTRACE or CONFIG_PROC_MEM_NO_FORCE blocks
unforced /proc/self/mem self-writes.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/mem/thp/thp04.c | 179 ++++++++++++++++++++++---------
 1 file changed, 127 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index a4b2fa7bc629..1fe75c3608f0 100644
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
+ * the race condition. The test verifies that forced writes work before proceeding.
+ * If forced writes are blocked by kernel configuration, the test reports TCONF.
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
@@ -67,47 +80,68 @@ static void *alloc_zero_page(void *baseaddr)
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
+	state->write_ptr = (int *)(state->write_thp + state->thp_size - sizeof(int));
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
@@ -119,20 +153,20 @@ static void run(void)
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
@@ -141,20 +175,61 @@ static void run(void)
 	tst_res(TPASS, "Huge zero page is still clean");
 }
 
+static void setup(void)
+{
+	int test_val = 0xdeadbeef;
+
+	state = SAFE_MMAP(NULL, sizeof(*state), PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	memset(state, 0, sizeof(*state));
+	state->writefd = -1;
+	state->readfd = -1;
+
+	thp_setup();
+
+	if (*state->write_ptr != 0) {
+		tst_brk(TBROK, "write_ptr not zero initially: 0x%x",
+			*state->write_ptr);
+	}
+
+	SAFE_MPROTECT((void *)state->write_thp, state->thp_size,
+		PROT_READ | PROT_WRITE);
+	*state->write_ptr = 0x12345678;
+	SAFE_MPROTECT((void *)state->write_thp, state->thp_size, PROT_READ);
+
+	SAFE_LSEEK(state->writefd, (off_t)state->write_ptr, SEEK_SET);
+
+	TEST(write(state->writefd, &test_val, sizeof(test_val)));
+
+	if (TST_RET == -1 && TST_ERR == EIO) {
+		tst_brk(TCONF,
+			"Direct writes to /proc/self/mem disabled "
+			"(CONFIG_PROC_MEM_FORCE_PTRACE=y)");
+	}
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "probe write to /proc/self/mem failed");
+
+	if (TST_RET != sizeof(test_val)) {
+		tst_brk(TBROK, "short write to /proc/self/mem: %ld bytes (expected %zu)",
+			TST_RET, sizeof(test_val));
+	}
+
+	if (*state->write_ptr != test_val) {
+		tst_brk(TBROK,
+			"write to /proc/self/mem did not modify memory: "
+			"expected 0x%x, got 0x%x", test_val, *state->write_ptr);
+	}
+
+	*state->write_ptr = 0;
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
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
