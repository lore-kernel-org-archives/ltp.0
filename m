Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ACEC021A9
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 02:31:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F12E43C9C25
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 03:31:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE7963C0959
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 03:31:18 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=chwen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4DF761414C5B
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 03:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739845876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wr36urdCXnyl+Lk+vHciQtUzHPqX7F6BmC2M43E+HmE=;
 b=Wz05v/fXrAYWcgRrXfUqlqnh8jOnJuUtFkGSojb14YD3dBvCajBReqUPlVyAiPCbYxuv/J
 Z22pDK2VNCzwonMR+3EGdxhrzRWDYH3t5lWwGBptsp98M89krRjNfxA08wqWtZM7UX5x8N
 FxOg0QMERuFfWK/W815R1kooLE0UePQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ZcAG8igxOnyjRNOzi3m1PA-1; Mon,
 17 Feb 2025 21:31:14 -0500
X-MC-Unique: ZcAG8igxOnyjRNOzi3m1PA-1
X-Mimecast-MFC-AGG-ID: ZcAG8igxOnyjRNOzi3m1PA_1739845874
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B02111800373
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 02:31:13 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75972180034D
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 02:31:12 +0000 (UTC)
From: chunfuwen <chwen@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 21:31:07 -0500
Message-ID: <20250218023107.1208990-1-chwen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YrOkqbJGZ-xGO-jGqlkrJtgJIQGWfcQKsAVYFhbwv64_1739845874
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add test case to cover the setting resource limit64
 for process
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

The test ensures that the process gets the correct signals in the correct order:

First, it should get SIGXCPU after reaching the soft CPU time limit64.
Then, if the CPU time exceeds the hard limit, it should receive SIGKILL

Signed-off-by: chunfuwen <chwen@redhat.com>
---
 .../kernel/syscalls/setrlimit/setrlimit07.c   | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setrlimit/setrlimit07.c

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit07.c b/testcases/kernel/syscalls/setrlimit/setrlimit07.c
new file mode 100644
index 000000000..031d58c64
--- /dev/null
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit07.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*
+ * Description:
+ * Set CPU time limit64 for a process and check its behavior
+ * after reaching CPU time limit64.
+ * 1) Process got SIGXCPU after reaching soft limit of CPU time limit64.
+ * 2) Process got SIGKILL after reaching hard limit of CPU time limit64.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <sys/mman.h>
+#include <inttypes.h>
+
+#include "tst_test.h"
+
+#include "lapi/syscalls.h"
+#include "lapi/abisize.h"
+
+#ifndef HAVE_STRUCT_RLIMIT64
+struct rlimit64 {
+	uint64_t rlim_cur;
+	uint64_t rlim_max;
+};
+#endif
+
+static int *end;
+
+static void sighandler(int sig)
+{
+	*end = sig;
+}
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGXCPU, sighandler);
+
+	end = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (end)
+		SAFE_MUNMAP(end, sizeof(int));
+}
+
+static int setrlimit_u64(int resource, const struct rlimit64 *rlim)
+{
+    return tst_syscall(__NR_prlimit64, 0, resource, rlim, NULL);
+}
+
+static void verify_setrlimit64(void)
+{
+	int status;
+	pid_t pid;
+	struct rlimit64 rlim;
+	rlim.rlim_cur = 1;
+	rlim.rlim_max = 2;
+
+	*end = 0;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TEST(setrlimit_u64(RLIMIT_CPU, &rlim));
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO,
+				"setrlimit_u64(RLIMIT_CPU) failed");
+			exit(1);
+		}
+
+		alarm(20);
+
+		while (1);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
+		return;
+
+	if (WIFSIGNALED(status)) {
+		if (WTERMSIG(status) == SIGKILL && *end == SIGXCPU) {
+			tst_res(TPASS,
+				"Got SIGXCPU then SIGKILL after reaching both limit");
+			return;
+		}
+
+		if (WTERMSIG(status) == SIGKILL && !*end) {
+			tst_res(TFAIL,
+				"Got only SIGKILL after reaching both limit");
+			return;
+		}
+
+		if (WTERMSIG(status) == SIGALRM && *end == SIGXCPU) {
+			tst_res(TFAIL,
+				"Got only SIGXCPU after reaching both limit");
+			return;
+		}
+
+		if (WTERMSIG(status) == SIGALRM && !*end) {
+			tst_res(TFAIL,
+				"Got no signal after reaching both limit");
+			return;
+		}
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
+}
+
+static struct tst_test test = {
+	.test_all = verify_setrlimit64,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
