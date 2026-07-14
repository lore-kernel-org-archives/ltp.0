Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B401C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 15:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8A053E968D
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 17:07:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD40E3E56A3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:06:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A20F9200969
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:06:44 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEfcBZ3906496; Tue, 14 Jul 2026 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+81aMjTX3Iz9OqKpV
 WqEOUA6lVfkf8sZny6cj8oFhjM=; b=fTDf+pCp+vYBhPQtM9PIXkq4Ol+4htYh5
 yOCGUGdYSZrDs8Q+RvEQeZwxuPQQV2wxqar/GzLXznPlIItePwUAIJBs5GDjkXp2
 SxG9wvFEAyiEhys74a1XduZkvjQy1IvWW4FDBH/quLJlu7umsVDc1edkTa3pIr+D
 TRZFlKER6QeVSdl9GOJ68jO5oceEetJZT9Tdl40+7I2Dnv4CGEchD1TfP04S49dk
 +SLi5ZS0nBp6YdaF4OR0pS79PDSPmU7cq4UrQbo7o5x1XKfMso14G3KILoAZXgBp
 uIqi7uZSpgwdHI/1EGFbLtjK4OaZxfLeSjQtoYZPfWn29MkW0g4Rg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv337ch1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:06:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EF4h81031577;
 Tue, 14 Jul 2026 15:06:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgb5q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:06:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EF6bCQ23921080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 15:06:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADC4020040;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F1522004E;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 17:06:28 +0200
Message-ID: <20260714150631.250972-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714150631.250972-1-japo@linux.ibm.com>
References: <20260714150631.250972-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfX7cVcIXOpRdm8
 p53V1VoheCpwCkY+3NIX1JQHgQ0JnMXxlgNs/uH5+DKnj8hsmfHu/oLj9V5dTf5Akq8J6oId562
 z/rd4WyLFaKq/EekIfbd4MfhYmusGSw=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a565082 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=aKpMiE9gd_-pdFYVdXcA:9
X-Proofpoint-GUID: Qc0yxpYIr_2Yd2370HQC2dsH9uf6TBow
X-Proofpoint-ORIG-GUID: Qc0yxpYIr_2Yd2370HQC2dsH9uf6TBow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfXxx0/vpRUJlmr
 MKlW9xYvvSxtDhGeElydGVafgdZi+0RP8pcrGxMu4z4fmqsJt1qehuTsqCBsje+BBBObVwxgU0F
 /wUGO3f70lf8MHn97lavy4YsFEozWZxXbR+PD4ZdBUUqLBFlQ6fYT9ner+8AzHPxjy88QsHWunD
 Jo4D2bCFdDipY7BsaK4ERgYGyvKCbCUAM9fltbWErPxKr1nIcPHMDUOhCUVYYvGKNTCCXYUsqq6
 kBBci4UyFD2oWHvEcRvBFL+xtpY+irUKo15dneIstQ1s71TMoLYHF2ZMIHi31RzRcRHDCid/w2A
 9eogiprUERPVI/V4HVEsf0ltYY8GbMnq5vbypbr0rfvYVFpLG2qZjy/JasBsxUMxMIic1MU5I8m
 tGmG27B+asjVjxdOSUpo4TH3q1HqP6FS8lVMQarpBn8efqhubfSP2EWt/Ufb+n4OeL9L6Mq/PnE
 q2rFtsv7PbRgMF7KvTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140153
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] thp04: Simplify to focus on CVE-2017-1000405
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
 1 file changed, 113 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index 16d766c349b7..ffdad60c798f 100644
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
@@ -21,27 +21,38 @@
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
 #include "lapi/mmap.h"
 #include "tst_fuzzy_sync.h"
+#include "tst_test.h"
 
-static char *write_thp, *read_thp;
-static int *write_ptr, *read_ptr;
-static size_t thp_size;
-static int writefd = -1, readfd = -1;
-static struct tst_fzsync_pair fzsync_pair;
+struct child_state {
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
+static struct child_state *child;
+
+static void *alloc_zero_page(void *baseaddr, size_t thp_size)
 {
 	int i;
 	void *ret;
 
-	/* Find aligned chunk of address space. MAP_HUGETLB doesn't work. */
 	for (i = 0; i < 16; i++, baseaddr += thp_size) {
 		ret = mmap(baseaddr, thp_size, PROT_READ,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -67,47 +78,70 @@ static void *alloc_zero_page(void *baseaddr)
 	}
 
 	tst_brk(TBROK, "Cannot map huge zero page near the specified address");
-	return NULL;	/* Silence compiler warning */
+	return NULL;
 }
 
-static void setup(void)
+static void child_cleanup(void)
+{
+	if (!child)
+		return;
+
+	tst_fzsync_pair_cleanup(&child->fzsync_pair);
+
+	if (child->readfd >= 0)
+		SAFE_CLOSE(child->readfd);
+
+	if (child->writefd >= 0)
+		SAFE_CLOSE(child->writefd);
+
+	if (child->read_thp)
+		SAFE_MUNMAP(child->read_thp, child->thp_size);
+
+	if (child->write_thp)
+		SAFE_MUNMAP(child->write_thp, child->thp_size);
+}
+
+static void child_setup(void)
 {
 	size_t i;
 
-	thp_size = tst_get_hugepage_size();
+	child->thp_size = tst_get_hugepage_size();
 
-	if (!thp_size)
+	if (!child->thp_size)
 		tst_brk(TCONF, "Kernel does not support huge pages");
 
-	write_thp = alloc_zero_page((void *)thp_size);
+	child->write_thp = alloc_zero_page((void *)child->thp_size,
+		child->thp_size);
 
-	for (i = 0; i < thp_size; i++) {
-		if (write_thp[i])
+	for (i = 0; i < child->thp_size; i++) {
+		if (child->write_thp[i])
 			tst_brk(TCONF, "Huge zero page is pre-polluted");
 	}
 
-	/* leave a hole between read and write THP to prevent merge */
-	read_thp = alloc_zero_page(write_thp + 2 * thp_size);
-	write_ptr = (int *)(write_thp + thp_size - sizeof(int));
-	read_ptr = (int *)(read_thp + thp_size - sizeof(int));
-	writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
-	readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	child->read_thp = alloc_zero_page(child->write_thp + 2 * child->thp_size,
+		child->thp_size);
+	/* write_ptr points to last int in write_thp page */
+	child->write_ptr = (int *)(child->write_thp + child->thp_size - sizeof(int));
+	/* read_ptr points to last int in read_thp page */
+	child->read_ptr = (int *)(child->read_thp + child->thp_size - sizeof(int));
 
-	fzsync_pair.exec_loops = 100000;
-	tst_fzsync_pair_init(&fzsync_pair);
+	child->writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	child->readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+	child->fzsync_pair.exec_loops = 100000;
+	tst_fzsync_pair_init(&child->fzsync_pair);
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
+	while (tst_fzsync_run_b(&child->fzsync_pair)) {
+		tst_fzsync_start_race_b(&child->fzsync_pair);
+		madvise(child->write_thp, child->thp_size, MADV_DONTNEED);
+		memcpy(&c, child->write_ptr, sizeof(c));
+		SAFE_LSEEK(child->readfd, (off_t)child->write_ptr, SEEK_SET);
+		SAFE_READ(1, child->readfd, &c, sizeof(int));
+		tst_fzsync_end_race_b(&child->fzsync_pair);
 		/* Wait for dirty page handling before next madvise() */
 		usleep(10);
 	}
@@ -119,20 +153,20 @@ static void run(void)
 {
 	int c = 0xdeadbeef;
 
-	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+	tst_fzsync_pair_reset(&child->fzsync_pair, thread_run);
 
-	while (tst_fzsync_run_a(&fzsync_pair)) {
+	while (tst_fzsync_run_a(&child->fzsync_pair)) {
 		/* Write into the main huge page */
-		tst_fzsync_start_race_a(&fzsync_pair);
-		SAFE_LSEEK(writefd, (off_t)write_ptr, SEEK_SET);
-		madvise(write_thp, thp_size, MADV_DONTNEED);
-		SAFE_WRITE(SAFE_WRITE_ALL, writefd, &c, sizeof(int));
-		tst_fzsync_end_race_a(&fzsync_pair);
+		tst_fzsync_start_race_a(&child->fzsync_pair);
+		SAFE_LSEEK(child->writefd, (off_t)child->write_ptr, SEEK_SET);
+		madvise(child->write_thp, child->thp_size, MADV_DONTNEED);
+		SAFE_WRITE(SAFE_WRITE_ALL, child->writefd, &c, sizeof(int));
+		tst_fzsync_end_race_a(&child->fzsync_pair);
 
 		/* Check the other huge zero page for pollution */
-		madvise(read_thp, thp_size, MADV_DONTNEED);
+		madvise(child->read_thp, child->thp_size, MADV_DONTNEED);
 
-		if (*read_ptr != 0) {
+		if (*child->read_ptr != 0) {
 			tst_res(TFAIL, "Huge zero page was polluted");
 			return;
 		}
@@ -141,20 +175,45 @@ static void run(void)
 	tst_res(TPASS, "Huge zero page is still clean");
 }
 
+static void setup(void)
+{
+	int test_val = 0;
+
+	child = SAFE_MMAP(NULL, sizeof(*child), PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	memset(child, 0, sizeof(*child));
+	child->writefd = -1;
+	child->readfd = -1;
+
+	child_setup();
+
+	/* Verify that direct writes to /proc/self/mem work */
+	TEST(lseek(child->writefd, (off_t)child->write_ptr, SEEK_SET));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");
+
+	TEST(write(child->writefd, &test_val, sizeof(test_val)));
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
+	child_cleanup();
 
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
+	if (child)
+		SAFE_MUNMAP(child, sizeof(*child));
 }
 
 static struct tst_test test = {
@@ -162,10 +221,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 150,
+	.forks_child = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a8f97366452e"},
 		{"linux-git", "8310d48b125d"},
 		{"CVE", "2017-1000405"},
 		{}
 	}
-};
+};
\ No newline at end of file
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
