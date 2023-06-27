Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EDCEB64D9
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 05:19:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AC513CC9FB
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 07:19:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 955AB3C99AE
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 07:19:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 727CA1000742
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 07:19:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 838021F8B4
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 05:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687843154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vwc0tLwhVJ53HazF61P92thCeFYwUAmhVy/HTmCqEsE=;
 b=Oy4lTSsDY8SiX9YaCx+dnSVrhp4rnlS2uGMTN0x0/R1M05/ZB5u3h7oo++4RUG729uh2l2
 BPka6r4Z+mYJ86gZD2VVqJotSD8+iDS1mc1gyn/hb+veTnOE4rgDQPQ1NkNjykSPvzWS11
 YXGOyYQHURPz1RCiiDd8Qdb1gz7S/sA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687843154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vwc0tLwhVJ53HazF61P92thCeFYwUAmhVy/HTmCqEsE=;
 b=4Nazlv6zJPWFHuA6q/puCxplyo5R0alCgrABKQ4OwFjp7GOWKhOQXNwE1suNUxpe8KfE9h
 MzHhVdwqS6diKTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B0E313462
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 05:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WSS+L1FxmmQXYgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 05:19:13 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 27 Jun 2023 10:49:10 +0530
Message-ID: <20230627051911.521-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pipe14: Add new test
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

New test to verify, if the write end of a pipe is closed, then a process
reading from the pipe will see end-of-file (i.e., read() returns 0) once it
has read all remaining data in the pipe.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/pipe/.gitignore |  1 +
 testcases/kernel/syscalls/pipe/pipe14.c   | 46 +++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pipe/pipe14.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e5ad2c2f9..c6524d7c4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -988,6 +988,7 @@ pipe10 pipe10
 pipe11 pipe11
 pipe12 pipe12
 pipe13 pipe13
+pipe14 pipe14
 
 pipe2_01 pipe2_01
 pipe2_02 pipe2_02
diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
index 23e7186a6..774d73205 100644
--- a/testcases/kernel/syscalls/pipe/.gitignore
+++ b/testcases/kernel/syscalls/pipe/.gitignore
@@ -11,3 +11,4 @@
 /pipe11
 /pipe12
 /pipe13
+/pipe14
diff --git a/testcases/kernel/syscalls/pipe/pipe14.c b/testcases/kernel/syscalls/pipe/pipe14.c
new file mode 100644
index 000000000..2d2969d82
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/pipe14.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, if the write end of a pipe is closed, then a process reading
+ * from the pipe will see end-of-file (i.e., read() returns 0) once it has
+ * read all remaining data in the pipe.
+ */
+
+#include "tst_test.h"
+
+static int fds[2];
+
+static void run(void)
+{
+	char wrbuf[] = "abcdefghijklmnopqrstuvwxyz";
+	char rdbuf[30];
+
+	memset(rdbuf, 0, sizeof(rdbuf));
+	SAFE_PIPE(fds);
+
+	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, sizeof(wrbuf));
+	SAFE_CLOSE(fds[1]);
+
+	SAFE_READ(0, fds[0], rdbuf, sizeof(wrbuf));
+
+	TST_EXP_VAL(SAFE_READ(0, fds[0], rdbuf, 1), 0);
+	SAFE_CLOSE(fds[0]);
+}
+
+static void cleanup(void)
+{
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
