Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0E6C35FF3
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 03:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742528599; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=aExEjRZbiSIlgZd+KPs17KfmP7bGhkpaVa6Lqf1sQl0=;
 b=JxPAszqM1yImon1k1uuILfsoadxenmv+XDhbDLzr+bgqX6Q7+8qdbiQuawk10NJxuxfUm
 CiXdCwbQrlVuvg8hXp3GdJ1av+LEfuySwfcAMOuttTfRSIHg4HDDqoX0ztNCW3ESMxoINdF
 JBDRuJFqZ8iBdoNWx34zWjE1sZZbxwY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 445C13CAE7B
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 04:43:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 419683CAE7B
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 04:42:57 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3A50600735
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 04:42:55 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-39143200ddaso898715f8f.1
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742528575; x=1743133375; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzd0KAm1/in1+khAQzATflT9w1LYbw+GtgFjraK+z44=;
 b=DaBpCvUnRld6FHBahvdd7/VXKP44yuo2DFuoQN4xBRwdFNpzZaO1JoGB3O+hK2LNvp
 6KQLYiNXvpYveTmr8+feD2Vev5OsvnC8CZVf6c0rBmkvxf9ctMPhr9gMfyMb28TxX+09
 1u93DyckikK1VGV2qmdemeb6IDTHMqVvOK2Am/qH6rjv3OZFF7BNg8HwPt/55JPSdOhd
 i50pqDCwDq8mxyDASxUPKQhmeSVXo0RzsSo2uuS2pTdgEbLrxRB1NzP/K0d87bMx8fwV
 ddIVGxSyS4DIRTOXbY2d2du1IuYIQoCtP4ui938fXKpxD1bvuabXz8rTYhXEaLGYZPfZ
 ErXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742528575; x=1743133375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzd0KAm1/in1+khAQzATflT9w1LYbw+GtgFjraK+z44=;
 b=eI8KCp75cIvujSCQmXB5Pw4/J5PxUGavgyX0pY+nFuFflPVATWfTGqJvQVN0N0pUmj
 d+unIg5sae6C9+LSQnLeqwD50nZiM00K+t4ScpnrZVS1xOvHg4xslVhcfuVUJAma4jX+
 EpJmSV5v4dR2uMCJUsZWEZ7xuAaxzY3f3G/WJp3X8NoOKZV4FySNpZcr+/+tEREXYhUP
 1UXCOGyagds+QWxN9omS10y3EvLpZW7AVgIIuERoK5838xnKyHIex71g9am6+2Nh+wL/
 K8Sb+Nw3BHnjgCk7weej3hf1K7Qq2igXsQHKLI5BygEFPKdOJYp22fbWBLkc1flBxuld
 x5YA==
X-Gm-Message-State: AOJu0Yze5MRQTLSKQ8AOp4R4wqFUYsmEH+DBDDhzhKf6TdOhShAdKnJ0
 SU3FHTACF28TWU6QXIw7FipXD0aOXch21hCYqXLqtlPfqjaTZ8OXoE6eocOsEPwlpwUCY9i7EdY
 eMJFdGg0=
X-Gm-Gg: ASbGncvvHGUdzRb/J+0GLnTB4wR5Qc0dMeTRjFE+tepFzjK03QFGFavoZXwbLC3ZZ97
 fcassg+PXmoyhSBhDMPvLM6mpwh/3Urp3nueIA5qTWEbDQlkIJSCH110r2R4uuB4up/GI03TsXk
 A0qtMi3e0ywmRXJ9Wk+0UYhM12yA9b/eb8vb5ahCb2JKSZ21Iu6+oWhBeAZImpgkyqd8dVILb8D
 +4YXs1OZrK5M30bMEwgFqvkxdajJoirAp/DGLzXSkrELQ4Py1894uBhEIj3i4b3QgSYRWm3jloN
 UkQke9smyoykuYywndEc3MOMEHPd/KMPrQw3iQ/Kez1O
X-Google-Smtp-Source: AGHT+IESmG1Zk1ULirpJmT8YpVkXxI74m+BrRnKdoDbu25r7NOmT61AnCTWBmsKerbBJxEDnKKMfJA==
X-Received: by 2002:a05:6000:156e:b0:391:2b04:73d9 with SMTP id
 ffacd0b85a97d-3997f93d5d4mr1513949f8f.49.1742528574714; 
 Thu, 20 Mar 2025 20:42:54 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28001efsm719126a12.22.2025.03.20.20.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 20:42:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 20 Mar 2025 23:42:48 -0400
Message-Id: <20250321034248.3501-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250319044750.19434-1-wegao@suse.com>
References: <20250319044750.19434-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mount08.c: Restrict overmounting of ephemeral
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

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

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
