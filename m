Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDF9C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 10:13:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15C433CBC84
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 11:13:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C8323C1C26
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 11:13:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8985D1A00CA4
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 11:13:29 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D78CE20F40;
 Thu, 15 Dec 2022 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1671099208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EQ+ULYw3qi/6FrDTNiTihVU3nJ9UiJyg/fLYLayFnzg=;
 b=p3z1nKdXg1+Yg4Jg3CDCVqI90avlzD8ie5gAeJ2rDd4aI1Po6cZ9m0LBCFMlg46kSUFlze
 nr+/C5/wV7b2EzTqspT41tw271MDvS2/xiJJR15f57Ek48zgXcgvpJ83biIMHhDZGZVHaM
 4NtBaPR3q6hUqvGed5AhVrP8gQlcNP4=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id A492A2C141;
 Thu, 15 Dec 2022 10:13:28 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 15 Dec 2022 10:13:22 +0000
Message-Id: <20221215101322.14417-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] getcpu01: Reinstate node_id test
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
available. sched_getcpu does not have the node_id parameter, it's not
the same thing as getcpu.

Also we can check the node_id on any platform which has NUMA. Which
includes more than just x86.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---

V2:
* Removed all the ifdefs
* Use libc getcpu when available
* Remove kernel version check

V3:
* Add back the kernel version check bc it conflicts with other patch

 configure.ac                                |  1 +
 include/lapi/sched.h                        |  7 ++++++
 testcases/kernel/syscalls/getcpu/getcpu01.c | 28 +++------------------
 3 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index e9b15c7f7..1ab7cc60d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -101,6 +101,7 @@ AC_CHECK_FUNCS_ONCE([ \
     fstatat \
     getauxval \
     getcontext \
+    getcpu \
     getdents \
     getdents64 \
     io_pgetevents \
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 1d22a9d7e..1065665d1 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -70,6 +70,13 @@ static inline void clone3_supported_by_kernel(void)
 	}
 }
 
+#ifndef HAVE_GETCPU
+static inline int getcpu(unsigned *cpu, unsigned *node)
+{
+	return tst_syscall(__NR_getcpu, cpu, node, NULL);
+}
+#endif
+
 #ifndef SCHED_DEADLINE
 # define SCHED_DEADLINE	6
 #endif
diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index fcc273e29..4c4d86764 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -11,26 +11,12 @@
 #define _GNU_SOURCE
 #include <dirent.h>
 #include <errno.h>
-#include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
-#include "lapi/syscalls.h"
-#include "lapi/cpuset.h"
 #include "tst_test.h"
-#include "config.h"
-
-static inline int get_cpu(unsigned *cpu_id,
-			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
-			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
-{
-#ifndef HAVE_SCHED_GETCPU
-	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
-#else
-	*cpu_id = sched_getcpu();
-#endif
-	return 0;
-}
+#include "lapi/cpuset.h"
+#include "lapi/sched.h"
 
 static unsigned int max_cpuid(size_t size, cpu_set_t * set)
 {
@@ -78,7 +64,6 @@ realloc:
 	return cpu_max;
 }
 
-#ifdef __i386__
 static unsigned int get_nodeid(unsigned int cpu_id)
 {
 	DIR *directory_parent, *directory_node;
@@ -119,33 +104,26 @@ static unsigned int get_nodeid(unsigned int cpu_id)
 	}
 	return node_id;
 }
-#endif
 
 static void run(void)
 {
 	unsigned int cpu_id, node_id = 0;
 	unsigned int cpu_set;
-#ifdef __i386__
 	unsigned int node_set;
-#endif
 
 	cpu_set = set_cpu_affinity();
-#ifdef __i386__
 	node_set = get_nodeid(cpu_set);
-#endif
 
-	TEST(get_cpu(&cpu_id, &node_id, NULL));
+	TEST(getcpu(&cpu_id, &node_id));
 	if (TST_RET == 0) {
 		if (cpu_id != cpu_set)
 			tst_res(TFAIL, "getcpu() returned wrong value"
 				" expected cpuid:%d, returned value cpuid: %d",
 				cpu_set, cpu_id);
-#ifdef __i386__
 		else if (node_id != node_set)
 			tst_res(TFAIL, "getcpu() returned wrong value"
 				" expected  node id:%d returned  node id:%d",
 				node_set, node_id);
-#endif
 		else
 			tst_res(TPASS, "getcpu() returned proper"
 				" cpuid:%d, node id:%d", cpu_id,
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
