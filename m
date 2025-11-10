Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD23FCCFA13
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762814928; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=T670AaPnjjrffzmKtXfqi8o6kNeB4jq+ClOaDr7czhI=;
 b=D6nXR2JIiJYCbewztefAQpzoJvj3uI9WGQzQqhtxUXNbqVgVVJhIqzX6ZEH60M7R1019o
 HL71LSLPpjTklCLshc/fl3r7rFC9Kc/HyF0xmkFzWAO6X4fT7Lf+8qvT43Vm+9bNPBF4M1V
 fqX+ZqPAt6i1CzSFy1lomol0yrAdWBo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3CF73CF62A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 23:48:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEEE53CF5EF
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 23:48:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C170A600858
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 23:48:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762814905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yQ21i+agxGT1Pz5HRB6u4SIRvE+NoLxTYk9lUs+wFMc=;
 b=EgLSukEh3ri9jPGWVCSvpANWdMoKFcLFRQs3Q3GWLvfDa6U+/7vaGXrzvMdTDFGVVP3JiV
 UUkUlIHF6tmt3BwlEKiOGm8baVsMrlhNwSgjPE8bjDBdbii+o2XhNcZFTgNoQXpWk/uuss
 vveV8J57gqn2FrliD11beDojc/lbLEY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-R1C2fbHKMKusWsUQF20lGQ-1; Mon, 10 Nov 2025 17:48:24 -0500
X-MC-Unique: R1C2fbHKMKusWsUQF20lGQ-1
X-Mimecast-MFC-AGG-ID: R1C2fbHKMKusWsUQF20lGQ_1762814904
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b259f0da04so249663585a.0
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 14:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762814904; x=1763419704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ21i+agxGT1Pz5HRB6u4SIRvE+NoLxTYk9lUs+wFMc=;
 b=W3CaP6gwmHrvlp1kbL1i0v94DhD1IooRGy5w5aq+zHpJhkTTf6UrtgEc6Fu5VVLfXD
 5znuEp4+08i7BTCplEGKKbR37UO02QSGAKQ4LxWdTqoCNi8iWuJ3oLrs5/rfZGpjGa+3
 1VSDiQM6h0HHFa4HVOsYkCwliJFhc/+1ovS5xxgnBZxng9zG1KtEKR31nEOBIa+2fr1B
 zRhOlIy+AecXYcUnfaRlUNmJ/shjjNXULTAkV+uYKQatKD8zv38tfVT4A0Po3HJ7H3b4
 9Es3PtRqOxpkGrdWgu8Fkpz2qdgTDYN/8QI5AQaBh2cPqy6Pl6B98kjkKOq/BPawfCji
 Wb4Q==
X-Gm-Message-State: AOJu0YxTKRHy9XIb78SJzM1+ihpebqHsSIwFxGzUKemv5uHF70DkH610
 U4vwCcu3YgTrnjC/ohK0zX9qVbLG1ejwECz2R951Frolnjp6zt51iX9zm7bukBJhLkjNrt59F8i
 7x04IPnoAGrPn3hum2VqCNI3O1l2i6WJcFm/YI52bsXTEb7jkYmTNiuYZ+80DCtaK36JV2Xnsht
 1s5Mg7HR97zEn7E1nKmrzjCKn5gS29ax4mGN4R
X-Gm-Gg: ASbGnct6S003x+NjfQNmmkhTZkJhvrk4TubhI0qC42cwn2oGNLB2dgDqarB8K2ia/bF
 +M8wN5e0QOrIMMDz54zXnf9BbcsxiJkwQao8ZG1t/q/DQcUc7MwFW9B6xqIQEgZb0FG6nHGI83b
 8ZciteFocjtoNoN9ZafyZWKH+3sx87xlUPdR7E5WjDPalL5eSNfUEC477NSswqizzpx5rCC8QmQ
 CrMviJQUxFcwzDp/ciPw0ZuQjCsDBp0o/YuqvGdRxdQ8uSo0xPAhAd4oFKlQKyeu44MtZydHoH7
 8Vg2p/a5MoiNlx//fAtFlEiMlDGGkXL8BAVDOwDKVUzWqiD7GIse/l9azgBVcaDPL6ejeMRFhVJ
 ljXSvlOEWWTDLTKAqEuQH+dMUIRg=
X-Received: by 2002:a05:620a:407:b0:8ab:5cb2:1f68 with SMTP id
 af79cd13be357-8b257f6d6ccmr848615385a.69.1762814903776; 
 Mon, 10 Nov 2025 14:48:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmlwg48YIwHMcBRAuzcfjTP4mobwF84Ww/D+ejtt9ktnRLZls5Z9PCthUCwyyGUT5Gtxelbg==
X-Received: by 2002:a05:620a:407:b0:8ab:5cb2:1f68 with SMTP id
 af79cd13be357-8b257f6d6ccmr848612485a.69.1762814903098; 
 Mon, 10 Nov 2025 14:48:23 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([172.56.199.92])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2732b0b3fsm384033985a.0.2025.11.10.14.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 14:48:22 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 17:48:11 -0500
Message-ID: <20251110224813.431590-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uga_Ca23uUwku6i0VU0cPmI08VICw9DnW5f95dZGkS4_1762814904
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Confirming EPERM is returned when CAP_SYS_ADMIN is
 removed from clone3. Signed-off-by: Stephen Bertram <sbertram@redhat.com>
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

---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/clone3/.gitignore |  1 +
 testcases/kernel/syscalls/clone3/clone304.c | 70 +++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone3/clone304.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 54d94c0ca..b2c4f338e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -128,6 +128,7 @@ clone10 clone10
 clone301 clone301
 clone302 clone302
 clone303 clone303
++clone304 clone304
 
 close01 close01
 close02 close02
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
index 000000000..8968b0144
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Stephen Bertram <sbertram@redhat.com>
+ */
+
+/*
+ * Test for clone3() EPERM error when set_tid_size > 0 without CAP_SYS_ADMIN
+ *
+ * This test verifies that clone3() returns EPERM when:
+ * - set_tid_size is greater than zero
+ * - The caller lacks the CAP_SYS_ADMIN capability in one or more of the
+ *   user namespaces that own the corresponding PID namespaces.
+ *
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/sched.h"
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
+	struct clone_args args = {0};
+	pid_t tid_array[4] = {0, 0, 0, 0};
+	pid_t pid;
+
+	args.flags = tc->flags;
+	args.pidfd = 0;
+	args.child_tid = 0;
+	args.parent_tid = 0;
+	args.exit_signal = 0;
+	args.stack = 0;
+	args.stack_size = 0;
+	args.tls = 0;
+	args.set_tid = (uint64_t)(uintptr_t)tid_array;
+	args.set_tid_size = 4;  // Greater than zero - requires CAP_SYS_ADMIN
+
+	errno = 0;
+	TEST(pid = clone3(&args, sizeof(args)));
+
+	if (pid > 0)
+		tst_res(TFAIL | TTERRNO, "clone3(%s) worked and it shouldn't", tc->sflags);
+	else
+		if (errno != EPERM)
+			tst_res(TFAIL | TTERRNO, "clone3(%s) expected EPERM.", tc->sflags);
+		else
+			tst_res(TPASS | TTERRNO, "clone3(%s) failed as expected", tc->sflags);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.needs_root = 1,
+	.caps = (struct tst_cap []) {
+				TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+				{}
+	},
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
