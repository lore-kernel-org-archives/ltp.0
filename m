Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A290C35FF1
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 04:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742359693; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=t1KHj2kCoLDbq4jdTgCtK7/XxL4aJIe82vIO9gTOEFw=;
 b=DjmzT5QOGqO1pCf3Fged+xFD7cs8JQ23DXgXLOAvNzryCQ8k49aU2srBVCoBc4RYa6Boj
 0Kz8s987Bz77mEBh3U1NB5T79oXzhdZ2v06BUGXeQWEdd9oRsAQzR/IB7sS+BjBu0ULGtSY
 SzS8LUXNZAvXWbqmRj2HWog3TvEMgZo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D233CAC53
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 05:48:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFC943C9B43
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 05:47:52 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FBCF600755
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 05:47:51 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso38613895e9.0
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 21:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742359670; x=1742964470; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Wx9JRrMJoHKRcBtgnsooYBiahfQzrfbaYgWqJRx6tA=;
 b=Z0J894ouJAC7LfCv3em47Qoorqr5UE03hh6q0uw80q0uc89tTQhYN/BoeS6x9A71eE
 3wx0Q1kgoKqoxXDXEsDXJmcNC7zAmXTKbWHoclCbibwUZzKPAqdHMr/I7unZdB3FSBg/
 snzg7K1cboWY6eW7YHSyiZYYDTHBNeH/3slMXHYTBiwt8xic4pUcKxxNRtBSJup7Ivaz
 aU5ArAwI18/i6LJx/wwxCAJvYqLlIijpWa6c3B2WlVSMxZQPH9Ppb2gKnfbjMLoji/wn
 E5bu0c9eDrz5AF0KFu9zKcwI6aWr3/mx+Z4VsmxvMcnD2gj8Qe9F69mlOdV50WPeF8Ld
 zMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742359670; x=1742964470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Wx9JRrMJoHKRcBtgnsooYBiahfQzrfbaYgWqJRx6tA=;
 b=tmN6j28emcA82NCek/qxqF4BgdDX2bXN++A4nymZUi7NW54Pl0WuSEERYqA9LC2OZ9
 0bCf1tJng+nP2EwDcrlI6B/sB/C2ZgOkjabU+O+L4YMVvtxrRZBrRCo3YghKZpZ+TKni
 jKFbQguEAWa+3tXpq+o9xRuaQxaYH4S7Vii4cVWs05GIcpJDjcsqsX130qA+HtiMrjRA
 Lhwi1mwLj4yVsYHqTf8iz/9BrTZy8pEgF0Q4C4VvuRuNw9WbZSQK8khU/LmeaK/NmYY8
 +B3mHHrSf1YHdmBIyeG4bFOdOzVUoMIUlTSNHiE7EwScyYUz4ZWOl9Dx+hy8MECxuI8J
 SPjQ==
X-Gm-Message-State: AOJu0YyQpPkaKX2mB5/ymUyLcFmaXM6B4wVavhlHumsvC9Yp5wBfjj8C
 JhIUd+HJcROpyXU+dH2ZDOSSuuBRybCcs3C3xyxxoZnDDXzDVkqLIBDkX0+25d8mZUUa+SUFyUL
 jN8bVO1g=
X-Gm-Gg: ASbGnctOBnR1+PBqbOJNWqvjVuz7c2VnLfrBHytnpUjzaCchKaHovRpoqCHWm7nPQKc
 mOINGoUflGZhCd6tRGOX3TZZDpHT6FHBuMOqaiRvvyLXosYB2iJewVoWLjv/CyTtfMO9+Ias+9G
 W27v143430kuvj07ME9sMGvSmLjHVD+D8BE4/vqBlylGF5YbFhj5jI6WRd3vccMhSm1aO2wRYWe
 5ebUZcNy9CTUr4XtICwN0es+o70yW8rQhJqNq26ddjVEKePznTvBc++s1+pEWPf7NNMll+lWhci
 AUcMw14grg6ohYpG3/wmfv5xbWfXZMpv5Xg6+Wd9XScl
X-Google-Smtp-Source: AGHT+IFNUFM8XPI4XA36h7Fo4X9pJ91jb6i+KHNi16o29XW1SMTn9nzqdVxib88J0yPglpdNg2wOfw==
X-Received: by 2002:adf:a40d:0:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-399739c6b29mr817141f8f.20.1742359670382; 
 Tue, 18 Mar 2025 21:47:50 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578d15sm10572331b3a.82.2025.03.18.21.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 21:47:49 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 19 Mar 2025 00:47:50 -0400
Message-Id: <20250319044750.19434-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241225114215.2973-1-wegao@suse.com>
References: <20241225114215.2973-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mount08.c: Restrict overmounting of ephemeral
 entities on /proc/<pid>/fd/<nr>
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

Add a new test to verify that mount will raise ENOENT if we try to mount
on magic links under /proc/<pid>/fd/<nr>.
Refer to the following kernel commit for more information:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/mount/.gitignore |  1 +
 testcases/kernel/syscalls/mount/mount08.c  | 57 ++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount/mount08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..d3abc8b85 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -852,6 +852,7 @@ mount04 mount04
 mount05 mount05
 mount06 mount06
 mount07 mount07
+mount08 mount08
 
 mount_setattr01 mount_setattr01
 
diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
index 80885dbf0..3eee5863a 100644
--- a/testcases/kernel/syscalls/mount/.gitignore
+++ b/testcases/kernel/syscalls/mount/.gitignore
@@ -6,3 +6,4 @@
 /mount05
 /mount06
 /mount07
+/mount08
diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
new file mode 100644
index 000000000..1938c5519
--- /dev/null
+++ b/testcases/kernel/syscalls/mount/mount08.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify that mount will raise ENOENT if we try to mount on magic links
+ * under /proc/<pid>/fd/<nr>.
+ */
+
+#include "tst_test.h"
+#include <sys/mount.h>
+#include "tst_safe_file_at.h"
+
+#define MNTPOINT "mntpoint"
+#define FOO MNTPOINT "/foo"
+#define BAR MNTPOINT "/bar"
+
+static void run(void)
+{
+	char path[PATH_MAX];
+	int foo_fd, newfd, proc_fd;
+
+	foo_fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
+	newfd = SAFE_DUP(foo_fd);
+	SAFE_CLOSE(foo_fd);
+
+	sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
+
+	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
+
+	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
+
+	TST_EXP_FAIL(
+		mount(BAR, path, "", MS_BIND, 0),
+		ENOENT,
+		"mount() on proc failed expectedly"
+	);
+}
+
+static void setup(void)
+{
+	SAFE_CREAT(FOO, 0777);
+	SAFE_CREAT(BAR, 0777);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.min_kver = "6.12",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d80b065bb172"},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
