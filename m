Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B18C352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 899713CDB51
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 17:58:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D0153CAEDD
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 17:58:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 493841000410
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 17:58:47 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 824B51FE72;
 Tue,  6 Dec 2022 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1670345926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OE2OcYWomu79vEwpCLO4QIYYdfDWGde71ij58C5IiRg=;
 b=XQDZT///iRdVSJuEawHSFLvfXE+vPMEmrn9hetamubqJtQzsTIN8IlDlDTPcMnfn4WCJRa
 xdAxWY5kcuFtrMxbPStJ+MVXv5mFX9oWpTpFKxqy78kMFdAoQ+4oWYhSY4lnn5wDAL9CQw
 5u77urzmD+q7jHtoP3tcb/TAiK9Z3/U=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 59AE62C141;
 Tue,  6 Dec 2022 16:58:46 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  6 Dec 2022 16:58:40 +0000
Message-Id: <20221206165840.12107-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getcpu01: Reinstate node_id test
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Presently the node_id is only checked on i386 and it is broken. The
sched_getcpu call was substituted for getcpu when
available. sched_getcpu does not have the node_id parameter and does
not even call SYS_getcpu if it can be completed by vDSO.

Also we can at least check the node_id on x86_64 as well.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/getcpu/getcpu01.c | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index fcc273e29..21c67f412 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -15,20 +15,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "lapi/cpuset.h"
-#include "tst_test.h"
 #include "config.h"
 
 static inline int get_cpu(unsigned *cpu_id,
-			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
-			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
+			  unsigned *node_id)
 {
-#ifndef HAVE_SCHED_GETCPU
-	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
-#else
-	*cpu_id = sched_getcpu();
-#endif
+	return tst_syscall(__NR_getcpu, cpu_id, node_id, NULL);
+
 	return 0;
 }
 
@@ -78,7 +74,7 @@ realloc:
 	return cpu_max;
 }
 
-#ifdef __i386__
+#if  defined(__i386__) || defined(__x86_64__)
 static unsigned int get_nodeid(unsigned int cpu_id)
 {
 	DIR *directory_parent, *directory_node;
@@ -125,22 +121,22 @@ static void run(void)
 {
 	unsigned int cpu_id, node_id = 0;
 	unsigned int cpu_set;
-#ifdef __i386__
+#if defined(__i386__) || defined(__x86_64__)
 	unsigned int node_set;
 #endif
 
 	cpu_set = set_cpu_affinity();
-#ifdef __i386__
+#if defined(__i386__) || defined(__x86_64__)
 	node_set = get_nodeid(cpu_set);
 #endif
 
-	TEST(get_cpu(&cpu_id, &node_id, NULL));
+	TEST(get_cpu(&cpu_id, &node_id));
 	if (TST_RET == 0) {
 		if (cpu_id != cpu_set)
 			tst_res(TFAIL, "getcpu() returned wrong value"
 				" expected cpuid:%d, returned value cpuid: %d",
 				cpu_set, cpu_id);
-#ifdef __i386__
+#if defined(__i386__) || defined(__x86_64__)
 		else if (node_id != node_set)
 			tst_res(TFAIL, "getcpu() returned wrong value"
 				" expected  node id:%d returned  node id:%d",
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
