Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C4ACD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779822347; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XflXB+fWIjrMbkb+IzBJppJXLHhU/43e4ngYsrHcsXI=;
 b=X8p10q0ff3pq8D9Pkgoaf+JUBHZ56ZoagClpHXfk6/U7Ce73FnLLuZY9fBY6xgeZwP9nj
 muNGTpurcWwRGiXwNAuGVAfTO2KilTqO+R/D6I8OypX5WJlCNb7Nc0cp4EyrMgiNUfalEF0
 w+uSvu+AsY1ey++d02juAbGL1C8u+9I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1F773C7049
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:05:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586D33C70A4
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8844600942
 for <ltp@lists.linux.it>; Tue, 26 May 2026 21:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779822280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2D7AZDLLnrIo1exkcOaY8/f5+BA6GsjVRXikOqkKE0=;
 b=K64tldhpJDKbughJCha1zwn+e0GheDhGvuOSyK4Pfugn6nLluBKsvQfPQwy3UUNmSDd3Jt
 gWMRvpcl3A9CGTNPLedR9HweiWZEA3EBQ1Q9+Dcws1Te4PsqYaJq1ramRiGMHodTXhJBYA
 hyjAaFpk+iXFR1bFNhL2gZxRufoERyo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-eX6TqjQFMKu26gcIRzZdwg-1; Tue, 26 May 2026 15:04:39 -0400
X-MC-Unique: eX6TqjQFMKu26gcIRzZdwg-1
X-Mimecast-MFC-AGG-ID: eX6TqjQFMKu26gcIRzZdwg_1779822278
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43ff19e54beso7047990f8f.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 12:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779822278; x=1780427078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2D7AZDLLnrIo1exkcOaY8/f5+BA6GsjVRXikOqkKE0=;
 b=VvA23yPU2YrGmYZpGrB+Vnj/Miiu5IkKAQIDrG5qlMQYGLPYHQPec+55fy0EKygWwg
 hDKHmlXk55JBEdqo7rfDkHAJzCZf8A8s6pvZUyMzBW9yyCSziG7MkuyC1cRW+xnoWoA6
 CCcHkIj3SM/fdmtjK+uulRCiO/yZfMj7MoJMho3dT2Nxpyzp2xN4XKvtE+kwSlx4dfdI
 91NDRNNjdOWYDu3FJGsf0gVHTwQ4ZwlvCoZUKhDQczdB71KDJLhIeQXHv7wG3886FmYq
 NGtye3FqNrQbOfdi/wyv5g7Z2fqwgSTBgh2LZzJcSeXNr+uo7dpVOQvbPNKtGe0X7If7
 JV9A==
X-Gm-Message-State: AOJu0YyuNWZWNjR9g7q6T8dISCwlxVTgbFhrNUulVzXJs2Xbq5Mg9IO5
 9+F2COhUSs0tRMx+szHqeypqIvU5Dx82aksT4WI8yAm95+NLOt2XX/INctIHKU4aH+4uTwi9P0V
 49InX7+GESOSmHzKo9mo87M8QY6Q4IJ3YKZiigihwHqFJglXKeHlvGB+N1KEzz0+jY9mB1NBFKd
 LBZd54ZerGbU7fhGICHwVhxR1EbS8+Oo0HBGVo
X-Gm-Gg: Acq92OGDPHjDxnvRwvMG5DumePx/8Ohdvppjq6C7xrzf8zMOPqcINgAW5hNnC9KGdRz
 XYp+JSQ1Ki5G2/VPc9r0Tc3+LwvXHUf0Ama8F7i1WLMjGvbmhlRFtrPX29RrfM8TcGo9gi1QPFS
 uyuY5PYHE+jX0MLaeo2kllOtC/2JnUti8EXEARCDXB90mJF7SY6VZY6/HoTJ9YPLtnvq/qWiEPT
 /qLVmg0ImlNZ6DIS+TQ6ZhbMdUZuo/IKZvJOu2Ma4XXegSd6yUSvNa60rU7qv9mggCetguIWgot
 SBAOBqri0JkPkA9Bond2nUvvvc2IB0YrNJpCg2AkqA6wCDDEOvMyh6AdubXMjzzgSzTpMvI6tbl
 NfqgDGqJf5Ddd8kQZPjbcIBdwg4utbklSDLtT85XzXyz2omLFHra8uSJ0Kgpwyg==
X-Received: by 2002:a5d:6f10:0:b0:45e:a19f:22c1 with SMTP id
 ffacd0b85a97d-45eb38a28a8mr33328200f8f.15.1779822277993; 
 Tue, 26 May 2026 12:04:37 -0700 (PDT)
X-Received: by 2002:a5d:6f10:0:b0:45e:a19f:22c1 with SMTP id
 ffacd0b85a97d-45eb38a28a8mr33327880f8f.15.1779822274961; 
 Tue, 26 May 2026 12:04:34 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm204398f8f.26.2026.05.26.12.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:04:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 22:04:28 +0300
Message-ID: <20260526190430.129798-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190430.129798-1-mmenashe@redhat.com>
References: <20260526190430.129798-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CK4o2rlLJzDSEZZDphwUXyIf2xi51-n_mG4jphowbNg_1779822278
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 2/4] futex_wait07: Add EINTR error coverage test
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

futex(FUTEX_WAIT) has no existing test for EINTR. Add coverage for
the case where the wait is interrupted by a signal before the futex
word changes.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait07.c      | 89 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c

diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 56596dcb4..74ac9a926 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -14,3 +14,4 @@
 /futex_waitv02
 /futex_waitv03
 /futex_wait06
+/futex_wait07
diff --git a/testcases/kernel/syscalls/futex/futex_wait07.c b/testcases/kernel/syscalls/futex/futex_wait07.c
new file mode 100644
index 000000000..5a8a3c49f
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAIT) returns EINTR when interrupted by a signal.
+ * A child process blocks on futex_wait() with a long timeout. The parent
+ * waits for the child to enter sleep state, then sends SIGUSR1 to it.
+ * The child verifies it received EINTR and exits accordingly.
+ */
+
+#include <errno.h>
+#include <signal.h>
+
+#include "futextest.h"
+
+static futex_t *futex;
+
+static struct futex_test_variants variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+/* Empty handler: receiving the signal is sufficient to interrupt futex_wait(). */
+static void sigusr1_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
+
+static void do_child(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct sigaction sa;
+	struct tst_ts timeout;
+
+	sa.sa_handler = sigusr1_handler;
+	sa.sa_flags = 0;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	timeout = tst_ts_from_ms(tv->tstype, 5000);
+	TST_EXP_FAIL(futex_wait(tv->fntype, futex, *futex, &timeout, 0), EINTR);
+	exit(0);
+}
+
+static void run(void)
+{
+	pid_t child;
+
+	child = SAFE_FORK();
+
+	if (child == 0)
+		do_child();
+
+	TST_PROCESS_STATE_WAIT(child, 'S', 0);
+	SAFE_KILL(child, SIGUSR1);
+	SAFE_WAITPID(child, NULL, 0);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	*futex = FUTEX_INITIALIZER;
+}
+
+static void cleanup(void)
+{
+	if (futex)
+		SAFE_MUNMAP((void *)futex, sizeof(*futex));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
