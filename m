Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8BFE77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 13:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 515283E6FF5
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 14:36:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3E9F3E6FE3
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 14:36:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 445A8100FF17
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 14:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733492199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHPuMoE3cnjG31YRrIkMVGtKOkeqFBIzaG+HccMGquY=;
 b=egbryf9icEv2hmu/HT6famBWze8oSuzdwCY2wb11/CDWBeE5xJZprShIwo4x9svzJFlDqu
 t6uXYzI9t9bgjjaO7x+29L9TYxFw7D8aKzeaYDm6YmP518FyszfmWBH7+7kFuCSUp9eIQj
 xtfxJo8svQ+9D9j2Qm0wnKdXmDOJigI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-4i55Wal4Pw2GdNbHUgBZVA-1; Fri,
 06 Dec 2024 08:36:38 -0500
X-MC-Unique: 4i55Wal4Pw2GdNbHUgBZVA-1
X-Mimecast-MFC-AGG-ID: 4i55Wal4Pw2GdNbHUgBZVA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2539A195608B; Fri,  6 Dec 2024 13:36:37 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BBA21955F3E; Fri,  6 Dec 2024 13:36:35 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  6 Dec 2024 14:36:32 +0100
Message-ID: <cab714b22f1b2bb055dcc6732aa065c625c23c30.1733492099.git.jstancek@redhat.com>
In-Reply-To: <Z1LTvZEBUvK744Ye@yuki.lan>
References: <Z1LTvZEBUvK744Ye@yuki.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bot5TafqgF2zlltOarZ8GyytUUQNDbc7ISV0ODz44mQ_1733492197
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/getrandom05: add test variants
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

And skip EFAULT for glibc as it can segfault in VDSO:
  #0  __arch_chacha20_blocks_nostack () at arch/x86/entry/vdso/vgetrandom-chacha.S:146
  146             movups          state0,0x00(output)

  (gdb) bt
  #0  __arch_chacha20_blocks_nostack () at arch/x86/entry/vdso/vgetrandom-chacha.S:146
  #1  0x00007fcd3ce6417a in __cvdso_getrandom_data (rng_info=0x7fcd3ce5f280, buffer=0xffffffffffffffff, len=64, flags=1, opaque_state=0x7fcd3ce5df00,
      opaque_len=<optimized out>) at arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:237
  #2  __cvdso_getrandom (buffer=<optimized out>, len=64, flags=1, opaque_state=0x7fcd3ce5df00, opaque_len=<optimized out>)
      at arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:259
  #3  __vdso_getrandom (buffer=0xffffffffffffffff, len=64, flags=1, opaque_state=0x7fcd3ce5df00, opaque_len=<optimized out>)
      at arch/x86/entry/vdso/vgetrandom.c:11
  #4  0x00007fcd3cc7faf3 in getrandom_vdso (buffer=0xffffffffffffffff, length=64, flags=0, cancel=<optimized out>)
      at ../sysdeps/unix/sysv/linux/getrandom.c:204
  #5  0x0000000000401ff7 in verify_getrandom (i=0) at getrandom05.c:40

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/getrandom/getrandom05.c   | 16 +++++++-
 .../kernel/syscalls/getrandom/getrandom_var.h | 41 +++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/getrandom/getrandom_var.h

diff --git a/testcases/kernel/syscalls/getrandom/getrandom05.c b/testcases/kernel/syscalls/getrandom/getrandom05.c
index 92098deb723d..c4886b886f80 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom05.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
@@ -16,6 +16,7 @@
 
 #include "tst_test.h"
 #include "lapi/getrandom.h"
+#include "getrandom_var.h"
 
 static char buff_efault[64];
 static char buff_einval[64];
@@ -32,15 +33,28 @@ static struct test_case_t {
 	{buff_einval, sizeof(buff_einval), -1, EINVAL, "flag is invalid"},
 };
 
+static void setup(void)
+{
+	getrandom_info();
+}
+
 static void verify_getrandom(unsigned int i)
 {
 	struct test_case_t *tc = &tcases[i];
 
-	TST_EXP_FAIL2(getrandom(tc->buff, tc->size, tc->flag),
+	/* EFAULT test can segfault on recent glibc, skip it */
+	if (tst_variant == 1 && tc->expected_errno == EFAULT) {
+		tst_res(TCONF, "Skipping EFAULT test for libc getrandom()");
+		return;
+	}
+
+	TST_EXP_FAIL2(do_getrandom(tc->buff, tc->size, tc->flag),
 		tc->expected_errno, "%s", tc->desc);
 }
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_getrandom,
+	.test_variants = TEST_VARIANTS,
+	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/getrandom/getrandom_var.h b/testcases/kernel/syscalls/getrandom/getrandom_var.h
new file mode 100644
index 000000000000..b19b0ebc0120
--- /dev/null
+++ b/testcases/kernel/syscalls/getrandom/getrandom_var.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Jan Stancek <jstancek@redhat.com>
+ */
+
+#ifndef GETRANDOM_VAR__
+#define GETRANDOM_VAR__
+
+#include "lapi/syscalls.h"
+
+static inline int do_getrandom(void *buf, size_t buflen, unsigned int flags)
+{
+	switch (tst_variant) {
+	case 0:
+		return tst_syscall(__NR_getrandom, buf, buflen, flags);
+	case 1:
+		return getrandom(buf, buflen, flags);
+	}
+	return -1;
+}
+
+static void getrandom_info(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing SYS_getrandom syscall");
+		break;
+	case 1:
+		tst_res(TINFO, "Testing libc getrandom()");
+		break;
+	}
+}
+
+/* if we don't have libc getrandom() test only syscall version */
+#ifdef HAVE_SYS_RANDOM_H
+# define TEST_VARIANTS 2
+#else
+# define TEST_VARIANTS 1
+#endif
+
+#endif /* GETRANDOM_VAR__ */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
