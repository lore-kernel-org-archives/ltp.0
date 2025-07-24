Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292C1C83F17
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753321323; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hnV8ElGdYTk2PMHPmFrYZ0qwZDTKsKahJiLkARrOlk8=;
 b=pjDG+SPhh1Qcwo3+BaR08LFKIAhAD65fuN8kUUaDvLa/HXejvepQbuEEN4eJM2jtwl1qU
 Mw+DcizHI+qYJrJ+yqpma2kGmIowUr4Bk86i1Dc8YyCJJJPcTdiNPZIVc3X11AdRJ6ssSKH
 Us41MldVHQ0UQVBPreOAjJpreJj48pU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B153CCDE5
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 03:42:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9C593CB13C
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 03:41:42 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0201600543
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 03:41:41 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so391484f8f.3
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 18:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753321301; x=1753926101; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNVa8OPxYUcXxmddeyr/HZUEF5Y+Lf5Cjpz+HByGPf0=;
 b=DaFE2zXS8Hx+BQRZYqgbvM8aRMy6Rlxbkq/CEp0G6oy+OpP08zh51T71KHf58APR1f
 Lu2sKDjNDadjbMxiTJMd7s7qpok5dssdJGdO5K3SkF2eBUXgSYuFYhPu3xOzapJDpVMo
 P5VVeOSrOty3T61pCCDlbKaMx4dOb7ZyFFF/VgCY+R249BjD6roKI0NZFbePsSd9zQVy
 DMmnVvdw+zKUavHC02o6HU8ga4RlCdNzUdapqkNkcRfxJVefi0IhODnwinhZlqqv9BbO
 kWe6bVipkmMXaQHcOpNG2tNZo0K94bFxxi7jq3GbVAj+CrFNmJUAXq+ph479wiiS1se4
 81Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753321301; x=1753926101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNVa8OPxYUcXxmddeyr/HZUEF5Y+Lf5Cjpz+HByGPf0=;
 b=UaiMnh4soY6FZBEwMiXD0/re74WzdXloeSj8Ju/nQhcLXFVp1z1Uoqee1hw554HJ3J
 OiXymLdGnLaINmS7YXjMp5pRubLu6iOjYwI/eBnNIV2oKWRon35QyvfFhQDHfCFvL9+C
 qitjW/HT88x2t35Q1JUhwrbCxINxA6mceUdT3nZ++Lt46GHuLpOLQJFRNUk+5BgKq8Xh
 Lj0ctufNGRJoA/gyXdnsCqlKQMyWMJeBYyPosXvYYwGU4qD+WmXA3YiNZnVrH8/tpfia
 ve/IiQhBoV7PWiFoyShiOdv9xsZ523qg4rd/41Vw6LAldTb55bjfZqfB3T+hqCyytQYv
 vsAw==
X-Gm-Message-State: AOJu0YxtCB6LEoKx63Sn53cB3S6A2SVX+rwbkOVLbfZHb2ddK2dpjMeq
 57txrNXV0MH5o6mSWaofslM38x6Wi+ojSzsEzPQoGbkwHVe8PvGQFzudirjyOhTt0E4ASH+KMbc
 41tM=
X-Gm-Gg: ASbGnctnE1snMX/0xhhC1GyHdNy+xB2tDJiHA/ReK28D1/I8H5arnkX23RcYGbGdMAl
 +r6SS/AViiKeue6R4Jz7hZG7dMreNF9dxfZjvqnVglYZwivVOc9SHTjGMnr4uCfOLwQyD8tsTP5
 soKF0eJFaafdvGMEXXfq9l0Di9pYJ2VQLmDAaP88iapwQwwpr35RhadBSySc+nSDLUzXoffgG8H
 7/xloEuan0h3bk4YQIGTfLm4vDe/x5s6XvCEcNfAc6HunhKXZmZjjf48KmkwzHMvMV08PstduH5
 o++L5e2MYpMcoC0lwrF/ygKg5JW1jrPl7JjnpuMwShW/MgOA1ia1nwLqzpi3yv7SsrW49xb3bL9
 yDjGEOWB0Fvw=
X-Google-Smtp-Source: AGHT+IEcXB4Sh6bRmuc9Aj9Qqms+7gHd50SUKMbsughjfPaWA2GXjmyrL6euB0F9Aj1ytkjx+6csbQ==
X-Received: by 2002:a05:6000:2484:b0:3a4:e502:81e1 with SMTP id
 ffacd0b85a97d-3b768f105ddmr4279356f8f.52.1753321301048; 
 Wed, 23 Jul 2025 18:41:41 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31e663a67e7sm63451a91.41.2025.07.23.18.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 18:41:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 24 Jul 2025 09:40:34 -0400
Message-ID: <20250724134052.568308-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319114144.24349-1-wegao@suse.com>
References: <20250319114144.24349-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mount_setattr02.c: Check mount_setattr attr
 propagation
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
 .../syscalls/mount_setattr/mount_setattr02.c  | 127 ++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9c80bccb0..2528fec52 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -866,6 +866,7 @@ mount06 mount06
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
index 000000000..640778f7c
--- /dev/null
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * This test is checking if the propagation field of the
+ * structure is handled properly.
+ *
+ * - EINVAL with propagation set to -1
+ * - When propagation is set to 0 it's not changed
+ * - MS_SHARED turns propagation on
+ * - MS_SLAVE turns propagation off
+ * - MS_PRIVATE turns propagation off
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/statvfs.h>
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
+
+static char *tmpdir;
+static char slavedir[PATH_MAX];
+static int mounted;
+
+enum mount_type {
+	MOUNT_TYPE_SHARED,
+	MOUNT_TYPE_MASTER
+};
+
+static bool check_mount_type(const char *path, enum mount_type type_to_check)
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
+		switch (type_to_check) {
+		case MOUNT_TYPE_SHARED:
+			if (strstr(opts, "shared:") != NULL)
+				found = true;
+			break;
+		case MOUNT_TYPE_MASTER:
+			if (strstr(opts, "master:") != NULL)
+				found = true;
+			break;
+		default:
+			tst_res(TFAIL, "Unexpected mount_type value: %d", type_to_check);
+		}
+	}
+
+	fclose(file);
+	return found;
+}
+
+static void cleanup(void)
+{
+	if (mounted) {
+		SAFE_UMOUNT(slavedir);
+		SAFE_UMOUNT(tmpdir);
+	}
+}
+
+static void setup(void)
+{
+	tmpdir = tst_tmpdir_path();
+	sprintf(slavedir, "%s/slavedir", tmpdir);
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	SAFE_MOUNT("ltp-mount_setattr", tmpdir, "tmpfs", MS_NOATIME | MS_NODEV, "");
+	SAFE_MKDIR(slavedir, 0777);
+	mounted = 1;
+}
+
+static void run(void)
+{
+	struct mount_attr attr = {
+		.attr_set       = 0,
+		.attr_clr       = 0,
+	};
+
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(check_mount_type(tmpdir, MOUNT_TYPE_SHARED), 0);
+
+	attr.propagation = -1;
+	TST_EXP_FAIL_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)), EINVAL);
+	TST_EXP_EQ_LI(check_mount_type(tmpdir, MOUNT_TYPE_SHARED), 0);
+
+	attr.propagation = MS_SHARED;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(check_mount_type(tmpdir, MOUNT_TYPE_SHARED), 1);
+
+	attr.propagation = 0;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(check_mount_type(tmpdir, MOUNT_TYPE_SHARED), 1);
+
+	attr.propagation = MS_SLAVE;
+	SAFE_MOUNT(tmpdir, slavedir, "none", MS_BIND, NULL);
+	TST_EXP_PASS_SILENT(mount_setattr(-1, slavedir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(check_mount_type(slavedir, MOUNT_TYPE_MASTER), 1);
+	TST_EXP_EQ_LI(check_mount_type(slavedir, MOUNT_TYPE_SHARED), 0);
+
+	attr.propagation = MS_PRIVATE;
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(check_mount_type(tmpdir, MOUNT_TYPE_SHARED), 0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
