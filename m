Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02D9C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717585192; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ppN0E33jPoxor4rm/Z/bIVEPrlU1qW/j7G1ZZQTH97g=;
 b=c2daDqqOl5fDPR+JJQM6cKAxnj89CX0TX8K9ZfAmo1X73HbOmDwSoz3tY99Pv9InzPFVL
 mXlmfXAV8P3RbmVlxYZnGfQEGOixawV8rTrdu+jR91RFXw7A01FM8AX4Tzu2OoHKHo2McOc
 FExKlTfWkzAXlgxl+g+uQ68XrdhoRyo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3137D3D0984
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 12:59:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F4A93D091C
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 12:59:30 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CA2B1B61055
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 12:59:29 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e73441edf7so71033811fa.1
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717585168; x=1718189968; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfSQnmM9WjxbLXw9rBZ3E1rKL9Porl+2gE5rMxdM+XY=;
 b=CFVNQ+2MoZniRoO+ecP3kUlv6Di65/etjgW06jisKV0IE2nVm9TL5+t8pUlxN08l84
 bvoUCVzI1zbDXx9Efy7f4Pq5JFux+u8zbZmXHKH15XJfFzTZhoSSGOTKlLXDbW0p3xsy
 WX10CdaS4R/KUNiqGikwMse826KnyHw9VnTYKmWWlVtL43/yEgceTEqrDvYz6ou9Nc6w
 iJHkEYfGXZb07yDCyhdoBlyVhhtfmNaiU0XD/LycK7ZppfMuDiV0iNe5r0Hb0VJX7ykJ
 rqZOyxi+T+A9zhHhmUTLEWAa9EjhqO2wAEud3jMMv7jKBJI+KSehDiFltwTYpb4WX9P8
 aIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717585168; x=1718189968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfSQnmM9WjxbLXw9rBZ3E1rKL9Porl+2gE5rMxdM+XY=;
 b=G0Bc5d4JUxus1WVIMaoAb/78qbu5ZCCMrrvSpggleovPiWH9Z2W7twdqHfQenZp+uV
 KsLorD5GVSE8i+hHR7GJkfgZlrT6mGt8/alNhVDRiyKMnfmU73JOMqN9QkYOzIDBJuMz
 4+adtMP6xBEmf7FV0HppZeg85eKeRFApyEcnZx66CQLCP2FIEEbJX2QdsXuDV6Ki3AMl
 YxnTz68fD22fciS4kmhZV5P2xPKkZFmjfPMA2zLSZOMOWt+dZIc2k0DjKnTKUlujF0gA
 mtELxbfOm2P11oPyodATkz86qTmIFl6bVtoFj4JnTd5tZshN6vx5eKMnKkC6ShHlrQrt
 bGMg==
X-Gm-Message-State: AOJu0YzIAVsz2queU1qGx9Q50Z/f2GrLvO0P/jdQ5y5SXTVVbqG9wfI+
 mxE9OHW8x0vS7+y6bTHdLbGZV2wrjIGSyRHduzM6y6n/qEL9NRZH+kUQzJITcOcADaUF3V0Sqrw
 =
X-Google-Smtp-Source: AGHT+IEI4UQ/K6zbfGzFP/FURUbeTYNq2vvu8LiUWRPALpouMLLzDzK51L8ulWOVHod+cMATU1apRw==
X-Received: by 2002:a2e:7302:0:b0:2ea:8456:fc93 with SMTP id
 38308e7fff4ca-2eac79c342amr12536031fa.9.1717585168095; 
 Wed, 05 Jun 2024 03:59:28 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323f6da2sm99229015ad.227.2024.06.05.03.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 03:59:27 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  5 Jun 2024 06:59:19 -0400
Message-Id: <20240605105919.10123-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322112031.20939-1-wegao@suse.com>
References: <20240322112031.20939-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] move_mount03: check allow to mount beneath top
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
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/fsmount.h                        |   4 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/move_mount/.gitignore     |   1 +
 .../kernel/syscalls/move_mount/move_mount03.c | 145 ++++++++++++++++++
 4 files changed, 151 insertions(+)
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
index 000000000..ad5c8b9ed
--- /dev/null
+++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Christian Brauner <brauner@kernel.org>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test allow to mount beneath top mount feature added in kernel 6.5:
+ * 6ac392815628 ("fs: allow to mount beneath top mount")
+ *
+ * Test based on:
+ * https://github.com/brauner/move-mount-beneath
+ *
+ * See also:
+ * https://lore.kernel.org/all/20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org/
+ * https://lwn.net/Articles/930591/
+ * https://github.com/brauner/move-mount-beneath
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
+	TST_EXP_PASS(access(DIRA "/A", F_OK));
+	TST_EXP_FAIL(access(DIRB "/A", F_OK), ENOENT, "A should not exist");
+
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
+	.min_kver = "6.5",
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
