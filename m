Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A72F532D4
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 05:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D0913E60D1
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 06:24:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70C983E61D0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:22:53 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 071221400BE2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:22:51 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NN9GlK3422231; Tue, 24 Mar 2026 05:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=411xVG0pAL3ZIWfKv
 KiE6oH1qgUn5C/1h9rND+0X1Ho=; b=FtqlAiYtq6imibMmDjUlOwTWtzQw7L4x/
 7ZfdAZ+h+5v/NLicwAqBJd6KWXjI6VX0LlHRZJm8yb8biy8iWtAayIvH8KsiqWEY
 EJoAZK8F4fAARAqtrXF89vId5hOPLxUiwy+YRcx07xgGT1l2cvypyYGnTKWgHqVx
 P3LJ5sL2Pzhc2kviwRjLjVSxC8DW5lBCAqagCQ9n8gNI/qEzhAbL0OvtiJ5E43sm
 E7Sgd+LolBPsrt0lNyL8PKgTPikuWKK1B/aiZGdmA5ldDXyHh9HJovZ2Yf8pL9Ak
 rAYnhYzYX6RqapzmcnxlhCcqNanW69unwICCQkB9fqFlW8JbJ1/fw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9sx7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:22:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O4kfP6004375;
 Tue, 24 Mar 2026 05:22:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2014w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:22:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O5Mkmc58196290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 05:22:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E52B2005A;
 Tue, 24 Mar 2026 05:22:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2C0F2004B;
 Tue, 24 Mar 2026 05:22:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.76.226])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 05:22:45 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 24 Mar 2026 10:52:41 +0530
Message-Id: <20260324052241.21455-4-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260324052241.21455-1-sachinp@linux.ibm.com>
References: <20260324052241.21455-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: koeJrSVyAzB6mnCCd4Xz7UsOuBp8w5lL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0MiBTYWx0ZWRfX0Jv+RGHV9g8i
 QrU6um7JvyaUrdtyFnBUMboK/i1tO4cMTGvKT38rd7pimGqV8sd3ASL9UrAW7GhwEd4gHjIlwGE
 qXOktVVwN8egRJyLKa9NvmNjQUCTP+W4v8AWeQDXEor6kXRhIXYzOfs8gYkTiSsmXCxemIqtRhB
 RDZHb2YTj1Q494tfZkxN07p+bdp6RmgyshAwzw26vc3S9dpbEqFf7NZus3yTzaOhRFhqa04Jxdi
 LXOLGxFNHoDJh3q0b7rOQBN9x70MlgZL+ASil4OjOgUAnmAeLmVzS7N6NEW2X1usf5m6gBDhp0k
 vNtVOx1QQacraLRz4lmGfryQb0bHaB2ZYRhO+cuyZWN/aAPOYzyWhSBX8H8x6tqPmJLREhtC8Od
 jeE38bacqF5QCJOipW6Wu+ee/pf1wHbPG/vnpTAUal+OCrO5eFs+PNc056MiceGb9n/LW03eXEA
 rqbGuM/Cfze17zh1xjg==
X-Proofpoint-GUID: koeJrSVyAzB6mnCCd4Xz7UsOuBp8w5lL
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c21fa9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=w-8AqQcQpHbUZSzVSHMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240042
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] io_uring: Refactor io_uring01 to use common
 code
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
- Submit SQE using common helper

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 .../kernel/syscalls/io_uring/io_uring01.c     | 145 +++---------------
 1 file changed, 22 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index ab1ec00d6..4c64e562b 100644
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
 
@@ -32,96 +26,19 @@ static struct tcase {
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
-	struct io_sq_ring *sring = &s->sq_ring;
-	struct io_cq_ring *cring = &s->cq_ring;
-	struct io_uring_params p;
+	int ret;
 
-	memset(&p, 0, sizeof(p));
-	p.flags |= tc->setup_flags;
-	s->ring_fd = io_uring_setup(QUEUE_DEPTH, &p);
-	if (s->ring_fd != -1) {
+	ret = io_uring_setup_queue(s, QUEUE_DEPTH, tc->setup_flags);
+	if (ret == 0)
 		tst_res(TPASS, "io_uring_setup() passed");
-	} else {
-		tst_res(TFAIL | TERRNO, "io_uring_setup() failed");
-		return 1;
-	}
-
-	sptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
-
-	/* Submission queue ring buffer mapping */
-	sptr = SAFE_MMAP(0, sptr_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE,
-			s->ring_fd, IORING_OFF_SQ_RING);
-
-	/* Save global submission queue struct info */
-	sring->head = sptr + p.sq_off.head;
-	sring->tail = sptr + p.sq_off.tail;
-	sring->ring_mask = sptr + p.sq_off.ring_mask;
-	sring->ring_entries = sptr + p.sq_off.ring_entries;
-	sring->flags = sptr + p.sq_off.flags;
-	sring->array = sptr + p.sq_off.array;
-
-	/* Submission queue entries ring buffer mapping */
-	s->sqes = SAFE_MMAP(0, p.sq_entries *
-			sizeof(struct io_uring_sqe),
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE,
-			s->ring_fd, IORING_OFF_SQES);
-
-	cptr_size = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
-
-	/* Completion queue ring buffer mapping */
-	cptr = SAFE_MMAP(0, cptr_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_POPULATE,
-			s->ring_fd, IORING_OFF_CQ_RING);
-
-	/* Save global completion queue struct info */
-	cring->head = cptr + p.cq_off.head;
-	cring->tail = cptr + p.cq_off.tail;
-	cring->ring_mask = cptr + p.cq_off.ring_mask;
-	cring->ring_entries = cptr + p.cq_off.ring_entries;
-	cring->cqes = cptr + p.cq_off.cqes;
 
-	return 0;
+	return ret;
 }
 
 static void check_buffer(char *buffer, size_t len)
@@ -139,7 +56,7 @@ static void check_buffer(char *buffer, size_t len)
 		tst_res(TPASS, "Buffer filled in correctly");
 }
 
-static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
+static void drain_uring_cq(struct io_uring_submit *s, unsigned int exp_events)
 {
 	struct io_cq_ring *cring = &s->cq_ring;
 	unsigned int head = *cring->head;
@@ -175,12 +92,10 @@ static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
 	        events, exp_events);
 }
 
-static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
+static int submit_to_uring_sq(struct io_uring_submit *s, struct tcase *tc)
 {
-	unsigned int index = 0, tail = 0, next_tail = 0;
-	struct io_sq_ring *sring = &s->sq_ring;
-	struct io_uring_sqe *sqe;
 	int ret;
+	int fd;
 
 	memset(iov->iov_base, 0, iov->iov_len);
 
@@ -193,26 +108,13 @@ static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
 		return 1;
 	}
 
-	int fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
-
-	/* Submission queue entry addition to SQE ring buffer tail */
-	tail = *sring->tail;
-	next_tail = tail + 1;
-	index = tail & *s->sq_ring.ring_mask;
-	sqe = &s->sqes[index];
-	sqe->flags = 0;
-	sqe->fd = fd;
-	sqe->opcode = tc->enter_flags;
-	sqe->addr = (unsigned long)iov->iov_base;
-	sqe->len = BLOCK_SZ;
-	sqe->off = 0;
-	sqe->user_data = (unsigned long long)iov;
-	sring->array[index] = index;
-	tail = next_tail;
-
-	/* Kernel to notice the tail update */
-	if (*sring->tail != tail)
-		*sring->tail = tail;
+	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
+
+	/* Submit SQE using common helper */
+	io_uring_submit_sqe_internal(s, fd, tc->enter_flags,
+				     (unsigned long)iov->iov_base,
+				     BLOCK_SZ, 0,
+				     (unsigned long long)iov);
 
 	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, &sig);
 	if (ret == 1) {
@@ -229,23 +131,20 @@ static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
 
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
