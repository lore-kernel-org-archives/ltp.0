Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DD1CEBF61
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 01:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763428719; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=1bzTRG+ztWmkuzi4AC1rAej3eCyZhW5nj6yxkcIl4s4=;
 b=rgHYLpGRYRFxGzY4ECUSdA6MHIGDWLwBjshHo/YRNIy0WBO4KvYLUi+633sWa2ZYG6Y3f
 IanzQGIpRz11LS1o2BTgK9EzcbsAyeBR0eKsgn9ieucEU/wCoD+4s2UBGKKzPVo7HzUGZWx
 QCieWQuJ2CtyL44mh2ETO9f4pG3n5MY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70D193CE39F
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 02:18:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4384F3C00CF
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 02:18:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F53B600043
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 02:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763428695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gD2ewhs7IuI3EqFB8IsekOVrLx2EK+p3v5ozl7pWJx8=;
 b=VgfzjAFOnquRnYNItzT0WeSefWsZb5Jf+ERywJ9VIaQEBapEgX0GkizeQ55mey5+Q+gLh2
 RNz5a4uzLLdmLb4NzpwIwsPACPXruKFVujWEXqqMgXNus0Kv57mRpM7o1OUrTH7pwigBI5
 K3EdpuIobqo29aVnF4xxlbKJm8I6/zk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-tJSPUoE9OLWhKaLn8rDROA-1; Mon, 17 Nov 2025 20:18:13 -0500
X-MC-Unique: tJSPUoE9OLWhKaLn8rDROA-1
X-Mimecast-MFC-AGG-ID: tJSPUoE9OLWhKaLn8rDROA_1763428693
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so1366136285a.2
 for <ltp@lists.linux.it>; Mon, 17 Nov 2025 17:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763428693; x=1764033493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gD2ewhs7IuI3EqFB8IsekOVrLx2EK+p3v5ozl7pWJx8=;
 b=SpNjU7C1Yqia0H6ti9i4aqdkWSrLHAvT0ITrF9Tc3ormkuPimyLDO+LgKY1iyIIxk8
 fLaEd2SALRL7mMgz/RRDdCUhSQseY0RshMk20rb+jEoRAvj/7tbCdAXRfBNlDzjduaLz
 EEHyJlG5Rt8yVPk7Ow2wlyTbh2VCmgS99Ee5+dntv5NbW7an6UTtjIr8pE19Zo/SvBso
 vSTfWOap4qkc8VJjUWhYr7WZbZc05Yfo8J1WiA02PwTqG3lKBjgBIQTzumyaS1b9Rf2a
 pFpCzOynnE3JoQ/6YOgGDbGxZtS8b5QjREhbllPnIVVR5KqxqojC1HRqj1qMCpQgi5ey
 lcWg==
X-Gm-Message-State: AOJu0YyN9j+RQu8IuwNSMIh7NQj6rB/X1jwupkjBdlgcwmDnMl5Zi/bj
 bnMQR7vyjxNp5EG1ifrLMpGiBYkWi9jYbrnQe1TTIya78+0eGBid1sG7uIwfz5d9ge+ebgCLLMN
 NtovoA94D+ehrCYNwBMPECgPhh2c00GOgdlQBVziXNOTSYG906LzPdGGZVg7JO0yAAYMCCqFCvI
 3FHTsOlLEQfiFtTNaCoOtlZG8svMDOHE3IE0Bn
X-Gm-Gg: ASbGncsGgwAcBoS4pHC/kV4cQhYTw5zIFxUeH1NHA5zKcp74jfAR6dhY8wcnuBhRf5y
 rU+sdudpeF6xGKEb5mVy3L5YLz8UhBUtAKLXWu0UvbP5n+qKo7Y3/DcRClaHXU67qJq3zpVIL6Z
 0cjTlikieIo5A7+ob6hY+/HsZjWTw5H/t57SCmK3O8pTw8PqQDLwlOwDehQamrkKFJtXQ5dWFxG
 nEzIWVUnBzx9NOcBmoHxXcBUPnhkhqUMZIKGU2nhPkvcKCjvQH5zJ91e/kPNZ57xTymViLtgKqO
 sjv4SOIwQMJnv8ZNQqRTCPV6QkTrxJs7gGUCxGtr6jJxooNpqHqKsfZSzten1C32sbgN8pNRX8M
 JEBvg3juS84NxVQeFz0hJcy0Tr2fYOcXdO+Afbw==
X-Received: by 2002:a05:620a:c41:b0:8b2:7558:409c with SMTP id
 af79cd13be357-8b2c3162bb8mr1993173585a.36.1763428693163; 
 Mon, 17 Nov 2025 17:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxwuOVnkzzMNqtiayViai85bDXET6BEptDpT0lJuDrywaUkqxiaN6gDe2vf6WmDmI2jjWLRA==
X-Received: by 2002:a05:620a:c41:b0:8b2:7558:409c with SMTP id
 af79cd13be357-8b2c3162bb8mr1993169985a.36.1763428692577; 
 Mon, 17 Nov 2025 17:18:12 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([172.56.196.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aeecb087sm1102601785a.26.2025.11.17.17.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 17:18:12 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 17 Nov 2025 20:18:01 -0500
Message-ID: <20251118011802.1174010-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7aOpJJuLah9dg7lLWCr9eo6wqJhCHvFZ9jt-FdJCf0Q_1763428693
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Add EPERM test for clone and clone3
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Confirming EPERM is returned when CAP_SYS_ADMIN is
removed from clone and clone3.
And for clone3 the set_tid_size is greater than 0.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 runtest/syscalls                            |  2 +
 testcases/kernel/syscalls/clone/.gitignore  |  1 +
 testcases/kernel/syscalls/clone/clone11.c   | 74 +++++++++++++++++
 testcases/kernel/syscalls/clone3/.gitignore |  1 +
 testcases/kernel/syscalls/clone3/clone304.c | 88 +++++++++++++++++++++
 5 files changed, 166 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone/clone11.c
 create mode 100644 testcases/kernel/syscalls/clone3/clone304.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 54d94c0ca..a1ef7548b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -124,10 +124,12 @@ clone07 clone07
 clone08 clone08
 clone09 clone09
 clone10 clone10
+clone11 clone11
 
 clone301 clone301
 clone302 clone302
 clone303 clone303
+clone304 clone304
 
 close01 close01
 close02 close02
diff --git a/testcases/kernel/syscalls/clone/.gitignore b/testcases/kernel/syscalls/clone/.gitignore
index adfb8257d..0edcfef5d 100644
--- a/testcases/kernel/syscalls/clone/.gitignore
+++ b/testcases/kernel/syscalls/clone/.gitignore
@@ -8,3 +8,4 @@
 /clone08
 /clone09
 /clone10
+/clone11
diff --git a/testcases/kernel/syscalls/clone/clone11.c b/testcases/kernel/syscalls/clone/clone11.c
new file mode 100644
index 000000000..6fb9e5346
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone11.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
+ */
+
+/*\
+ * This test verifies that :man2:`clone` fails with EPERM when CAP_SYS_ADMIN
+ * has been dropped.
+ */
+
+#define _GNU_SOURCE
+#define DESC(x) .flags = x, .sflags = #x
+
+#include "tst_test.h"
+#include "clone_platform.h"
+#include "lapi/sched.h"
+
+static void *child_stack;
+static int *child_pid;
+
+static struct tcase {
+	uint64_t flags;
+	char *sflags;
+} tcases[] = {
+	{ DESC(CLONE_NEWPID) },
+	{ DESC(CLONE_NEWCGROUP) },
+	{ DESC(CLONE_NEWIPC) },
+	{ DESC(CLONE_NEWNET) },
+	{ DESC(CLONE_NEWNS) },
+	{ DESC(CLONE_NEWUTS) },
+};
+
+static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	*child_pid = getpid();
+	exit(0);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE,
+			child_stack), EPERM, "clone(%s) should fail with EPERM"
+			, tc->sflags);
+}
+
+static void setup(void)
+{
+	child_pid = SAFE_MMAP(NULL, sizeof(*child_pid), PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (child_pid)
+		SAFE_MUNMAP(child_pid, sizeof(*child_pid));
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.caps = (struct tst_cap []) {
+			TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+			{},
+	},
+	.bufs = (struct tst_buffers []) {
+			{&child_stack, .size = CHILD_STACK_SIZE},
+			{},
+	},
+};
diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
index 10369954b..e9b5312f4 100644
--- a/testcases/kernel/syscalls/clone3/.gitignore
+++ b/testcases/kernel/syscalls/clone3/.gitignore
@@ -1,3 +1,4 @@
 clone301
 clone302
 clone303
+clone304
diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
new file mode 100644
index 000000000..75ceaa065
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
+ */
+
+/*\
+ * This test verifies that :man2:`clone3` fails with EPERM when CAP_SYS_ADMIN
+ * has been dropped and ``clone_args.set_tid_size`` is greater than zero.
+ */
+
+#define _GNU_SOURCE
+#define DESC(x) .flags = x, .sflags = #x
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+enum case_type {
+	K_SET_TID,	/* flags = 0 || CLONE_NEW*, set_tid_size > 0 => EPERM */
+	K_NAMESPACE_ONLY,  /* flags = CLONE_NEW*, set_tid_size = 0 => EPERM */
+};
+
+static struct clone_args args = {0};
+static pid_t tid_array[1] = {1};
+
+static struct tcase {
+	uint64_t flags;
+	char *sflags;
+	enum case_type type;
+	const char *desc;
+} tcases[] = {
+	{ DESC(CLONE_NEWPID), K_NAMESPACE_ONLY, "set_tid_size=0" },
+	{ DESC(CLONE_NEWCGROUP), K_NAMESPACE_ONLY, "set_tid_size=0" },
+	{ DESC(CLONE_NEWIPC), K_NAMESPACE_ONLY, "set_tid_size=0" },
+	{ DESC(CLONE_NEWNET), K_NAMESPACE_ONLY, "set_tid_size=0" },
+	{ DESC(CLONE_NEWNS), K_NAMESPACE_ONLY, "set_tid_size=0" },
+	{ DESC(CLONE_NEWUTS), K_NAMESPACE_ONLY, "set_tid_size=0" },
+
+	{ DESC(CLONE_NEWPID), K_SET_TID, "set_tid_size>0" },
+	{ DESC(CLONE_NEWCGROUP), K_SET_TID, "set_tid_size>0" },
+	{ DESC(CLONE_NEWIPC), K_SET_TID, "set_tid_size>0" },
+	{ DESC(CLONE_NEWNET), K_SET_TID, "set_tid_size>0" },
+	{ DESC(CLONE_NEWNS), K_SET_TID, "set_tid_size>0" },
+	{ DESC(CLONE_NEWUTS), K_SET_TID, "set_tid_size>0" },
+
+	{ DESC(0), K_SET_TID, "set_tid_size>0" },
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	args.flags = tc->flags;
+
+	if (tc->type == K_NAMESPACE_ONLY) {
+		args.set_tid = 0;
+		args.set_tid_size = 0;
+	} else {
+		args.set_tid = (uint64_t)(uintptr_t)tid_array;
+		args.set_tid_size = 1;
+	}
+	if (!tc->flags)
+		SAFE_UNSHARE(CLONE_NEWUSER | CLONE_NEWNS);
+
+	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM, "clone3(%s), should fail when %s (set_tid_size=%ld)"
+			, tc->sflags, tc->desc, args.set_tid_size);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+
+	memset(&args, 0, sizeof(args));
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = run,
+	.needs_root = 1,
+	.caps = (struct tst_cap []) {
+			TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+			{},
+	},
+	.bufs = (struct tst_buffers []) {
+			{&args, .size = sizeof(struct clone_args)},
+			{},
+	},
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
