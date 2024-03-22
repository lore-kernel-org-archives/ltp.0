Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0494FC47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711106459; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tKDG8hozFa1e9DQMRyyu0+07Lu2oj4vTntRhQzaYlKk=;
 b=O4klC+HiDK/tHAL6adfx+4eyVvnWewdqhh0deyZu77Aph6eDJQzcOJy6gJzwn1sQkK40X
 7BtYcQm86dbLE353C4iOmKKHtfp0gEQ8Fcp2rdVjFORrw8nnv4Y6q7fq6QIaxH4LBcI5xaw
 rsy7yZnKiHK88yWZtzrQxstkDZkTiY8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2578C3CE62C
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 12:20:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 724633CD61B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:20:38 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E4CCC14060C7
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:20:37 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56be4efb63fso539861a12.1
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711106437; x=1711711237; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCv3HyuYfKFqUa/HZM56bEofc8a6mkSdLBXLwTy8Rwo=;
 b=MSaDb6bh+xe2AGgrD3fKtPOgDZbewCbYRHgFVqcMrzavoopTiqh3gMsg+jZOLR+yld
 knxF2Vgv+uU/l/DCIu+VJpFvxRwNUvW2mY13q5czsEo1uvtqgRDgOBGXEQ9jExeU9ne/
 2MoyGtEsfz9d16MoLbCx6jF83GJ/WeiFuBHU0oGf7NEEMbWxHsThdgSlBWWZRzhyBVY9
 Od2DCPRc2cp2w4ywWPbhh4e7BhqGjV5XcXIxHDVVS/I+08YyvovzzeFyMrF/iOm3YJPt
 hvyWI4aC4dkI63R3WGwMCQH59hxzrro7h/G8gfb+CkByZ0LPliuZwJej/b4lEjmUKPKA
 fIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711106437; x=1711711237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCv3HyuYfKFqUa/HZM56bEofc8a6mkSdLBXLwTy8Rwo=;
 b=GxDgmWmfzGrO4thbC2hjUUtBYQbrwJ8WRgc7BGGzdnb93/CEuFVP7LHpwtYdOHEY5k
 lYkxlZXWQ5Pa5ZzV7KUKDLeu0+bGbnZa8zhNwgN911iLt304kzXgeOzNLqOzlPJFSsmt
 wCo2R3B2lhAFmNlyiUUyI7F05ZEDmqHZarg6pijSQg0kdQA8rUtWwZZb+zcR+S4NiJcX
 ItF6zaIRM6d4YzSw7d9SqOCIfk0x36hqVovP6PgOf84TTwX+pWZxUncrawUvs/OGCBUN
 OpCJOZpb7O/EH+dZBaScuQwGAfQoSRgrq56eFSQuEznEPbVyEt8fYvyPOxJuOfzxKi9t
 C2Rg==
X-Gm-Message-State: AOJu0Yw5jERbqCyMRKueg/cCJofY55XYV5FNker1DJxSyAWOiZTeNY6e
 23tECAdTXegfQeQQm5yc66n0N0JRje+GtAjert0ClQ/y3tXvoxtBsUNqaTD7/qhj3lT5ayYAgH4
 =
X-Google-Smtp-Source: AGHT+IHNtl0Puup4y6QlfjawFEvMiabX9kEpHPwjkpD/UMtnqTCKHJzw+UrRD/aAgukd0jJ5MPR1Xw==
X-Received: by 2002:a50:a453:0:b0:568:b702:e0d3 with SMTP id
 v19-20020a50a453000000b00568b702e0d3mr1415059edb.21.1711106436825; 
 Fri, 22 Mar 2024 04:20:36 -0700 (PDT)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 fj26-20020a0564022b9a00b00568d2518105sm924304edb.12.2024.03.22.04.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 04:20:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Mar 2024 07:20:31 -0400
Message-Id: <20240322112031.20939-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231228025537.28807-1-wegao@suse.com>
References: <20231228025537.28807-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] move_mount03: check allow to mount beneath top
 mount
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
 include/lapi/fsmount.h                        |   4 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/move_mount/.gitignore     |   1 +
 .../kernel/syscalls/move_mount/move_mount03.c | 137 ++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_mount/move_mount03.c

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..216e966c7 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -115,6 +115,10 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
 }
 #endif /* HAVE_MOUNT_SETATTR */
 
+#ifndef MOVE_MOUNT_BENEATH
+#define MOVE_MOUNT_BENEATH 		0x00000200
+#endif /* MOVE_MOUNT_BENEATH */
+
 /*
  * New headers added in kernel after 5.2 release, create them for old userspace.
 */
diff --git a/runtest/syscalls b/runtest/syscalls
index b1125dd75..04b758fd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -824,6 +824,7 @@ mount_setattr01 mount_setattr01
 
 move_mount01 move_mount01
 move_mount02 move_mount02
+move_mount03 move_mount03
 
 move_pages01 move_pages01
 move_pages02 move_pages02
diff --git a/testcases/kernel/syscalls/move_mount/.gitignore b/testcases/kernel/syscalls/move_mount/.gitignore
index 83ae40145..ddfe10128 100644
--- a/testcases/kernel/syscalls/move_mount/.gitignore
+++ b/testcases/kernel/syscalls/move_mount/.gitignore
@@ -1,2 +1,3 @@
 /move_mount01
 /move_mount02
+/move_mount03
diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
new file mode 100644
index 000000000..dfdad080e
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Christian Brauner <brauner@kernel.org>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test allow to mount beneath top mount feature
+ */
+
+/*
+ * Test create for following commit:
+ * commit 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
+ * Author: Christian Brauner <brauner@kernel.org>
+ * Date:   Wed May 3 13:18:42 2023 +0200
+ *     fs: allow to mount beneath top mount
+ *
+ * Above commit has heavily commented but i found following commit
+ * contain simple summary of this feature for easy understanding:
+ *
+ * commit c0a572d9d32fe1e95672f24e860776dba0750a38
+ * Author: Linus Torvalds <torvalds@linux-foundation.org>
+ *       TL;DR:
+ *
+ *         > mount -t ext4 /dev/sda /mnt
+ *           |
+ *           --/mnt    /dev/sda    ext4
+ *
+ *         > mount --beneath -t xfs /dev/sdb /mnt
+ *           |
+ *           --/mnt    /dev/sdb    xfs
+ *             --/mnt  /dev/sda    ext4
+ *
+ *         > umount /mnt
+ *           |
+ *           --/mnt    /dev/sdb    xfs
+ *
+ * So base above scenario design following scenario for LTP check:
+ *
+ *         > mount -t tmpfs /DIRA
+ *           |
+ *           --/DIRA(create A file within DIRA)
+ *
+ *         > mount -t tmpfs /DIRB
+ *           |
+ *           --/DIRA(create B file within DIRB)
+ *
+ *         > move_mount --beneath /DIRA /DIRB
+ *           |
+ *           --/mnt    /DIRA /DIRB
+ *             --/mnt  /DIRB
+ *
+ *         If you check content of /DIRB, you can see file B
+ *
+ *         > umount /DIRB
+ *           |
+ *           --/mnt    /DIRA /DIRB
+ *         Check content of /DIRB, you can see file A exist since
+ *         current /DIRB mount source is already become /DIRA
+ *
+ * See also:
+ * https://lwn.net/Articles/930591/
+ * https://github.com/brauner/move-mount-beneath
+ */
+
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "lapi/fsmount.h"
+#include "lapi/sched.h"
+
+#define DIRA "LTP_DIR_A"
+#define DIRB "LTP_DIR_B"
+
+static int fda = -1, fdb = -1;
+
+static void run(void)
+{
+	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
+	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
+	SAFE_TOUCH(DIRA "/A", 0, NULL);
+	SAFE_TOUCH(DIRB "/B", 0, NULL);
+
+	fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
+	if (fda == -1)
+		tst_brk(TBROK | TERRNO, "open_tree() failed");
+
+	fdb = SAFE_OPEN(DIRB, O_PATH | O_NOFOLLOW, 0666);
+	TST_EXP_PASS(move_mount(fda, "", fdb, "",
+				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH |
+				MOVE_MOUNT_T_EMPTY_PATH));
+	SAFE_CLOSE(fda);
+	SAFE_CLOSE(fdb);
+
+	TST_EXP_PASS(access(DIRB "/B", F_OK));
+	SAFE_UMOUNT(DIRB);
+	TST_EXP_PASS(access(DIRB "/A", F_OK));
+
+	SAFE_UMOUNT(DIRB);
+	SAFE_UMOUNT(DIRA);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(DIRA, 0777);
+	SAFE_MKDIR(DIRB, 0777);
+}
+
+static void cleanup(void)
+{
+
+	if (fda >= 0)
+		SAFE_CLOSE(fda);
+
+	if (fdb >= 0)
+		SAFE_CLOSE(fdb);
+
+	if (tst_is_mounted_at_tmpdir(DIRA))
+		SAFE_UMOUNT(DIRA);
+
+	if (tst_is_mounted_at_tmpdir(DIRB))
+		SAFE_UMOUNT(DIRB);
+
+	if (tst_is_mounted_at_tmpdir(DIRB))
+		SAFE_UMOUNT(DIRB);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.min_kver = "6.5.0",
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
