Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA1C02198
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 02:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739757894; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=zMcUY0PteKeJkffPCTXDPCF4A6XMy0GgLmBVXkPzWpQ=;
 b=elDxPZditCt4Uumh3fTz4LldUXLtfPMQj6rGeAelan8fLMXCU1fEGpiLUCRIWtkWmYJyY
 1To7B/ieLZM2ZxOe/0Pi1ShQlbois2i59yCor/qgAN5pgglgKl5QHehVhgisjIjpIx7AbYV
 QZ/P9ts2mx4kXoMGvyQVAop2BbwZ5Xc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2195F3C9B8C
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 03:04:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 404E53C92B5
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 03:04:31 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E708463007A
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 03:04:30 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43932b9b09aso41439605e9.3
 for <ltp@lists.linux.it>; Sun, 16 Feb 2025 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739757870; x=1740362670; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=punHMebLZrJWM7DcVt2qJ76o6+9z1ETzEX2eHRGZV4k=;
 b=b5vYKKdNwvLEc+uFfa+HDFhBDk68SXI1bWtVTCWRQO02OniEV2SkcI9z/PdYKwMKhV
 GnWdMbAvDMfXqaeonQSBlQW4+Gn2yMc3VcozIB22VkAoKgqAReGJ2asjqEyvrtyiTiPI
 sVJs7gmP0u/xg7XOdT625cPhzUN2T1RBwb1EEgvIIMknpsZtpWgeH7bs3Hu9JyNUD454
 GBWNCGRBBf/0mKEsIS41pGK6n7hcYx78Xx0h3yzsZR6HAJPT1XSn6Y/p24HdAAhv6k2z
 oZEFIwbb5JEcZQBt9bkJvqWKf3vX9VctxKi2T7fNyXPGIZtrPfRZtITRw5cOfOGTpVoO
 liPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739757870; x=1740362670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=punHMebLZrJWM7DcVt2qJ76o6+9z1ETzEX2eHRGZV4k=;
 b=g3MXIFOze9v1CnNc61zmCpWIL3ObcNl6r7deZMLxRfRMxHULiDIj9/gNbx/C8MZEW1
 Flk6VV/ewBWe7pBWFNbH6go/X49tnTTTmfjo7/xBXypjfd3D4d0TuLhEI9qIGukcpu9v
 BfJ+Gb/XyjCP+3ZExWWb5zV+bFwdE3lb8sWEgSIXNjeueNBoAFICHh+KuSbiRxh/mqni
 ulX+RPIXHedlIam2N8KHmnSFiYzERr0ycRuUvZOPVZAqDH40+ubZZy+OKzfAWhVvfcAT
 d98nzEDzg7SOdyoGTrqQeUR1P9P06eQHRfjdK1rIU1xSw5A3SNaCWrUiBcdn9kbcvV3k
 1wgA==
X-Gm-Message-State: AOJu0YwQ8l6VX+e7sKRjA1HhM7SmdK0w8iMd6xbgEga3BZHrFnNCWKor
 7io71rWyJBxLcpXjOyIRPE/6Et+ml+T1MK7KhdD9uUcdimSjCGApXFRLKKKPNMmBAtXJOJXXfCI
 =
X-Gm-Gg: ASbGnct69U/nkWH+j02SWcs7ktn3VxMZJBKmyzT66KPjekQhYpe3Atpf/IEsE2aHQ6u
 UkdHUYFWblWyxoqoqXfRSjxZIWeLvnmfIx8mRgY45AX4eJ3x5lKAjHBvn6McH2qpUwrmVCDH/Eq
 3vY5IPHhlAyT+yhXKgVifdJJVjD/4jpWKxfEqCwIkGdyPsjfKIfixiY1e7pQhonYY/X65pIaUgl
 eW17W3PU0DILy68BQ4nMPQQoPl0TbDBjGlYe+7uIUzANWAQEEA0/5vyztIgZ2KRCJ1/kZmXzm8W
 5Rc7
X-Google-Smtp-Source: AGHT+IHvazVPEglB+7VlQJBQgagxIVxLuWqvZCCCv9Uv+clxxGb6CCtildjSehGOZGHWA+wVn95Rcw==
X-Received: by 2002:a05:600c:154c:b0:439:89d1:30dc with SMTP id
 5b1f17b1804b1-43989d1328bmr1902565e9.10.1739757869685; 
 Sun, 16 Feb 2025 18:04:29 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961e07252sm105469445e9.14.2025.02.16.18.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 18:04:29 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun, 16 Feb 2025 21:04:23 -0500
Message-Id: <20250217020423.31602-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mount_setattr02.c: Check mount_setattr
 attr.propagation
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/mount_setattr/.gitignore  |   1 +
 .../syscalls/mount_setattr/mount_setattr02.c  | 102 ++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4ab8436d3..b856027df 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -856,6 +856,7 @@ mount06 mount06
 mount07 mount07
 
 mount_setattr01 mount_setattr01
+mount_setattr02 mount_setattr02
 
 move_mount01 move_mount01
 move_mount02 move_mount02
diff --git a/testcases/kernel/syscalls/mount_setattr/.gitignore b/testcases/kernel/syscalls/mount_setattr/.gitignore
index 52a77b9ca..1654f27de 100644
--- a/testcases/kernel/syscalls/mount_setattr/.gitignore
+++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
@@ -1 +1,2 @@
 /mount_setattr01
+/mount_setattr02
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
new file mode 100644
index 000000000..c7c5b3e74
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic mount_setattr() test.
+ * Test basic propagation mount attributes are set correctly.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/statvfs.h>
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
+
+#define DIRA "/DIRA_PROPAGATION_CHECK"
+
+static bool is_shared_mount(const char *path)
+{
+	FILE *file = SAFE_FOPEN("/proc/self/mountinfo", "r");
+
+	char line[PATH_MAX];
+	bool found = false;
+
+	while (fgets(line, sizeof(line), file)) {
+		char mntpoint[PATH_MAX];
+		char opts[256];
+
+		if (sscanf(line, "%*d %*d %*d:%*d %*s %255s %*s %255s",
+					mntpoint, opts) != 2)
+			continue;
+
+		if (strcmp(mntpoint, path) != 0)
+			continue;
+
+		if (strstr(opts, "shared:") != NULL) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(file);
+	return found;
+}
+
+static void cleanup(void)
+{
+	SAFE_RMDIR(DIRA);
+
+}
+
+static void setup(void)
+{
+	fsopen_supported_by_kernel();
+
+	SAFE_MKDIR(DIRA, 0777);
+}
+
+static void run(void)
+{
+
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
+
+	struct mount_attr attr = {
+		.attr_set       = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
+		.attr_clr       = MOUNT_ATTR__ATIME,
+	};
+
+	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+
+	attr.propagation = -1;
+	TST_EXP_FAIL_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)), EINVAL);
+	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+
+	attr.propagation = MS_SHARED;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(DIRA), 1);
+
+	attr.propagation = MS_PRIVATE;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+
+	attr.propagation = MS_SLAVE;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+
+	SAFE_UMOUNT(DIRA);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
