Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFABCCFA18
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762875324; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=9ZS1fJul6vpjd4vf07RdwCjOmWAcNGD5sSJZ9MhcDwo=;
 b=eCxwwBTXvMfQH50NoY6T6S6onlUcdZO5orcxLpCtsSxZBel274LYgHuxxOqcb/db1V/XI
 Al1orsQ/GDQ4Z4eIkOwC0a7bY37OYi3UnD9vMoqB+3I6gHj5h+daI1nPvlk0qFqR387dWbY
 y070pIO3Pi09MGedv424DaDZdp7mIew=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8EB03CF681
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 16:35:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C82B3CF647
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 16:35:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCC536009A4
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 16:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762875301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JAJtOE6lsKy4qYt/BieN7VhwgoYLcw9upIHcFrFzB5o=;
 b=ZeqSAkwVIoZOYE/eYWIueTf5NiRjCiBTqnOC4Qd6xB3jIlFKprSmxqx7jNXGy4BlhKEMFn
 YElCieKPeMTtTPoSyyhIs8DTlV2ClCJV5x4sD2VPaR4mvUwzNrQaM5LRoC8VJlrgzWNbRb
 I8qnUOZy8nEI7QP2zXmPFGpaDkZMDDw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Q4ECZf0QNMiMwuRso3IW6A-1; Tue, 11 Nov 2025 10:34:59 -0500
X-MC-Unique: Q4ECZf0QNMiMwuRso3IW6A-1
X-Mimecast-MFC-AGG-ID: Q4ECZf0QNMiMwuRso3IW6A_1762875299
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4edb31eed49so61415631cf.2
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 07:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762875299; x=1763480099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAJtOE6lsKy4qYt/BieN7VhwgoYLcw9upIHcFrFzB5o=;
 b=Cj+iqgefFyTv45PBGSw66LYu+sIWHegbgkBmZnES1Zpo9y+aH/rtdP05kS7OFOFLA1
 LbS10nM2F6i/hWinac3vkg/SCiwtPsFPSTJyNyAmpqZERxIqnDi8f7jvHz3vwQIf2jGT
 yf2hTNe0c/0F22sJGxX9XxrlwLeG5+p95UN5Uey+xMu0PL7S2t7ipVCcseYkGxVdtF+9
 uaR5lxjTxRwxTP/AMYJKE1ssk7ICtm99gAYgkJAfzKoM/PIJNwKvMvM03Oq74IIwEd0C
 lHUm+e6XOIScw1iIxpUGQIKEsfqRv4tX4ezHXpdmcbqQze2VG+wt9e9VOIaABrTGFBVl
 b8/A==
X-Gm-Message-State: AOJu0Yy/oEr5LyxQcV7EXTgx4yNPiGxpuYbjW3lmXqcra1Kp/1pcIfPh
 uk12Iv8ajUjGfpaywlMykYQyeqJyGymXAAGoERV2I4wo/5kKul3bZYJcRs0gqPlt4U0Xvc1FoNe
 4SL+bVkAx9eiwhX8fBgRJTLPPx73jmZ010aJtArZcsqTgZOUtHCVMvq54icBdr4WeQ4rjSr27gR
 FYQTrDADr23iTcXaig5TxDvHb9FgcB/HJ0ZjH7
X-Gm-Gg: ASbGncuIVslxqLf87DJMGnxx1kfBFjepr9n+xGGzlKorJAcFwio467/0yCNaEQi7Gyi
 SKKlOrc4Z//PSIj5gMWEjE9IpRQsKeCHt8smLjJMTEa4hWNkx7TfFGw8z/jefY2BiWH06z9tuwU
 s1S1xAF97ge/gkfS82lAZkS7eJ0WOyFNgLUpDF2YkVDcnd8sjxM+7ZB907vmpE7qaQOwTXuXshN
 UfJSfYVXq1s+HhZzTapyd14vg79ZFRUDiTCALo6iwizj2tk/tE5gAuDXOCCXRwQ92fPvgk2YvdS
 2PvZDQjKjtDsiHnvolNA2ZPTHhahPQQXpgwJLK6LjgyT0ngb8uVGtRtUyLkH8MvKtag/rfjnnJC
 KdpO8bxsH1jmwKz3bR+DyGrmy
X-Received: by 2002:a05:622a:1390:b0:4ed:6169:c335 with SMTP id
 d75a77b69052e-4eda4f7f0damr164447921cf.40.1762875299018; 
 Tue, 11 Nov 2025 07:34:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxhBb9K+YAUU91sZ8rhx7fvt7rfU/ulTT54DG9/O68IaLg1JzXJBXj0EJMj0F92ek8ExtlTQ==
X-Received: by 2002:a05:622a:1390:b0:4ed:6169:c335 with SMTP id
 d75a77b69052e-4eda4f7f0damr164447501cf.40.1762875298594; 
 Tue, 11 Nov 2025 07:34:58 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([144.121.52.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88238b742f0sm72777236d6.43.2025.11.11.07.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 07:34:58 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 11 Nov 2025 10:34:51 -0500
Message-ID: <20251111153453.547195-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L-gy-XzJj862J8Da7_lE1Y_vmEpoAAOiRAyWpum5eRs_1762875299
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Confirming EPERM is returned when CAP_SYS_ADMIN is
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
 testcases/kernel/syscalls/clone3/clone304.c | 63 +++++++++++++++++++++
 3 files changed, 65 insertions(+)
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
index 000000000..8d0d85bd4
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
+struct clone_args args = {0};
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
+	pid_t tid_array[4] = {0, 0, 0, 0};
+
+	args.flags = tc->flags;
+	args.set_tid = (uint64_t)(uintptr_t)tid_array;
+
+	TST_EXP_FAIL(clone3(&args, sizeof(args)), EPERM, "clone3(%s) should fail with EPERM",tc->sflags);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+
+	args.pidfd = 0;
+	args.child_tid = 0;
+	args.parent_tid = 0;
+	args.exit_signal = 0;
+	args.stack = 0;
+	args.stack_size = 0;
+	args.tls = 0;
+	args.set_tid_size = 4;  // Greater than zero - requires CAP_SYS_ADMIN
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
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
