Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33E6C83F17
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752624428; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=fjyyJD5BZ6YaMpJWL5GW5tatxd/o10NjNV6KuIT8SqM=;
 b=hyhsE4POArtiBJFwQaC9zbTdAoDOHqPQrnkhMX7cw2RlBA5ES4lx0woZdopH5ELuCLht/
 7BrlO1LMHh39a78eEmM6dpEe1t8VhTpAIOilBMzTJSlpQz7u6UozNE+EvRswMwlr2aJxx7N
 5jRz2xpMs2N8grk9p7kDnXOtkYVoOpY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCE093CBBFB
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 02:07:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 560043C06E9
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 02:06:47 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D9C7200C13
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 02:06:45 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so3414202f8f.0
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752624405; x=1753229205; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KCmodZ2TfKG4bVU2m90wY+1B/1kKJ5pV/t2wmpwNwCg=;
 b=ex9M/xGk59zLnUWqxftYMTPey1H21kiQvaEEYI74/g7Dth7ZAIK231jZJKjrooEVGN
 b4poCGBq2lD+H8zEaTCSeCh+GjjlFp6wyV6M6gZyfVumQVJ+0oQ+Fe9cQT/JJWkcgS1g
 oroiSar8jcWS8idJ1PVfc3PNFxAYpzauqejH41nm0RvPb4tXgakNRnkC7Z4uyarJMnSX
 wXlBhcjPYSAkp+RlbGXN/n9FBuicUbdWUQ+7VP4bfXCq6T61Fjqbm6a1dUYU9lRNkFyT
 sk2oChgxjh913BGvFwZQQCB9Jgr7YPyWB4PTb5qFrA9SPAMZb7t7JqSYGosvtfU1OWxW
 mSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752624405; x=1753229205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCmodZ2TfKG4bVU2m90wY+1B/1kKJ5pV/t2wmpwNwCg=;
 b=JJSaNTlCnO/OqXU8g5OR1Zt0hekNogrhhr2QB1xK2z5x2FCD6fDBhazhNxGGI2rlaF
 NWL+CeVvp827T4GyP35gzZek2NLBxlWhPrPxVgR2hWnuQSN9psY12tMGsKKSv+hQvc/d
 MWmaXzOthdDX/F+G6DGJiM94Qxk9EAoegA+owMR2YkX3/WoDNNC1L4Nu/B6jcMFqCAOW
 WsmaB2ytZSG2L4xR3OXRwKWTpLeZoWWaTVxxqkW+l96EKkpvEIXjDH6hGVbwTWknT+ve
 SKDc//ZliofUsSNVWalVYLt7z0MRbOjAyP5reyA0iGlly4HxES0iSFKmBnamu/jfW2G2
 4WVg==
X-Gm-Message-State: AOJu0YylStEQKnSTNBf1imuGZzMtSsdSU8TakqttxLZC28HDdJ2b8eO2
 aaPVztPAULD1HGPHXTnIJ3eYATklY463zWvVSugWLpAN7jA8blA2rv8s7XgXV90Y1sqqumBwl8S
 5tjM=
X-Gm-Gg: ASbGncuQlFcSirrb9AD9Ch6w0vylYPgERwryozq6cuLc4jywuoDlRkyaiF4zlOOGvfw
 r7jdqjiZCYLbE4raroOPUAS5ufZSwQafs/KiLx59bJvRLEbTcNJ8mIXm0rNSpUXfNFet/VNdx/k
 /T9gEkHsh+weUunbuQve5H0d35q5AE+J+Q56asIxJPLlVPgoHXQIJjBXBQi5R0QDPd3bjyxxJRg
 Wdpkq2nxIH+xMrZUG3zC6fhodV2RENNgDb/Q+KWG/6KSLae/0H7oylU28qGGEMq81LbrLO/LFKU
 D8tzUyaUnLln92/zSNivhoVPB/XTPOa3OXKFIzrGvOPaNkMVvQgwO2pogp78X6h8/TtGfFA1lwl
 4fxeFU24vQZQ=
X-Google-Smtp-Source: AGHT+IFOXbfa+JwYuDpcL3DiyPCSpPBbjq1ziQijZDzc2BxJsQcepycyeAjddUwNmwhq1Wl+4QlYMw==
X-Received: by 2002:adf:9dc3:0:b0:3a4:f918:9db9 with SMTP id
 ffacd0b85a97d-3b60e5127e4mr214270f8f.32.1752624405099; 
 Tue, 15 Jul 2025 17:06:45 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74eb9f1f53fsm12880118b3a.91.2025.07.15.17.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 17:06:44 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 16 Jul 2025 08:05:57 -0400
Message-ID: <20250716120600.2855395-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] splice10.c: New splice tests involving memfd secret
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

Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
secretmem LSM bypass") prevents any access to secret memory pages from other
kernel subsystems.

Splice operations involving memfd secret are checked within this case.

Discussed-on: https://lists.linux.it/pipermail/ltp/2025-July/044351.html
Reference: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice10.c | 48 +++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b4a387b28..d6da59bd2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1585,6 +1585,7 @@ splice06 splice06
 splice07 splice07
 splice08 splice08
 splice09 splice09
+splice10 splice10
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
index 96b1727a1..5e98981fe 100644
--- a/testcases/kernel/syscalls/splice/.gitignore
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -7,3 +7,4 @@
 /splice07
 /splice08
 /splice09
+/splice10
diff --git a/testcases/kernel/syscalls/splice/splice10.c b/testcases/kernel/syscalls/splice/splice10.c
new file mode 100644
index 000000000..98ee73ef0
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice10.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
+ * secretmem LSM bypass") prevents any access to secret memory pages from other
+ * kernel subsystems.
+ * This case check splice operations involving memfd secret should return EACCES.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static void verify_splice(void)
+{
+	char buf[1024];
+	int fd;
+	int pipefd[2];
+
+	memset(buf, 0xff, sizeof(buf));
+
+	if (!tst_selinux_enforcing())
+		tst_brk(TCONF, "SELinux not running");
+
+	fd = syscall(__NR_memfd_secret, 0);
+	if (fd < 0) {
+		tst_brk(TCONF | TERRNO,
+			"Skipping __NR_memfd_secret check");
+	}
+
+	SAFE_PIPE(pipefd);
+	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
+
+	TST_EXP_FAIL(splice(pipefd[0], NULL, fd, NULL, sizeof(buf), 0), EACCES);
+	TST_EXP_FAIL(splice(fd, NULL, pipefd[1], NULL, sizeof(buf), 0), EACCES);
+
+	SAFE_CLOSE(pipefd[0]);
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_splice,
+	.min_kver = "6.16",
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
