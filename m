Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8D8C4332F
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 11:08:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 473493CAE09
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 13:08:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ADAB3CAD92
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 13:07:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 013EF1A00437
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 13:07:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D99B219BB;
 Thu,  6 Oct 2022 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1665054476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCZ/KcMS/a5ihHmIVVHM0czD+IVenLXSYSnCvJerEBM=;
 b=s2zOTU8XjLqY+K9wqW/qQ1aKs/Dl0ShgiuLDwE2qJRX+mFBfDnL6sPiaMZjMA7/3TdPHP+
 o1xOu3CjSyMNC/wEJ/py0HGrZgpuXDu0lVQw85R1d6q/IfcGPzuuOxotzxrEFaKtueKKRQ
 MEekXPbvoplUNWOZOE5VEXKAlZRdGj8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7589813ACC;
 Thu,  6 Oct 2022 11:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wOObGgy3PmNmBQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 06 Oct 2022 11:07:56 +0000
To: ltp@lists.linux.it
Date: Thu,  6 Oct 2022 13:06:41 +0200
Message-Id: <20221006110642.12410-4-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221006110642.12410-1-andrea.cervesato@suse.com>
References: <20221006110642.12410-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] Add process_madvise02 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test for checking MADV_PAGEOUT functionality over anonymous memory in
process_madvise syscall.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/cma/.gitignore      |   1 +
 .../kernel/syscalls/cma/process_madvise02.c   | 128 ++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cma/process_madvise02.c

diff --git a/testcases/kernel/syscalls/cma/.gitignore b/testcases/kernel/syscalls/cma/.gitignore
index 846704294..47ae3e445 100644
--- a/testcases/kernel/syscalls/cma/.gitignore
+++ b/testcases/kernel/syscalls/cma/.gitignore
@@ -3,3 +3,4 @@
 /process_vm_readv03
 /process_vm_writev02
 /process_madvise01
+/process_madvise02
diff --git a/testcases/kernel/syscalls/cma/process_madvise02.c b/testcases/kernel/syscalls/cma/process_madvise02.c
new file mode 100644
index 000000000..9f42dd48a
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_madvise02.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Spawn child inside cgroup and set max memory. Allocate anonymous memory
+ * pages inside child and reclaim it with MADV_PAGEOUT. Then check if memory
+ * pages have been swapped out.
+ *
+ * The advice might be ignored for some pages in the range when it is
+ * not applicable, so test passes if swap memory increases after
+ * reclaiming memory with MADV_PAGEOUT.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/mman.h>
+#include "tst_test.h"
+#include "lapi/mmap.h"
+#include "lapi/syscalls.h"
+#include "cma.h"
+
+#define MEM_CHILD	(10 * 1024 * 1024)
+
+static void **data_ptr;
+
+static void child_alloc(void)
+{
+	char *ptr;
+	int freed = 1;
+	struct addr_mapping map_before;
+	struct addr_mapping map_after;
+
+	tst_res(TINFO, "Allocate memory");
+
+	*data_ptr = SAFE_MMAP(NULL, MEM_CHILD,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	memset(*data_ptr, 'a', MEM_CHILD);
+
+	read_address_mapping((unsigned long)*data_ptr, &map_before);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	for (ptr = *data_ptr; *ptr != '\0'; ptr++) {
+		if (*ptr == 'a') {
+			freed = 0;
+			break;
+		}
+	}
+
+	if (freed) {
+		tst_res(TFAIL, "Memory has been freed");
+		return;
+	}
+
+	read_address_mapping((unsigned long)*data_ptr, &map_after);
+
+	SAFE_MUNMAP(*data_ptr, MEM_CHILD);
+	*data_ptr = NULL;
+
+	if (map_before.swap < map_after.swap)
+		tst_res(TPASS, "Memory has been swapped out");
+	else
+		tst_res(TFAIL, "Swap memory has decreased");
+}
+
+static void setup(void)
+{
+	data_ptr = SAFE_MMAP(NULL, sizeof(void *),
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (*data_ptr)
+		SAFE_MUNMAP(*data_ptr, MEM_CHILD);
+
+	if (data_ptr)
+		SAFE_MUNMAP(data_ptr, sizeof(void *));
+}
+
+static void run(void)
+{
+	int ret;
+	int pidfd;
+	pid_t pid_alloc;
+	struct iovec vec;
+
+	pid_alloc = SAFE_FORK();
+	if (!pid_alloc) {
+		child_alloc();
+		return;
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	tst_res(TINFO, "Apply MADV_PAGEOUT advise rule");
+
+	pidfd = SAFE_PIDFD_OPEN(pid_alloc, 0);
+
+	vec.iov_base = *data_ptr;
+	vec.iov_len = MEM_CHILD;
+
+	ret = tst_syscall(__NR_process_madvise, pidfd, &vec, 1UL,
+			MADV_PAGEOUT, 0UL);
+
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "process_madvise failed");
+
+	if (ret != MEM_CHILD)
+		tst_brk(TBROK, "process_madvise reclaimed only %d bytes", ret);
+
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+	.min_kver = "5.10",
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
