Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCECC4345F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 05:32:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 923563C8206
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 07:32:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42E463C9D40
 for <ltp@lists.linux.it>; Mon,  6 May 2024 07:32:20 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF474221A0E
 for <ltp@lists.linux.it>; Mon,  6 May 2024 07:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714973538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLg8mVDAfdcGUzVxFviJ8lcOm0so6hXh1ql1PyV+EPs=;
 b=erbIL8LoTDaE7RvQhHUUBAipF5+Q5VWizM1+hrrF6BH5zABFec8L4t87Cuxgl9+26ekGmf
 mA9EKzMRyYERAellW9JvgZpX/zaLGbw+DBA04NmD8fSEgBgS05oo5lpZhPoxyEeyBx++ve
 KAFYrBJZFMdw/fTLOGpfVNVigv3rZpA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-y16bKPRHNVObdaoBj9UIHw-1; Mon,
 06 May 2024 01:32:15 -0400
X-MC-Unique: y16bKPRHNVObdaoBj9UIHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEFDC380673B;
 Mon,  6 May 2024 05:32:14 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D875492BC7;
 Mon,  6 May 2024 05:32:11 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 May 2024 13:32:07 +0800
Message-ID: <20240506053207.12308-2-liwang@redhat.com>
In-Reply-To: <20240506053207.12308-1-liwang@redhat.com>
References: <20240506053207.12308-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v3 2/2] kallsyms01: Utilize ksymbol table for
 unauthorized address access
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
Cc: Rafael Aquini <aquini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Access the system symbols with root permission to test whether it's
possible to read and write the memory addresses of kernel-space
from user-space. This helps in identifying potential vulnerabilities
where user-space processes can inappropriately access kernel memory.

Suggested-by: Rafael Aquini <aquini@redhat.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v2 --> v3
    	* update GPL lisence to 2.0-or-later
    	* move the sigaction to the test setup
    	* init segv_caught to 0 in the main
    	* add TFAIL print in report

 runtest/mm                                    |   2 +
 testcases/kernel/security/kallsyms/.gitignore |   1 +
 testcases/kernel/security/kallsyms/Makefile   |   6 +
 testcases/kernel/security/kallsyms/kallsyms.c | 145 ++++++++++++++++++
 4 files changed, 154 insertions(+)
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
index 000000000..818e8c471
--- /dev/null
+++ b/testcases/kernel/security/kallsyms/kallsyms.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+static struct kallsym *sym_table;
+static unsigned int nr_symbols;
+static sigjmp_buf jmpbuf;
+volatile sig_atomic_t segv_caught;
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
+static unsigned int read_kallsyms(struct kallsym *table, unsigned int table_size)
+{
+	char *line = NULL;
+	size_t len = 0;
+	unsigned int nr_syms = 0;
+	FILE *stream = SAFE_FOPEN("/proc/kallsyms", "r");
+
+	while (getline(&line, &len, stream) != -1) {
+
+		if (table && nr_syms < table_size) {
+			sscanf(line, "%lx %c %s",
+					&table[nr_syms].addr,
+					&table[nr_syms].type,
+					table[nr_syms].name);
+		}
+
+		nr_syms++;
+	}
+
+	SAFE_FCLOSE(stream);
+
+	return nr_syms;
+}
+
+static void setup(void)
+{
+	struct sigaction sa;
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = segv_handler;
+	sigaction(SIGSEGV, &sa, NULL);
+
+	nr_symbols = read_kallsyms(NULL, 0);
+	sym_table = SAFE_CALLOC(nr_symbols, sizeof(*sym_table));
+	unsigned int read_symbols = read_kallsyms(sym_table, nr_symbols);
+
+	if (nr_symbols != read_symbols)
+		tst_res(TWARN, "/proc/kallsyms changed size!?");
+}
+
+static void access_ksymbols_address(struct kallsym *table)
+{
+	tst_res(TDEBUG, "Access kernel addr: 0x%lx (%c) (%s)",
+				table->addr, table->type, table->name);
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		*(volatile unsigned long *)table->addr = 0;
+
+		tst_res(TFAIL, "Successfully accessed kernel addr 0x%lx (%c) (%s)",
+				table->addr, table->type, table->name);
+	}
+}
+
+static void test_access_kernel_address(void)
+{
+	segv_caught = 0;
+
+	for (unsigned int i = 0; i < nr_symbols; i++)
+		access_ksymbols_address(&sym_table[i]);
+
+	if (segv_caught == (sig_atomic_t)nr_symbols)
+		tst_res(TPASS, "Caught %d SIGSEGV in access ksymbols addr", segv_caught);
+	else
+		tst_res(TFAIL, "Caught %d SIGSEGV but expected %d", segv_caught, nr_symbols);
+}
+
+static void cleanup(void)
+{
+	if (sym_table)
+		free(sym_table);
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
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
