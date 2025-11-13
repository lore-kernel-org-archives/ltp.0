Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEBFCD4F35
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 01:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762998813; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=l/ikocMpA0z0FerGnhKJRzQBhOtqut/5nhswWkCCEuI=;
 b=aZNZKHyzDeJt7r+tqGDbvAO7KBGhvCsC1+dnyZNR6I9T58KuK5KHqv969OqWJ8nu7Jz/l
 3SGgxyZ4MgZNUVA9drD/HkM7FB22z0+jpDOM/PZWGCOECqUyXNs1m42bEt0AQMeDAKiKv2q
 1fRIur1+6yLQR91DyoKNF8chWVYqk/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 886E83CF7C1
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 02:53:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B6163CEE04
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:51 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DBBC61A00368
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:52:50 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b72bf7e703fso39000266b.2
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 17:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762998770; x=1763603570; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1/MpoLf2lZnBB/v50IAbfXO43A8i08Aa2ue4kbq8CA=;
 b=R0/LhshzQZkHYEcUQTD4TDZb4+mo3gk/vjFxMEexyZzLY2FSdH24PBgjKPCc43jlKF
 3Ed7fgtre2I2OMcmiYIPSuKtsMfNO7ioJO9DFQsSUN7cu/M6bHCiQohLvFzGRMmjLKJR
 MCRqrfVAqpf+pmn207cjkNkrJQuwpXvnqTmlDE27BIjxnTtP6W8lMylmy4IyzEJYSbBA
 6RWheSfo57coy+9tfm3yCdSiDgd0pdmUCYMadxrZzlW+TnRFkNyINOFyoMmNlg69HnUf
 JtM1i0tto+6OoHE8AmNr1zj5BcJ47575ZBuq69S/xJ23WQSnLAfiGMQOoO/ZLC/MpbBz
 VROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762998770; x=1763603570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1/MpoLf2lZnBB/v50IAbfXO43A8i08Aa2ue4kbq8CA=;
 b=m1F8Sj39O+X3JsErUwvM4OqeKIx94Kkuy7r3ws3k04Hsmraq410cPneh+DiaHQb7VW
 61BJ084hwuKthdprW3ATRQ0SdMiR3oE0pL5xOoCvP7VdgztbTdVQnpb/K2B/6R2MstiX
 Aqj8huzCCaua8DXZE2WxEiC2LtD+d8uw/KEL9vRWXSNUs+cZsECPf2w86PjiggGMhfhc
 9QIprKbmUkg+/QXPkorXCxmU6Bx3cGQLzFqRYfL+Yw52LdS2J429HIQ6tvpyVZ25zwzd
 HLQho2rYIoL1g5S9dtp1gLW8SpsGuStvZXfRDxiOaKDt+P8zismGv1ZlNhkRnOgr48Fr
 DFOw==
X-Gm-Message-State: AOJu0YycbE6T2SZ3kN+AXa127OApbPgKKCVhUxhFXFtslHnz20DNLiNu
 G2LtWYMNU6r0jNltYDW5fDJpIRmMNriC5XSBdB7zPlBbm4sZ14n2bYnf/ZqIk1RHI4bTXivOG9U
 blc0=
X-Gm-Gg: ASbGncsk8pXe1QLU0tAjUUc8X+mIzpED7SJaIfly69zhNuegGiRcRA9h3uJRyN423hx
 M5U0HjLp1RxNwKNhOkXDOq6fwE4fDFfe1wRcX09ea5v64B3nFbCyQ3h130a2bDBwusDOlft9CvG
 ftVW0ZbT8AnS0yH2jNkG6v6NcHX2AcsIriQdnleJUHyEEI0la3VmbGcLQF1GWkWKe+SqRfYuSD5
 ssgzhGuVTanmzXvqN6XXs8rvWqWkjsmcTfmReb9cZA0BZBug0/SYryUap1UNVPB7cyjJZaD8mjV
 qVV53jzVOgsjS1Q66yTgxkdUZr6miZXXtg6BKXXURFwZFcLB/ZgxBGGsto7uYTheRIiGwnsPzX7
 3VQixvPTL3OkDqNXqHMYBOVesZrVbgRViYlwplZFK/9c6zk+GVcGC4fZP5cfOTcuV
X-Google-Smtp-Source: AGHT+IF3i6CUCPSk5dgCp0pvSl77QQZWUoDJ/ChL+unzrtue288TuwiLfk/zvY6PRbKIi71Uanuh0A==
X-Received: by 2002:a17:906:6a19:b0:b70:b7f8:868f with SMTP id
 a640c23a62f3a-b7331997c33mr556417566b.27.1762998770103; 
 Wed, 12 Nov 2025 17:52:50 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fa81223sm53430366b.4.2025.11.12.17.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:52:49 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 13 Nov 2025 01:52:30 +0000
Message-ID: <20251113015242.799-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113015242.799-1-wegao@suse.com>
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] tst_filesystems01.c: Add test for .filesystems
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
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/newlib_tests/runtest.sh          |   1 +
 lib/newlib_tests/tst_filesystems01.c | 108 +++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
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
index 000000000..dd24abca2
--- /dev/null
+++ b/lib/newlib_tests/tst_filesystems01.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define INODE_SIZE 128
+#define BLOCK_SIZE 1024
+#define MKFS_SIZE_VAL 10240
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
+		TST_EXP_PASS((check_inode_size(INODE_SIZE)));
+		TST_EXP_PASS((check_mkfs_size_opt(MKFS_SIZE_VAL)));
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
+			.mkfs_opts = (const char *const []){"-I", TST_TO_STR(INODE_SIZE), "-b", TST_TO_STR(BLOCK_SIZE), NULL},
+			.mkfs_size_opt = TST_TO_STR(MKFS_SIZE_VAL),
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
