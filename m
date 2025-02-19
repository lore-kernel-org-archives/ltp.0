Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839D8C021B0
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739953832; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3QjNmzlfZdnBJkwKUsUgsNXfMuX5zLFUoXpP/oY9kxA=;
 b=D1Ip/YTE2PEzeJOD5sY8EPmuPIEq9TYFLy5vcfMZD1KQoQuJrZn4Bx7L8u79aNPdXHOh2
 8AcbwgqsxxpEU9NupJZGSyA7FpgKMAXGEkNiHPwX5MCdXhQz110R7rjKRwJkofxjg80Q+Xe
 9hkGotdW7ridmb5mkJEK08u17joUkCo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEF033C29B6
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:30:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CCC43C2653
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 09:30:09 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 376DB142F7C4
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 09:30:09 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43989226283so18375115e9.1
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739953808; x=1740558608; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUmXXqM46ilZIXXvMyy8aSNSwFqcV2Dzg0oqO2DxpOE=;
 b=LOM778JpJ3jiB8W4aUd8XgJ9GQ1l8/O4Vw1PaMROADb35xzUOzbYkkqvIF23DOfROn
 bW1mRnZ9mklPhycpkiibGyll6lDUdz13+5Bl9CsLQx6frSc86PW7I1vigDX6Yb7umy3D
 as2F5hS1Uq5RGUJ0PaJRGJ6HcjcrmDUWDzHdwegmTAXHsLsUwhAytOyGTOV4O2MVilk/
 fvhCIFOO+hOqEoHFuXfIbTMdr5VTTZVTmgHbYUcGTaMi69Io2sHpsQWlDwEtCd0nfA34
 TBDnUBJ6DBtCbXUG3RVV3BMOR17TWZxjd9+ucgjzc2V3fuqMwi8b6ATLyVEZghuvgtc0
 ukcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739953808; x=1740558608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUmXXqM46ilZIXXvMyy8aSNSwFqcV2Dzg0oqO2DxpOE=;
 b=aRisDYb6zA+yYBIbEqEOQ28Xz+1G3fev3sM++NvoLQhelebvyE/7E0kVAOg4SKb0R5
 LJiqAwPo0i7Sq8Z3bHAEj/SyitDIzXcr7uPpa2JbI0dkIkCmYhp7jilTOQZ1JM0gKQoG
 hJNONnIOvZoMzggGmsZHzW6wKQEGkzp631y6I4zbGLbVmsKiPG40DDD8BOd9h34eQ08I
 DuuLY8nHsdIY3U/9pBwabrv2W/cqIv/Ucm/X9BW1Jj/DwUbLITuoW0tgYCnAkaYVg9g2
 tEGYeXPNsI/ffczHFBKEWL2aHCG6uEV9wTFNvmXxWM7ZH59CdZdfs9qsuLjakyLtAR8Y
 0dDA==
X-Gm-Message-State: AOJu0YxwNGLcBMY5G6J3oJKKYaMrPAWVG4PW4hnBjD70PQ5TalRx84J5
 cx336l/0zb/Z0XY7iw9sG2AaRqLYVcfoWWoZspsMyxkjCm+YqNIDBwp3Ry8fjT02wEXOQIek2Ao
 =
X-Gm-Gg: ASbGncsChvpD0qHTRT1BWXCcY2u09fJr3142Rjj6BuZxl2NniUMU7JM9aQ10ogEcCsl
 KBiIZ5ffJjRF0+DkiU3SIqpJG41CRtE2cMBaSqySB0dI86fotoqjFPm8xv0d0/unCkN4S/NCafh
 j6FNbNZk8P0c7isOYIWuhJVenZ9UnT9mrti7dlcNOF7ZeddSu+IYfXxwCScuHOP3z0veUtXjA8F
 3wMN24MLxtiQFREY6NnhRQOUQ9V9PxBp31gamyImhjY7qPX771G3kC/qy0tkQEDMqRwReG2bG4x
 osQz
X-Google-Smtp-Source: AGHT+IGAxONaVCMbrfDRph6fOGDDmJ9c/fn+8Yc/tpS2LfBUvMCmcIEJsWZF8EvrGwwyvztKdXfKiQ==
X-Received: by 2002:a05:6000:18ad:b0:38f:210b:693f with SMTP id
 ffacd0b85a97d-38f33f5508emr14604475f8f.52.1739953807909; 
 Wed, 19 Feb 2025 00:30:07 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4163sm17415897f8f.19.2025.02.19.00.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 00:30:07 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 03:29:54 -0500
Message-Id: <20250219082954.23552-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250217020423.31602-1-wegao@suse.com>
References: <20250217020423.31602-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mount_setattr02.c: Check mount_setattr
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
 .../syscalls/mount_setattr/mount_setattr02.c  | 103 ++++++++++++++++++
 3 files changed, 105 insertions(+)
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
index 000000000..301c55ef9
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
@@ -0,0 +1,103 @@
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
+static int dir_created, mounted;
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
+	if (mounted)
+		SAFE_UMOUNT(DIRA);
+
+	if (dir_created)
+		SAFE_RMDIR(DIRA);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(DIRA, 0777);
+	SAFE_UNSHARE(CLONE_NEWNS);
+	dir_created = 1;
+	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
+	mounted = 1;
+}
+
+static void run(void)
+{
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
