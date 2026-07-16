Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3241C44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784208720; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MRWCxxBC2ka4iIgFeG+FoMWeozQkT1RtEodeCN9/cOg=;
 b=PurZdJlnmtGbIUb+Z8gJOf98JpYshpG0CKeoovmcvGNS8gd6cPmjd3PXbjmhJpGnbOgkf
 2WkuWo1aqDTqqfYIfp0ORLdCBYNJoxAS+FjZ6I29wOk/KQ0+LPWjShViRO7FG56Y/cRa8NE
 qmjy5UtkHvntn1QZDQ0Z9sp48CQaDnk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 297EF3E564B
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:32:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 228AC3E2580
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:31:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C047100099D
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOW8+wX/1cQw+eMMY3j2XY/euVs+73eoo/f+MPIz9Bk=;
 b=Tq0ccTlXQAqI2xlmTH3e6kh4Pz42QvKdVF0AI55SnidG6OTX6jfmE8X/rLRfjtzIdZk9uv
 DFoGvk+QX4tfV+XiNSUGAPmbjWnJ1Ng1umff10CGvx5L9KO+oSKW6QXjDDpJnldjV4GAYp
 31Zhhu6gMlqadgP2YdWu5vWQFHo/pwo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Wi4SF59wM7GKh8N9y0i7zA-1; Thu, 16 Jul 2026 09:31:16 -0400
X-MC-Unique: Wi4SF59wM7GKh8N9y0i7zA-1
X-Mimecast-MFC-AGG-ID: Wi4SF59wM7GKh8N9y0i7zA_1784208674
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso2357175f8f.1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208674; x=1784813474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gOW8+wX/1cQw+eMMY3j2XY/euVs+73eoo/f+MPIz9Bk=;
 b=ddOPDfPB8SaetwtXdLXQek8vIoyj+dRyt7ihRnfCyqrOSJO7y9Ty2a5o/qIZZNP8Ac
 hSHVWSuzMOOICiiSND7Bq0BAkPElY29aZEZurDswHniJLQc42X6ZlO5UK3ApVBoumst3
 beASX+BGyiQ38cgW6U9RlyC/AAKEVomK1YYcjGdQJPCQqt/6fVw0ors3wrvJzuU97Mce
 BT1GPTJzMWz1/AT3Olbg9gB1//IX2ni8Uc8je/KV3OWEe1BWavHc6Xe/rmI3fK0fQ560
 FB40yAr8Ok1xjD1jJA2JxUiqS65ykruBzXGS73wEJz7k9vU8tbJNPOtzkwoP8Fwbxe6q
 YJzA==
X-Gm-Message-State: AOJu0YxVw1nh/TabcQJXnqIX1v0Gk17EMGJXV/beG+L84UgGhI38SFAf
 xhsm/BUIDdFs4lmqPWbeb1DybBEm/47RxfM1Z53m5fzsy2RtMHqjlJ3hKmYg0HNuoArVf55shBT
 86GNXBugiSD/WWdicQMEAvf1DwnAexA+Mk0YF9THdRCaHnOJ9om9pAjWAs53VTNABKJjLckJJOn
 EJPyXXOi7/n0brjRWcXCKxVBP38w3x/gAjvh/A
X-Gm-Gg: AfdE7ckFhMur0NJb5WTEF41c6+HdLCTp6yqYfnEeXv59oYusw9LB2uwmwek9eFEfEsj
 HO8JcVgwfHyLRtKVPU7/WOkYXTWt/gpDansvjvm548BesbafNtvAWa/PrYjHT/KwRqLe15JjCoL
 LtKJMHeZNtlm04NUW42to3nbWoo/hqB4AtJ0zCVYRVOpRHIxSewE3MIUymQgu3Mq3OIFvt170d8
 osn6caruWLhHb5RAJiWGpQuKIlnbuXNwbZA+mH112IOd3oTOFXJmQHteievcSwepswiUfOxyX/2
 MpSsWSn9M/jdOZrwYs8a4Q07xkyalbO/8OhByENWnl2996QJ+Z3c/QV2uHqFfCDq+8rHgd50FdY
 laMih+RGK6GFLfvg11L2cOY68duKPZhkFaOsrXDgsozlG2aBBbQ==
X-Received: by 2002:a05:6000:290f:b0:46d:d693:88cb with SMTP id
 ffacd0b85a97d-47f2dce2db6mr25406714f8f.46.1784208674161; 
 Thu, 16 Jul 2026 06:31:14 -0700 (PDT)
X-Received: by 2002:a05:6000:290f:b0:46d:d693:88cb with SMTP id
 ffacd0b85a97d-47f2dce2db6mr25406636f8f.46.1784208673615; 
 Thu, 16 Jul 2026 06:31:13 -0700 (PDT)
Received: from fedora.redhat.com (85.64.193.120.dynamic.barak-online.net.
 [85.64.193.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635c86csm24900918f8f.16.2026.07.16.06.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:31:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 16:31:07 +0300
Message-ID: <20260716133108.13003-2-mmenashe@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716133108.13003-1-mmenashe@redhat.com>
References: <20260716133108.13003-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: __lvX_uKGC1aiMhUE3WsRQqKgWzvYF5bjWDtkeSbgHs_1784208674
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 1/2] futex_wake05: Add EFAULT error coverage test
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
unmapped, PROT_NONE, and truncated file-backed uaddr, each exercising a
different code path in the kernel's address validation.

Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/futex/.gitignore    |   1 +
 .../kernel/syscalls/futex/futex_wake05.c      | 113 ++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a021c79da..67509826f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1878,6 +1878,7 @@ futex_wake01 futex_wake01
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
index 000000000..7cd26ffaf
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ * Copyright (C) 2026 Michael Menasherov <mmenashe@redhat.com>
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped, PROT_NONE, or truncated file-backed memory.
+ *
+ * For opflags=0 (no FUTEX_PRIVATE_FLAG) futex_wake() takes the
+ * shared-futex path in get_futex_key() which must resolve the physical
+ * page.
+ *
+ * The three cases exercise different code paths:
+ *
+ * - unmapped memory fails at find_vma() (no VMA exists)
+ * - PROT_NONE memory fails at get_user_pages_fast() (VMA exists but
+ *   page is inaccessible)
+ * - a file-backed address beyond the file's end triggers VM_FAULT_SIGBUS
+ *   inside the page fault handler, which get_user_pages() propagates as
+ *   EFAULT
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+
+#include "futextest.h"
+
+static futex_t *unmapped_addr;
+static futex_t *prot_none_addr;
+static futex_t *file_trunc_addr;
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
+} testcases[] = {
+	{
+		.desc = "uaddr unmapped",
+		.addr = &unmapped_addr,
+	},
+	{
+		.desc = "uaddr PROT_NONE",
+		.addr = &prot_none_addr,
+	},
+	{
+		.desc = "uaddr file truncated",
+		.addr = &file_trunc_addr,
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, *tc->addr, 1, 0),
+		     EFAULT, "%s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	size_t pagesize = getpagesize();
+	int fd;
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
+
+	fd = SAFE_OPEN("futex_wake05_tmp", O_CREAT | O_RDWR | O_TRUNC, 0644);
+	SAFE_FTRUNCATE(fd, pagesize);
+	file_trunc_addr = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
+				    MAP_SHARED, fd, 0);
+	SAFE_FTRUNCATE(fd, 0);
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK("futex_wake05_tmp");
+}
+
+static void cleanup(void)
+{
+	size_t pagesize = getpagesize();
+
+	if (prot_none_addr)
+		SAFE_MUNMAP((void *)prot_none_addr, pagesize);
+	if (file_trunc_addr)
+		SAFE_MUNMAP((void *)file_trunc_addr, pagesize);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+	.needs_tmpdir = 1,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
