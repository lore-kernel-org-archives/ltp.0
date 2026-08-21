Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0322C5DF93
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 14:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C99FF3C2220
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 16:09:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8D0C3C20C3
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 16:09:08 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE0C760065C
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 16:09:07 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LD20iH1473242; Fri, 21 Aug 2026 14:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=f2248ynzZt8O8iIAyBR9hynkjy3t+miVbHI4Dmlu3
 eE=; b=kZLRAoGG70DYw/D4Q7DLCXGwRiwKUofynB0bCFf+BtJzxu+dGcJxPAaPX
 ppzVimpBpPP+DBV21uebRgbIEhaMgiZuJVfBmbgqQkN1A6tvzh4wPvUNrtqoozwQ
 lNwbHQsol6xJ/q9fnw6TayWd/AvxI4krT7blveZwIw43gCMr0Euc/s3Kx75CPj/T
 KtmYh5/m2fUaiMg5iBxgOA6syh1I1oyONlBJsRmS5poQWIfmuoFem2cz1VW2EVC8
 uAJTwwYlfnSqv6gB2HvRny355583AvtY31o+eeCF1goYWTq8CY2Bsiit0TxQrgfC
 EK7sgIKddMjUPUubgYrhhWT7g5Vcg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4htvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 14:09:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LDuLpR019072;
 Fri, 21 Aug 2026 14:09:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhn1mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 14:09:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LE93jB47448554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 14:09:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 020B620043;
 Fri, 21 Aug 2026 14:09:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F07EB20040;
 Fri, 21 Aug 2026 14:09:01 +0000 (GMT)
Received: from ltcden9-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 14:09:01 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 21 Aug 2026 14:07:36 +0530
Message-ID: <20260821083736.49869-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOCBTYWx0ZWRfXzpqkP73OKwOH
 eKVO8cnn5XMRYkhIrobD0h8DFOVRuE19Q4G6x5mJOgnqDcnuxjkcjIN0DbUY8TBbfBs6taB4NdI
 U7oWAoY+5RN/7TCxOyzbB3MHKCfqypM=
X-Proofpoint-GUID: vHpPH8nGciEYY9nIFSobSP4B4m1p3_Ks
X-Proofpoint-ORIG-GUID: vHpPH8nGciEYY9nIFSobSP4B4m1p3_Ks
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a885c01 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Tty9oNO6AAAA:8
 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=ybZZDoGAAAAA:8
 a=SpjrkTOX177JWpPHQoUA:9 a=Bts-Es6F1CBXvF7u4C_G:22 a=_4ULuFcjZWfTdIrHNsp6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOCBTYWx0ZWRfXzjNuvw7jhiS2
 jTnOeBuusZHQgHa3TRDYlBh3E9WdfpL6RvzANkvipxw/iauBM4ixA1hCWr+d+prPAkmdj1FHosE
 VCBNEGFZgRpiyjJ30qXeKvmA4yKD11Y26rPMrVgu3CHkXhY1n8elyLveG9hHhE075bUulF5SLoW
 BoNaCylMlbKWpNO5TaukWjFkKuiPO5odakpRCG/t0gDCbj0uBTyonPuVSqfBen486EtYYoQ8l4+
 Thki9DbJOSsxSJAJvo50IHERQiSKVNuq7vODI4CPh9ygGwZAEmoWSkdMmJ1/7nH4able+8oH/4v
 aOV0UBrPnliZN1fGqB31At9NIYMKXjXnSxDjxkvuISf7NFmp8amzuLuMs8Ad0btYTS4fnqQJDjv
 6syyWQXGzmmCI05kktlQ01eguLw4OPcJua6fyayuNbIVtu+ue6lJNHxVdIuNIjr4b5UdvHOLwZx
 coIb16CGAM6H0sFn/uA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210108
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] sched/cfs-scheduler: Fix 'make check' errors and
 warnings in hackbench.c
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
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix all 'make check' warnings in hackbench.c to comply with the LTP
coding style guidelines. Add the missing SPDX-License-Identifier
header and remove the unnecessary space after a cast as flagged by
checkpatch.pl. Make create_worker() and reap_worker() static since
both functions are only used within this translation unit.

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
Changes in v6:
- Make create_worker() and reap_worker() static since both functions
  are only used within this translation unit.

Link: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/ #v1
Link: https://lore.kernel.org/ltp/20260412122842.1074017-1-samir@linux.ibm.com/ #v2
Link: https://lore.kernel.org/ltp/20260602095656.404290-1-samir@linux.ibm.com/ #v3
Link: https://lore.kernel.org/ltp/20260722114047.54671-1-samir@linux.ibm.com/ #v4
Link: https://lore.kernel.org/ltp/20260818113032.41963-1-samir@linux.ibm.com/ #v5

 .../kernel/sched/cfs-scheduler/hackbench.c    | 109 ++++++++----------
 1 file changed, 47 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
index 6f37060aa..a9c3d2952 100644
--- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
+++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
@@ -1,52 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /******************************************************************************/
-/* Copyright Rusty Russell,                                                   */
-/* Copyright Pierre Peiffer                                                   */
-/* Copyright Zhang, Yanmin,                                                   */
-/* Copyright Ingo Molnar,                                                     */
-/* Copyright Arjan van de Ven,                                                */
 /* Copyright (c) International Business Machines  Corp., 2008                 */
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
+/* Copyright Rusty Russell <rusty@rustcorp.com.au>                            */
+/* Copyright Pierre Peiffer <pierre.peiffer@bull.net>                         */
+/* Copyright Ingo Molnar <mingo@elte.hu>                                      */
+/* Copyright Arjan van de Ven <arjan@infradead.org>                           */
+/* Copyright Zhang, Yanmin <yanmin_zhang@linux.intel.com>                     */
+/* Copyright Nathan Lynch <ntl@pobox.com>                                     */
+/* Copyright Subrata Modak <subrata@linux.vnet.ibm.com>                       */
 /*                                                                            */
 /******************************************************************************/
 
 /******************************************************************************/
 /*                                                                            */
-/* File:        hackbench.c                                                   */
-/*                                                                            */
 /* Description: hackbench tests the Linux scheduler. Test groups of 20        */
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
+/*              processes spraying to 20 receivers.                           */
 /*                                                                            */
 /******************************************************************************/
 #include <pthread.h>
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -59,24 +31,24 @@
 #include <sys/poll.h>
 #include <limits.h>
 
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
@@ -86,9 +58,15 @@ struct receiver_context {
 	int wakefd;
 };
 
-static void barf(const char *msg)
+static void barf(const char *fmt, ...)
 {
-	fprintf(stderr, "%s (error: %s)\n", msg, strerror(errno));
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, " (error: %s)\n", strerror(errno));
 	exit(1);
 }
 
@@ -108,18 +86,18 @@ static void fdpair(int fds[2])
 		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
 			return;
 	}
-	barf("Creating fdpair");
+	barf("%s: creating pipe pair", __func__);
 }
 
 /* Block until we're ready to go */
 static void ready(int ready_out, int wakefd)
 {
 	char dummy;
-	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
+	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN};
 
 	/* Tell them we're ready. */
 	if (write(ready_out, &dummy, 1) != 1)
-		barf("CLIENT: ready write");
+		barf("%s: pipe write", __func__);
 
 	/* Wait for "GO" signal */
 	if (poll(&pollfd, 1, -1) != 1)
@@ -182,7 +160,7 @@ again:
 	return NULL;
 }
 
-pthread_t create_worker(void *ctx, void *(*func) (void *))
+static pthread_t create_worker(void *ctx, void *(*func)(void *))
 {
 	pthread_attr_t attr;
 	pthread_t childid;
@@ -199,7 +177,7 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 			exit(0);
 		}
 
-		return (pthread_t) 0;
+		return (pthread_t)0;
 	}
 
 	if (pthread_attr_init(&attr) != 0)
@@ -210,7 +188,9 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 		barf("pthread_attr_setstacksize");
 #endif
 
-	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
+	err = pthread_create(&childid, &attr, func, ctx);
+
+	if (err != 0) {
 		fprintf(stderr, "pthread_create failed: %s (%d)\n",
 			strerror(err), err);
 		exit(-1);
@@ -218,7 +198,7 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 	return (childid);
 }
 
-void reap_worker(pthread_t id)
+static void reap_worker(pthread_t id)
 {
 	int status;
 
@@ -235,15 +215,16 @@ void reap_worker(pthread_t id)
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
-	else
-		snd_ctx_tab[gr_num] = snd_ctx;
+
+	snd_ctx_tab[gr_num] = snd_ctx;
 
 	for (i = 0; i < num_fds; i++) {
 		int fds[2];
@@ -251,8 +232,8 @@ static unsigned int group(pthread_t * pth,
 
 		if (!ctx)
 			barf("malloc()");
-		else
-			rev_ctx_tab[gr_num * num_fds + i] = ctx;
+
+		rev_ctx_tab[gr_num * num_fds + i] = ctx;
 
 		/* Create the pipe between client and server */
 		fdpair(fds);
@@ -305,8 +286,12 @@ int main(int argc, char *argv[])
 		argv++;
 	}
 
-	if (argc >= 2 && (num_groups = atoi(argv[1])) == 0)
-		print_usage_exit();
+	if (argc >= 2) {
+		num_groups = atoi(argv[1]);
+
+		if (num_groups == 0)
+			print_usage_exit();
+	}
 
 	printf("Running with %d*40 (== %d) tasks.\n",
 	       num_groups, num_groups * 40);
@@ -329,7 +314,7 @@ int main(int argc, char *argv[])
 	snd_ctx_tab = malloc(num_groups * sizeof(void *));
 	rev_ctx_tab = malloc(num_groups * num_fds * sizeof(void *));
 	if (!pth_tab || !snd_ctx_tab || !rev_ctx_tab)
-		barf("main:malloc()");
+		barf("%s: malloc()", __func__);
 
 	fdpair(readyfds);
 	fdpair(wakefds);
@@ -363,9 +348,9 @@ int main(int argc, char *argv[])
 
 	/* free the memory */
 	for (i = 0; i < num_groups; i++) {
-		for (j = 0; j < num_fds; j++) {
-			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
-		}
+		for (j = 0; j < num_fds; j++)
+			SAFE_FREE(rev_ctx_tab[i * num_fds + j]);
+
 		SAFE_FREE(snd_ctx_tab[i]);
 	}
 	SAFE_FREE(pth_tab);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
