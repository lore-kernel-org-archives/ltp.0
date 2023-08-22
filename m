Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B7EE4996
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 13:46:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6A133CC73F
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 15:46:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 391DC3C2A04
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 15:46:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17FD71400F54
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 15:46:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 269871F892;
 Tue, 22 Aug 2023 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692711965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GBTevIy5TSbn/Lm4MYjFcXYw2VAAeE/VfMu5XFFMGXc=;
 b=TIj9jYl0dKlIz/K8TPK4cElIDxIvm9Y+HVbiWYb9Xhfhn4eBiW0Bz3+zbgQCBlm02X16Br
 CO6xhRBhDP8YNcDPNbcibl9D1FbuQyQLTxg9jR9/yoUftCzoqEqUto1kC5jUhrUGj2ToTZ
 NW2U8EvAYx+YZRmQOqJOB2pAhCUk+QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692711965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GBTevIy5TSbn/Lm4MYjFcXYw2VAAeE/VfMu5XFFMGXc=;
 b=EhZ2QPnOeKEjVYJbg6RJu30jX84N+9RMgR4VnfVvYEZHmOspRhFVVrsXkACrrhto3gm4iC
 q9B/NhBQLd+42uBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09135132B9;
 Tue, 22 Aug 2023 13:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NVk9Oxy85GTHDAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 22 Aug 2023 13:46:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 22 Aug 2023 15:46:04 +0200
Message-Id: <20230822134604.3982-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add process_madvise01 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test checks process_madvise support for MADV_PAGEOUT. It tests
if memory pages have been swapped out by looking at smaps information
after reclaiming memory using MADV_PAGEOUT.
This test supports kernel 5.10 or later.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/cma/cma.h           | 101 ++++++++++++++
 .../kernel/syscalls/cma/process_madvise01.c   | 124 ++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cma/cma.h
 create mode 100644 testcases/kernel/syscalls/cma/process_madvise01.c

diff --git a/testcases/kernel/syscalls/cma/cma.h b/testcases/kernel/syscalls/cma/cma.h
new file mode 100644
index 000000000..08a0d9319
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/cma.h
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef CMA_H__
+#define CMA_H__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "tst_safe_stdio.h"
+
+struct addr_mapping {
+	int size;
+	int rss;
+	int pss;
+	int shared_clean;
+	int shared_dirty;
+	int private_clean;
+	int private_dirty;
+	int referenced;
+	int anonymous;
+	int anon_huge_pages;
+	int shmem_huge_pages;
+	int shmem_pmd_mapped;
+	int swap;
+	int kernel_page_size;
+	int mmu_page_size;
+	int locked;
+	int protection_key;
+};
+
+static inline void read_address_mapping(unsigned long address, struct addr_mapping *mapping)
+{
+	FILE *f;
+	int found = 0;
+	char label[BUFSIZ];
+	char line[BUFSIZ];
+	char smaps[BUFSIZ];
+	char ptr_str[BUFSIZ];
+	int value;
+
+	snprintf(smaps, BUFSIZ, "/proc/%i/smaps", getpid());
+	snprintf(ptr_str, BUFSIZ, "%lx", address);
+
+	f = SAFE_FOPEN(smaps, "r");
+
+	while (fgets(line, BUFSIZ, f) != NULL) {
+		if (strncmp(ptr_str, line, strlen(ptr_str)) == 0)
+			found = 1;
+
+		if (!found)
+			continue;
+
+		if (found && strcmp(line, "VmFlags") >= 0)
+			break;
+
+		if (sscanf(line, "%31[^:]: %d", label, &value) > 0) {
+			if (strcmp(label, "Size") == 0)
+				mapping->size = value;
+			else if (strcmp(label, "Rss") == 0)
+				mapping->rss = value;
+			else if (strcmp(label, "Pss") == 0)
+				mapping->pss = value;
+			else if (strcmp(label, "Shared_Clean") == 0)
+				mapping->shared_clean = value;
+			else if (strcmp(label, "Shared_Dirty") == 0)
+				mapping->shared_dirty = value;
+			else if (strcmp(label, "Private_Clean") == 0)
+				mapping->private_clean = value;
+			else if (strcmp(label, "Private_Dirty") == 0)
+				mapping->private_dirty = value;
+			else if (strcmp(label, "Referenced") == 0)
+				mapping->referenced = value;
+			else if (strcmp(label, "Anonymous") == 0)
+				mapping->anonymous = value;
+			else if (strcmp(label, "AnonHugePages") == 0)
+				mapping->anon_huge_pages = value;
+			else if (strcmp(label, "ShmemHugePages") == 0)
+				mapping->shmem_huge_pages = value;
+			else if (strcmp(label, "ShmemPmdMapped") == 0)
+				mapping->shmem_pmd_mapped = value;
+			else if (strcmp(label, "Swap") == 0)
+				mapping->swap = value;
+			else if (strcmp(label, "KernelPageSize") == 0)
+				mapping->kernel_page_size = value;
+			else if (strcmp(label, "MMUPageSize") == 0)
+				mapping->mmu_page_size = value;
+			else if (strcmp(label, "Locked") == 0)
+				mapping->locked = value;
+			else if (strcmp(label, "ProtectionKey") == 0)
+				mapping->protection_key = value;
+		}
+	}
+
+	SAFE_FCLOSE(f);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/cma/process_madvise01.c b/testcases/kernel/syscalls/cma/process_madvise01.c
new file mode 100644
index 000000000..ea3e0270d
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_madvise01.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Allocate anonymous memory pages inside child and reclaim it with
+ * MADV_PAGEOUT. Then check if memory pages have been swapped out by looking
+ * at smaps information.
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
+#define MEM_CHILD	(1 * TST_MB)
+
+static void **data_ptr;
+
+static void child_alloc(void)
+{
+	char data[MEM_CHILD];
+	struct addr_mapping map_before;
+	struct addr_mapping map_after;
+
+	memset(data, 'a', MEM_CHILD);
+
+	tst_res(TINFO, "Allocate memory: %d bytes", MEM_CHILD);
+
+	*data_ptr = SAFE_MMAP(NULL, MEM_CHILD,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	memset(*data_ptr, 'a', MEM_CHILD);
+
+	memset(&map_before, 0, sizeof(struct addr_mapping));
+	read_address_mapping((unsigned long)*data_ptr, &map_before);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	memset(&map_after, 0, sizeof(struct addr_mapping));
+	read_address_mapping((unsigned long)*data_ptr, &map_after);
+
+	if (memcmp(*data_ptr, data, MEM_CHILD) != 0) {
+		tst_res(TFAIL, "Dirty memory after reclaiming it");
+		return;
+	}
+
+	SAFE_MUNMAP(*data_ptr, MEM_CHILD);
+	*data_ptr = NULL;
+
+    TST_EXP_EXPR(map_before.swap < map_after.swap,
+        "Most of the memory has been swapped out: %dkB",
+        map_after.swap);
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
+	tst_res(TINFO, "Reclaim memory using MADV_PAGEOUT");
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
