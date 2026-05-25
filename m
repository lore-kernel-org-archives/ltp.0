Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3EBCD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779735884; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XQbiz0yKnGSXa5+mKrKOMjXeIM3Ow5xiHrfMeNkA1ko=;
 b=o750PJxmE+yGFD90+kUItwAveZj0Hc58IdwsEmMM4MTVTcwX+Jzk6YTIk+ST4BeoYh5mT
 K3+9uHdNTcZ4YytjbttsnUjD45FhcPsAx4G/8gcOeHc/SpW6trHh6gkfiA5hAKDYJEL9eVc
 smDPY/3Q8V9RJE5SgKzrKwhSVXY1Wsc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C19843E1EA9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:04:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 636C33E63B6
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2097020074D
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779735831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRpO9K6WNb0mffd2tAddehUOuR73R7AjjcqdztcmJ1c=;
 b=RIWlr1ieuoDAFyvWYIZ14aSn6yk2TXKISiiUO35pGby11XQmVzi90Zg5g/sBLgHHAB4XMH
 sq65SVZ+hIXxOE01wGkZ+a4KOBmAVQafDQXyXTlJ05AiOBy04XsuN2Q5MAQ4MWb6gPhErP
 l/RVM5rtd4dWEimEIZU7ifCDPvG2gCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-mml6HBO_NjyfoePfhLtkBw-1; Mon, 25 May 2026 15:03:50 -0400
X-MC-Unique: mml6HBO_NjyfoePfhLtkBw-1
X-Mimecast-MFC-AGG-ID: mml6HBO_NjyfoePfhLtkBw_1779735829
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49048bcbeb8so37725805e9.2
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779735829; x=1780340629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRpO9K6WNb0mffd2tAddehUOuR73R7AjjcqdztcmJ1c=;
 b=X+akCSuKuApHp0bJZCJnpdo5ZaFXCUc22GPAP/CwkW/Ew3mHv0sqSO9nXrvDsPZYIp
 c9Vt5tAe9STKJBcOZKfpt9DeDEVL9d1+gjN+KUzGYRmbV4x+Zr0tKS9X/RXWdDbIYOIK
 e3qtiLR6oUbCUFHcwJs6hvd3iK/ukEPHazlpnfq8RJ63RJ72h9g/pWBvuFaO7bXDOcuW
 4JdiEg5EgFULTHj92N8IuZ4uSzdgBQQ01KquI67/Hb6LZGz4agiSaN+v54Fm5PX/Uuvm
 03PDh/3T9wnAEG64dvW2iOU1Yo4C141XKDXUPF+pGBl/5p0jQspb8yZJPr5bBTA24gz/
 2I9Q==
X-Gm-Message-State: AOJu0YxOZ1iKT7QxZ2IuFoUuSg3/J1HhL0xe9h6AQz0ud1Jc5yBKYIm2
 dWaAk3gzv8/l7ZIuTpjSy3knYhHB9QNeHK9ZP6Q/0d0Qy8SXg0714CoZhZOL7q35Y6SYiMdEIBn
 S7TOB7BeQGeSMBXbGEVBVLwkBCNYLB6/G3jbEauY6v2YYxDRcJmKw2b05HnAm5Ymb8F7KhaPUMG
 RsvH9mOcyLm3oFaUn2fhkiA4EkvbzmrChy4Sjf
X-Gm-Gg: Acq92OE6vjyytFAD10h7t9wbJC8AwIFHrdUl8NAlzPBU/SVqlDVOIoERCkSw6r3FiKm
 Q0hkDO5TLhLddf1pqw9pBZBPjnMrhTiHCrm+MHLP4bV7P+QFdXW4U6g6NEf+BqQbakSxqY0TNhH
 af6oiYAK5j6NA0ksN7hMqp5cwgHbtvsIIdyx8CSdmpSUKBav3rNN0ynMhGL0xv5srHVxa7g6s2e
 nKWt03ty3gX+t+DXVNkkDuMg4ggx4t/JsA0ubGiB+7KPjNoIaWtaTSjVHCI0RwObSeDZHC2T4iJ
 8CVC903aHjxXCAtIZgppNTx376W2CQLVzKhX2W2n3kBdWUk3Ksnt12AHCnzEHZnQP7Jnc4dhsH4
 N/bdMUKotxqd2mzLKfth3CFH3r7lf+X9lFSpAhC/KjyVFPjQufqGRuTMk+Z6UZTWdQnn8n0Lt
X-Received: by 2002:a05:600c:35c9:b0:490:45bb:8dd8 with SMTP id
 5b1f17b1804b1-49045bb8e65mr253939365e9.25.1779735829149; 
 Mon, 25 May 2026 12:03:49 -0700 (PDT)
X-Received: by 2002:a05:600c:35c9:b0:490:45bb:8dd8 with SMTP id
 5b1f17b1804b1-49045bb8e65mr253938725e9.25.1779735828608; 
 Mon, 25 May 2026 12:03:48 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm397695995e9.7.2026.05.25.12.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:03:47 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 22:03:42 +0300
Message-ID: <20260525190344.60330-3-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190344.60330-1-mmenashe@redhat.com>
References: <20260525190344.60330-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oejCa-Zi1hk4CqFEfYXTBIn_-I_FFCzrLgl1vtNShAg_1779735829
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/4] futex_wait07: Add EINTR error coverage test
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
index 8d93c0e40..c5f96adb4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1877,6 +1877,7 @@ futex_wake03 futex_wake03
 futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
 futex_wait06 futex_wait06
+futex_wait07 futex_wait07
 
 memfd_create01 memfd_create01
 memfd_create02 memfd_create02
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
index 000000000..43808a8fc
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wait07.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc. Michael Menasherov <mmenashe@redhat.com>
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
