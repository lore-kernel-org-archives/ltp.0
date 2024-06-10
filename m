Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1182CC27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 14:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91C173D0B54
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 16:09:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA9383C74EA
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 16:09:03 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 15DDF1000F79
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 16:09:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BF591F7F4;
 Mon, 10 Jun 2024 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718028542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B6ly/g9YTrGU7sLGBltueYmJYeNE93raFMmj8zq3990=;
 b=LzfWnxmyhp+PYOV+VNQfZImQoVkEgkNIHPHwYSN+evdsJXtUMRq8jM6i94EkLJNZEGLRUb
 kNG+1BEbfYgijl+1U6mEXwmtjxCLBxv30SDi018EBxkV++29bpo6zfnjW7E3og+ODgts/3
 QlQYLpVgBrwCHpsUwhtWBU65cDdQ164=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718028542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B6ly/g9YTrGU7sLGBltueYmJYeNE93raFMmj8zq3990=;
 b=kKs1SkAId3G6mMYLqHhnNLMBXjvKarjw26epO56IM6uBO+gaeP9UL8JCwn4M3s7DwmO0VH
 YGr7IrN05/N6IWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718028542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B6ly/g9YTrGU7sLGBltueYmJYeNE93raFMmj8zq3990=;
 b=LzfWnxmyhp+PYOV+VNQfZImQoVkEgkNIHPHwYSN+evdsJXtUMRq8jM6i94EkLJNZEGLRUb
 kNG+1BEbfYgijl+1U6mEXwmtjxCLBxv30SDi018EBxkV++29bpo6zfnjW7E3og+ODgts/3
 QlQYLpVgBrwCHpsUwhtWBU65cDdQ164=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718028542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B6ly/g9YTrGU7sLGBltueYmJYeNE93raFMmj8zq3990=;
 b=kKs1SkAId3G6mMYLqHhnNLMBXjvKarjw26epO56IM6uBO+gaeP9UL8JCwn4M3s7DwmO0VH
 YGr7IrN05/N6IWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BAA113A7F;
 Mon, 10 Jun 2024 14:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VLqfCP4IZ2auQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Jun 2024 14:09:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Jun 2024 16:08:57 +0200
MIME-Version: 1.0
Message-Id: <20240610-shutdown-v3-1-2733be9fa101@suse.com>
X-B4-Tracking: v=1; b=H4sIAPkIZ2YC/02Myw6CMBBFf4XM2po+eLryP4yLpp1KF1LTgaoh/
 LuFxMDy3NxzZiCMHgkuxQwRkycfhgzqVIDp9fBA5m1mkFyWvJIlo34abXgPzLS2qVqOnag15Ps
 rovOfLXW7Z+49jSF+t3IS6/qPNHskCcaZcOic0RUq6640EZ5NeMLaSHL3an70ZPY07wwq2XFEc
 fCWZfkB1/vgFNcAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4079;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=00qB+LNC7DC7ir5hyGDr6xAp+j/4og2q03415x2okaU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmZwj6feYsEewjyTf4vQoq37aSzgxykzTLZFJV8
 32mZQgUsAqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmcI+gAKCRDLzBqyILPm
 RrCqDACxLO+pfGhs10OiCWfMzhJUnNNtKwI2Wip5XP0YwVVL2GpBYj3NiJY1sT9jYQGumLgWGAD
 CNKEuC4GVhpQ7vdPEh5BPIKNG83j/xj8zonD9bQQtDS3k1CC3u34cRGTXAF8ozhD2F8H/i3Y9cQ
 C/MVZOwRpVwxL0EHZSMIUVodE4WVJ3Yv6QCZYgnuPnQIwGmpijn3Ld+gk3a+s+XjnbEK0oJ/iJL
 NR/UJ2PnIpZqRhormy2msFEWcNLxY2QAiuM57tjYxgpD2ITNth2BMLdJMr6/oO6UmhCFu8JhkVZ
 SsU7Z9UMugvE27FH0ZYx//4yysG4BX/bPAIaS0eaI/Ys1h96sJpBTORPJU7WIMsJzp3h4N5E3EC
 Ns9QXwy6qnz8gU4fUCRz+iekC0Ykpo+yhrsRX+aFg5B++mOAywAPC1t9rbuegHnbhm++4f0q3dz
 vOgEstVCS/un8EDbgKq54KOFP/5UWhoi7CblJ7vSOgqf7TWVfuAw1sPXwfbLSuVEf3+ko=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add shutdown02 test
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

This test verifies the following shutdown() errors:

- EBADF sockfd is not a valid file descriptor
- EINVAL An invalid value was specified in how
- ENOTCONN The specified socket is not connected
- ENOTSOCK The file descriptor sockfd does not refer to a socket

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This testing suite is meant to test shutdown() syscall functionalities.
The current LTP version uses shutdown() inside many tests, but none of
them is specifically running unit tests for it.

This suite comes with both unit tests for shutdown() flags and error
codes.
---
Changes in v3:
- shutdown02: fix file descriptors initialization
- Link to v2: https://lore.kernel.org/r/20240607-shutdown-v2-0-a09ce3290ee1@suse.com

Changes in v2:
- shutdown01: move test cases inside .test / .tcnt
- shutdown01: usage of SAFE_RECV / SAFE_SEND
- shutdown01: fixed documentation formatting
- shutdown02: fixed documentation formatting
- Link to v1: https://lore.kernel.org/r/20240527-shutdown-v1-0-1feffca5e3df@suse.com
---
 runtest/syscalls                                |  1 +
 testcases/kernel/syscalls/shutdown/.gitignore   |  1 +
 testcases/kernel/syscalls/shutdown/shutdown02.c | 76 +++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index dc396415e..44a577db3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1466,6 +1466,7 @@ shmget05 shmget05
 shmget06 shmget06
 
 shutdown01 shutdown01
+shutdown02 shutdown02
 
 sigaction01 sigaction01
 sigaction02 sigaction02
diff --git a/testcases/kernel/syscalls/shutdown/.gitignore b/testcases/kernel/syscalls/shutdown/.gitignore
index 2df24d1ab..fd1ed807d 100644
--- a/testcases/kernel/syscalls/shutdown/.gitignore
+++ b/testcases/kernel/syscalls/shutdown/.gitignore
@@ -1 +1,2 @@
 shutdown01
+shutdown02
diff --git a/testcases/kernel/syscalls/shutdown/shutdown02.c b/testcases/kernel/syscalls/shutdown/shutdown02.c
new file mode 100644
index 000000000..33f748814
--- /dev/null
+++ b/testcases/kernel/syscalls/shutdown/shutdown02.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies the following shutdown() errors:
+ *
+ * - EBADF sockfd is not a valid file descriptor
+ * - EINVAL An invalid value was specified in how
+ * - ENOTCONN The specified socket is not connected
+ * - ENOTSOCK The file descriptor sockfd does not refer to a socket
+ */
+
+#include "tst_test.h"
+
+static int file_desc;
+static int valid_sock;
+static int invalid_sock = -1;
+
+static struct sockaddr_in *server_addr;
+
+static struct tcase {
+	int *socket;
+	int flags;
+	int error;
+} tcases[] = {
+	{&invalid_sock, PF_INET, EBADF},
+	{&valid_sock,   -1,      EINVAL},
+	{&valid_sock,   PF_INET, ENOTCONN},
+	{&file_desc,    PF_INET, ENOTSOCK},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(shutdown(*tc->socket, tc->flags), tc->error);
+}
+
+static void setup(void)
+{
+	file_desc = SAFE_OPEN("notasocket", O_CREAT, 0640);
+	valid_sock = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+
+	server_addr->sin_family = AF_INET;
+	server_addr->sin_port = 0;
+	server_addr->sin_addr.s_addr = INADDR_ANY;
+
+	SAFE_BIND(valid_sock,
+		(struct sockaddr *)server_addr,
+		sizeof(struct sockaddr_in));
+}
+
+static void cleanup(void)
+{
+	if (valid_sock > 0)
+		SAFE_CLOSE(valid_sock);
+
+	if (file_desc > 0)
+		SAFE_CLOSE(file_desc);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&server_addr, .size = sizeof(struct sockaddr_in)},
+		{}
+	}
+};

---
base-commit: 998df1a5aa5026c5c9b91b0caa3b1188146aa678
change-id: 20240524-shutdown-c8d7580e916a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
