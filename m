Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7F51075269
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:49:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0CAE3E279C
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:49:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB7EF3E279D
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:52 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C19936008DD
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:51 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K1j12W1008729; Fri, 20 Mar 2026 12:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MKFvmhi7TCMXOLSbI
 zTszUGjvsrwwLjTKr0Of/IVu7Y=; b=p5SvVoItKcap6jvVmBbHdEAS5sUlSeu3Z
 EtLGdxQm+gqaCer1sqKyZDA8aFDzfxo8knet8n78UAnBdS8kUV9quUjuXrfOmelO
 ZOAkpCk5XVgmDkgcPSBktHvOl/Tg7xh/raLb0rA2owPXFww4ARiQNd9m2cFvb+Ei
 2A7Q9E9PlMqWEwVU4SGZ72vl8nd0eOne+E/UJ4Ci6yiASjNHHT8WtFtXsLqqgy/i
 y4LECqREPab6GMWTdxPaXiC3qwrslsx9C+s0f2Zw5esKbTI0Zm3t02jhU/32OlUo
 R0hWmedtXF6ZxUJfILFccLNB5/K+XA74f/5T9oLUlI28elFiXvuyA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3jatjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KBChut005412;
 Fri, 20 Mar 2026 12:47:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sqapt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KCll2u46465486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 12:47:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 735CE2004B;
 Fri, 20 Mar 2026 12:47:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A96AA20040;
 Fri, 20 Mar 2026 12:47:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.5.99])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 12:47:46 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 18:17:42 +0530
Message-Id: <20260320124742.75946-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260320124742.75946-1-sachinp@linux.ibm.com>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IdxFvcsROaqxx08XP38rHvGWpuB9SmSZ
X-Proofpoint-ORIG-GUID: IdxFvcsROaqxx08XP38rHvGWpuB9SmSZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwMCBTYWx0ZWRfX6t0ayNgYjrLW
 iRGstmz2/etQogoWraQG7ntZGbUaF4STs3Oq2lmgAcUL5UVj/iyB0CIVZc1PYx4HjOk1sUkk0fI
 F/6QEuZ2TObowrqQxKCs1QHohFgyNkjHf+R3y4DJ4Xr0pFiGgggV4NhwYxPDO8hSV7WDrLMhOf/
 0EDEeRKjRxwxfuq5dyr7yDbASeKiIHAjolIPIkFGoc/aTHOwD2OgHodRktkoeSm3qqqdPQCnwds
 +PQ+JGGbMu9xn7znJ0etW5cvhvA6Jj03dL9wihQKY1Pba7O6m9JF3di+UdNhHDC+iZkmCH1zhgu
 worqu0cBSTJPN8PI/zDbbKmsUA1Y/fj7blDWwrxe+WQZaYEltTIb6aY3ykV1Vtlg67rw9ht2pc9
 DKU4ynq2O2a/IMnLyIPNX0OJUV3DgnSVxugCSTA2FqZaHoCedNCAFmWl5pjHwo0Uxvr0D4ob9BA
 LR4QNT1OGKKIHulAphg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bd41f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=w-8AqQcQpHbUZSzVSHMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200100
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] io_uring: Refactor io_uring01 to use common code
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

No functional change.

Refactor io_uring01 test case to use
- common definitions from io_uring_common.h
- remove duplicate structure definitions
- Replace manual munmap/close calls with io_uring_cleanup_queue()
  helper function

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 .../kernel/syscalls/io_uring/io_uring01.c     | 111 ++++++------------
 1 file changed, 35 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index ab1ec00d6..368c1ed15 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -11,13 +11,7 @@
  * registered in the kernel for long term operation using io_uring_register().
  * This tests initiates I/O operations with the help of io_uring_enter().
  */
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
-#include "config.h"
-#include "tst_test.h"
-#include "lapi/io_uring.h"
+#include "io_uring_common.h"
 
 #define TEST_FILE "test_file"
 
@@ -32,42 +26,11 @@ static struct tcase {
 	{0, IORING_REGISTER_BUFFERS, IORING_OP_READ_FIXED},
 };
 
-struct io_sq_ring {
-	unsigned int *head;
-	unsigned int *tail;
-	unsigned int *ring_mask;
-	unsigned int *ring_entries;
-	unsigned int *flags;
-	unsigned int *array;
-};
-
-struct io_cq_ring {
-	unsigned int *head;
-	unsigned int *tail;
-	unsigned int *ring_mask;
-	unsigned int *ring_entries;
-	struct io_uring_cqe *cqes;
-};
-
-struct submitter {
-	int ring_fd;
-	struct io_sq_ring sq_ring;
-	struct io_uring_sqe *sqes;
-	struct io_cq_ring cq_ring;
-};
-
-static struct submitter sub_ring;
-static struct submitter *s = &sub_ring;
+static struct io_uring_submit s;
 static sigset_t sig;
 static struct iovec *iov;
 
-
-static void *sptr;
-static size_t sptr_size;
-static void *cptr;
-static size_t cptr_size;
-
-static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
+static int setup_io_uring_test(struct io_uring_submit *s, struct tcase *tc)
 {
 	struct io_sq_ring *sring = &s->sq_ring;
 	struct io_cq_ring *cring = &s->cq_ring;
@@ -83,43 +46,42 @@ static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
 		return 1;
 	}
 
-	sptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
+	s->sq_ptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
 
 	/* Submission queue ring buffer mapping */
-	sptr = SAFE_MMAP(0, sptr_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE,
-			s->ring_fd, IORING_OFF_SQ_RING);
+	s->sq_ptr = SAFE_MMAP(0, s->sq_ptr_size,
+			      PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_POPULATE,
+			      s->ring_fd, IORING_OFF_SQ_RING);
 
 	/* Save global submission queue struct info */
-	sring->head = sptr + p.sq_off.head;
-	sring->tail = sptr + p.sq_off.tail;
-	sring->ring_mask = sptr + p.sq_off.ring_mask;
-	sring->ring_entries = sptr + p.sq_off.ring_entries;
-	sring->flags = sptr + p.sq_off.flags;
-	sring->array = sptr + p.sq_off.array;
+	sring->head = s->sq_ptr + p.sq_off.head;
+	sring->tail = s->sq_ptr + p.sq_off.tail;
+	sring->ring_mask = s->sq_ptr + p.sq_off.ring_mask;
+	sring->ring_entries = s->sq_ptr + p.sq_off.ring_entries;
+	sring->flags = s->sq_ptr + p.sq_off.flags;
+	sring->array = s->sq_ptr + p.sq_off.array;
 
 	/* Submission queue entries ring buffer mapping */
-	s->sqes = SAFE_MMAP(0, p.sq_entries *
-			sizeof(struct io_uring_sqe),
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE,
-			s->ring_fd, IORING_OFF_SQES);
+	s->sqes = SAFE_MMAP(0, p.sq_entries * sizeof(struct io_uring_sqe),
+			    PROT_READ | PROT_WRITE,
+			    MAP_SHARED | MAP_POPULATE,
+			    s->ring_fd, IORING_OFF_SQES);
 
-	cptr_size = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
+	s->cq_ptr_size = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
 
 	/* Completion queue ring buffer mapping */
-	cptr = SAFE_MMAP(0, cptr_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE,
-			s->ring_fd, IORING_OFF_CQ_RING);
+	s->cq_ptr = SAFE_MMAP(0, s->cq_ptr_size,
+			      PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_POPULATE,
+			      s->ring_fd, IORING_OFF_CQ_RING);
 
 	/* Save global completion queue struct info */
-	cring->head = cptr + p.cq_off.head;
-	cring->tail = cptr + p.cq_off.tail;
-	cring->ring_mask = cptr + p.cq_off.ring_mask;
-	cring->ring_entries = cptr + p.cq_off.ring_entries;
-	cring->cqes = cptr + p.cq_off.cqes;
+	cring->head = s->cq_ptr + p.cq_off.head;
+	cring->tail = s->cq_ptr + p.cq_off.tail;
+	cring->ring_mask = s->cq_ptr + p.cq_off.ring_mask;
+	cring->ring_entries = s->cq_ptr + p.cq_off.ring_entries;
+	cring->cqes = s->cq_ptr + p.cq_off.cqes;
 
 	return 0;
 }
@@ -139,7 +101,7 @@ static void check_buffer(char *buffer, size_t len)
 		tst_res(TPASS, "Buffer filled in correctly");
 }
 
-static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
+static void drain_uring_cq(struct io_uring_submit *s, unsigned int exp_events)
 {
 	struct io_cq_ring *cring = &s->cq_ring;
 	unsigned int head = *cring->head;
@@ -175,7 +137,7 @@ static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
 	        events, exp_events);
 }
 
-static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
+static int submit_to_uring_sq(struct io_uring_submit *s, struct tcase *tc)
 {
 	unsigned int index = 0, tail = 0, next_tail = 0;
 	struct io_sq_ring *sring = &s->sq_ring;
@@ -229,23 +191,20 @@ static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
 
 static void cleanup_io_uring_test(void)
 {
-	io_uring_register(s->ring_fd, IORING_UNREGISTER_BUFFERS,
+	io_uring_register(s.ring_fd, IORING_UNREGISTER_BUFFERS,
 			  NULL, QUEUE_DEPTH);
-	SAFE_MUNMAP(s->sqes, sizeof(struct io_uring_sqe));
-	SAFE_MUNMAP(cptr, cptr_size);
-	SAFE_MUNMAP(sptr, sptr_size);
-	SAFE_CLOSE(s->ring_fd);
+	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
 }
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	if (setup_io_uring_test(s, tc))
+	if (setup_io_uring_test(&s, tc))
 		return;
 
-	if (!submit_to_uring_sq(s, tc))
-		drain_uring_cq(s, 1);
+	if (!submit_to_uring_sq(&s, tc))
+		drain_uring_cq(&s, 1);
 
 	cleanup_io_uring_test();
 }
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
