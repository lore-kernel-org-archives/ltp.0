Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887D3CD4F23
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 23:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762989073; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=W12VJ2OpIT430aXAtO7wva8hgwzO5hJMfoysAzx8khA=;
 b=DZ3tgF099PyfdxcQwk7vW2alWmn2Y3KPKupp0J4qLJlz6RV+b3ScW7qkv67vnwfw6kxI1
 byyBZK9I5QAIvyKBVf0/lu6gLc88PBHdAm6dJ/ZG80R5tDD+Ni43qYFKsIJAUkArUtfDiD+
 WS/crREgPbrbnJdyUR7hAzm0BRTjBHM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69A703CF7B3
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 00:11:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88DA33CF6EF
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 00:10:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C99601000A5C
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 00:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762989048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KJMevy3V7DnhwzDRfIpW+vbKz6Kf4oJeKZT+5V7CIPE=;
 b=OfR5gi7xRB/TxM+cFkabmUpUHt3IfIVoQTqd/ZsdV1+lAkkxR72lamWj4f0A0seLEu2oKy
 crCebDLmII6e34VH3fzffJ9V9wmyxOgvj5J0/d3zrs3q6bYm0KaoL5DwrGO6V9iVwrM3RC
 dxdIRTw20WgoIlk2ZPHe4YMr7GYwvhw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-N9rtPs-WMk6VhxnAW0WEYg-1; Wed, 12 Nov 2025 18:10:47 -0500
X-MC-Unique: N9rtPs-WMk6VhxnAW0WEYg-1
X-Mimecast-MFC-AGG-ID: N9rtPs-WMk6VhxnAW0WEYg_1762989047
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2217a9c60so95986585a.3
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762989046; x=1763593846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJMevy3V7DnhwzDRfIpW+vbKz6Kf4oJeKZT+5V7CIPE=;
 b=eJ6WqfC0bZDO649vzJdISmdkZXVeAh7u9owchhD7q6h3d/NF+pVlq8SPNwK0NXp6It
 d7SSPreKUg1dM1aj0j7wCN5NV1G2qUOm0ox2zBrFL27o91fRSKSuHv1EfF7UGQ7FjHJR
 qsU2PR7W65YKMfb2ubM0BxtV1yFPRQ0x0r9bDu2SISiKQ8kbKnQ69ZdFcVj9rcNgEe2W
 P098Lg4pDUxpOy7ORxGoujyF/P4WiaiCGBazPaD7yPSvTcAlfub8+G9ITS2coyifi3v9
 XOC80UAcr2EdGcCDyXGXY6kTs2/rgo1rNHN6NdPNSvh1ztAsMar8osdYdGpx81rMnfEn
 gNWg==
X-Gm-Message-State: AOJu0Yw/WIfmvZvSiEalRzAZtOSM2Rf4gEcffqvPZzc/BYkndWAGTrSD
 tLn0JDSjdRprrC4Yh2z/hLapuvV7q9A+3/K/b+DIcnnEEI8acQwy8OGMhHUay1XCEexkE9B7Gvu
 1QCuRSzSYJ/YVkPBnD/7LVobPKvPWHwHX9MKY3+XexlA9h2MslB9zL8CkvcPlKctdSK/Dcx7ozN
 MT+oUdpI8PHhLyG7KduTavxB2wPdtN1WgSkUZ5
X-Gm-Gg: ASbGncsYXXTBP1CVGmZ39im4xrcUz+OcbDjI0+uIIE1nfQyrvT3+k2eemB5vDJMMAV+
 h2lbFj9jrDD8OGJe9VEtompKTZrOjKejwfrmn3eVlDqVD1m8Cm3hzHCjgLqpv9FL4mLTg4I5b1d
 o7C101jkyBzKOz/bN05ppbFwdkV/t3TQtcyOKit81G9tui29P+oqwL7PZetB9qJb3PldWBco2rr
 qbMbeQ2/bSHj8EAOvArDIEn2PRaB/eqzM0RjXyB06j7z7S6C5AlDJ8RJpy+zjzORThOZZLuTF7k
 z4ShjhxXjDAzYCD2RUsCD+LiLbOLEoNpdcfXGrlYHOPF05lx9EwxQbkCIDFLgO1uFpULTANuUah
 yqhyeZGa3A/1fnqILsYke124u
X-Received: by 2002:a05:620a:370e:b0:890:492:cbc1 with SMTP id
 af79cd13be357-8b29b7fcc99mr623811785a.67.1762989046648; 
 Wed, 12 Nov 2025 15:10:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqnKdUsdPKf1CifQvuHkZSyA5Y4E+rNbT3hzmZl4uP1opLWFuSTzArrpXGZgZhS1MPhxILnQ==
X-Received: by 2002:a05:620a:370e:b0:890:492:cbc1 with SMTP id
 af79cd13be357-8b29b7fcc99mr623808685a.67.1762989046155; 
 Wed, 12 Nov 2025 15:10:46 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([144.121.52.162])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aee9ed4bsm16070685a.10.2025.11.12.15.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 15:10:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 12 Nov 2025 18:10:37 -0500
Message-ID: <20251112231039.659940-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7_bYOaBgxznCL-M1I9izD2AhDxOCbuiVmCtTUHBXt9Y_1762989047
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add EPERM test for clone and clone3
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
 testcases/kernel/syscalls/clone/clone11.c   | 74 +++++++++++++++++++++
 testcases/kernel/syscalls/clone3/.gitignore |  1 +
 testcases/kernel/syscalls/clone3/clone304.c | 65 ++++++++++++++++++
 5 files changed, 143 insertions(+)
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
index 000000000..8e51a6ff7
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,65 @@
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
+static struct clone_args args = {0};
+static pid_t tid_array[4] = {0, 0, 0, 0};
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
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	args.flags = tc->flags;
+
+	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM, "clone3(%s) should fail with EPERM"
+			, tc->sflags);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+
+	memset(&args, 0, sizeof(args));
+	args.set_tid = (uintptr_t)tid_array;
+	/* set_tid_size greater than zero - requires CAP_SYS_ADMIN */
+	args.set_tid_size = 4;
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
