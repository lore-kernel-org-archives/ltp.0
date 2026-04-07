Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E472EF4EDF
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 13:00:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C02363D082A
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 15:00:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 019CB3C2B7E
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 14:59:45 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 431D02001D5
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 14:59:43 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635MIJ653623154; Mon, 6 Apr 2026 12:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=UvofAyRgW+UJ8eOKenJR6yNyGXkVN0dQemH47JCl0
 Ss=; b=WA+08GK1+0AkJJwwB/d1XZfW5mnKlYQkK5DyoGyyXlRk/c1RJHRyfH4MD
 7H1c4NO/ILx313++ZPc3Wo2OpGbSTnRqM0Z7gyk7hSgqhDx2MUIIic09O/Z6i22O
 /vMP+dP31VmusIfQylIhqI+OTPWEIwX+7OCVXn+n/294Zys8H6rmodBzUtX4NGO2
 S7wfIYjnLsICS8/QmffK4tdu4U4OBiu4YafWac8ybrgvp5NQtf8TCcJmE26s0bfR
 dPxy82cmcp2Cw1teNbt5bYUA+fTN0PrH5jlH7QXkoamfJAhBQQgyoKiB73SNQR4c
 X7QG+xsdWlQnzBWjLDOSqJGkbQTWA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bx7vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 12:59:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636C3UmX014280;
 Mon, 6 Apr 2026 12:59:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbf6jvjxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 12:59:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 636CxbPh50528524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2026 12:59:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76AC920043;
 Mon,  6 Apr 2026 12:59:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5FA020040;
 Mon,  6 Apr 2026 12:59:36 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2026 12:59:36 +0000 (GMT)
From: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  7 Apr 2026 11:53:36 +0530
Message-ID: <20260407062336.127454-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x8nUdEL-QqIfCZicZLSDCMpycOrbz4uV
X-Proofpoint-GUID: x8nUdEL-QqIfCZicZLSDCMpycOrbz4uV
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d3ae3e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Tty9oNO6AAAA:8 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8
 a=ybZZDoGAAAAA:8 a=l9JX6vZTvPTgqXr74MMA:9 a=Bts-Es6F1CBXvF7u4C_G:22
 a=_4ULuFcjZWfTdIrHNsp6:22 a=1CNFftbPRP8L7MoqJWF3:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEyNiBTYWx0ZWRfXxs5fg1ItFcBQ
 dO1pvx7qVxWNFs8LSieIjeN7iy4WWjq1rOXRqqPESAnyguum88PppU24LcB3ynsCG2mGfCYqzql
 0J9CeuqSS1O6CpfUqHxNx6PUhNy6iHJ+PhSNYhvgBho4g1uMB/BiV3mZeOmis4J9pffHkRTDYRQ
 RQC5dgzC2dxIbaLpY3XFevya6+2kvf/gmsjZ8XGRGTsL5RmJTjWPF+bTCjeYyOWIcYX1GE9fE5s
 R+QB1dlN5+QVKbe28fgjYNOMQATXj1+hVR99QXKyTY8k7BnF9isw/Rvkpbk0vI1st7B7rJxI2LW
 rQmjGUY764LGYBc91682vaaiigZRzZwSVHpMb4i1CLk88KAOUGOg02ASfVejxRQ6zafClpE5M3E
 VnkssgsNUiTyIzX/8S8Xq3suwn2ES03MVVStKswmCFCCW2d/B6PuO2tsfvvW/EeGjapyuqw4p1W
 FNR3A9knYSo/a/OcPbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060126
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cfs-scheduler: Fixed "make check" errors and warnings.
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
Cc: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed all make check errors and warnings in cfs_bandwidth01.c and
hackbench.c to comply with LTP coding style.

cfs_bandwidth01.c:
- Remove initialization of static variable to 0

hackbench.c:
- Add SPDX-License-Identifier header
- Remove FSF mailing address paragraph
- Remove filename from file header
- Remove initialization of static variables to 0
- Convert zero-length array to C99 flexible array
- Modify barf() function to accept variadic arguments
- Use __func__ instead of hardcoded function names
- Separate assignments from if conditions
- Fix pointer declaration spacing
- Add blank line after declarations
- Fix spacing in macro and struct initialization
- Remove unnecessary braces for single statement

Both files now pass make check validation with 0 errors and 0 warnings.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |   2 +-
 .../kernel/sched/cfs-scheduler/hackbench.c    | 121 +++++++++---------
 2 files changed, 58 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index e52858f8e..8c511f060 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -35,7 +35,7 @@
 
 static struct tst_cg_group *cg_level2, *cg_level3a, *cg_level3b;
 static struct tst_cg_group *cg_workers[3];
-static int may_have_waiters = 0;
+static int may_have_waiters;
 
 static void set_cpu_quota(const struct tst_cg_group *const cg,
 			  const float quota_percent)
diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
index 6f37060aa..6a30e1cc8 100644
--- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
+++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
@@ -1,51 +1,33 @@
-/******************************************************************************/
-/* Copyright Rusty Russell,                                                   */
-/* Copyright Pierre Peiffer                                                   */
-/* Copyright Zhang, Yanmin,                                                   */
-/* Copyright Ingo Molnar,                                                     */
-/* Copyright Arjan van de Ven,                                                */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-/******************************************************************************/
-/*                                                                            */
-/* File:        hackbench.c                                                   */
-/*                                                                            */
-/* Description: hackbench tests the Linux scheduler. Test groups of 20        */
-/*              processes spraying to 20 receivers                            */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   hackbench01 and hackbench02                                   */
-/*                                                                            */
-/* Test Assertion:                                                            */
-/*                                                                            */
-/* Author(s):   Rusty Russell <rusty@rustcorp.com.au>,                        */
-/*              Pierre Peiffer <pierre.peiffer@bull.net>,                     */
-/*              Ingo Molnar <mingo@elte.hu>,                                  */
-/*              Arjan van de Ven <arjan@infradead.org>,                       */
-/*              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,               */
-/*              Nathan Lynch <ntl@pobox.com>                                  */
-/*                                                                            */
-/* History:     Included into LTP                                             */
-/*                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>*/
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Rusty Russell,
+ * Copyright Pierre Peiffer
+ * Copyright Zhang, Yanmin,
+ * Copyright Ingo Molnar,
+ * Copyright Arjan van de Ven,
+ * Copyright (c) International Business Machines  Corp., 2008
+ */
+
+/*
+ * Description: hackbench tests the Linux scheduler. Test groups of 20
+ * processes spraying to 20 receivers
+ *
+ * Total Tests: 1
+ *
+ * Test Name:   hackbench01 and hackbench02
+ *
+ * Test Assertion:
+ *
+ * Author(s):   Rusty Russell <rusty@rustcorp.com.au>,
+ *              Pierre Peiffer <pierre.peiffer@bull.net>,
+ *              Ingo Molnar <mingo@elte.hu>,
+ *              Arjan van de Ven <arjan@infradead.org>,
+ *              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
+ *              Nathan Lynch <ntl@pobox.com>
+ *
+ * History:     Included into LTP
+ *                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>
+ */
 #include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -58,25 +40,26 @@
 #include <sys/time.h>
 #include <sys/poll.h>
 #include <limits.h>
+#include <stdarg.h>
 
-#define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
+#define SAFE_FREE(p) { if (p) { free(p); (p) = NULL; } }
 #define DATASIZE 100
 static struct sender_context **snd_ctx_tab;	/*Table for sender context pointers. */
 static struct receiver_context **rev_ctx_tab;	/*Table for receiver context pointers. */
-static int gr_num = 0;		/*For group calculation */
+static int gr_num;		/*For group calculation */
 static unsigned int loops = 100;
 /*
  * 0 means thread mode and others mean process (default)
  */
 static unsigned int process_mode = 1;
 
-static int use_pipes = 0;
+static int use_pipes;
 
 struct sender_context {
 	unsigned int num_fds;
 	int ready_out;
 	int wakefd;
-	int out_fds[0];
+	int out_fds[];
 };
 
 struct receiver_context {
@@ -86,9 +69,14 @@ struct receiver_context {
 	int wakefd;
 };
 
-static void barf(const char *msg)
+static void barf(const char *fmt, ...)
 {
-	fprintf(stderr, "%s (error: %s)\n", msg, strerror(errno));
+	va_list args;
+
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+	fprintf(stderr, " (error: %s)\n", strerror(errno));
 	exit(1);
 }
 
@@ -108,18 +96,18 @@ static void fdpair(int fds[2])
 		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
 			return;
 	}
-	barf("Creating fdpair");
+	barf("Creating %s", __func__);
 }
 
 /* Block until we're ready to go */
 static void ready(int ready_out, int wakefd)
 {
 	char dummy;
-	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
+	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN };
 
 	/* Tell them we're ready. */
 	if (write(ready_out, &dummy, 1) != 1)
-		barf("CLIENT: ready write");
+		barf("CLIENT: %s write", __func__);
 
 	/* Wait for "GO" signal */
 	if (poll(&pollfd, 1, -1) != 1)
@@ -210,7 +198,8 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 		barf("pthread_attr_setstacksize");
 #endif
 
-	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
+	err = pthread_create(&childid, &attr, func, ctx);
+	if (err != 0) {
 		fprintf(stderr, "pthread_create failed: %s (%d)\n",
 			strerror(err), err);
 		exit(-1);
@@ -235,11 +224,12 @@ void reap_worker(pthread_t id)
 }
 
 /* One group of senders and receivers */
-static unsigned int group(pthread_t * pth,
+static unsigned int group(pthread_t *pth,
 			  unsigned int num_fds, int ready_out, int wakefd)
 {
 	unsigned int i;
 	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context) + num_fds * sizeof(int));
+
 	if (!snd_ctx)
 		barf("malloc()");
 	else
@@ -305,8 +295,11 @@ int main(int argc, char *argv[])
 		argv++;
 	}
 
-	if (argc >= 2 && (num_groups = atoi(argv[1])) == 0)
-		print_usage_exit();
+	if (argc >= 2) {
+		num_groups = atoi(argv[1]);
+		if (num_groups == 0)
+			print_usage_exit();
+	}
 
 	printf("Running with %d*40 (== %d) tasks.\n",
 	       num_groups, num_groups * 40);
@@ -329,7 +322,7 @@ int main(int argc, char *argv[])
 	snd_ctx_tab = malloc(num_groups * sizeof(void *));
 	rev_ctx_tab = malloc(num_groups * num_fds * sizeof(void *));
 	if (!pth_tab || !snd_ctx_tab || !rev_ctx_tab)
-		barf("main:malloc()");
+		barf("%s:malloc()", __func__);
 
 	fdpair(readyfds);
 	fdpair(wakefds);
@@ -363,9 +356,8 @@ int main(int argc, char *argv[])
 
 	/* free the memory */
 	for (i = 0; i < num_groups; i++) {
-		for (j = 0; j < num_fds; j++) {
+		for (j = 0; j < num_fds; j++)
 			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
-		}
 		SAFE_FREE(snd_ctx_tab[i]);
 	}
 	SAFE_FREE(pth_tab);
@@ -373,3 +365,4 @@ int main(int argc, char *argv[])
 	SAFE_FREE(rev_ctx_tab);
 	exit(0);
 }
+
-- 
2.52.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
