Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7B1C77B73
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 09:40:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9753CD2C6
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 11:39:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B49E3CAD6B
 for <ltp@lists.linux.it>; Wed, 24 May 2023 11:39:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8732A60019B
 for <ltp@lists.linux.it>; Wed, 24 May 2023 11:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684921176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDg5/XUbgOd43xJBT5Ry4PBve6XrOraQ1KvBmHj+9ik=;
 b=E14JGMZQ9ex9RkfXkUZ98xBDxouRpjtfLH8VW35stJh+w8LsOlU6VWqONV3X2+XCvbAA9V
 XrCarXsRxV5OWk3XcO2FnRw+Ts3WBF5/EiHZvwGyjfEytWRp7Yvpwkw8E6ILhDvJM8UHSy
 sdCGA+0OwNgqp2/gvbty4/ZZYXd4uXo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-28nwE0T8NUeAXwt7qg111A-1; Wed, 24 May 2023 05:39:34 -0400
X-MC-Unique: 28nwE0T8NUeAXwt7qg111A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FB501C07827
 for <ltp@lists.linux.it>; Wed, 24 May 2023 09:39:34 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B026AC1ED99
 for <ltp@lists.linux.it>; Wed, 24 May 2023 09:39:33 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 24 May 2023 17:39:30 +0800
Message-Id: <20230524093930.43971-2-liwang@redhat.com>
In-Reply-To: <20230524093930.43971-1-liwang@redhat.com>
References: <20230524093930.43971-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/2] hugemmap33: Test to detect bug with migrating
 gigantic pages
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap33.c  | 143 ++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 299c07ac9..3576e063d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -35,6 +35,7 @@ hugemmap29 hugemmap29
 hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
+hugemmap32 hugemmap33
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..d130d4dcd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -34,6 +34,7 @@
 /hugetlb/hugemmap/hugemmap30
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
+/hugetlb/hugemmap/hugemmap33
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
new file mode 100644
index 000000000..12a470193
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2023
+ * Copyright (C) 2023, Red Hat, Inc.
+ *
+ * Author: David Hildenbrand <david@redhat.com>
+ * Port-to-LTP: Li Wang <liwang@redhat.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Migration code will first unmap the old page and replace the present PTE
+ * by a migration entry. Then migrate the page. Once that succeeded (and there
+ * are no unexpected page references), we replace the migration entries by
+ * proper present PTEs pointing at the new page.
+ *
+ * For ordinary pages we handle PTEs. For 2 MiB hugetlb/THP, it's PMDs.
+ * For 1 GiB hugetlb, it's PUDs.
+ *
+ * So without below commit, GUP-fast code was simply not aware that we could
+ * have migration entries stored in PUDs. Migration + GUP-fast code should be
+ * able to handle any such races.
+ *
+ * For example, GUP-fast will re-verify the PUD after pinning to make sure it
+ * didn't change. If it did change, it backs off.
+ *
+ * Migration code should detect the additional page references and back off
+ * as well.
+ *
+ *  commit 15494520b776aa2eadc3e2fefae524764cab9cea
+ *  Author: Qiujun Huang <hqjagain@gmail.com>
+ *  Date:   Thu Jan 30 22:12:10 2020 -0800
+ *
+ *      mm: fix gup_pud_range
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <linux/mempolicy.h>
+#include <linux/mman.h>
+
+#include "lapi/syscalls.h"
+#include "numa_helper.h"
+#include "hugetlb.h"
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
+static char *mem;
+static size_t pagesize;
+static size_t hugetlbsize;
+static volatile int looping = 1;
+
+static void *migration_thread_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	while (looping) {
+		TST_EXP_PASS_SILENT(syscall(__NR_mbind, mem, hugetlbsize,
+			MPOL_LOCAL, NULL, 0x7fful, MPOL_MF_MOVE));
+	}
+
+	return NULL;
+}
+
+static void run_test(void)
+{
+	ssize_t transferred;
+	struct iovec iov;
+	int fds[2];
+
+	pthread_t migration_thread;
+
+	if (!is_numa(NULL, NH_MEMS, 1))
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
+
+	pagesize = getpagesize();
+	hugetlbsize = 1 * 1024 * 1024 * 1024u;
+
+	mem = mmap(NULL, hugetlbsize, PROT_READ|PROT_WRITE,
+		   MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_1GB,
+		   -1, 0);
+	if (mem == MAP_FAILED)
+		tst_brk(TBROK | TERRNO, "mmap() failed");
+
+	memset(mem, 1, hugetlbsize);
+
+	/* Keep migrating the page around ... */
+	TEST(pthread_create(&migration_thread, NULL, migration_thread_fn, NULL));
+	if (TST_RET)
+		tst_brk(TBROK | TRERRNO, "pthread_create failed");
+
+	while (looping) {
+		if (pipe(fds) < 0)
+			tst_brk(TBROK | TERRNO, "pipe() failed");
+
+		iov.iov_base = mem;
+		iov.iov_len = pagesize;
+		transferred = vmsplice(fds[1], &iov, 1, 0);
+		if (transferred <= 0)
+			tst_brk(TBROK | TERRNO, "vmsplice() failed");
+
+		close(fds[0]);
+		close(fds[1]);
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Runtime exhausted, exiting");
+			looping = 0;
+		}
+	}
+
+	TEST(pthread_join(migration_thread, NULL));
+	if (TST_RET)
+		tst_brk(TBROK | TRERRNO, "pthread_join failed");
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "Test resulted in kernel tainted");
+	else
+		tst_res(TPASS, "Test completed successfully");
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all = run_test,
+	.max_runtime = 60,
+	.hugepages = {2, TST_NEEDS, 1048576},
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (struct tst_tag[]) {
+	    {"linux-git", "15494520b776"},
+	    {}
+	},
+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
+	},
+};
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
