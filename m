Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8860AC43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783381223; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=sRcjjqRv8LXT1eFYaWXDog+mG4IYVbkurxw+dOIlo4Y=;
 b=cSC0mieylQeWcsnrshwOM330SJMWSLCko2pDWp+1HszaBHMR8vJlN007JK0rIJhsPjwmh
 43TLLRIPiWJY7E1ed2HeeFRlG4pngvKeIR3mJN58eFiSNI33Ca2l/Jaajdx+hoYOQMC8411
 rpbTN6z7L0eC+OcFEYhXDgYxM7yCLJk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 826143E5F3D
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 01:40:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 321D83C3167
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 01:40:03 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5A03B6000FD
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 01:40:03 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so21499585e9.1
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 16:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783381203; x=1783986003; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idfu1pF4gCUTuicyWmQvJnBANst0kso0wW6cclCvp30=;
 b=Rdh5JjcXbA+DV/io4woiEu0FjQKiClkBiV8jBr1WH1t/P+ixy7TPueCxX3r3ME1UdX
 xDBQkcCKd96hUxy640OwqEJh2+tcgTZSynmvah0m2St9TnvpFluSnCJ4xwy4E75x7HwH
 bU01WbfQbSgBEgG6do9/0xeAdfD9JqHABHej7DOdV/925oPIltwQzPczgRf3Pu7Yl0hV
 r741dJ92ueIqrU6wVKcF/Dqrq4jT8at9vLmwwGNTldB7zCA0hmYUI2F5aKz7mA1vOSgP
 EbMpzawV5B1N6UCml5DdbRwiwoDa+CDH5Hmi14Y4xLU7QBk5qTNU2/EtJP7M5XwJ//cz
 F9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783381203; x=1783986003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=idfu1pF4gCUTuicyWmQvJnBANst0kso0wW6cclCvp30=;
 b=Khqiank1pYWQG49VvIYkAU7GU0vl0SV8+wtB2C13xZCVrwXnAZFVwxtcyHUV2oYbrJ
 CCklP9FMEzv8gbAeG0bhylr5SCzte0TcJMFj0AlqH74m7mr0fJXOcLqArM7bqs+9WeBl
 d7yIHeN/yyZCTdYsEW/pVlxqArfVJx7g5fhYi1Mmnv2n31JNyxcLa2I8DVrsrLi/Li7m
 KOM8rS6FlD+qBG7MtwtUPg/4Ov77Y9EfOUHlJ+tbBXdLzrwrmKWi2Q+BQK7Kh+3QCTwa
 pWyD2K61YZN/5hi5oTdVrgh1MyKkKZev1iOzmK4FmeWux/Ce1ihVVk77BFKjq4GyXPuT
 3z1A==
X-Gm-Message-State: AOJu0YwB0tucdcLezjAJJFAeJtHwQorFexAmGF5KYNSuo4nGukumCKlF
 roPZz38Af6qrvSHdmDgG78aWX1fxwefN/hPTgqqQ8v9psY2Sa4PEltkUBu+IcNJUa4YETeWAWfp
 YAJo=
X-Gm-Gg: AfdE7clkSmmpIpBg2z1uDLWn+GeAn8bX/pF5qyOxuxyexWKu/SNxAlts79F1UViCSvj
 Pwbog/BV83q3Gbcjpj4B9qeJcJX4RzIeljIUmeMtmV2HQbyfdUFKcq5RY6Ef8vov7lKwqRI5bsB
 bBT/lt6mYrpBA7/qS2OmXlBjXkpMo1qnJ1dEVZyHYNf2h+qfAasTBTcpbmUcWj5O514fOwpfpbI
 ply+/3ywEIoW82ErCrxnHH83NLExn1e3nN7M3BUnXFtEa3UY0EruGomwNGlzT4u5Bqd41kD2zAG
 NY3zJFMPYFcVhOj7U4Ex2Jvflnhjc7sGm56RXuxsA8KeKiR/7oqoSUMEkwLiK89Y+Rt7svOZg33
 hQVyyX9ZuBIJowRi9PxMiT2GoPt2Z/ipQcPyfwd1wyg+DLk26mawvV6dySWcdlrmaWv4IHTo8yQ
 EU
X-Received: by 2002:a05:600c:8b17:b0:492:43d2:9e6e with SMTP id
 5b1f17b1804b1-493df04a73bmr29684765e9.9.1783381202689; 
 Mon, 06 Jul 2026 16:40:02 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493e0f3676dsm9364365e9.5.2026.07.06.16.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 16:40:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  6 Jul 2026 23:39:49 +0000
Message-ID: <20260706234000.23719-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706060244.23332-1-wegao@suse.com>
References: <20260706060244.23332-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] connect03: New test case for EPROTOTYPE and EACCES
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

connect01/02 only cover generic socket error paths and do not test
AF_UNIX-specific errors.

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
