Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A774DCD342F
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762970630; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=EsoXVwKNNKbJvQ0VYlxejy3Z0o8XEW/N2/EvLIwcgOY=;
 b=TA3hKGqZRlSxW1xR73vXB7v+49wAuidl3uV5vl/uvbhbRABBb+4lXB6yKTcZCtLiv/hJy
 K6D6182GrKoGh1jscmEJYqR81OsbD16YjuZwqXRXuR31OgwZADOn4puU5OJiYginNZjINEP
 IRheKOe+kwx2UFjSuqguDifqtTCepJo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 999943CF7D0
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 19:03:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C4FE3CF759
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 19:03:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C48D7600971
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 19:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762970607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wywNendLO+CLQ24WpTgF0VWnB6+dGQpKOnQYOdCQyMY=;
 b=BfBHX3rV02SMt3fVEnwogeICP2n7AMLJBuftF/KDQelNvMTEyYTj1yRh1OYb3i4VZKXBvM
 JFAfBsBo5tN4xaFwjyy3PIJSx7sdz7rlHd1WcFiYboVT5x9/wSuFv3N+quetc3IoF2R4WB
 H9CdTI1ep/JN/f+/ncBowqqHHT6+nLs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-2JKqAi-lMleo2fvgPDr1xA-1; Wed, 12 Nov 2025 13:03:26 -0500
X-MC-Unique: 2JKqAi-lMleo2fvgPDr1xA-1
X-Mimecast-MFC-AGG-ID: 2JKqAi-lMleo2fvgPDr1xA_1762970604
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8823f4666abso27661996d6.0
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 10:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762970604; x=1763575404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wywNendLO+CLQ24WpTgF0VWnB6+dGQpKOnQYOdCQyMY=;
 b=XKIKgWN0rfS/LOhTTggAwcnXk2BCrp7E046mX/u9cDZz7WHasWuf1hmWDmRQVvS/rI
 vTGeiC09+VS2PgXq25l6J/0yD16PbHOmKJ3OkXbWTNWHBZvLujCvh9KXCNaGPV4u/OMM
 tJHRioLzXs5Bb4jBqAJUZ7dMsAclHNzNrkPs1fkWtcD0gAVwpkDrtxZQxWRqf4e8O9NB
 tN7zFvZDdfAzQLAg5H/S5E8u+vUsJLY1Kyui29HsIbNj2aSjajVUvohDk8TfbrGmOSdq
 5NTDSMz/dVGbyTBEhQkXCtw7np8zf5lUcVFIsZzDk4vPv/rfcyv97Q5GBUj2N4YXKKnK
 CvTw==
X-Gm-Message-State: AOJu0YxISRckG/vJCkjXzT3nfZ4oxSTyJLCy2L9vdall2XUiE6CHAWdh
 64mbFqo0ULQ1l3HowvxcgykF23rknPBfzDSRns9O+CHWbMejV6yBG08+DAo9jVSRCB67hRVwAuc
 UinCfZ0P8Pf3lDBlTytpy/GQF8EJk4KeUgMxvSTq1+W+R573FMlXOGTVzlAZxI4u8DsJyQhxUX+
 sDZEx23D+UDOrmZ2swE+saExmBBdFpEcx34yH1
X-Gm-Gg: ASbGncvNhEuqiLbgWqElfILTVgjMu/nO1h5PzH7G9O8cSjIqZMOSoBjANI93WXE70cE
 P+Pz5WT3quTG9jRER+4nplJ7QUuTZeKJya4DMfE3wOVmJJ56N9wFOqVGtv4uTDZoL0vLYwgqSSg
 xmVkBZYojBebyoEN1sepV5biwBrqSyCdfBzUAKM2ONSSTZS2qJfPtbB2PtWk2bSuhD9z97lrj9O
 U/ez00E56/CYORR0IsP9IAGj90Xh+E5X5AT72t83vvHVOeb8YwP481zUcUKB84Qrrs0YJM0Ufaq
 INSM+zuGs+FQ6xT/OYXCNC9rsdB3A2R/Eg1LHSu/G1WALKMhHylzVHSZCvP4Ap7jPwEI7cZ1/h9
 WkFEVIgDaME8n2XfClY7lnosw
X-Received: by 2002:a05:6214:48c:b0:882:4a63:63a7 with SMTP id
 6a1803df08f44-88271a4232bmr60887586d6.60.1762970604072; 
 Wed, 12 Nov 2025 10:03:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEovIE+jh3bpmXNXmfiYpH6lysmIAbBew764KRwaAucogi4TyCSDQlLVA2CRma3KtZf6/TNvg==
X-Received: by 2002:a05:6214:48c:b0:882:4a63:63a7 with SMTP id
 6a1803df08f44-88271a4232bmr60886676d6.60.1762970603407; 
 Wed, 12 Nov 2025 10:03:23 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([144.121.52.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88238929ae1sm95561736d6.3.2025.11.12.10.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:03:23 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 12 Nov 2025 13:03:18 -0500
Message-ID: <20251112180319.630584-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MU30wgpEkKpyGGMMeG0lolcEJOyzAgGCgIcu7GVArN0_1762970604
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add new tests for clone and clone3
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
 testcases/kernel/syscalls/clone/clone11.c   | 72 +++++++++++++++++++++
 testcases/kernel/syscalls/clone3/.gitignore |  1 +
 testcases/kernel/syscalls/clone3/clone304.c | 63 ++++++++++++++++++
 5 files changed, 139 insertions(+)
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
index 000000000..dd26c1594
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone11.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
+ */
+
+/*\
+ * This test verifies that clone() fals with EPERM when CAP_SYS_ADMIN
+ * has been dropped.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "clone_platform.h"
+
+static void *child_stack;
+static int *child_pid;
+
+static struct tcase {
+	uint64_t flags;
+	char *sflags;
+} tcases[] = {
+	{CLONE_NEWPID, "CLONE_NEWPID"},
+	{CLONE_NEWCGROUP, "CLONE_NEWCGROUP"},
+	{CLONE_NEWIPC, "CLONE_NEWIPC"},
+	{CLONE_NEWNET, "CLONE_NEWNET"},
+	{CLONE_NEWNS, "CLONE_NEWNS"},
+	{CLONE_NEWUTS, "CLONE_NEWUTS"},
+};
+
+static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+		*child_pid = getpid();
+		exit(0);
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
index 000000000..e47ab313e
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
+ */
+
+/*\
+ * This test verifies that clone3() fals with EPERM when CAP_SYS_ADMIN
+ * has been dropped and ``clone_args.set_tid_size`` is greater than zero.
+ */
+
+#define _GNU_SOURCE
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
+	{CLONE_NEWPID, "CLONE_NEWPID"},
+	{CLONE_NEWCGROUP, "CLONE_NEWCGROUP"},
+	{CLONE_NEWIPC, "CLONE_NEWIPC"},
+	{CLONE_NEWNET, "CLONE_NEWNET"},
+	{CLONE_NEWNS, "CLONE_NEWNS"},
+	{CLONE_NEWUTS, "CLONE_NEWUTS"},
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
