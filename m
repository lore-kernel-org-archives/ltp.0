Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF14CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:57:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14B213E56BF
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:57:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD3AC3E1EB4
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:57:07 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0186606A69
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:57:06 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651NRoeC3100564; Tue, 2 Jun 2026 09:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=PPYiwuiVEAUszFVK4vKyjCW+A1WleYDRkcxgS/813
 eU=; b=NtCWBjar/hrSOt4TCbbHmN3P1rQujV5Lxg5yNrZu9jjeDCzuQqGfgUEsJ
 3QmM6EkLGEZUPVFOtMt0nMObA9WeDbI9w1JaJhV8smF4wUjvDjG/Qaa17YzfpBEg
 SOKQOUSxogeVuHcDJ1wXLXXt37rxZT/U0kgWLZxD2XzAZ7FNLQjb6iSEaMypDWUC
 cRJRYvL2QR3tKLl17NpxZGwC+ySF07MMVAKrNRqy8fBqYpXOluviyv7uakEixZe/
 rPGCUhscpaFc/KA6VDd794gCIUU0FuEpoBrSJdQwIR4NLSLg7U1ylaZoA9gOlsHG
 y+ZvZx3ki3rdr/Nt/yqzsUuHwEbeQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht4svn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 09:57:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6529s8tn006419;
 Tue, 2 Jun 2026 09:57:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k2mnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 09:57:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6529v0TH56885622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2026 09:57:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310D82004B;
 Tue,  2 Jun 2026 09:57:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6212F20043;
 Tue,  2 Jun 2026 09:56:59 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2026 09:56:59 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 11:56:56 +0200
Message-ID: <20260602095656.404290-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GEo33J5IAXub48BCeRjS1ekEdg0FYpWH
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1ea8f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Tty9oNO6AAAA:8
 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=ybZZDoGAAAAA:8
 a=KvAxFzU07BMct0TMzk4A:9 a=Bts-Es6F1CBXvF7u4C_G:22 a=_4ULuFcjZWfTdIrHNsp6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5MCBTYWx0ZWRfX7jLMD9aw51Wi
 jTAfu72kvhCBf4/tHj2mi+sSO1RAo+ZxkBNZBcT4mHQDziTuQL1Xo79VNkThfQ+9LQSYDU8dcp1
 i8TapMnEX5IZ2Y8X8TIKpq4S0znPKHJRo2Ie2Lx3U5UVcs2v2r90BvZ0/PdkkG/i0JRqWtMt0SI
 Uq8yRmDSmTlRPIPiULmmkugFMpZ3eoJMSEx8V6tlA4CzceTXD0jrZVqBFiHnQyHoRXdIJaQ/thM
 Ls7ckS1FcWDYLkx887k0jwUT8J5a8jmQ2vycWUpUxfXFaikPVPfbOO2vd+d09U06GP26rIx8Rda
 R4bZ1AR2CY8aPW1yPEtHWeznmggznMyX1SzhQu6lQ6ewGJqtS4qUs6KUOfxwJr9a4kgSZESfh5n
 ziWtE0gmiFGnc9yrt8GzRxbuppF6vGJwY8ayTv7RH4EfB2u7UQ5lM7597B6ho4vWYf4TcudmIdh
 Thec83jkt6kvgck+ZZg==
X-Proofpoint-ORIG-GUID: GEo33J5IAXub48BCeRjS1ekEdg0FYpWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020090
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] cfs-scheduler: Fixed "make check" errors and
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed all make check errors and warnings in hackbench.c to comply with
LTP coding style.

hackbench.c:
- Add SPDX-License-Identifier header.
- Remove obsolete header metadata.
- Keep short description and add trailing period.
- Remove initialization of static variables to 0.
- Convert zero-length array to C99 flexible array.
- Separate assignments from if conditions.
- Fix pointer declaration spacing.
- Add blank line after declarations.
- Fix spacing in macro and struct initialization.
- Remove unnecessary braces for single statement.
- Use Authors block for contributor attribution.

Patch v1: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/
Patch v2: https://lore.kernel.org/ltp/20260412122842.1074017-1-samir@linux.ibm.com/

Addressed review comments from patch v2 -> patch v3:
- Add SPDX-License-Identifier header as requested by Andrea Cervesato.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 .../kernel/sched/cfs-scheduler/hackbench.c    | 73 +++++++------------
 1 file changed, 25 insertions(+), 48 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
index 6f37060aa..c374e6069 100644
--- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
+++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
@@ -1,49 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /******************************************************************************/
-/* Copyright Rusty Russell,                                                   */
-/* Copyright Pierre Peiffer                                                   */
-/* Copyright Zhang, Yanmin,                                                   */
-/* Copyright Ingo Molnar,                                                     */
-/* Copyright Arjan van de Ven,                                                */
 /* Copyright (c) International Business Machines  Corp., 2008                 */
 /*                                                                            */
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
+/* Authors: Rusty Russell <rusty@rustcorp.com.au>                             */
+/*          Pierre Peiffer <pierre.peiffer@bull.net>                          */
+/*          Ingo Molnar <mingo@elte.hu>                                       */
+/*          Arjan van de Ven <arjan@infradead.org>                            */
+/*          Zhang, Yanmin <yanmin_zhang@linux.intel.com>                    */
+/*          Nathan Lynch <ntl@pobox.com>                                      */
+/*          Subrata Modak <subrata@linux.vnet.ibm.com>                        */
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
@@ -115,7 +87,7 @@ static void fdpair(int fds[2])
 static void ready(int ready_out, int wakefd)
 {
 	char dummy;
-	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
+	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN };
 
 	/* Tell them we're ready. */
 	if (write(ready_out, &dummy, 1) != 1)
@@ -210,7 +182,8 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 		barf("pthread_attr_setstacksize");
 #endif
 
-	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
+	err = pthread_create(&childid, &attr, func, ctx);
+	if (err != 0) {
 		fprintf(stderr, "pthread_create failed: %s (%d)\n",
 			strerror(err), err);
 		exit(-1);
@@ -235,11 +208,12 @@ void reap_worker(pthread_t id)
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
@@ -305,8 +279,11 @@ int main(int argc, char *argv[])
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
@@ -363,9 +340,9 @@ int main(int argc, char *argv[])
 
 	/* free the memory */
 	for (i = 0; i < num_groups; i++) {
-		for (j = 0; j < num_fds; j++) {
+		for (j = 0; j < num_fds; j++)
 			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
-		}
+
 		SAFE_FREE(snd_ctx_tab[i]);
 	}
 	SAFE_FREE(pth_tab);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
