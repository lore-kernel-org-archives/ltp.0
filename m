Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB34E7718B
	for <ltp@archiver.kernel.org>; Wed, 25 Dec 2024 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735127371; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=HvAbG6Ixu5RNA/8M2aWMO8tQx+3etZRzyWIcrcoWU68=;
 b=PzX+LCHSMWjeI9feuh9AV2gKwKg7IYI6j4v9AzBuM/EGFkbkRmEuJbXMZT9Zug6UuabSQ
 C8wRQptFC21AmO8xTMpEm1XXNd31KhUTjp/h5ghAPiVGFBK0hDK/jrQI38gS2Odh6hzCE0I
 kuDvdZO0aT3wgCNE9Lp4oUcDERkAqMw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 788423E4E56
	for <ltp@archiver.kernel.org>; Wed, 25 Dec 2024 12:49:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57C483E271E
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 12:49:10 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 73D4410005CF
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 12:49:09 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d34030ebb2so3358031a12.1
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 03:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735127348; x=1735732148; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DcbBqonNAAZs53xXlzvWHxq0+fW/8Tkc1kH8lvYsX7g=;
 b=arMqjehoSwJamz0NBOojUfGj1cycGzsIF0cUnx2OmY0CUuB0MQX43F3F6naDOsNObT
 oUFQXmXoR1AkaHR/HvZSs8sCvw6CRUUighhQI0iWxl/pINbK2iN5r17vxxONB5+rbyvc
 lO+Zm1jf3GQ6SeYlHi6Ra/8daMGm0WgOucCRtKhigrI4QLZda/XI6Ke4NDjc+ix9YUGs
 8D5mP5cnbaWz4c+6vfVBUXdm7q04yusMUvtdqV4uH7DR3fdUYhT0aoHJzazMVis5F5xH
 kpOyYSuj66CKIrtFk7pEBFlXdSt11ay7L9h1PpAmhtfta8lGLnJPbbELP+XfjoryQLbD
 Oitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735127348; x=1735732148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcbBqonNAAZs53xXlzvWHxq0+fW/8Tkc1kH8lvYsX7g=;
 b=d3luraH7BxGbKMXi+2rqDmTfZB+xE8htQpJeZbJcQQ8tAMLxdGck51oa/kCSzpN2AN
 Ja/Ff0gg+D70faYqDqbZAX99cImK+k7oE9t7u4PzxYsfJaTzuMCXnzqgbQrNU+xSVc/7
 z2K8Gzc8bdouOpYmrW8lGIXLzWmb1Yh7r98DFpObR4oZSgFKpbW/Q3zDIaPzgbFpWGAm
 VH7E5EtXZ+gbsL97Won7iRw+MqtHtg2lE17RXU4LwzSQah4bekufgkaIWnXq2J+/iAdz
 HDbzgg2AN6uBIMP5QrXMeiJVSoU0VD1OhylTMUQmwkjUmJ74NiGZ/Vwf6Qi/M8785gQN
 fwrw==
X-Gm-Message-State: AOJu0YxX7WiIlu0C2s2PMS3vlmN6u668vj413wtOsxY2vFsLdZW8yrkK
 1Y3/0z0UiAfXJ9KDtruPEkgebmTJOdCV6f+FmpPJs1fFB6ODyTjfZlDn6Il1npxQ2eR2QWPAqC8
 =
X-Gm-Gg: ASbGncummYuBIdIfW0SHduLVqBEahcbA+f0l+Trk6wijA2ol2W6ly3Lr4CbE4DnCLeA
 +9ESPSRmzuN7MwsClFr5st5GYxpm2KPAhkWj8v4p/3YA8jQ3o/E8tGjKTWsBPQZm21Xs2WnCJKE
 bgVmdqkwfQCbg8mGSqT5QaB4EYSwCU0SvWjUa+hNLRiJMjqkP1KLWZnyurI01gHRqeQ4iZ6hg21
 U3Q7Op47J0zmVblh4TxDrVvVaOPfvNYo7bVHhUYWOemsg==
X-Google-Smtp-Source: AGHT+IHZmyfZc5/NC4YhdInZNGQpfiMiWerxKF9zCd9VwJXgzZJPQ6YqHuocl09CiF48RABVDluw8A==
X-Received: by 2002:a05:6402:5256:b0:5d0:bdc1:75df with SMTP id
 4fb4d7f45d1cf-5d81ddf7fa6mr17255417a12.24.1735127348261; 
 Wed, 25 Dec 2024 03:49:08 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80665253dsm7369015a12.0.2024.12.25.03.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Dec 2024 03:49:07 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 25 Dec 2024 06:42:15 -0500
Message-Id: <20241225114215.2973-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mount08.c: Restrict overmounting of ephemeral
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
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/mount/.gitignore |  1 +
 testcases/kernel/syscalls/mount/mount08.c  | 56 ++++++++++++++++++++++
 3 files changed, 58 insertions(+)
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
index 000000000..9b54ea835
--- /dev/null
+++ b/testcases/kernel/syscalls/mount/mount08.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test check restrict overmounting on /proc/<pid>/fd/<nr>.
+ * It is based on the following kernel commit:
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172
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
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
