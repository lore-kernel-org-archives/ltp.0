Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291BBC83F1A
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753085206; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1YYm1f0udc9xCsfMKASRZQsFpHPofuKv1wGeRerYr5E=;
 b=Yec6JQzGDxRx4HSo6DRbgxiO9FWp5RfXFz4ysVkLPqC4IX/0LZtDdib2WVbqUOG7zf81Y
 IKjHAU0tPwe12bx4ksfw2T27Ox7P2Acjilgs1B06n10IuUikU+5pVciX5JZ1cMmqpo5FQhn
 3k3RcYI2u9zIFpxeVT2+AiVxJJdzHDo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC8363CCB49
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 10:06:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE8B93C2FB8
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 10:06:25 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C04F1A008B3
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 10:06:25 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so2082257f8f.3
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753085184; x=1753689984; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXEvnQS+LDfF93nCByJeNBnbxl+hxl7Dr8q4ugiOlf8=;
 b=Bow+mqncrpUeGKs3dPC1Omx+wFx9aYk6bT7WNKMiWiPNqwH5QY5borHOGbVk21hcHA
 aU5oV9kME+ZSdKOiF6bA9JFI1YG4yr/xflXEg7C6qwTJQBg+hvmLwEUzY3iDl95EEggN
 RIKazmOIV+th6kMOTxxc3KYNIcwSYveaiQcO2gt//bRODPAdCdElvX8WowEJ7cuusRrX
 QYO7eaPmU6YZGlug+BpON2erPMcFqSjQC2PJakdwtuta3djAnDxC0qDbyt3l6CLxqmkH
 TyzIAoYPrYaRrW9NotN7o3CxLi5RRAPuQzRWJC/p3TzET4WNJR0qohdW3hrSaW3OTyUR
 o8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753085184; x=1753689984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXEvnQS+LDfF93nCByJeNBnbxl+hxl7Dr8q4ugiOlf8=;
 b=d0tl0PhLZYkoWbc3ZCz96lPZJvw/ARfEAoKu+RXmIxf8MvZ4/+PKpMbNYQ9iqplZaj
 kGi3gAAqtJpIftyZ/32TSM7HnU/wZc2GVx/PwgNsdnw+q9XUV73qMUIbC9IHx4q0xyBA
 A8J+sGzGHQh39MRrAGPBPZKgL6ou7KaH97CuCrb1EzFu27K/2S2AqZZVggO+4ALrFGKP
 /YoBCgGEficOWj97BgCv0is4K2TvQtUiybyl/bXEtjKTJLgJS414uCVRmvOjB/Wwqz9x
 8eSUUq4RY545ktd3NNda2+Lv8tntlUm/3XuE65LbIhnp4jQOTeDZ1unbGl4pvfGxMw3+
 N/Og==
X-Gm-Message-State: AOJu0YzGxAKhz1MMNCH8O2dRKSh5RwRNfyrq1aXFr7BcX2mTkNRW93ND
 L5sf0dyQAIGD9Z/9qEbnjfW0//y4nAzPJHuI2sHg/iBgRV6DYs6eVCT7E0kvNkV0H4C/iuGwIYp
 e+S8=
X-Gm-Gg: ASbGncsNghiB6x8nsyR4ddUtTle3HNVyd2H1pYm0gHViqOI1ntR3xch+vLtB27f0xD/
 OSmMTwyZgppGNea2uHBy0thQ+zn+Dwg2W4HNCcXoQW98xXKYtIwGBu8ZnZmfsbzt0jgrB2PKyWw
 vuIZo6OJIJU50oL8vMnwt7fkZ//JVy/2cuMOwoPfW3A+d2QuV9LS7y7aR9p0gvcpW03tjLpmHeU
 TLqkTghpSCzdJ5QJVREGn3rej8jXuWLKh4Dbf9d0eA6Ka5O1dN0GpIwHU2ku8YIfoCsrMc0xWHw
 TdCF2JGmU7D7uSdbEve7HlOPWC0c4ZYgpwkAyo6PCZfY6G0nImUtnPZbNYe/Fhss/gGtQo/wMHI
 eJevHm9k12Zp//5P6arU3GQ==
X-Google-Smtp-Source: AGHT+IFNiGwdSliOD8ObyaUahsG6DAKBB1FOgd9myiAEow7v1JAxlXjP07sl+6GNgxUcDkwLFJXxnw==
X-Received: by 2002:a05:6000:188e:b0:3a4:eed9:755d with SMTP id
 ffacd0b85a97d-3b60e4d2312mr15908813f8f.3.1753085184163; 
 Mon, 21 Jul 2025 01:06:24 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23e3b5e22fdsm52653205ad.25.2025.07.21.01.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 01:06:23 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 21 Jul 2025 16:04:20 -0400
Message-ID: <20250721200428.2627117-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321151143.11332-1-wegao@suse.com>
References: <20250321151143.11332-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] mount08.c: Restrict overmounting of ephemeral
 entities
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

Add a new test to verify that mount will raise ENOENT if we try to mount
on magic links under /proc/<pid>/fd/<nr>.
Refer to the following kernel commit for more information:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/mount/.gitignore |  1 +
 testcases/kernel/syscalls/mount/mount08.c  | 57 ++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mount/mount08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e738c332b..3531c2a3c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -865,6 +865,7 @@ mount04 mount04
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
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
