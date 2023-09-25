Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B84CE7A89
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 09:30:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAE0E3CDCBF
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:30:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778CA3C99D5
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 11:30:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A3B61A00E16
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 11:30:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF57E1F459;
 Mon, 25 Sep 2023 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695634212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=utANgiuKVg3YZt2chO8uzkGFWutSutt3rtUXfuzmIOM=;
 b=FHTxHPkRPtvBHbvdUd0dbNqbQLyPNVjHLbLzQYKeDXqXxQi958zMX/8N+sZvTbhFjvADwr
 kx1WUTpmDpX/fa4vgQEIrAIn5xHDqrbyQCIyyw9lKG0ir7aDftCVXrsayzgZMPbtXVZr2Z
 Fujp4m9E4kfOeH5pdcGb4xrsvfJqeAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695634212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=utANgiuKVg3YZt2chO8uzkGFWutSutt3rtUXfuzmIOM=;
 b=YkN6dx3V2ZZna2tLnsCKp/LBR+rgu1odppenMhGLnxNJEjVY9/erpn8JZQY5mdPyPC7hud
 FzDYj/ZkyyDJhOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C7F01358F;
 Mon, 25 Sep 2023 09:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M+ZSJSRTEWWEBQAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 25 Sep 2023 09:30:12 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 11:30:05 +0200
Message-ID: <20230925093005.24248-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add regression test for hangup on pipe operations
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

This tests the problem fixed by the patch
https://www.spinics.net/lists/linux-api/msg49731.html.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/pipe/.gitignore |  1 +
 testcases/kernel/syscalls/pipe/pipe15.c   | 96 +++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pipe/pipe15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..6c125c2f5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1004,6 +1004,7 @@ pipe11 pipe11
 pipe12 pipe12
 pipe13 pipe13
 pipe14 pipe14
+pipe15 pipe15
 
 pipe2_01 pipe2_01
 pipe2_02 pipe2_02
diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
index 774d73205..581a68b78 100644
--- a/testcases/kernel/syscalls/pipe/.gitignore
+++ b/testcases/kernel/syscalls/pipe/.gitignore
@@ -12,3 +12,4 @@
 /pipe12
 /pipe13
 /pipe14
+/pipe15
diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
new file mode 100644
index 000000000..7b55143c1
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/pipe15.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC Marius Kittler <mkittler@suse.de>
+ */
+
+/*\
+ * [Description]
+ *
+ * This is a regression test for hangup on pipe operations. See
+ * https://www.spinics.net/lists/linux-api/msg49762.html for
+ * additional context. It tests that pipe operations do not block
+ * indefinitely when going to the soft limit on the total size of
+ * all pipes created by a single user.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_macros.h"
+
+static int pipe_count;
+static int *pipes;
+static char *buffer;
+static int buffer_size;
+
+static void run(void)
+{
+	SAFE_WRITE(0, pipes[1], buffer, buffer_size);
+	SAFE_READ(0, pipes[0], buffer, buffer_size - 1);
+	SAFE_WRITE(0, pipes[1], buffer, 1);
+	tst_res(TPASS,
+		"Pipe operations do not block indefinitely when going to "
+		"the soft limit on the total size of all pipes created by "
+		"a single user");
+}
+
+static void setup(void)
+{
+	int pipe[2];
+	int page_size = getpagesize(), soft_limit;
+	struct rlimit nfd;
+
+	/* determine the buffer size of a pipe, usually 65536 */
+	SAFE_PIPE(pipe);
+	buffer_size = fcntl(pipe[1], F_GETPIPE_SZ);
+	SAFE_CLOSE(pipe[0]);
+	SAFE_CLOSE(pipe[1]);
+
+	/* determine the max number of pipes we can create within the
+	 * soft limit, usually 1024
+	 */
+	SAFE_FILE_SCANF("/proc/sys/fs/pipe-user-pages-soft", "%i", &soft_limit);
+	pipe_count = soft_limit * page_size / buffer_size;
+
+	tst_res(TINFO, "Soft limit for pipes: %i pages", soft_limit);
+	tst_res(TINFO, "Buffer size: %d byte", buffer_size);
+	tst_res(TINFO, "Creating %i pipes", pipe_count);
+
+	/* avoid running into "pipe() failed: EMFILE (24)" */
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
+	if (nfd.rlim_max < (unsigned long)pipe_count)
+		tst_brk(TCONF, "NOFILE limit max too low: %lu < %i",
+			nfd.rlim_max, pipe_count);
+	if (nfd.rlim_cur < nfd.rlim_max) {
+		nfd.rlim_cur = nfd.rlim_max;
+		SAFE_SETRLIMIT(RLIMIT_NOFILE, &nfd);
+	}
+
+	/* allocate memory for pipes and the buffer */
+	pipes = calloc(pipe_count * 2, sizeof(int));
+	memset(pipes, 0xFF, pipe_count * 2 * sizeof(int));
+	for (int i = 0; i < pipe_count; ++i)
+		SAFE_PIPE(pipes + i * 2);
+	buffer = calloc(buffer_size, 1);
+}
+
+static void cleanup(void)
+{
+	for (int i = 0; i < pipe_count * 2; i++)
+		if (pipes[i] > 0)
+			SAFE_CLOSE(pipes[i]);
+	if (pipes)
+		free(pipes);
+	if (buffer)
+		free(buffer);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
