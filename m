Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAF6C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783660427; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rRYg5tS0sH3bP/Qns0RT6uEFdtzE8/4WwuVN+f5tYyE=;
 b=aTit9MSmPD1gvHbJ3tFdX8WbMt2xBLBSGX+ipkZyk2T/cVKVYcY0YWoFrao01Zx1KeuXu
 P9tk4zw6cSaPqF7OG8lf/eGMNIxIKtC8kRQsuBc//dVkDNV4ZPRz+ioBAbdwDCw8kZzoDGy
 IN/b39myrmXHsiOosIsngvAYEuwkB4o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A557C3E2789
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:13:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13F753E26AE
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:13:28 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B6471000A24
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:13:27 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so3812505e9.2
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783660407; x=1784265207; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyHVbJ5/QwNw5FANRLEgzzyUel0OMTDDyfKyEvV7UjI=;
 b=Q7c2ccxETvmkwW2lYk6nLZmgPoL1VwHPgLu2fAFv43/oLyhTuRPGYLqzJJDoQoCAqH
 mz0rLZXNxXOAOo/H89/4eli0uvv9O5kixNjM6yPxEuJ1DuexJkUHyzG8nZIPncSq4yN4
 4X0EfQp4JeLjsEqTzggzx0VIVOWfTiHiVeYYZ7xwW3OAHkv1ioZFhZgwzF7U6JjB9hx4
 tjuvPkk65lG2jnFr1+2Go1obTKTtB6ActKMxKvSLFstVslgtkfccofR7fs7H9PjpzDVh
 sXsqlqfWkeaFwvJwvi7NvlXH14iDX1cu5vr8ylYdxyDuDGWmy9QMBLc0dx0pDrsoXOFj
 NZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783660407; x=1784265207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZyHVbJ5/QwNw5FANRLEgzzyUel0OMTDDyfKyEvV7UjI=;
 b=pjH00m8nlbpKlLQB29b+pCjKhPVqeZUMJ+NsmhY2YoKhl8n9GSnkhLhXtGLzJuylIw
 vYCNdBB+cAjVlQT/CWdKpOAN5c8O4A2WgBALbd6akAz4P3JgzRqhtcWc+E7AJLlTfGTS
 BB2AzCajztZ5AG4+9UzCTFnbUeYeJWYMicwF3GI8b6UpT7F0p/sidHUKZDb17hKBD1ch
 eaDaQPJkDbIDQKWoYiROY9xTjjABF9syWnwpnTQ0x3MuprJyH1ZUx6OxZwzv5fuTGRam
 XLWZ1u5kh+JdY7oMxbjE6nAzJfl82JVG+MU8RFD2q2a0m9xBkPLVdz5KY7kpvfU7U53Z
 m9cg==
X-Gm-Message-State: AOJu0YzECtyKzFBgMoFZArkCLfs/A6xpCRE5m8EktRVLxNooCPOFWBPG
 tEVHWdfy8HTY/E4DU/vxJy2sNyx6sS+5NwRfSWaXHtpQ6UF9OLwOmXeJpNsKkb0HH0koFtqp4ef
 aTXU=
X-Gm-Gg: AfdE7cmNQ6jHCpG8+qZiU58ZZnDUMHewarP9q3F3Qga4V7uvQ/A566A15l9mQbv6Cbl
 fChFISpic5ax3LNj/1HPmbMkJ+OsoFRG4dKQ9cvXCUg0nJgvILt2cSjnkiIdkW4MSFjwj9I0NP0
 HEEr9OxAlhAei9N1Ud700XCyTWBR3+2ay5ch82xHQ1mDcYi9upzeqUmU2W5ceAXLbg03LLNMnUA
 KuOPJRZ6zOv+qSkVp1EZAVXBtcvs5ga3GihVPtdHH3Ybpn1FfgjyO3YMpmjt7X7XEgbWxAdNOvh
 K7/mnOllxP1YnjzkeCG5e2mzVV+WVNbRFnwCjB0padBuDTJV0aBOzJQ0ErWv5liWSsPEj47NYvT
 D0t9mNEC/L8cgwVj3XlTv5r0egr6j1wKhLltuPuNTvEcaWqQch+lKbcvoYAy4HTbR/Zr7KFSaJv
 QO
X-Received: by 2002:a05:600c:4453:b0:492:3da4:81ef with SMTP id
 5b1f17b1804b1-493e685ff4cmr94423895e9.18.1783660406693; 
 Thu, 09 Jul 2026 22:13:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493eb6f373csm184585215e9.14.2026.07.09.22.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:13:26 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 05:13:11 +0000
Message-ID: <20260710051323.26430-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706234000.23719-1-wegao@suse.com>
References: <20260706234000.23719-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10] connect03: New test case for EPROTOTYPE and
 EACCES errors
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
- EACCES is verified by setting socket file permissions to 0500 and
  attempting to connect. If run as root, effective privileges are
  dynamically dropped to 'nobody' in setup() to ensure standard DAC
  checks apply and prevent CAP_DAC_OVERRIDE from bypassing permissions.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/connect/.gitignore  |  1 +
 testcases/kernel/syscalls/connect/connect03.c | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+)
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
index 000000000..47f0347d3
--- /dev/null
+++ b/testcases/kernel/syscalls/connect/connect03.c
@@ -0,0 +1,99 @@
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
+
+#define SOCK_FILE "sock_file"
+
+static int fd_unix_server = -1;
+static int fd_unix_dgram = -1;
+static int fd_unix_stream = -1;
+
+static struct sockaddr_un sock_un;
+
+static struct test_case_t {
+	int *fd;
+	int exp_errno;
+	mode_t mode;
+	const char *desc;
+} tcases[] = {
+	{
+		.fd = &fd_unix_dgram,
+		.exp_errno = EPROTOTYPE,
+		.mode = 0700,
+		.desc = "socket type does not support the protocol"
+	},
+	{
+		.fd = &fd_unix_stream,
+		.exp_errno = EACCES,
+		.mode = 0500,
+		.desc = "write permission is denied on the socket file"
+	},
+};
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	/* Drop privileges to 'nobody' if we are running as root */
+	if (geteuid() == 0) {
+		pw = SAFE_GETPWNAM("nobody");
+		SAFE_SETEUID(pw->pw_uid);
+	}
+
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
+	SAFE_CHMOD(SOCK_FILE, tc->mode);
+
+	TST_EXP_FAIL(connect(*tc->fd, (const struct sockaddr *)&sock_un, sizeof(sock_un)),
+		     tc->exp_errno, "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_connect,
+	.needs_tmpdir = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
