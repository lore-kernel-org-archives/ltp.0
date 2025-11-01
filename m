Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDBCCF9FE
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 01:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761960251; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pyY8lT9haQnStQ3H1Z0w7PNZLi1tiFQbBn5152uXxNA=;
 b=TnyN+Pu2YNTyCnL6FJcL4FnD7ySwnDkSEDJry8ToIfC+A+tk01TiKS8PMqMCC0AfeNHuX
 HoImkAE4IEvx56qhF/cHEaAkGszmpCeb4+mLUpuglI3HQiEhH7Pfq4LlJ73dXQXq53RoEd5
 VkSgqzHIVNXSPApbUBNbYvamBNoSLDs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB7F33CCFEA
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 02:24:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 488593C85EB
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 02:23:28 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2EE571A00CB9
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 02:23:27 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so708742266b.1
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 18:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761960206; x=1762565006; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=954Kq8XimI0FYyXj4TBnjYiGcxo6Iqtw+OJ6E7aqHQs=;
 b=SZLvtdNk1z5ZRW6WEy6stGwLLOteUkTRebtWKyPbje7HbITdaz46hhoZNE4wFPxCcV
 dniIztTKg5ozJ3c0Y3dtv1/kcHo3gknwxFX1p/ecx/oJd1QtY0mtJeXmupsHj474SHli
 EBpo7XB0WVQoG5w+LLYnEB9p+1ydZi3bfhX28gW2Taw0L4cb0jqVFkmHI3zJLkqVTZwh
 p7FLHGSBU+t2R83y6o1y+3ZgnL/0eY93x9JQrsiDr+y0hlxs7HpYnSHQmdECFkhJ4n4Y
 FCvPmSKHcAOwRplDxU1zF04K+ax7xjOJrTwfRZXUag8ymArt3+a7dWnEwv0Qp0uXUv89
 s4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761960206; x=1762565006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=954Kq8XimI0FYyXj4TBnjYiGcxo6Iqtw+OJ6E7aqHQs=;
 b=aBH4z4dHv4bpZ8FXWvwZ2HsxbC8ZTazmhLIIhBvFp1ZjsOxhD8rh9rPQi5nVV8v+H0
 sxMMzN+6pIIMY7H0rPaoy5R662IiChF6p4j2okgu3uCfyHuLDoPfW7xnL4Fy6tv8oTHD
 8sgVrS8cMmnMFH4ToIZ8zKnj4sGcKIQ6mCvFHdzs75UUbbcyzJ5vwZCZGc5suw3nnECY
 hffEPagwggLYVGALnizWnniaovZCXN7JtJZ1g7EmV5zVPQgYchSvWqZa+jIXRnZog+C2
 jE3OBoxsYjX7z/8Bh91cdalpilwSrfyzJJ2z0VpeRTOQqo/04gZtDIwSL9aG07ODiDv7
 lT8w==
X-Gm-Message-State: AOJu0Yz+a+ctYDiB0hz9Y3evtSljo2b9xDxAqj/lRwJoB2bkP6164G0q
 9IDAgkacO3bah3U/i8RMnjs9wew8ey6s0BOv2A5Jc4JzjzHGMzC88GFFgY1q+4eRm5IKgyi2Bes
 EmRE=
X-Gm-Gg: ASbGnctl4cb0mFckTK8RwFDo9dwaSkf4DsBTZnfXtmdXBRT59uWjccs062Qnl4DtVe9
 lsXXVC9wKNBCIL5r9SK/nswxnG+4k89svtkTFzMH7MCQ16URRFL6B7dJE6TOGGV5UhHrTDPU1+D
 6zXqwZOKQq+bjHgyo7UF50NScXHnehj2tFfWBq9Pvx0i914QlMrORIhokOihNTDAK1YQy5o2lkW
 ZHWs7gYm11FSjLc7qhido6H7Ar4eu2wfttMS0CGCGpjaFnjNtOXLQ0evDyqovFkH9A/I/qU6LNT
 P7JoohPnHbEFg/DCo6AxBt4NWfSm76lnmK+HDCmOMe9fX6/a3pDRnq26QSL47vBA37rIPzCUyBr
 Ou2i3qVB19R0MMynSgCoPX/VvKhi/AD2dw7ExnoQxxMDKiAYFjT4Wiu13O5pprW6g
X-Google-Smtp-Source: AGHT+IH74hJcDM5MePFElpAJHqXjkrXQkdH9mQ7wizRQgtpJ2h6ZvbMtnv4pSmvI6A23KjiD9PIh5g==
X-Received: by 2002:a17:907:94ca:b0:b6d:529f:9702 with SMTP id
 a640c23a62f3a-b706e29aa79mr743624866b.12.1761960206188; 
 Fri, 31 Oct 2025 18:23:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b70779762bcsm324076966b.15.2025.10.31.18.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 18:23:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  1 Nov 2025 01:20:21 +0000
Message-ID: <20251101012320.24972-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101012320.24972-1-wegao@suse.com>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for .filesystems
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
