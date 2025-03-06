Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3247FC19F32
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 02:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741227788; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=k3JleMP2h07mGPPNSFda180TXj/5Ol/V3a0IIMApvQ4=;
 b=N/ZGlxQDn9QzNWyzImwVhSGv74v8Tg7dPrf3I0KuRXSwvgdnpRDMI4uh40hmvp5Poycf/
 /K3EL8kt//mjPAh/AFA93E0TO847iPWQN5sgoIMxP+/ILBDVlDIuowvIx6IDlmLojgVgIPZ
 xq1lq5SsSA+LnLwEXUweBObd3ASPAfA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1726E3CA0DB
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 03:23:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79AA83C72E9
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 03:22:47 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 152141A000F1
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 03:22:45 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso114471f8f.3
 for <ltp@lists.linux.it>; Wed, 05 Mar 2025 18:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741227765; x=1741832565; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deTLYTqAi7YVXnQV1C1BJMz5Y8klfR8v6RMM22kVFwM=;
 b=fdm2dfhWYoCDevD/40R7EGRLcjzn21mGnNw4vnpE25CNUXCAh+IMheY4LCDE8LHR3B
 7VUN+vxVxQgsqK3NHWJ2xxpqw4bUD7dQXJ+8dX7Nsm8QdYb6C+dvs5cAp8IFGTJOzajw
 rG+ck+WE16p1zafovN9sRurTwZw/g8VQvZjl0E9eaWXKJKJgtheJlBwoao+Or+FIL2qD
 TcfGnZZwD4dsg7mCQSvEPv2bbBHf+mRUvNnzO6fUfJcNOFYREWnypp1i9dg83+tY3OiE
 jXivILlgql8cj80gxHV301vZ6xHghWrTHgy1V0EKnlO43yt/kMpjmdLg33ua5W/JPRzn
 N0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741227765; x=1741832565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=deTLYTqAi7YVXnQV1C1BJMz5Y8klfR8v6RMM22kVFwM=;
 b=Sb3+zeBbMR2+e3aGXaCuAV8bHzA1oIPF8qRyz/qTKmdnvULTLrFHvH+r+Z4+Gfh4wS
 /g4bD+5JYoBQ+ZErmb43KEWbGbVv9tj2V7ClSaFJx+hWno/m5ZbJXZvlQiAm/3+P7Uyq
 nvEJmWCNdUfqvycJgdE4RpJnDW9Di9HCTivQoYHCf0Ow2Cg3oLjSH0B7/ad+8XkZvYcn
 RhtZfrqRvdClVLnDhy/uOXXtYtaa37AYn+yVrsq/geQnwQK3kRxER1hvFHCRpVHSgd/Y
 qWoLAacKKQ2Yu/TOkn7Rizj9amoB1QCe1U6YjBgBIKP+0fdnz5hyrSu6PurEWGTx0hT3
 AJZA==
X-Gm-Message-State: AOJu0Yzi8AM7vmk2IlInKX+FlxjoYiHejBTTHckKPO40jYRgYb9RdCEO
 1ue6Qbe8QXXrEjtWjBwf15Fmz5wzjeHjCr++w/vbEQaTBNRdZz3oYY8OirPLq7viaJ9AW8TAVWa
 Evw==
X-Gm-Gg: ASbGncu/U/eoh8Ns2FkiYXun/kmHFE8L4tBfjtNLmWtfx+hGjok3TM6C6bXrZF4PgDO
 JNZTB2w7uhHbwIY19egOc8PuJ9WAom9MzrT/vfW2wNDK/T8XWnZ7gsH6KeQP+E76TblY7NatuJt
 +lpfKaW8Ii7gcwd/wkkQlVpychaPXDERKEQ7/DGaXYNOBv6NE5EAvJCxMIUXBHkShevOLJ+WN9w
 3HJl+KLsVo3k8J5zHunrFhj/o4CDTiBFzfXQKHK7mvFJB8u1Pu6kVrTXJUi27kR5tWHVZ//IMJk
 viQ0tVl/UeuAkA3knwLE0K4JuDfpYkZRz5ncsn6yVj4H
X-Google-Smtp-Source: AGHT+IGiEgrw7GSk1Bvncp4g549BMVt0hN7bJuzGjt5PvAjguULfg+QhVr/xX/W2zcQ38Mzfs9zG/A==
X-Received: by 2002:a5d:648c:0:b0:38e:d026:820 with SMTP id
 ffacd0b85a97d-3911f740634mr6204472f8f.16.1741227764784; 
 Wed, 05 Mar 2025 18:22:44 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93ca93sm4385075e9.32.2025.03.05.18.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 18:22:44 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 21:22:39 -0500
Message-Id: <20250306022239.4363-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250304040601.23920-1-wegao@suse.com>
References: <20250304040601.23920-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test case based on kernel self-test unshare_test.c to check that
the kernel handles the EMFILE error when a parent process changes file
descriptor limits and the child process tries to unshare (CLONE_FILES).

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/unshare/.gitignore  |  1 +
 testcases/kernel/syscalls/unshare/unshare03.c | 74 +++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 testcases/kernel/syscalls/unshare/unshare03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..10800c1a3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1715,6 +1715,7 @@ unlinkat01 unlinkat01
 
 unshare01 unshare01
 unshare02 unshare02
+unshare03 unshare03
 
 #
 # These tests require an unmounted block device
diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
index 855ffd055..e5b5c261d 100644
--- a/testcases/kernel/syscalls/unshare/.gitignore
+++ b/testcases/kernel/syscalls/unshare/.gitignore
@@ -1,2 +1,3 @@
 /unshare01
 /unshare02
+/unshare03
diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
new file mode 100644
index 000000000..7298cdebe
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Al Viro <viro@zeniv.linux.org.uk>
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test case based on kernel self-test unshare_test.c to check that
+ * the kernel handles the EMFILE error when a parent process changes file
+ * descriptor limits and the child process tries to unshare (CLONE_FILES).
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "config.h"
+#include "lapi/sched.h"
+
+#define FS_NR_OPEN "/proc/sys/fs/nr_open"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	int nr_open;
+	struct rlimit rlimit;
+	struct tst_clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
+	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
+
+	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
+
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
+
+	rlimit.rlim_cur = nr_open + 1024;
+	rlimit.rlim_max = nr_open + 1024;
+
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
+	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
+		nr_open + 1024);
+
+	SAFE_DUP2(2, nr_open + 64);
+
+	if (!SAFE_CLONE(&args)) {
+		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
+		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
+		exit(0);
+	}
+
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
+	.save_restore = (const struct tst_path_val[]) {
+		{FS_NR_OPEN, NULL, TST_SR_TCONF},
+		{}
+	},
+};
+
+#else
+TST_TEST_TCONF("unshare syscall is undefined.");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
