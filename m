Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0065ECAC5A7
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758703369; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pyY8lT9haQnStQ3H1Z0w7PNZLi1tiFQbBn5152uXxNA=;
 b=RtNPJ25nfhpHgYwgvTcR4gERgAvcI4cQsplfMJVUaqVia1zx37H3e3ud4rf3XVUpznXGs
 Nb81WGIlTWJoU6lUpdDljBzPEXMq7CYgzmol+o2iTdsJkBMbcgF8dufMN+Gn62QbsJYREab
 WG0k7+GGtwQZod/01JZjtk006Xr4+Z8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 225FD3CDF1A
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 10:42:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 492AB3CCD6F
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 10:42:27 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 758991000A5A
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 10:42:26 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63053019880so7622846a12.0
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758703346; x=1759308146; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=954Kq8XimI0FYyXj4TBnjYiGcxo6Iqtw+OJ6E7aqHQs=;
 b=dzZxGDa5/jReew2ax9GamP1lgyFEpV8brAD97ypyDY4oNs6xGlVOmWhQ/nrfnM0rPR
 zCPSJBR47fI5yJKspZVv05wIgdg/8F8c8CaI3tt7+1y1mJtE2xQ7jjMJ3Q0ec8QIJ7a9
 jfUFWL+BsGUTFA8ui77NKLKwHa9yc5RZGM5JLwm1c/NulyPd4K5EOGr4VNUG2RXFBgUw
 1WS4aae7ztIj9JkwqEiE/EVC2BOWCa6lB2dUwbQcLnOHxjbGM5LpjlkjdXLG7JYdh05t
 QmhCxokqgsDJC8rUDug5rzhDZ9zH6qcueNxVd9zm+mH31ETp80LsNi+3L37+B4lA5RoA
 m1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758703346; x=1759308146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=954Kq8XimI0FYyXj4TBnjYiGcxo6Iqtw+OJ6E7aqHQs=;
 b=r8M021gVsKZe3leYT6OyLGnYr20R21cfZSmszAxmUi3S/mU9vgQXwR5CO1N7F8EAol
 YotNIhbVkXDlc+EDgoJgoR2lzB5chRpSXMi+ZIRbkxNt7rLOgZ7OoIkoppwWFt9wz854
 NSN/ysBX2O5MEYzifvSuBbg4qxzwZxgvgod68Lw+VyMohmExYe7UX7Phl7ny32yrYqlK
 c4kcCh39aytjJuSiTzF+70RMkblLM/DQuwRyQoijH88dDuEAbFZwdfXKu/H5MqQJ3JyC
 A0CFnxBxcqb3XlpUaULaLd//Wpah1K84k7VeB0TcBsaofhaFak3SvGNmjr+P1GnUt3e8
 9sxQ==
X-Gm-Message-State: AOJu0YwX21ZKO2k+o/7E6Iu6J113uPIXEy9lRYc3B/Vq8DOa0WYUcRr3
 pVE8be9Ktx2ASh+G/7InvSt9334+bXg6fgRGkivZuALXGFvX9JSp3Wh0P4y3DsfVVcsPB8LzkIQ
 CyX0=
X-Gm-Gg: ASbGncttcxw3yOkSSQibj0u3zjCp5pdp8rVkV98p+zzwQJW4WoHQgrWtE/xZ782CuQ+
 GmILXc68mrYARGCagMyLRi/j6rYaj9g36es5e+YO3+h6/sGImY14iVINf3YkE+VQRu0wHRez6/Y
 2ngBE7CX4ZTeGbUt/vHEEuqKvQDg+5I4sLj/J04zTQlq0VKA8ikJDGRR/6tCA0oVFaJGPN1UPhJ
 xb3pQpEPiSs08Uj05R8+cRBqDOblH7BZhOemF8Yfl4jXa0f0NYY7BsRJeL1UiHh7LUiOGVuRJmk
 keVHNHNTw4GxhNcKvr/XrAtATJucTzHZxi3NkKgbwSFGxwrQGEfefyq9e7RIxT/nSiVAs5CDHjf
 3b2GYXtnxalB74DiVx9/UI2SSY1fbmXX3FXBf1oXdXuI=
X-Google-Smtp-Source: AGHT+IEHY+JkSe5kOqYn8Y6hYS2WMA+w3u03l5m6J1W2YtDSerZkI2TrTEV/7cwwS/bNNFyBA2No8g==
X-Received: by 2002:a05:6402:3244:b0:628:12e9:5e41 with SMTP id
 4fb4d7f45d1cf-634677f870dmr4118005a12.29.1758703345556; 
 Wed, 24 Sep 2025 01:42:25 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-62fa5cfa6dcsm12829436a12.10.2025.09.24.01.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 01:42:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 24 Sep 2025 08:42:16 +0000
Message-ID: <20250924084223.20597-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529105156.2564268-1-wegao@suse.com>
References: <20250529105156.2564268-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_filesystems01.c: Add test for .filesystems
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

Fixes: https://github.com/linux-test-project/ltp/issues/1243
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/newlib_tests/runtest.sh          |   1 +
 lib/newlib_tests/tst_filesystems01.c | 104 +++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 lib/newlib_tests/tst_filesystems01.c

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index d87751c2f..71808ef8b 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -24,6 +24,7 @@ tst_checkpoint_wait_timeout
 tst_checkpoint_wake_timeout
 tst_device
 tst_expiration_timer
+tst_filesystems01
 tst_fuzzy_sync0[1-3]
 tst_needs_cmds0[1-36-8]
 tst_res_hexd
diff --git a/lib/newlib_tests/tst_filesystems01.c b/lib/newlib_tests/tst_filesystems01.c
new file mode 100644
index 000000000..4eca0af0e
--- /dev/null
+++ b/lib/newlib_tests/tst_filesystems01.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define MOUNT_POINT "mount_test_filesystems"
+
+static int check_inode_size(unsigned int size)
+{
+	char path[PATH_MAX];
+	char line[PATH_MAX];
+	FILE *tune2fs;
+	char str_size[NAME_MAX];
+
+	snprintf(str_size, sizeof(str_size), "%u", size);
+	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
+	tune2fs = SAFE_POPEN(path, "r");
+
+	while (fgets(line, PATH_MAX, tune2fs) != NULL) {
+		if (strstr(line, "Inode size:") && strstr(line, str_size))
+			return 0;
+	}
+
+	pclose(tune2fs);
+	return -1;
+}
+
+static int check_mnt_data(char *opt)
+{
+	FILE *fp;
+	char line[PATH_MAX];
+
+	fp = SAFE_FOPEN("/proc/mounts", "r");
+
+	while (fgets(line, PATH_MAX, fp) != NULL) {
+		if (strstr(line, tst_device->dev) && strstr(line, opt))
+			return 0;
+	}
+	SAFE_FCLOSE(fp);
+	return -1;
+}
+
+static int check_mkfs_size_opt(unsigned int size)
+{
+	char path[PATH_MAX];
+	char line[PATH_MAX];
+	FILE *dumpe2fs;
+	char str_size[NAME_MAX];
+
+	snprintf(str_size, sizeof(str_size), "%u", size);
+	snprintf(path, sizeof(path), "dumpe2fs -h %s 2>&1", tst_device->dev);
+	dumpe2fs = SAFE_POPEN(path, "r");
+
+	while (fgets(line, PATH_MAX, dumpe2fs) != NULL) {
+		if (strstr(line, "Block count:") && strstr(line, str_size))
+			return 0;
+	}
+
+	pclose(dumpe2fs);
+	return -1;
+}
+
+static void do_test(void)
+{
+	long fs_type;
+
+	fs_type = tst_fs_type(MOUNT_POINT);
+
+	if (fs_type == TST_EXT234_MAGIC) {
+		TST_EXP_PASS((check_inode_size(128)));
+		TST_EXP_PASS((check_mkfs_size_opt(10240)));
+	}
+
+	if (fs_type == TST_XFS_MAGIC)
+		TST_EXP_PASS((check_mnt_data("usrquota")));
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_root = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.needs_cmds = (const char *[]) {
+		"tune2fs",
+		"dumpe2fs",
+		NULL
+	},
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext3",
+			.mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL},
+			.mkfs_size_opt = "10240",
+		},
+		{
+			.type = "xfs",
+			.mnt_data = "usrquota",
+		},
+		{}
+	},
+
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
