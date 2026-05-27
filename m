Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A2BCD5BDE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779874079; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vUQqCyOEF+r4jCmSbAhYpu1Z6AKQHpL1HaZBgtKyYB8=;
 b=fuJtTRBPWnZq288urLSOZJIdDoDP3dWdG4VR5vvoGgOiBLKhd9v1b+3zb9TLTrOqQldQW
 O4gLJ5g2VyrOpL6Syrl7RtHGhkRogH77a/88IYWa3Fvfuy6LR67Ac7ZQ48P//4DmhAIiJMC
 PXeUhLCznjGCzMkEIXEaqXPjor72C6U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4D803CB98B
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:27:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8434A3CB69A
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1804600ADF
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779873990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZAj81vg7UdQnS+0iskttImribHHfAO+YYWNW2506Rs=;
 b=K9557BpCFgmHxtbcR2bO2NvCsN1OSg2uFYL9ZouWlRoYaNMKUE+wv9T3+mxm6/0dxy8+sl
 PHOaMDgOikTgevlda0WKedzdfga0xN3ZgfmmkL77fbabPCv0odx2HPeRV9YksFC5x3wxxm
 1Nrk7wzLR4g5pcYPnpIeugANaQxLRAQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-xgabKAD5O4eZ-lpGhi_AqQ-1; Wed, 27 May 2026 05:26:28 -0400
X-MC-Unique: xgabKAD5O4eZ-lpGhi_AqQ-1
X-Mimecast-MFC-AGG-ID: xgabKAD5O4eZ-lpGhi_AqQ_1779873987
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so41671765e9.3
 for <ltp@lists.linux.it>; Wed, 27 May 2026 02:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779873987; x=1780478787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZAj81vg7UdQnS+0iskttImribHHfAO+YYWNW2506Rs=;
 b=KYCFYV/DMUSxbAy3w68oi3FlFDeSgQSiEcnXJUEW1/MiPS2sEywJ8nD9nrGq24aN8o
 Vahgb8SMw3ohlqnWRgPjgHnjWldTDG6ccZdamYcQpQ1G+YiuRSz+9WE3ACxKC9wMA78Z
 YN5b5b53QbGdAFHCMdvgRei4dMyXQj+WzMj6Rqsdqdhi3PHiXuTHtLhGsp527sTrnlxy
 huE7DVb8LIRVaIotDrZQqIRh7I+l3Arg4zmty50WBiQ5wUkb8/bS3KgmEs3mXT/auWQ/
 Nhl2YrRmYGuJB34srSrDM/KowHm1LRG+rxErt9Gs/YJWLKGrImnHyVJYc3y1P9PuhHNn
 RyiA==
X-Gm-Message-State: AOJu0YxRg5fMmTeIX8UrxDt1qhCvW9yQTnbWJwz5p74uWmoWnZQsTC7n
 KZJtq/nEa3PVAoGZWWRrd19KEnzPn13imkCC0D1aOvERwtb4i84J8OkBXiqwpGqzW7AJcbn+Ry/
 B1V/wxjizNTH1HAAkly3d6MGP8+IlKgpTipVpF8uVoJmnfCDroDEMOhXaeC6FIojJqUxFtdCEmI
 lllOoCvMUFa36xWZ5VTBwvhBo03V0v8Tx3wyu4
X-Gm-Gg: Acq92OFKZCd+Gyojte7moTNNmg2d3qPkqwwPXhlzYvGscxB4qsBM7gYVT6JspRq5BkR
 mNVgTcRNMppjt88hr04uq2KokQPGtyS21MqKzmqaLWigbzUiFs863D5WjqWrqBdieIihxuJFndm
 KSt5tdI1gOTdpN7YxNtSd+GLmtLOnqhiwNgyOQxp85shjC1aAiANRjQ5xxG2PSH1VUPC0D9PIxU
 lTX9D827lzX7xqjotG77dUd+RVQsuCCqtj5K6knzOKfIcF3FyhurY7Tb7+LthYqe9mr4dY3Mdih
 hycHw7HuJBQXsrK6XvSos5gpNbrZ+MJ9/MuWtHjpN7FrOdIFTSot0EUAMghr3MdGTyL1a9YDThX
 H+/Ds5dNgjL+smhfX9e23VVEwFo9m65qcb3cjN9BmXVusPEa441rnxLoPv9cgPw==
X-Received: by 2002:a05:600c:1c0b:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490426aa7acmr410376375e9.14.1779873987248; 
 Wed, 27 May 2026 02:26:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0b:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490426aa7acmr410375945e9.14.1779873986749; 
 Wed, 27 May 2026 02:26:26 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a281dsm4552653f8f.24.2026.05.27.02.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:26:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 12:26:17 +0300
Message-ID: <20260527092618.14824-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-1-mmenashe@redhat.com>
References: <20260527092618.14824-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3x5qwBzivM7mOlosVtIsJvMFPJAs5ej2RMctW8wRCCU_1779873987
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 3/4] futex_wake05: Add EFAULT error coverage test
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

futex(FUTEX_WAKE) has no existing test for EFAULT. Add coverage for
the cases where uaddr points to unmapped or PROT_NONE memory.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../kernel/syscalls/futex/futex_wake05.c      | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e6c5d5112..8c4d9be6c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1877,6 +1877,7 @@ futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
 futex_wake04 futex_wake04
+futex_wake05 futex_wake05
 futex_wait_bitset01 futex_wait_bitset01
 
 memfd_create01 memfd_create01
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 74ac9a926..c11546e07 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -15,3 +15,4 @@
 /futex_waitv03
 /futex_wait06
 /futex_wait07
+/futex_wake05
diff --git a/testcases/kernel/syscalls/futex/futex_wake05.c b/testcases/kernel/syscalls/futex/futex_wake05.c
new file mode 100644
index 000000000..5b0f4ac17
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped or PROT_NONE memory.
+ *
+ * The test uses opflags=0 (no FUTEX_PRIVATE_FLAG), so futex_wake() takes
+ * the shared-futex path in get_futex_key() which must resolve the physical
+ * page. For PROT_NONE memory this page lookup fails with EFAULT, even though
+ * futex_wake() never reads *uaddr.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t *unmapped_addr;
+static futex_t *prot_none_addr;
+
+static struct futex_test_variants variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static struct testcase {
+	const char *desc;
+	futex_t **addr;
+	int exp_errno;
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.addr = &unmapped_addr,
+		.exp_errno = EFAULT,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.addr = &prot_none_addr,
+		.exp_errno = EFAULT,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, *tc->addr, 1, 0),
+		     tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP((void *)unmapped_addr, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+				   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP((void *)prot_none_addr, getpagesize());
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
