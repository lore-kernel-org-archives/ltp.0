Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B514CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778080787; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NfZjeVeH0lU8RK8MWYx6gzEY3+Br0e9TCZpOcdZBoxs=;
 b=PRpoP1OKpFqlAOh64PBs3ggZXtE5tnEzj0/hdvg89+Oc29RRQEDNZ+HrCFrwO7sk6IZDK
 hP+LNZwCl6EDEf2HSHZa0SOMc/NQIxGwY40kxO63N+ffwBMjDReiyRX4TfoCfX5/E174BiQ
 1Q3ROKb332YpQYe5ZGOgcybDiu5FRUM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78FDC3C5A8C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:19:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CB743E6A8F
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D53D06009C9
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778080691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6PM+iazZHiaNtQstutOpMmLJDrpEeOwSs1KfuxQnzw=;
 b=cuEi/hLpWxuIkdu+YUGCZt0Z8jEnAvauG9CtTxmgaLwjiFQcW50EirNJskYfMdqkkV+vAW
 fvLoafHv9YVDCDwoaTpeQog9XU8RBHVZYELkNGAiQVBtEZs3YwFBqj56greWi8NfdbmbhE
 gDkJq1pEAdpugkzH7YZ0SxlR+jJb2+Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_4DyH29JNaGDLKwbNgymJQ-1; Wed, 06 May 2026 11:18:10 -0400
X-MC-Unique: _4DyH29JNaGDLKwbNgymJQ-1
X-Mimecast-MFC-AGG-ID: _4DyH29JNaGDLKwbNgymJQ_1778080689
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso3178480f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080689; x=1778685489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w6PM+iazZHiaNtQstutOpMmLJDrpEeOwSs1KfuxQnzw=;
 b=RtDShGvIZO8qs4NApXPlwbqYhdYG7VRu1dykHv5MYklYrUuIxR5xy0iFVqiXQe1dGk
 QCh83OLVRvyHlNPAYv2QV7FX0e5eOoXpiN6dCCAglkoSmzTiRWo+sRgqlnPCLsNiJpwD
 T6sCt5swnXHcX5t+GczpbWWEN+aV3/MvcPBtJwZnvLBtDeYARv/TMTwlejPzAR+YW9bA
 AwXsPq9yBD2hexY17mzPPU75NNqL1dG6WCNFBvQZDKEu7cTehMMMG/Jqn6T4F5jHxEfN
 FptgcLf/rGMlxjKePZAN1PUtnkP8bafszOK60AoYo/Q9C8ZumyAqb2HWkFjlFt02GLmY
 oYfQ==
X-Gm-Message-State: AOJu0YyHsvbLjVHNBNV7LLRyrlR11gX0m9D0vRDltKKFwggw4II6DJb9
 y1TsjZM8I0288+N6S6ArX9rbXV7pbEnwE/TUT/a1WAYrOd5LifIf/jgC+3WqDM2GrjrTzqD8xvk
 2Dy5/Gyrc86CBPrtk+0W1ZmHtiI7KFxPdu0KEPYyNtMVpcpmsZT0oqG1zms19gjVmT/xGI1/yOt
 5BQsDA5iB3jJwxh1bmzqrqjehj1yAIBvQF05Z0
X-Gm-Gg: AeBDietni+zfg5tSPmbv62ANw29OtTNzKy1CL2fgHhNiUwdJ4LVDcw6bvDcpMRW9QY1
 d/W1lLkMbm1YqliX+1MtfHoZv/6HWsJA/cimb5swmVeee8umzv9BX4GZKc0310dTO+ZMG35ErZn
 0NOGMJLZiA8NrzcoSiPCNrDPnAk+bbOD/tX2XDkbqOPqfs5KKnzTk8364f+QU6iiqgYZQCBjfLh
 Ezf4mbs05U97LHWlAWQWaAwIXbF70L9dEAuZyrncYrJc5F/7GNulQ5ATByA/kqO2t+/Tfeq577Y
 YXhepziy4A7+HvhjWs7PlrpV/91AvZwVsy9qBs2vm0jx56ooCNRnh6J33o2y1W3NHLzSAcdrS0G
 Y1v2hGeUuXxmeD+9t87Epj9aUIc0NuUpSCQxdrC1lLCoi92YaWclQo2wmt8cyPN8hUVlePukgJu
 3wPKa5ow==
X-Received: by 2002:a05:6000:2405:b0:43d:7ba4:6b5a with SMTP id
 ffacd0b85a97d-4515cf12664mr6897262f8f.22.1778080688691; 
 Wed, 06 May 2026 08:18:08 -0700 (PDT)
X-Received: by 2002:a05:6000:2405:b0:43d:7ba4:6b5a with SMTP id
 ffacd0b85a97d-4515cf12664mr6897208f8f.22.1778080688091; 
 Wed, 06 May 2026 08:18:08 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e174sm13323519f8f.1.2026.05.06.08.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:18:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 18:18:00 +0300
Message-ID: <20260506151801.20401-4-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506151801.20401-1-mmenashe@redhat.com>
References: <20260506151801.20401-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UkofVrIa9Z46eRm0tVEDc6rtIPPvd8iN3ejPN8USlQE_1778080689
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ltp v2 3/4] futex_wake05: Add EFAULT error coverage test
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
 .../kernel/syscalls/futex/futex_wake05.c      | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 75b7754db..4d85a1d26 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1907,3 +1907,4 @@ io_uring03 io_uring03
 perf_event_open03 perf_event_open03
 futex_wait06 futex_wait06
 futex_wait07 futex_wait07
+futex_wake05 futex_wake05
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
index 000000000..1e9bd6435
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake05.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to
+ * unmapped or PROT_NONE memory.
+ *
+ * Note: FUTEX_WAKE never reads *uaddr, so PROT_NONE triggers EFAULT
+ * (not EACCES). The EACCES behavior only applies to syscalls that read
+ * *uaddr (e.g. FUTEX_WAIT, FUTEX_CMP_REQUEUE).
+ */
+
+#include <errno.h>
+#include <sys/mman.h>
+#include "futextest.h"
+
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
+	futex_t *addr;
+	int exp_errno;
+} testcases[2];
+
+static void run(unsigned int n)
+{
+	struct futex_test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+
+	TST_EXP_FAIL(futex_wake(tv->fntype, tc->addr, 1, 0),
+		tc->exp_errno, "%s", tc->desc);
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
+		.addr = unmapped,
+		.exp_errno = EFAULT,
+	};
+	testcases[1] = (struct testcase){
+		.desc = "uaddr PROT_NONE",
+		.addr = prot_none_addr,
+		.exp_errno = EFAULT,
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
