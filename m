Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2DAC44539
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 11:42:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853D53E5845
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 13:42:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3DD23C7757
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 13:42:35 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE5C01400DCF
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 13:42:33 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M9C2JS3592364; Wed, 22 Jul 2026 11:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=LpAu5cjSDZgw5eWNfs2W9rU1+iC1k80CrRRiKs/SV
 NQ=; b=Gid5xi5xEY4/vwCcF7yyN1xWt7ntSDaM9U0u1aLmym3QzsHFXRtYBpVSz
 KN3X9yBT2VPA3iGoZJJHI4kNH18KGPCDeXTRiyAD00gs1Lp8LXbR6bqSKLHltbva
 j6zaLg0OuUMK4EChT1w2VGZOsiBhUU+hycwdm091kS1EI2bbDJu/od3pXYfuoYpX
 kAq0SYJRE4Sf/0NfRmFa4hVHFy8GtmwHOVBXaDttsPNIZjbA9fYD+9VZsJKuSfrn
 eVuQ/JzytPB/jTZ9D7pJjL/CFI0GsZPT927Cm5UPE5v9Idvxi+uu4lUhsgTemQ1n
 akJRKgQ8EgeVlD9S9tmeBRUQWNMpA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k9fau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 11:42:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MBYe1s015837;
 Wed, 22 Jul 2026 11:42:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjy34d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 11:42:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66MBgRF650135530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2026 11:42:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB1C820093;
 Wed, 22 Jul 2026 11:42:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAD682006B;
 Wed, 22 Jul 2026 11:42:26 +0000 (GMT)
Received: from ltcden9-lp5.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2026 11:42:26 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 22 Jul 2026 13:40:47 +0200
Message-ID: <20260722114047.54671-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a60aca6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Tty9oNO6AAAA:8
 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=ybZZDoGAAAAA:8
 a=Y7pA49l7YSG1ouI29PgA:9 a=Bts-Es6F1CBXvF7u4C_G:22 a=_4ULuFcjZWfTdIrHNsp6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExNCBTYWx0ZWRfX42UKQ6YzEezR
 QLHbsDTVWq23r2+iTfFMJWkEGomyw7TC1qaoMWbjnrc18aVVFj7LBLUH9OMVAAghvOZWaWPKpSA
 tqjf0r3fRCBuxCtRzmoFQS/NU4YR3MSulhw5sVyjASikKWZEwlHP6jeYsaGiAkD1RY3FjtKRu8Q
 4j9eF4uWuwzJMLTuMwbk5bNuXe5FY4vt5i/Visysd/wSWkMKkKZ7yXfLu+gwl8UVcUSFx/xEaLP
 V2ZViQ0M8PlF9gmHZsB/UVouj56Jg1HLohIT8xpZvE02Sf44IKQkl5VslbXwLSWr5LU0KiO1POM
 UUI1+SIAP8o5wH55YueQJYTpssAYSRvvo8Feye5q1xDDmBSZMkuvrnFPMWoUXeApzKK0nGgUiff
 u4uLTqgBlIzcB88Q26LwIJCLI209VedBy6xO56geoR04BBvXlNrnOFO6kQ0Yuu1wa6SUSYl0tsi
 4jZQiedznk6fIpv7zcg==
X-Proofpoint-ORIG-GUID: WS_JF4M5MIK7Y6upEEYl1t3oXl7Iu28b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExNCBTYWx0ZWRfX/dOxDK5VykDS
 RawG/Q56DNgYP0Hw4lAxI2YK9nHSGfOosa7aOJuItTIUBS+dlLp/V7Zax1l8LCAbL5IsqACefX0
 DA8VQMn6CCcV0lmz6xl/+s4vZPBOFy0=
X-Proofpoint-GUID: WS_JF4M5MIK7Y6upEEYl1t3oXl7Iu28b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220114
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] sched/cfs-scheduler: Fix 'make check' errors and
 warnings in hackbench.c.
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
checkpatch.pl.

Link: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/ #v1
Link: https://lore.kernel.org/ltp/20260412122842.1074017-1-samir@linux.ibm.com/ #v2
Link: https://lore.kernel.org/ltp/20260602095656.404290-1-samir@linux.ibm.com/ #v3

Signed-off-by: Samir Mulani <samir@linux.ibm.com>
---
 .../kernel/sched/cfs-scheduler/hackbench.c    | 88 +++++++------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
index 6f37060aa..5ead2ffd7 100644
--- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
+++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
@@ -1,49 +1,20 @@
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
@@ -59,24 +30,24 @@
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
@@ -115,7 +86,7 @@ static void fdpair(int fds[2])
 static void ready(int ready_out, int wakefd)
 {
 	char dummy;
-	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
+	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN};
 
 	/* Tell them we're ready. */
 	if (write(ready_out, &dummy, 1) != 1)
@@ -199,7 +170,7 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 			exit(0);
 		}
 
-		return (pthread_t) 0;
+		return (pthread_t)0;
 	}
 
 	if (pthread_attr_init(&attr) != 0)
@@ -210,7 +181,9 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 		barf("pthread_attr_setstacksize");
 #endif
 
-	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
+	err = pthread_create(&childid, &attr, func, ctx);
+
+	if (err != 0) {
 		fprintf(stderr, "pthread_create failed: %s (%d)\n",
 			strerror(err), err);
 		exit(-1);
@@ -235,15 +208,16 @@ void reap_worker(pthread_t id)
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
@@ -251,8 +225,8 @@ static unsigned int group(pthread_t * pth,
 
 		if (!ctx)
 			barf("malloc()");
-		else
-			rev_ctx_tab[gr_num * num_fds + i] = ctx;
+
+		rev_ctx_tab[gr_num * num_fds + i] = ctx;
 
 		/* Create the pipe between client and server */
 		fdpair(fds);
@@ -305,8 +279,12 @@ int main(int argc, char *argv[])
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
@@ -363,9 +341,9 @@ int main(int argc, char *argv[])
 
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
