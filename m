Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52975CF2560
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763504984; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=h5QK+SAziVkR0RrmoNccKeyVXq4islTtj+bXab2274Y=;
 b=PoXd6C5hkPkpEbd0gg8UJfTGZ5ADS6kFxfUilWXtekcDx5pRLOBnLlej86x1OuEIXQcxt
 48eYY1/uDtuiTnL8gRn8ZvsAd+kz6l5uoJtP7FtIAZLnQ7uyyD5Ddcp6YtkriRxH35XCIua
 nNus6Z0Pk73VYsLp37woGmYf5Ury3RY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 242503CF822
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 23:29:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDCCE3CF6E1
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 23:29:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A9011000499
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 23:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763504960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HounzLXzpJS/gCA2ZEhxuhmJg1MHAlkgtbh1voGKzWk=;
 b=PQ50Xg+Sn7yDaZbFSi7o0KbgH/MaX9r0VI8OOChs9etC98nLfcP36MIL5fF3EHnPeWBQtZ
 /lhX1pica3RAK8lLqESi9bQ+5KWOn0q6S6UmLKxGp5X0ct+I3+jnA3fU7klbwZYzclMH+i
 oBEcLDPfPk/PGJ5PUseAszraFZNcuro=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-pGxvVky_MOWFc1Z1ST6BRQ-1; Tue, 18 Nov 2025 17:29:18 -0500
X-MC-Unique: pGxvVky_MOWFc1Z1ST6BRQ-1
X-Mimecast-MFC-AGG-ID: pGxvVky_MOWFc1Z1ST6BRQ_1763504958
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8824b00ee8bso92842466d6.0
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 14:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763504958; x=1764109758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HounzLXzpJS/gCA2ZEhxuhmJg1MHAlkgtbh1voGKzWk=;
 b=VdYwilCLBy0uzFb3JTjLtiV0BzIYC4+b2DkFYuGN2jy3WTGKJUyKx//rouMmL4bc8P
 1YPwdI6SwUb//ssg0aQGY2hCEjOKE1XiMq1XI6c/unMRDyNmyPnYOkaWZttpsoIwo7na
 pgSOQtmgf/HglxBNrAraCTVjhIEKzSEpDD9QuHkd1+QG0/Vm+tAFe+Z1wpYkDUN9KQPD
 ILQO4FJ+Q6vapjiUePqJU+Jh2MHm1i8hG4emaiWYVS44uRd0QowjSBzoXWgXE5s/g1pv
 SH24mr6cn/cxJpy8Z7Q8pMqfJJA+LrVkK05Gn4c5E35Fia4xZbK+HI+RUnlCsLCJJtHq
 +uXQ==
X-Gm-Message-State: AOJu0YwKZaI28jvTtaqHoH3l4ogefNq669vZpD3fE8svZ+axjWCx1hxc
 IiPbAxYe8fOC7qp1DDyL+uJvebZbrUfU5Q7TjJBnCgZdrCmOcmeGwktDMga5NAJfhlgCpvfYQ7Q
 ucsc9P5Mup/8F+d7fJdGkl1ZuoCuDyUDg4MA7jbfwJiRgvrUnVHybyMgHX1ypOsYYoIVKdM5eGB
 BgHfyvJoUfBSASD3R7jV9WKbcQjmVLjhfgS3GF
X-Gm-Gg: ASbGncvzFr4BwrVL03b21Lq1TDWLgCTZCBFSdGq5Xz6NU56nI8E9jmxI7UZ4TZW82Zo
 MDvRVdoHjXrEJTOskufsz2rjdZug3I4E+AoZ0zrslyyXzHIH827HFtThi/FYcy7rOdphT5qyt0R
 N344P6eogYudvgR7NUZuu4HdG0wMkaY1DdqkEdA4xQNwbN66AwUeelAWnDBNIW3TLfwYQYq/scS
 eSdCtxYbXdWVF9fgAxe2azYsAc9JRrIsneORfNNpWKMjVPfJr2pr9BUvYy9k1E829I+kBQrX/Em
 DxOkeI3anCmiVvU/U8sFFRK051nTOv9/XuhOK+PlMbJTuh3prrU8cOcjlls3Q6RbGQM6Ku2pIQa
 NHwsLT9S3bzsZPquPREXNraCcnI5rIXduV264Uw==
X-Received: by 2002:a05:6214:c49:b0:880:54eb:f66d with SMTP id
 6a1803df08f44-88292601607mr274250316d6.30.1763504958129; 
 Tue, 18 Nov 2025 14:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK8TlWkskC/VW+DnGy+cxJ1SRtZhO0f4i/5TUoq5kVJyV4zVDsdr5KCycyJUuZNrpS2GEVPg==
X-Received: by 2002:a05:6214:c49:b0:880:54eb:f66d with SMTP id
 6a1803df08f44-88292601607mr274249376d6.30.1763504957327; 
 Tue, 18 Nov 2025 14:29:17 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([172.56.196.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882862ce5e6sm122465646d6.10.2025.11.18.14.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 14:29:16 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 18 Nov 2025 17:28:51 -0500
Message-ID: <20251118222904.15554-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NGJ10FWz2tt9iFFwJK-SDSQU5l9oIWN6aj5jJPA3SF0_1763504958
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] Add EPERM test for clone and clone3
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
 testcases/kernel/syscalls/clone3/clone304.c | 92 +++++++++++++++++++++
 5 files changed, 170 insertions(+)
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
index 000000000..e0ae9db62
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
+	const char *sflags;
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
+	_exit(0);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE,
+		child_stack), EPERM, "clone(%s) should fail with EPERM",
+		tc->sflags);
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
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{},
+	},
+	.bufs = (struct tst_buffers []) {
+		{&child_stack, .size = CHILD_STACK_SIZE},
+		{},
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
index 000000000..34ce0cf7b
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,92 @@
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
+	const char *sflags;
+	enum case_type type;
+} tcases[] = {
+	{ DESC(CLONE_NEWPID), K_NAMESPACE_ONLY },
+	{ DESC(CLONE_NEWCGROUP), K_NAMESPACE_ONLY },
+	{ DESC(CLONE_NEWIPC), K_NAMESPACE_ONLY },
+	{ DESC(CLONE_NEWNET), K_NAMESPACE_ONLY },
+	{ DESC(CLONE_NEWNS), K_NAMESPACE_ONLY },
+	{ DESC(CLONE_NEWUTS), K_NAMESPACE_ONLY },
+
+	{ DESC(CLONE_NEWPID), K_SET_TID },
+	{ DESC(CLONE_NEWCGROUP), K_SET_TID },
+	{ DESC(CLONE_NEWIPC), K_SET_TID },
+	{ DESC(CLONE_NEWNET), K_SET_TID },
+	{ DESC(CLONE_NEWNS), K_SET_TID },
+	{ DESC(CLONE_NEWUTS), K_SET_TID },
+
+	{ DESC(0), K_SET_TID },
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
+
+	if (tc->flags == 0)
+		TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM,
+			"clone3(%s)\t\t\t set_tid_size=%ld",
+			tc->sflags, args.set_tid_size);
+	else
+		TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM,
+			"clone3(%s)\t set_tid_size=%ld",
+			tc->sflags, args.set_tid_size);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+
+	memset(&args, 0, sizeof(args));
+	SAFE_UNSHARE(CLONE_NEWUSER | CLONE_NEWNS);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = run,
+	.needs_root = 1,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{},
+	},
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(struct clone_args)},
+		{},
+	},
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
