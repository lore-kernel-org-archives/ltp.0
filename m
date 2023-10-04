Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53D3E7B608
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 12:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A8F3CDB66
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:47:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A393CB78E
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 06A221A0042A
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C32D31F855;
 Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696423590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUoVyxQDPI04NNDmHhtQVcaincSOaQHC43/Y+1GZ/uQ=;
 b=q+fA0bpyoiDMgg9i3CJ3rwpMwxClR9dIiTSozDPym2lvQDzfmdZyaAK48DoLihanXG4+1/
 R7OZ6kf68gDVY2FXJrSjZG5UyBZqDCRkZt92g5u7Dp4Pd3hDFUAJp4Uj9s8Q/f/ix1wrSi
 R8Vmds5NYYbLM4SlmzKMSQfhdaY2jy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696423590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUoVyxQDPI04NNDmHhtQVcaincSOaQHC43/Y+1GZ/uQ=;
 b=HO7kkoFSU5Jhhc493Sg2u9zSHCBpRgjdqZ5bfqsGy0n1BEchfSEx1V1LNwL29a7k4Ph7Dq
 MoGpxm9xlfntKyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD23813A2E;
 Wed,  4 Oct 2023 12:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f2zvKKZeHWXfPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Oct 2023 14:47:12 +0200
Message-ID: <20231004124712.3833-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124712.3833-1-chrubis@suse.cz>
References: <20231004124712.3833-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls: accept: Add tst_fd_iterate() test
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/accept/.gitignore |  1 +
 testcases/kernel/syscalls/accept/accept01.c |  8 ----
 testcases/kernel/syscalls/accept/accept03.c | 46 +++++++++++++++++++++
 4 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8652e0bd3..25b53a724 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -3,6 +3,7 @@ abort01 abort01
 
 accept01 accept01
 accept02 accept02
+accept03 accept03
 
 accept4_01 accept4_01
 
diff --git a/testcases/kernel/syscalls/accept/.gitignore b/testcases/kernel/syscalls/accept/.gitignore
index 5b1462699..f81d4bec9 100644
--- a/testcases/kernel/syscalls/accept/.gitignore
+++ b/testcases/kernel/syscalls/accept/.gitignore
@@ -1,2 +1,3 @@
 /accept01
 /accept02
+/accept03
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 85af0f8af..e5db1dfec 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -26,7 +26,6 @@
 struct sockaddr_in sin0, sin1, fsin1;
 
 int invalid_socketfd = 400; /* anything that is not an open file */
-int devnull_fd;
 int socket_fd;
 int udp_fd;
 
@@ -45,10 +44,6 @@ static struct test_case {
 		(struct sockaddr *)&fsin1, sizeof(fsin1), EBADF,
 		"bad file descriptor"
 	},
-	{
-		PF_INET, SOCK_STREAM, 0, &devnull_fd, (struct sockaddr *)&fsin1,
-		sizeof(fsin1), ENOTSOCK, "fd is not socket"
-	},
 	{
 		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)3,
 		sizeof(fsin1), EINVAL, "invalid socket buffer"
@@ -73,8 +68,6 @@ static void test_setup(void)
 	sin0.sin_port = 0;
 	sin0.sin_addr.s_addr = INADDR_ANY;
 
-	devnull_fd = SAFE_OPEN("/dev/null", O_WRONLY);
-
 	socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	SAFE_BIND(socket_fd, (struct sockaddr *)&sin0, sizeof(sin0));
 
@@ -88,7 +81,6 @@ static void test_setup(void)
 
 static void test_cleanup(void)
 {
-	SAFE_CLOSE(devnull_fd);
 	SAFE_CLOSE(socket_fd);
 	SAFE_CLOSE(udp_fd);
 }
diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
new file mode 100644
index 000000000..6bced33b6
--- /dev/null
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that accept() returns ENOTSOCK for non-socket file descriptors.
+ */
+
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "tst_test.h"
+
+void check_accept(struct tst_fd *fd)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = 0,
+		.sin_addr = {.s_addr = INADDR_ANY},
+	};
+	socklen_t size = sizeof(addr);
+
+	switch (fd->type) {
+	case TST_FD_UNIX_SOCK:
+	case TST_FD_INET_SOCK:
+		return;
+	default:
+		break;
+	}
+
+	TST_EXP_FAIL2(accept(fd->fd, (void*)&addr, &size),
+		ENOTSOCK, "accept() on %s", tst_fd_desc(fd));
+}
+
+static void verify_accept(void)
+{
+	tst_fd_iterate(check_accept);
+}
+
+static struct tst_test test = {
+	.test_all = verify_accept,
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
