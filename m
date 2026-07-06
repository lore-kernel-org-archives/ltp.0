Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6617AC43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 06:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783317793; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DnA+c8fcEzZ1NxMYm5Cxvzjjm9qunxx1/Q0nhMdxFE8=;
 b=RQekDLNbb6d0nS4ehyP1tWbqhmULn5bLpVj9oHQHW5biQKyIoW+DKQqGzRGKM2Mu7d7Im
 g14/gHUZBKJrPVz+FA66fmfDFIa739Rxl8AAWPTv0ZjQaoniat1NuZobL9WIclh35VfgWqP
 YAEM3n1Lz6IGyCIRLC1DGg3HDUhahZ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B150D3C1ADA
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 08:03:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8F413C0EDD
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 08:02:47 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5534560014D
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 08:02:47 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso16113295e9.2
 for <ltp@lists.linux.it>; Sun, 05 Jul 2026 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783317767; x=1783922567; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGA4bPqZUMOslwJNVpvhVwiQQ2nAHMWhlKFKFoRpXS8=;
 b=ZCLWdM32acW+5YCTUsufyVOgzsMqV/Im8F7A3krYCZrFRk4B8OXBYtvge2JMt3s9ZD
 03kKz+4U6eEOU10/GQTS4FXON2VSQvVG//1H29XjbPt0PV/m6WHg5kjZYrCch2c5xh+A
 QGsk8yqKZOxiljQNQZil8Bl49R2KtCFIzgdj5uRljfa1h5DXrmTtLpSVY0Ac4gWmRLc7
 ccA88bVodjheJM5moNn0S2o2GPwcKUrvUNPjWd3PRbAq9tRBc/R/kWrXLLRSKZJSoILS
 OfZ30yaGwzdQyYcwoFIU8oLASMhDaOX6uu6hW4DrI53kY1/V7yWnv0ZcRLoZSG4kURAk
 4+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783317767; x=1783922567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGA4bPqZUMOslwJNVpvhVwiQQ2nAHMWhlKFKFoRpXS8=;
 b=fULj5T7B2dii7XeFb4o7Hsdurg5SGLVA8GbygmLOha/W97i5bka7er1BxaQRwkjUmg
 Lp0qOdyKmzw1KQnF+CY5vIBJz7DJYyQblOiPH+V1Po466fIk1++7BGaqIvMG93H9Ihrw
 vFd1qil1UJRkgz+kMggqkGapen8lIzfdqGqEfLFN4+aua/ceu49u7w+yNMKQt1MQ+EfL
 2kxnuqXFaDbX1GDohvBCSEynMBmAuyioe5gkEfKhjOwhbIrDkN5/rN+xiCXLA8GiFixX
 LFTKYe6tl2t2JZkezZ8qPiZPsUFjEjH5POnhCGKdWgnNM0Eb9hVUPCHuhC0fLNYmZaN0
 NcYQ==
X-Gm-Message-State: AOJu0YxsyODotA974uG3M4D+Z9IL1kCfmH68ijciCiP6fdUDm/UPt5mc
 +R8aL6LVrzMtUf1MEG0fc0u6TKcEJlWPdnXLrktY2B9rFL8JoCbdT66DNlGMGoY+Whw3chmtXXd
 BJ/g=
X-Gm-Gg: AfdE7ckdrsz96ZTUxh+hiiiObOJK99JheE2YTzkeJZGUAAFIRhIRRkh9ywE1SdjI5E0
 Wpt146h6QATMzecmJhq/C4MC/5gqNEINt7wfYNMN9cfMGvf4gUg3jACb0+lf7R9PovKzkfa+x89
 +MQebd9C7G12W1jjkl/zxHGLyXu66nl05Qtjyk+qSZjlpAa+GVtXEiRQ8BwDPLBmXD8+godwGRw
 Hzleb4QtzE8aXi57XecjAFG0mc+QmAv/MKRY7/EM84NzoVOeoaq7Yeut7iWJIFW9a4cxkO5U4vz
 r8Qgw/VOlu+c/Hnfr41/NoMR28QZRzoSKdlsmgtyLe0eMaQ3Dvk7wuf0GUcK7Qalcxj3711A2Os
 tL9lOnGTjwKX+kqJ/lZ0qww0qV37eompLc03UynjghTdfQklaJKPWBQdWM6uJQDg+noGf0byMUk
 M3M1moj9ESxsI=
X-Received: by 2002:a05:600c:1988:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-493d11f7ea7mr100619035e9.28.1783317766701; 
 Sun, 05 Jul 2026 23:02:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47a9de1e736sm23998145f8f.7.2026.07.05.23.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:02:46 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  6 Jul 2026 06:02:34 +0000
Message-ID: <20260706060244.23332-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093119.8654-3-wegao@suse.com>
References: <20260616093119.8654-3-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] connect03: New test case for EPROTOTYPE and EACCES
 errors
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a new connect03 test case targeting AF_UNIX-specific connect(2)
error paths, specifically EPROTOTYPE and EACCES.

- EPROTOTYPE is verified by attempting to connect a UNIX domain SOCK_DGRAM
  socket to a SOCK_STREAM listening server.
- EACCES is verified by modifying permissions on the socket file to 0700,
  spawning a child process, dropping privileges to the unprivileged "nobody"
  user, and attempting to connect.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/connect/.gitignore  |   1 +
 testcases/kernel/syscalls/connect/connect03.c | 117 ++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 testcases/kernel/syscalls/connect/connect03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a021c79da..0fec2c6b5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -142,6 +142,7 @@ confstr01 confstr01
 
 connect01 connect01
 connect02 connect02
+connect03 connect03
 
 creat01 creat01
 creat03 creat03
diff --git a/testcases/kernel/syscalls/connect/.gitignore b/testcases/kernel/syscalls/connect/.gitignore
index 0a3fc90bf..7ef5fef1a 100644
--- a/testcases/kernel/syscalls/connect/.gitignore
+++ b/testcases/kernel/syscalls/connect/.gitignore
@@ -1,2 +1,3 @@
 /connect01
 /connect02
+/connect03
diff --git a/testcases/kernel/syscalls/connect/connect03.c b/testcases/kernel/syscalls/connect/connect03.c
new file mode 100644
index 000000000..b576a10ce
--- /dev/null
+++ b/testcases/kernel/syscalls/connect/connect03.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Verify that :manpage:`connect(2)` with AF_UNIX fails with -1 and sets proper errno:
+ *
+ * - EPROTOTYPE: The socket type does not support the protocol (e.g.,
+ *   connecting a UNIX domain datagram socket to a stream socket)
+ * - EACCES: Write permission is denied on the socket file
+ *
+ * Requires root to test EACCES by dropping privileges to an
+ * unprivileged user.
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <pwd.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define SOCK_FILE "sock_file"
+
+static int fd_unix_server = -1;
+static int fd_unix_dgram = -1;
+static int fd_unix_stream = -1;
+
+static struct sockaddr_un sock_un;
+static struct passwd *pw;
+
+static struct test_case_t {
+	int *fd;
+	struct sockaddr_un *addr;
+	socklen_t salen;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{
+		.fd = &fd_unix_dgram,
+		.addr = &sock_un,
+		.salen = sizeof(sock_un),
+		.exp_errno = EPROTOTYPE,
+		.desc = "socket type does not support the protocol"
+	},
+	{
+		.fd = &fd_unix_stream,
+		.addr = &sock_un,
+		.salen = sizeof(sock_un),
+		.exp_errno = EACCES,
+		.desc = "write permission is denied on the socket file"
+	},
+};
+
+static int sys_connect(int sockfd, const struct sockaddr *addr,
+		       socklen_t addrlen)
+{
+	return tst_syscall(__NR_connect, sockfd, addr, addrlen);
+}
+
+static void setup(void)
+{
+	sock_un.sun_family = AF_UNIX;
+	strncpy(sock_un.sun_path, SOCK_FILE, sizeof(sock_un.sun_path));
+
+	fd_unix_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+	SAFE_BIND(fd_unix_server, (struct sockaddr *)&sock_un, sizeof(sock_un));
+	SAFE_CHMOD(SOCK_FILE, 0700);
+	SAFE_LISTEN(fd_unix_server, 5);
+
+	fd_unix_dgram = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
+	fd_unix_stream = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+
+	pw = SAFE_GETPWNAM("nobody");
+}
+
+static void cleanup(void)
+{
+	if (fd_unix_dgram != -1)
+		SAFE_CLOSE(fd_unix_dgram);
+	if (fd_unix_stream != -1)
+		SAFE_CLOSE(fd_unix_stream);
+	if (fd_unix_server != -1)
+		SAFE_CLOSE(fd_unix_server);
+}
+
+static void verify_connect(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	if (tc->exp_errno == EACCES) {
+		if (!SAFE_FORK()) {
+			SAFE_SETUID(pw->pw_uid);
+			TST_EXP_FAIL(sys_connect(*tc->fd, (const struct sockaddr *)tc->addr, tc->salen),
+				     tc->exp_errno, "%s", tc->desc);
+			exit(0);
+		}
+		tst_reap_children();
+	} else {
+		TST_EXP_FAIL(sys_connect(*tc->fd, (const struct sockaddr *)tc->addr, tc->salen),
+			     tc->exp_errno, "%s", tc->desc);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_connect,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
