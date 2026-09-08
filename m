Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615DAC79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 16:55:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 449583E94A5
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 18:55:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F6D03C0032
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 13D981A003D2
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 18:55:03 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1k0Q1268741; Tue, 8 Sep 2026 16:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q71fJaxMfoM2aGSHm
 1NkyT2xXx+NBEpliA+wK6kJDXM=; b=LyWXbrnpcBCBUOpmi5SYusRxJwFqyqOiL
 Qs0c1SQjPDKTgwfOmC+nRvLPrzoKX2sXV4wsOd7iO0saPc+izhp5hbWX2k6IoeFl
 q5EJzzX+OeSCfMpa5GbnO7CItxaYXhXZUIKpASoYsCVxuF7KzeLkd12JWbESyyZd
 hfPsQO+NOJJXJe/qTovv5IARbmuqqDhzvLBPbKX/stp+YtcQOFm2OnC78f7eHyVT
 8Gnwfa7WLb9jcCU/vLMHtH/v0X0ilM4YlSi9M0NyHkyu3p3XvAk3roH9MNCUs0Wj
 ZaiWrs1VtvyZPze2Ao5D0tS03JOxzuVMsAW2/04500TF4p14TruCg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf09vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GfDvw027368;
 Tue, 8 Sep 2026 16:55:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjw6ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688Gsv1C50069824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 16:54:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9F8D20040;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB37D2004E;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 16:54:56 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Sep 2026 18:54:28 +0200
Message-ID: <20260908165430.251897-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908165430.251897-1-japo@linux.ibm.com>
References: <20260908165430.251897-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vfc_JLb-5NI_RxaJ0f-w1_pArJfiVYjE
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa03de5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=zDy2nzqT-TCeDLKo-nAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX2pzhNs6aqVYX
 VFw1w5ssgtnQqsMZSXYWKONPXU4Q+s6SJTYYLNwj6NZj/WWDJ/El7E5dAHhcidcHF7h6xcQEKVG
 QYIsRizej27X+0k0fI5WFIT8Jr2wnzY=
X-Proofpoint-ORIG-GUID: vfc_JLb-5NI_RxaJ0f-w1_pArJfiVYjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX8Hv+2pvtFn/G
 BaZXKxEqinuxFh6I7yd7NGCvo4aEhn5E0yf5lhp3M4StAYwSLlbKjaMMzFzpJ9Jqsb+lN5KMmaH
 3ON1wVLMANVxpPLCLDOpdYst+eOfvmdBryND/Pkd2xJHFEUXI64l1+GkvV3nP1FFJqjMmSII+Uv
 SsE8fHGJ5mo1R6tgr2tcvXp57Cy/i0OXdtGMOG/cEWAuabEEDTA1MEOUNsarwD0sEWDz6k2BUFf
 WdDNc61QKkGnxgv9wYuFIyi8eSCOA7qPMjycZyLO3tim3moCJKV8c4M2yeEuHawT9Jr+h5mrCE4
 MsrmCpJKkQetoeA4BdbVOFfVe5PuPbNsE3USVoRuiq5VnANFvHPWaEZNbHi0FnrXBIJWZ2at8uK
 nuclDWsNb1CYbcAmKKe4fXwrCqhfXacLylr4x2kq5OH+OFrLPB+PZRfDVDmBwP3KrAIvEMsyCfv
 t48N5eqhkks/xXcqKOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] thp04: group runtime state and skip when
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
 testcases/kernel/mem/thp/thp04.c | 172 +++++++++++++++++++++----------
 1 file changed, 120 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index a4b2fa7bc629..84ea908dc096 100644
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
 #include "lapi/mmap.h"
 #include "tst_fuzzy_sync.h"
+#include "tst_test.h"
 
-static char *write_thp, *read_thp;
-static int *write_ptr, *read_ptr;
-static size_t thp_size;
-static int writefd = -1, readfd = -1;
-static struct tst_fzsync_pair fzsync_pair;
+#include <string.h>
 
-static void *alloc_zero_page(void *baseaddr)
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
+
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
+	if (state->readfd != -1)
+		SAFE_CLOSE(state->readfd);
+
+	if (state->writefd != -1)
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
@@ -141,20 +175,54 @@ static void run(void)
 	tst_res(TPASS, "Huge zero page is still clean");
 }
 
+static void setup(void)
+{
+	int test_val = 0xdeadbeef;
+	int *probe_ptr;
+
+	state = SAFE_MMAP(NULL, sizeof(*state), PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	memset(state, 0, sizeof(*state));
+	state->writefd = -1;
+	state->readfd = -1;
+
+	thp_setup();
+
+	/*
+	 * Probe /proc/self/mem writes on a separate read-only mapping so
+	 * write_thp stays a clean huge zero page for the race test.
+	 */
+	probe_ptr = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	*probe_ptr = 0;
+	SAFE_MPROTECT(probe_ptr, sizeof(int), PROT_READ);
+
+	SAFE_LSEEK(state->writefd, (off_t)probe_ptr, SEEK_SET);
+
+	TEST(write(state->writefd, &test_val, sizeof(test_val)));
+
+	SAFE_MUNMAP(probe_ptr, sizeof(int));
+
+	if (TST_RET == -1 && TST_ERR == EIO) {
+		tst_brk(TCONF,
+			"Direct writes to /proc/self/mem disabled (CONFIG_PROC_MEM_FORCE_PTRACE=y)");
+	}
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "probe write to /proc/self/mem failed");
+
+	if (TST_RET != (ssize_t)sizeof(test_val)) {
+		tst_brk(TBROK, "short write to /proc/self/mem: %ld bytes (expected %zu)",
+			TST_RET, sizeof(test_val));
+	}
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
