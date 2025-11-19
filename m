Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F152CF58CC
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763578634; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=bfaXSrcQl3BThcC7VPRiv4s9BipZBnBtyB97hZZkE4o=;
 b=N7Vf47V+jvVxb9ROWEKbBcuNLsl9wuzY7V6qNkAAcA+WcDcy40e1/nmwOm6LKmYcJXjgq
 v9wWz1tfkn3eTnSrDhpPS2dJ1zJ9r1n/rMTF+Tzbf8AlskenCriLARGObnyOrHEuOGZTfHD
 t1S20Z1BPZKVoviemo2USdQbVBDfXKY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7BA03CF278
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 19:57:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A56B63CF278
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 19:56:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE074100061F
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 19:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763578610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=elhwERztWPdeJBm9EwGLyCnq8bImTtqE9AjBRJzCAYY=;
 b=bNmQbFexwzwK5gKNUxOutqpvy7Qpwyq/cXBrhdEGXgZmhpDB0We87pcLCA7rFE+szOqstV
 Okjd6Oh5TOSHWNlbLk30W5s3cFlVQLrFq83v9Q2AxLqlgYWqTbgUBVbpT4EHO2lozzx6gX
 5IVUdD9uICO2QWEn3SF9vInAcSKDHxU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-QWVtKBnTPcOPR3VfWWUAKA-1; Wed, 19 Nov 2025 13:56:48 -0500
X-MC-Unique: QWVtKBnTPcOPR3VfWWUAKA-1
X-Mimecast-MFC-AGG-ID: QWVtKBnTPcOPR3VfWWUAKA_1763578608
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88234e4a694so2774986d6.3
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 10:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763578607; x=1764183407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elhwERztWPdeJBm9EwGLyCnq8bImTtqE9AjBRJzCAYY=;
 b=c/rIVhLGTgV8/9QHBuRH/o9orWXRABuCqfVH7uCDM5MOvIOUbnjmdCCNuaNgINk3Rr
 1RbJglezq7I6pZTvuSrwWxaS4DUhCwOU1pevWpZwCI0gqKbp9T9novgS0gBee7PjKAEW
 /dXLKkpcWnN7hgPotzXOVSeNeuVk6SpnBpmQyGET05EEdN01vszYqKoLZ/68hdWMCDki
 4sGJoLwjHBKOQNV+WN5Fe8rx2gsnDA/ZZzNubyu2qg9xIqerG5kHBfSo2jkYemuj8igP
 F0BfcxVZo3VB0JPSJ9G+MF076p657hcsv8VYN+ZQQdEXKoPUlbsfTrvUPFrsh9KK3Eyw
 SHRQ==
X-Gm-Message-State: AOJu0Yx4GCo28SW/NwdtsUj+5MjRQ7WGfZrICOmogLEAk+V1eyyZKUw5
 TziBsFxNPgT8Y9VE9g8DpzDaJEj64YGq+pDwmurK28As08Uq0sETE39E09+KAlo+MbYitqV9vnI
 yzxhg7P/piIgXwN7P6HYvpq2hhhQ0+hNMcEt8EsW6/adUKGLuo5Emxrx6nhOu9zGWl3VojkyYi6
 VU13dZh3Gy7+5DpaZlYq0DUPxaW32cmEXNkiVM
X-Gm-Gg: ASbGncta96tQc5dC13sSZklQNh40+BCiO87uaQYKTRQRbS2xEXg0MAIIBso7im9d7iM
 0WMJlYGgvdPqS8blW0PDmDjbkQO8TrmNt4hLA6fOB8yvRz8jBwZL8ztWLolQvWYkxnYhtJ5CAF1
 Q9yL7ZFm/M0I6/BsZLhGOtyZz5VWEadQKvtzh093YlnrVg+3gUJt7h3FZer/H7zTsZMUUtCQ5vq
 aoMu4hJpQp5LRu3Ei/SGJcbiAxVG0DOtMVl4Tw9g5IBA0v9HmVXAZ46bmS9Cetm8Ck4Kzu1quNZ
 OKaqLO0Jzhg8ie8rUcMsMa1UrQ5kFM3jMAP8p6gtP7DRxA5OETFut+0kTtLvwNPNpvT1EqC6tg8
 zjT6CF8QACuubVDL1oHt/QcfAx3GKlVHcuz1LEg==
X-Received: by 2002:a05:6214:4991:b0:882:4cc4:15b with SMTP id
 6a1803df08f44-8846e00f7c8mr4033216d6.17.1763578607613; 
 Wed, 19 Nov 2025 10:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUM6yDBCFpwErwYmF+2CLqaV1mUAxuYbQMaX4jDWkNjaLWtzNTWuBFDFAdrFiaxb7Uq3kvWA==
X-Received: by 2002:a05:6214:4991:b0:882:4cc4:15b with SMTP id
 6a1803df08f44-8846e00f7c8mr4032756d6.17.1763578607199; 
 Wed, 19 Nov 2025 10:56:47 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([172.56.196.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e54c32csm906326d6.37.2025.11.19.10.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 10:56:46 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 19 Nov 2025 13:56:40 -0500
Message-ID: <20251119185642.80816-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xoBNIuOlitKsmz0AmdYy0UQWHEeS1aRcVw6rDrm1zfY_1763578608
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] Add EPERM test for clone and clone3
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
 testcases/kernel/syscalls/clone/clone11.c   | 74 ++++++++++++++++++
 testcases/kernel/syscalls/clone3/.gitignore |  1 +
 testcases/kernel/syscalls/clone3/clone304.c | 87 +++++++++++++++++++++
 5 files changed, 165 insertions(+)
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
index 000000000..a53e5fdca
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,87 @@
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
+	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM,
+		"clone3(%s) set_tid_size=%ld",
+		tc->sflags, args.set_tid_size);
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
