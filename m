Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C87C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 05:36:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AA6D3CFEEC
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 07:36:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8AC63CFE55
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 07:36:21 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D586B2005F8
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 07:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713764179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CVFjLstDb3i53y5BnMmQJQb+vWB8PxvTTaHjAr9lIuQ=;
 b=J+Ad5L5zmkhIT0T9YvJFZmduCXY6l5OrpiCj1zyanSw7ILEK4Br/mcj3iXLWZRcLZsfc7h
 lT/EDA94AOggmVDiodcl06Ti/Po2Ficn2MbOy6QkVYvqQdW6Vhm1+DqVutuxqC+744sLB4
 rpgqLOgX9huEmNFHoEYr+BWYD9eFDI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-He1D9Yt3M8aaB_SZSgwYxQ-1; Mon, 22 Apr 2024 01:36:16 -0400
X-MC-Unique: He1D9Yt3M8aaB_SZSgwYxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06A2018065AA
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 05:36:16 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C392151EF
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 05:36:14 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 22 Apr 2024 13:36:11 +0800
Message-Id: <20240422053611.3581473-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kallsyms01: Utilize ksymbol table for unauthorized
 address access
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

Access the system symbols with root permission to test whether it's
possible to read and write the memory addresses of kernel-space
from user-space. This helps in identifying potential vulnerabilities
where user-space processes can inappropriately access kernel memory.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/mm                                    |   2 +
 testcases/kernel/security/kallsyms/.gitignore |   1 +
 testcases/kernel/security/kallsyms/Makefile   |   6 +
 testcases/kernel/security/kallsyms/kallsyms.c | 161 ++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 testcases/kernel/security/kallsyms/.gitignore
 create mode 100644 testcases/kernel/security/kallsyms/Makefile
 create mode 100644 testcases/kernel/security/kallsyms/kallsyms.c

diff --git a/runtest/mm b/runtest/mm
index d859b331c..6a8cd0b9d 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -58,6 +58,8 @@ mmap10_2 mmap10 -s
 mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -i 60
 
+kallsyms kallsyms
+
 ksm01 ksm01
 ksm01_1 ksm01 -u 128
 ksm02 ksm02
diff --git a/testcases/kernel/security/kallsyms/.gitignore b/testcases/kernel/security/kallsyms/.gitignore
new file mode 100644
index 000000000..7074d4e24
--- /dev/null
+++ b/testcases/kernel/security/kallsyms/.gitignore
@@ -0,0 +1 @@
+kallsyms
diff --git a/testcases/kernel/security/kallsyms/Makefile b/testcases/kernel/security/kallsyms/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/security/kallsyms/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/kallsyms/kallsyms.c b/testcases/kernel/security/kallsyms/kallsyms.c
new file mode 100644
index 000000000..83622dea7
--- /dev/null
+++ b/testcases/kernel/security/kallsyms/kallsyms.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Red Hat, Inc.
+ */
+
+/*\
+ * [Description]
+ *
+ *  Utilize kernel's symbol table for unauthorized address access.
+ *
+ *  Access the system symbols with root permission to test whether it's
+ *  possible to read and write the memory addresses of kernel-space
+ *  from user-space. This helps in identifying potential vulnerabilities
+ *  where user-space processes can inappropriately access kernel memory.
+ *
+ * Steps:
+ *  1. Start a process that reads all symbols and their addresses from
+ *     '/proc/kallsyms' and stores them in a linked list.
+ *
+ *  2. Attempt to write to each kernel address found in the linked list.
+ *     The expectation is that each attempt will fail with a SIGSEGV
+ *     (segmentation fault), indicating that the user-space process
+ *     cannot write to kernel memory.
+ *
+ *  3. Handle each SIGSEGV using a signal handler that sets a flag and
+ *     long jumps out of the faulting context.
+ *
+ *  4. If any write operation does not result in a SIGSEGV, log this as
+ *     a potential security vulnerability.
+ *
+ *  5. Observe and log the behavior and any system responses to these
+ *     unauthorized access attempts.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <unistd.h>
+#include <string.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+struct kallsym {
+	unsigned long addr;
+	char type;
+	char name[128];
+};
+
+struct ksymstbl {
+	struct kallsym symbol;
+	struct ksymstbl *next;
+};
+
+static struct ksymstbl *sym_table;
+static unsigned int nr_symbols;
+static sigjmp_buf jmpbuf;
+volatile sig_atomic_t segv_caught = 0;
+
+static void segv_handler(int sig)
+{
+	if (sig == SIGSEGV)
+		segv_caught++;
+	else
+		tst_res(TFAIL, "Unexpected signal %s", strsignal(sig));
+
+	siglongjmp(jmpbuf, 1);
+}
+
+static struct ksymstbl *read_kallsyms(unsigned int *nr_symbols)
+{
+	FILE *stream;
+	char *line = NULL;
+	size_t len = 0;
+	unsigned int nr_syms = 0;
+	struct ksymstbl *head, *item, *i;
+
+	item = head = calloc(1, sizeof(*head));
+	if (head == NULL)
+		goto out;
+
+	stream = SAFE_FOPEN("/proc/kallsyms", "r");
+
+	while (getline(&line, &len, stream) != -1) {
+		i = item;
+
+		sscanf(line, "%lx %c %s",
+				&i->symbol.addr, &i->symbol.type, i->symbol.name);
+
+		item = calloc(1, sizeof(*i));
+		if (item == NULL)
+			tst_brk(TBROK, "In calloc[]");
+
+		i->next = item;
+		nr_syms += 1;
+	}
+
+	*nr_symbols = nr_syms;
+	SAFE_FCLOSE(stream);
+out:
+	return head;
+}
+
+static void setup(void)
+{
+	sym_table = read_kallsyms(&nr_symbols);
+	if (!sym_table)
+		tst_brk(TBROK, "Failed to read kernel symbols");
+}
+
+static void access_ksymbols_address(struct ksymstbl *sym_table)
+{
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		*(volatile unsigned long *)sym_table->symbol.addr = 0;
+
+		tst_res(TFAIL, "Successfully accessed kernel addr 0x%lx (%s)",
+			sym_table->symbol.addr, sym_table->symbol.name);
+	}
+
+}
+
+static void test_access_kernel_address(void)
+{
+	struct ksymstbl *current;
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = segv_handler;
+	sigaction(SIGSEGV, &sa, NULL);
+
+	current = sym_table;
+	while (current->next != NULL) {
+		access_ksymbols_address(current);
+		current = current->next;
+	}
+
+	if (segv_caught == (sig_atomic_t)nr_symbols)
+		tst_res(TPASS, "Caught %d times SIGSEGV in access ksymbols addr", segv_caught);
+}
+
+static void cleanup(void)
+{
+	while (sym_table != NULL) {
+		struct ksymstbl *temp = sym_table;
+		sym_table = sym_table->next;
+		free(temp);
+	}
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.max_runtime = 60,
+	.test_all = test_access_kernel_address,
+};
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
