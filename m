Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD70CD4F54
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779263179; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rtVqWv+iBak5ZdFqSCZltj9cZKFwAb4NtjLENVXqhtg=;
 b=pd2GsHXKt2d9kUKfCfV1adKYWsoGNFJWKioUYyHvXpteV8mBbo0/hzI37B/01BJ3FrI3k
 V2fxGemldnwtdLzvlC/rAB4YxQXTfk6gb+gijTmMiD6LDdqaGzLug8ttvsmmGcP5qYrDCv2
 0DSq3jNTYRwXYt/259ftAulYb3J2wFc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A75A3C72D7
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:46:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84D073C72DC
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C765E140009C
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779263079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8pvQ4IYdFU97tDhuzBbE/O/yvZOFFVCQuY866yDi8Y=;
 b=JgVLA92+vwbxgBjxXZOZgVvp25gsNhiCeIcv/m8YQxq2daOZ+jlVZfa41w6NsG6O+r4yQC
 o4lkjava3CBeeTN1yqjECKvs/40cSZ1fVc6EH2l7IwIjd2SmtjwmLM6MV6b4O4IQ95PS0w
 Kbk6AhyinAJePUs2tGGDw+emLoKU2hc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-xDkwMuyIMiWvmQsNmi1AGQ-1; Wed, 20 May 2026 03:44:38 -0400
X-MC-Unique: xDkwMuyIMiWvmQsNmi1AGQ-1
X-Mimecast-MFC-AGG-ID: xDkwMuyIMiWvmQsNmi1AGQ_1779263076
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4518f777225so3592629f8f.1
 for <ltp@lists.linux.it>; Wed, 20 May 2026 00:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263076; x=1779867876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k8pvQ4IYdFU97tDhuzBbE/O/yvZOFFVCQuY866yDi8Y=;
 b=pu6G56F80y6qsdULCwBw68MgML4vqE1dNPZtfJuManal6xO1npYkA8QHEQ68mMbtNi
 uKrxuPJMYZatMzZJ3gE4GBJcbKh+aKjFomvdiff+zRlghrTe/NIRfjlKajRoQDBLIxzS
 hz9Faz4Ls4yhg29AjdKdQsvYuOySjdl8jxYA+1iQrQbd1ZYMbxFNht6g7Oy8aIwABIaA
 nB63jezqTff7y2sRd07NhkA4VVdZq52P/o0CB4+suAWMIokxhty63NKudtUEIApK14ir
 I8EJlmVgtqn7kNmWau5baiNv+AH+xxLfHoo9ZezYiwXNS7EJrcIO7uMS7662++X53ZLR
 P4ew==
X-Gm-Message-State: AOJu0YxWz92YdNiAUsgXCznOiRzu6k+/XTrurzI412rPw95giCleC8jG
 YUmA1inI0D3OUy+EU/3mGg8J8LVKIjdsdR3zbm1Q0oVUF6ix3Gn+YRNoPTomDLm4yInK+FMzPex
 hTGcItKLOdmghWkErVFayMqqTFj2NiiROwvpCWK2d30iLWWx7yWtupzHA6sgQniX7q+jbr03oLb
 J91aUkpX6vxJgRzxTAK+5FJE0Z6urrLtfxhy7l
X-Gm-Gg: Acq92OHBMygx7luSQtCrJhZHbynHrTyePafAOcZYXNoew4K59wnKfV6FXdptegZ+ejA
 HzcjANOvGGX0exfOkHZQA2sR8KmMhUFV5IMeaMHrMIR7cU01Wmyfr8waWXIQMlBKS2WlUQB1PQN
 yEZ1qRjdF2u21HF9uRKOZEPHXKDUPkWsAuSuN2nIwwcX4ytcmbUhUzewh5Tr3sDD7pyLmdjkUiS
 STxkAv27zYJHSC5Pqhs0rkU55YcjNDTTAeBEqXeyFjXymVIizzOojQaHCLvWL/UsTqUXEhMbrFI
 Q/dWqZZ91RNgqGCjTClOgfCdDq/FxVPAfHUWu/hn5Pv6g2L9W6KzDsMSC6igCcK9zXYmRlmBoCY
 5TcYUKyQKTIvot93A2iIbyH6T3AmZOfM=
X-Received: by 2002:a05:600c:1389:b0:48f:fe2a:107c with SMTP id
 5b1f17b1804b1-49001285b87mr226112255e9.6.1779263075932; 
 Wed, 20 May 2026 00:44:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:48f:fe2a:107c with SMTP id
 5b1f17b1804b1-49001285b87mr226111055e9.6.1779263074505; 
 Wed, 20 May 2026 00:44:34 -0700 (PDT)
Received: from fedora.tlv.redhat.com ([5.28.174.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm127721625e9.1.2026.05.20.00.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:44:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 20 May 2026 10:44:25 +0300
Message-ID: <20260520074427.39155-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074427.39155-1-mmenashe@redhat.com>
References: <20260520074427.39155-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8pjX3FbU20zzvqoaOLD-zVFqhQWkpHGCoRd7KUP9T5A_1779263076
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/4] futex_wait07: Add EINTR error coverage test
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
 .../kernel/syscalls/futex/futex_wait07.c      | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e8ef890f3..e428deda1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1908,3 +1908,4 @@ io_uring03 io_uring03
 # Tests below may cause kernel memory leak
 perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
+futex_wait07 futex_wait07
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
index 000000000..fca7c7059
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
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
