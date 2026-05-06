Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC568CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778080811; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=r0hBWmJS8ZoabB4RfleNIE2iO8B5EkXOTgPL7Nk3mZM=;
 b=je1/kX+GJbxmVFYLWhK9uBm8bmqi+lCr3iM1OJsT5P/OrV6s2ii1aegk3ac1pVjGGoQ8R
 QtrdniUkVZa+T2Ers7SaCLdntvOv1rTlLOn8KDWgs4A+X072GBYeDuSWI8k1AlbrcjE7dyK
 FU8jZDQrL5xFjF6velnvY9qyPiFg88o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60C7A3C5A8C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:20:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A0E3E65A5
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DA6A1A00982
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778080694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CW08z9pGHyXYfeAAgPmQjnqzWN3yJZ9FozyxaxroIh8=;
 b=OHU2qC7zROWuF6esEtAZVwiYfKZupS+MxBu7gpH4QkMnu+u4KELPfeN7pXWs/3kkJWXDrb
 CGyXjssxvFLV9MyHawN9ZAJUDnkKTxp6I65ylRyARalja0VpTJB1A3hvsi9V2LHbhrABZh
 39W29W6He71SWKQrmcQB93xCCAKD75A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-3Vymf5YkPheXgMOhSdEPzg-1; Wed, 06 May 2026 11:18:12 -0400
X-MC-Unique: 3Vymf5YkPheXgMOhSdEPzg-1
X-Mimecast-MFC-AGG-ID: 3Vymf5YkPheXgMOhSdEPzg_1778080691
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a52d5e572so3142229f8f.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080691; x=1778685491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CW08z9pGHyXYfeAAgPmQjnqzWN3yJZ9FozyxaxroIh8=;
 b=NakDPD85GyiEbwV89e46yI6R6KArQMuIjrrvou1PeBLEj+alnhdS27FFSiffTkMBeo
 Z34+Z/NyJbfP3GNrLYnsklFfHLTeCzJjC1O3sgAw6/fK9nJkTQCky+UQobioul90dYvO
 8RdoSgJT7UDHdFf8we6V9ouT1jRAOgqiCWOn3K26JPgDrZaouW7Jgp/HZZEf79b1/Kwx
 ukUegG48Dcs+oIqeM8kdmWrCzt0fDhSTi5B7pAZm2WOO2g7xhKs68HaApg8Nf6ayCOWY
 vRqifxVRj+kj82mswqonfsd/F4QIAFso7mkLdi9bcZVEZk1a1BYPLjs5I65QVeHYwVLR
 jscA==
X-Gm-Message-State: AOJu0YyyamJD2u5FcgtdFfn7dqWZr1O/imFUyhc3tcWdmJhvbH6wqrvW
 IZ83DIfPE3WosXs4Crn2gjTAuVTHSYSuw3dlzz3WqUun+zGKZ3Akz1holNAB+Bp948HlhPKo/tr
 2LtD7Qk4ItsqHVi12af2i29Quo6au3MOByz6flLV1za7JHekPGt3Agijz4BHD5tfE8eIxOgnyRA
 JO+RtniK5Ioh0TwT1ILmVwYsPENVmOh9znIHWF
X-Gm-Gg: AeBDietCsKCWeNnk+16Zw5xdXwIR7teVnpl+/ZiSFLdjHCwCaWjwZUkHW2WlVlNyfXT
 dF8uJ+G08ElKba+cyG5zXhVDS1Q53awo1Xh7BQr31U3LjdLjlG2R81wZw6qsn/swfhQIvFjwCT3
 ompQZvFLk0978umyPW3mOGf89caaGbceBJek1ZzccYonMRlcHe4lFlICyhY/sK8lhdRbWqtxV22
 Zi058JZQFMWqjV8xal7SVhgxiPJj9TiXpJM+BzW4NpROH5RRYk6+KNoThVK5tK1dNQm4ukYDo0G
 HmOZ8GuL6yJLF+T6fvLZh6eH+GNblrtYYd2lMq0mqembqE7Ix8aeUXDRm78MITp1jmDtYzbGku/
 JZXFVEB1GslFPxKfi6URx0YlkfOqIdt5rjUYf+lP75zACk7Mb5owKjLLaSCgRXqj37CcB6q0jJl
 oXc8fG7Q==
X-Received: by 2002:a05:6000:2386:b0:43d:1cec:4767 with SMTP id
 ffacd0b85a97d-4515d9a02c4mr6891751f8f.36.1778080690742; 
 Wed, 06 May 2026 08:18:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2386:b0:43d:1cec:4767 with SMTP id
 ffacd0b85a97d-4515d9a02c4mr6891638f8f.36.1778080689913; 
 Wed, 06 May 2026 08:18:09 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e174sm13323519f8f.1.2026.05.06.08.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:18:08 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 18:18:01 +0300
Message-ID: <20260506151801.20401-5-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506151801.20401-1-mmenashe@redhat.com>
References: <20260506151801.20401-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZeB2GSSlbCnob7yNleQoVOBvKqdB9XG0NsrbyyMO-jk_1778080691
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ltp v2 4/4] futex_cmp_requeue03: Add EFAULT and EACCES error
 coverage test
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

---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/futex/.gitignore    |  1 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 96 +++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4d85a1d26..65baa44dc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1908,3 +1908,4 @@ perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
 futex_wake05 futex_wake05
+futex_cmp_requeue03 futex_cmp_requeue03
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index c11546e07..231b6bd25 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -16,3 +16,4 @@
 /futex_wait06
 /futex_wait07
 /futex_wake05
+/futex_cmp_requeue03
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
new file mode 100644
index 000000000..099d5e35c
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or
+ * uaddr2 points to unmapped memory, and EACCES (or EFAULT on older kernels)
+ * when uaddr points to memory without read permission (PROT_NONE).
+ *
+ * The EACCES behavior for PROT_NONE was introduced in kernel 5.9.
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t futex_var = FUTEX_INITIALIZER;
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
+	futex_t *uaddr;
+	futex_t *uaddr2;
+	int exp_errno;
+} testcases[3];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_cmp_requeue(tv->fntype, tc->uaddr, futex_var,
+		tc->uaddr2, 1, 1, 0), tc->exp_errno, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+	futex_t *unmapped;
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	unmapped = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MUNMAP(unmapped, pagesize);
+
+	prot_none_addr = SAFE_MMAP(NULL, pagesize, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	testcases[0] = (struct testcase){
+		.desc = "uaddr unmapped",
+		.uaddr = unmapped,
+		.uaddr2 = &futex_var,
+		.exp_errno = EFAULT,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "uaddr2 unmapped",
+		.uaddr = &futex_var,
+		.uaddr2 = unmapped,
+		.exp_errno = EFAULT,
+	};
+	testcases[2] = (struct testcase){
+		.desc = "uaddr PROT_NONE",
+		.uaddr = prot_none_addr,
+		.uaddr2 = &futex_var,
+		.exp_errno = tst_kvercmp(5, 9, 0) >= 0 ? EACCES : EFAULT,
+	};
+}
+
+static void cleanup(void)
+{
+	if (prot_none_addr)
+		SAFE_MUNMAP(prot_none_addr, getpagesize());
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
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
