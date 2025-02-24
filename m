Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E292CC021B2
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 03:08:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360623C9894
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 04:08:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 938823C090A
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 04:07:57 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=chwen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 024B062CBA4
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 04:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740366475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLPCYAD0bQT1Ar/QIsdfR3EFhxWuK+hczEcOpj3RXow=;
 b=CZknfIQHVZSF4xWzANpKC87mqdQtWNT+cMJn6sA8R09td7P+TtXvrX11cx6kDYnaqwtsSG
 adMpvHKGXjVinTIFGkKPk+Ta72REkkBtyK9oZa6ZWCzEAm/Ecr/6ZMjmsMaEs0mlwKHQMt
 RDjOiU1qgcDLqhYAKn2Juvv45PJrl2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-RK1xgmfaM-ig4ugvXSK4Ew-1; Sun,
 23 Feb 2025 22:07:52 -0500
X-MC-Unique: RK1xgmfaM-ig4ugvXSK4Ew-1
X-Mimecast-MFC-AGG-ID: RK1xgmfaM-ig4ugvXSK4Ew_1740366470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80F501800874
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 03:07:50 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D659D1800358; Mon, 24 Feb 2025 03:07:48 +0000 (UTC)
From: Chunfu Wen <chwen@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 23 Feb 2025 22:07:43 -0500
Message-ID: <20250224030743.1567840-1-chwen@redhat.com>
In-Reply-To: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k82sYY8tfJZxjLSqomlxe0cTJ6QD-4FGdfHyLMeFI1M_1740366470
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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

From: chunfuwen <chwen@redhat.com>

The test ensures that the process gets the correct signals in the correct order:

First, it should get SIGXCPU after reaching the soft CPU time limit64.
Then, if the CPU time exceeds the hard limit, it should receive SIGKILL

Signed-off-by: chunfuwen <chwen@redhat.com>
---
 include/lapi/resource.h                       | 28 ++++++++++++
 .../kernel/syscalls/setrlimit/setrlimit06.c   | 44 ++++++++++++++-----
 2 files changed, 60 insertions(+), 12 deletions(-)
 create mode 100644 include/lapi/resource.h

diff --git a/include/lapi/resource.h b/include/lapi/resource.h
new file mode 100644
index 000000000..a9bc57a0a
--- /dev/null
+++ b/include/lapi/resource.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+#ifndef LAPI_RESOURCE_H__
+#define LAPI_RESOURCE_H__
+
+#define _GNU_SOURCE
+
+#include "config.h"
+#include <sys/resource.h>
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_STRUCT_RLIMIT64
+struct rlimit64 {
+        uint64_t rlim_cur;
+        uint64_t rlim_max;
+};
+#endif
+
+static int setrlimit_u64(int resource, const struct rlimit64 *rlim)
+{
+        return tst_syscall(__NR_prlimit64, 0, resource, rlim, NULL);
+}
+
+#endif /* LAPI_RESOURCE_H__ */
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
index 9ff515d81..ded550973 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
@@ -4,12 +4,12 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
+/*\
  * Set CPU time limit for a process and check its behavior
- * after reaching CPU time limit.
- * 1) Process got SIGXCPU after reaching soft limit of CPU time.
- * 2) Process got SIGKILL after reaching hard limit of CPU time.
+ * after reaching CPU time limit
+ *
+ * - Process got SIGXCPU after reaching soft limit of CPU time
+ * - Process got SIGKILL after reaching hard limit of CPU time
  *
  * Note:
  * This is also a regression test for the following kernel bug:
@@ -27,6 +27,12 @@
 #include <sys/mman.h>
 
 #include "tst_test.h"
+#include "lapi/resource.h"
+
+#define TEST_VARIANTS 2
+
+static struct rlimit *rlim;
+static struct rlimit64 *rlim_64;
 
 static int *end;
 
@@ -37,6 +43,11 @@ static void sighandler(int sig)
 
 static void setup(void)
 {
+	rlim->rlim_cur = 1;
+	rlim->rlim_max = 2;
+	rlim_64->rlim_cur = 1;
+	rlim_64->rlim_max = 2;
+
 	SAFE_SIGNAL(SIGXCPU, sighandler);
 
 	end = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
@@ -58,12 +69,14 @@ static void verify_setrlimit(void)
 
 	pid = SAFE_FORK();
 	if (!pid) {
-		struct rlimit rlim = {
-			.rlim_cur = 1,
-			.rlim_max = 2,
-		};
-
-		TEST(setrlimit(RLIMIT_CPU, &rlim));
+		switch (tst_variant) {
+		case 0:
+			TEST(setrlimit(RLIMIT_CPU, rlim));
+		break;
+		case 1:
+			TEST(setrlimit_u64(RLIMIT_CPU, rlim_64));
+		break;
+		}
 		if (TST_RET == -1) {
 			tst_res(TFAIL | TTERRNO,
 				"setrlimit(RLIMIT_CPU) failed");
@@ -72,7 +85,8 @@ static void verify_setrlimit(void)
 
 		alarm(20);
 
-		while (1);
+		while (1)
+			;
 	}
 
 	SAFE_WAITPID(pid, &status, 0);
@@ -112,6 +126,12 @@ static void verify_setrlimit(void)
 static struct tst_test test = {
 	.test_all = verify_setrlimit,
 	.setup = setup,
+	.test_variants = TEST_VARIANTS,
+	.bufs = (struct tst_buffers []) {
+		{&rlim, .size = sizeof(*rlim)},
+		{&rlim_64, .size = sizeof(*rlim_64)},
+		{}
+	},
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.tags = (const struct tst_tag[]) {
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
