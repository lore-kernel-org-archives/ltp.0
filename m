Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF3E937E3
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 12:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA0803E2681
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6888E3CF0FF
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 14:31:01 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9166A1400353
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 14:30:59 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63C8rItL2007384; Sun, 12 Apr 2026 12:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+Vo35pBYiV28DhUCOp0Foqajb6RElCaVLseJxqfsC
 mw=; b=DIaVpb0Z3lSRPVGxW7/MRqDBefwo8hH7ui0HBCnhryvWDbsMnFyY3fGDe
 UaDILMDDKSKNe1EkX8sitKxozlcvpIeZxnGknbRTTIxP1G2tBJCXKFCxk8JKr6FW
 zQrrClh17AISM3H2+wJCwpU5qEtltbyN4C0GW27hiecoGhRPrpaIFfy1Qj7mVMMp
 qyqfMjZ1c9IJH6k5XDtuZLsZRPKiuPntly1xe1JM3c/cJUnEjzoaEMaT8c103r1T
 osSELgIs8xVBSMKcqR8jANrNR7n3UWxgl88eADwG0DAHC69Lf2JcxvUhwc46Qz7i
 u7DV6A+zvB2+2LutOUQBZ8rmuzp5A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3kxwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 12:30:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63C8Auax003557;
 Sun, 12 Apr 2026 12:30:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn1ddd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 12:30:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63CCUsxW51249634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2026 12:30:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DDE92004B;
 Sun, 12 Apr 2026 12:30:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A45E20040;
 Sun, 12 Apr 2026 12:30:53 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2026 12:30:53 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 12 Apr 2026 14:28:42 +0200
Message-ID: <20260412122842.1074017-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7q_W-GbbGVeU44uJFVMrb7eDUIwZz337
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDExOSBTYWx0ZWRfX9BWgmZqNgGGR
 LrYkf+dlb7ofgeesEfuRNPSF7yQMFT0NrOxbIt7Kb0jLlln+Wu0qzNstSxmDceUE4q9Yd2LzJXf
 JXKoGEGHT6b9ktHUxm141tgD035VCfd16YMLn8BKcmMZFBnGgZ/UreQPfOzz4uajWB0+1AM63ro
 p2CmUs6dl0rOMiV4TLlqkSYzYEoRAKlHOHk9rZPlBXerIfJlJtxWkKZ2FjLCe1/kgJld2i1IRXM
 Ydt3AAMPR9BrAcJIZstXFcFgoNBGGhaMyB/COjryKJD8qf57rMwuzzr4xig0c+MB0VjSEJxY+ch
 8CYEz46uA4gXK0fZ9duRD0zavoM+uXjeY7V3RFHSaXHF8L9HPdBnAGwtBLWw1WK26nb8fqh27aL
 uUWJDIDG6fD5eJFqoSXt89FbyyeSlrGY+oTqqRYKeREFpdZWDVsGQwoN1GyG0RAbn5zeLqtMToN
 NqjSM9q5PIwmEmMOZ/w==
X-Proofpoint-GUID: 7q_W-GbbGVeU44uJFVMrb7eDUIwZz337
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69db9081 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Tty9oNO6AAAA:8
 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=ybZZDoGAAAAA:8
 a=M_LgezkW9z8i3c8hpWEA:9 a=Bts-Es6F1CBXvF7u4C_G:22 a=_4ULuFcjZWfTdIrHNsp6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120119
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cfs-scheduler: Fixed "make check" errors and
 warnings.
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

Fixed all make check errors and warnings in cfs_bandwidth01.c and
hackbench.c to comply with LTP coding style.

cfs_bandwidth01.c:
- Remove initialization of static variable to 0

Patch v1: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/

Addressed review comments from patch v1 -> patch v2
hackbench.c:
- Drop SPDX-License-Identifier header addition.
- Remove obsolete header metadata.
- Keep short description and add trailing period.
- Remove initialization of static variables to 0.
- Convert zero-length array to C99 flexible array.
- Drop variadic barf() change.
- Drop __func__-based error messages.
- Separate assignments from if conditions.
- Fix pointer declaration spacing.
- Add blank line after declarations.
- Fix spacing in macro and struct initialization.
- Remove unnecessary braces for single statement.
- Use Authors block for contributor attribution.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |  2 +-
 .../kernel/sched/cfs-scheduler/hackbench.c    | 71 ++++++-------------
 2 files changed, 24 insertions(+), 49 deletions(-)

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
index 6f37060aa..846985e3b 100644
--- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
+++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
@@ -1,49 +1,20 @@
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
+/*          "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>                    */
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
+	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN };
 
 	/* Tell them we're ready. */
 	if (write(ready_out, &dummy, 1) != 1)
@@ -210,7 +181,8 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
 		barf("pthread_attr_setstacksize");
 #endif
 
-	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
+	err = pthread_create(&childid, &attr, func, ctx);
+	if (err != 0) {
 		fprintf(stderr, "pthread_create failed: %s (%d)\n",
 			strerror(err), err);
 		exit(-1);
@@ -235,11 +207,12 @@ void reap_worker(pthread_t id)
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
@@ -305,8 +278,11 @@ int main(int argc, char *argv[])
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
@@ -363,9 +339,8 @@ int main(int argc, char *argv[])
 
 	/* free the memory */
 	for (i = 0; i < num_groups; i++) {
-		for (j = 0; j < num_fds; j++) {
+		for (j = 0; j < num_fds; j++)
 			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
-		}
 		SAFE_FREE(snd_ctx_tab[i]);
 	}
 	SAFE_FREE(pth_tab);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
