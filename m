Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245E1CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779832251; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XY9pS8BwFaBAQxtSwqivwNApw4GcLd6IoNSyNx1WNf4=;
 b=YuAnMU3IA5wC9h0uZ8Fx8iGYqqvFA0Iid+PBGpeENi6beP0bWG2NoAmifNluVJnl5DU7i
 J0eV3tHAmt8yjP4Osm0mmWnAkAmur/dV1liU/vU3/+7nLDX+zbMzDneu32CyExUKFFwGs56
 GU+Z1SMlYR7/XyZQXXPXoBFxvrNjtKE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB9333C5E50
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 23:50:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63AF93C6FF3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 256E8140033A
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779832175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZ/4Y9eOIyJGRzYJlFpzLDL0FgTKa9zlQiQYuBOJGUM=;
 b=DpU0lOcYdZB7A6i9ZqVMdjWZLBJrwhPKG0jZvMeplaJJSyHav1jYmvV1oKJVfTUevFoh/T
 VMDG1a8qeHn2Ez+3aYluf7PdZT6RYW5s6tNU8u44KmS+BZwDmcsbhh9ILtm6pVSTAr8L/3
 GTsh+1NOXXfNJF2/FWmTvVknDvtmnY4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-ORNEAPVOPGmbAnjgz0eK6g-1; Tue, 26 May 2026 17:49:34 -0400
X-MC-Unique: ORNEAPVOPGmbAnjgz0eK6g-1
X-Mimecast-MFC-AGG-ID: ORNEAPVOPGmbAnjgz0eK6g_1779832173
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44696b11265so13554121f8f.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 14:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779832173; x=1780436973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wZ/4Y9eOIyJGRzYJlFpzLDL0FgTKa9zlQiQYuBOJGUM=;
 b=fvPwet5kFMvGy7+flaewt1tHUaswG2M507Vp+H5e2izEF6PiPib+ffl/St9rLiUZAF
 4270lRRrLY+1gO7dTamvUO5QG2au5JrplBndA1scixqVwmysutdCjkFlU42rj8torfKu
 qfKpGWXjCM8cWKCoi2f38PuYcTnz7kmRjC0K35/ED+l6zVxULD5XCBaCUjvduh1mPKQc
 /nQXiArsCAho2Hj8ZZcxy0orpyXJaIQ+LIw7ddvUlt4majTrxI7P/JhfBolEFg7cQME+
 fXy5HcbaIlzFPQ6mtUs5bZfHCHQYqP9c0UzYtppdR+6fDHaNyz7J3cXJTur7RX+VxFdl
 PX1g==
X-Gm-Message-State: AOJu0YzRWdHFdPEGXjO+h1rnv3nHDQSqETv2nMUnwOkFk2fcVlPCSPGg
 hI2hEKQw9t3x6NAx47vF+3YcBx3i+S8y85p3byvDKflBJS4KBNrpucQ68R3Xht7/medwv2JGaq1
 Sny4HqKY3OWoxVtaF5p06iBFLmEko6WRF+1qlb5s03x1cpwhtlkLOSMU7WFpBnOz3pFRaZLnwC3
 Hl9k5H4gMUBQyjXV4zRGhrePied86FEA4uT+WP
X-Gm-Gg: Acq92OG6XWsbpJFzH0KSf/BW3lqOf/HpWOLilNwYQsH/+W1xXd4K1Ca8rLRB71MwMRX
 uvfmHsFX8pJosg9Gk96UiJ/yFAL1E/CsGEsS/4duhz+WnHpQJE+W/GsoTZ4oQGSRsaLXiLElZr+
 QYw0d/VHszvWlNB8HzsXfG2IJHgBRDJRNpf6l32+gTbUH7YbsB4RdLErE+akeiTPBIXKODF8yca
 qWhvJ5bda+Wz0tTRXnS3rs8lYCHSsJYQ9ZPnlkvK+s4nJ7XezT8oU5fdLYtABNthH/ywsJzdFep
 93WUSFEgDauPaaruXgu57WwkTP7GgcCMmef0aqs6QjCRlF+KY1LvIxAZR53hMvnU0j9zKckU98G
 h7g4yQbbUai0Dj6RXCG9AbngifmNf69HEOq1ZNtWeb/J+Nxyy8+Pj/+STvGm0Gg==
X-Received: by 2002:a05:6000:2888:b0:44f:da26:cbb4 with SMTP id
 ffacd0b85a97d-45eb38bae90mr35888243f8f.21.1779832173293; 
 Tue, 26 May 2026 14:49:33 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:44f:da26:cbb4 with SMTP id
 ffacd0b85a97d-45eb38bae90mr35888218f8f.21.1779832172907; 
 Tue, 26 May 2026 14:49:32 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a6cdsm1211123f8f.2.2026.05.26.14.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:49:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 00:49:25 +0300
Message-ID: <20260526214927.150812-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526214927.150812-1-mmenashe@redhat.com>
References: <20260526214927.150812-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5FJ5wh05DGLZGafR4GwpRz0zVdVIqpSXfAexBEzBy3Q_1779832173
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 2/4] futex_wait07: Add EINTR error coverage test
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
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wait07.c      | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7d5ea849e..e6c5d5112 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1869,6 +1869,7 @@ futex_wait03 futex_wait03
 futex_wait04 futex_wait04
 futex_wait05 futex_wait05
 futex_wait06 futex_wait06
+futex_wait07 futex_wait07
 futex_waitv01 futex_waitv01
 futex_waitv02 futex_waitv02
 futex_waitv03 futex_waitv03
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
