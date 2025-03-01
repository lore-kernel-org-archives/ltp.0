Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2C0C021B8
	for <ltp@archiver.kernel.org>; Sat,  1 Mar 2025 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740810724; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ennPK459j4K3QwzyZIDea3JahYBmiIavJTW4IbPFkfE=;
 b=f05xSod9ucm05O40aSeBJGlGg0OX3f1wVA9qkhAZUqEVDqSPhIsQ5hlfWExwD+3qkoCsn
 XD9yWk3Ks+wDuBFC3TND7YRGtTDu1wB68te9br1PcGf8uCD9eg0vAIc0MWPxB4WttrV31kK
 /1mNt/JbaDN41l6oH+8QcRT1hpCXoBA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64F343CA03B
	for <ltp@archiver.kernel.org>; Sat,  1 Mar 2025 07:32:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 431EA3C9F73
 for <ltp@lists.linux.it>; Sat,  1 Mar 2025 07:31:42 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F26B36331A8
 for <ltp@lists.linux.it>; Sat,  1 Mar 2025 07:31:40 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390df942558so2212788f8f.2
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740810700; x=1741415500; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojEVwuny/NzzFMN3gfry3eQz5tC6DEzfOG7I3sMWE+Y=;
 b=f6b2676g7U3z26gOL0mHo8vWF7QOEkIy8TyefMI8z64rBTSH+YQnLOGdrtc4wKMBs/
 glnd5ri+2gJwr/rJ/h4IZWYQDrunlfTLoolNeZoNkTSOyaoJAsMlD0JyR70lwcV4+yKF
 LAzyr3nOexXrsspkCpqCmIlt9+D6BZzNS5X+uKc8h7ks3IifEQZSjLbuDjzjEWz/QVqN
 wJcSl9XY7uWN+rc25So54wEbhIXnCHG2t7tJ5/UiVRqo9GJyY4mkmqLwbG45LZfcCoyk
 U7Wg5vG17f8EBMc+6WB4EAH7rF7k8ZkbBsfoeCy/1pP24ilylgdH1V5Yhqgmv4GsB3rx
 VhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740810700; x=1741415500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojEVwuny/NzzFMN3gfry3eQz5tC6DEzfOG7I3sMWE+Y=;
 b=NpQvIbP+aaYc0UVjI4m3o7kBX7cTIA8F48Z+J7Pj71c4MLvP/DFPcF5Kh+OFNYsloM
 E0wbtLO9fPwUTFCKpzpj+a8dI/n/e0f3B3CDwAuiiwrRvzPbXP62YYTuEwD1J5K6njWM
 FcLoTxk06nJpQrLbJhF6Y/voD5Koma5MC+lNyzXcSxbLY2Lh+n9K60iRfJQ2+TS/7xxs
 vle6KMEKc4wfi+o+262CJ5Ed/Ole2MRQ6l+DE/B2sGKtRs3oLsHbBKeMrK3Q27qQRznH
 BlFP34JSS91pZnqOuRWIjGBQ3MpELvqBwc08sCRnhb5FQohwIJVqvICA4+PxYwQezN4H
 B+/A==
X-Gm-Message-State: AOJu0Yzdk3LwtYZTJDwsSL6+XZhloRKq+fleThGjIGJf2evHo/YeJsb+
 7cl8xqKI9h8TO7KMVJ9c/omnumxLHfr84mExpqSP8e1brLT3bZBKX6evg0sTkDmJDqdCFUxoH11
 R0A==
X-Gm-Gg: ASbGnctVIXwbxq3eTpllUiwu0GQBnwHuezIqDe+RYDz2yaZ+xqZffinvlNGuODNmjTa
 dZDTI3DWZsXG0UoqfWIdOqVXSGUjSKZJA9KZ1SulsMNmyj7N+mfuL7KYrco+XhwIio9RW/QohTH
 DB/zosJHdOXY7G03LY18wAvO4WxpZjYZWFmHn7nRH28a9nBUkTZ6MkCVXi60Z7L54hdLZynPpOM
 uo5uIUriK57mNAwi92TrbS8Xxqxfh483Dqn4p67dlvqOBBw5Mt44o3VoK/P+sa8MJbXAcwpJhmt
 KmY4nx4d/mfPJTvjKcMvgYfyeazO9eKNG2Lsdkd2jw9I
X-Google-Smtp-Source: AGHT+IEVkmJ3z0e8vP0tONp9jdlT7SSo5dSEbNNy3396r9Pc1GAzhgCGJENNTTSTtizgFgxPRYMdGg==
X-Received: by 2002:a5d:5f84:0:b0:390:df83:1f5d with SMTP id
 ffacd0b85a97d-390eca52f6dmr5970572f8f.35.1740810700075; 
 Fri, 28 Feb 2025 22:31:40 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27af83sm81623095e9.30.2025.02.28.22.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 22:31:39 -0800 (PST)
To: ltp@lists.linux.it
Date: Sat,  1 Mar 2025 01:31:34 -0500
Message-Id: <20250301063134.14515-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241228114416.12653-1-wegao@suse.com>
References: <20241228114416.12653-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fcntl40.c: Test fcntl using F_CREATED_QUERY
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

This is new test case for fcntl using new F_CREATED_QUERY operation.
Based on a kernel selftest.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/fcntl.h                       |  8 ++++
 runtest/syscalls                           |  2 +
 testcases/kernel/syscalls/fcntl/.gitignore |  2 +
 testcases/kernel/syscalls/fcntl/fcntl40.c  | 52 ++++++++++++++++++++++
 4 files changed, 64 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl40.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 761331798..7c0502488 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -154,6 +154,14 @@
 # define RENAME_WHITEOUT		(1 << 2)
 #endif
 
+#ifndef F_LINUX_SPECIFIC_BASE
+#define F_LINUX_SPECIFIC_BASE 1024
+#endif
+
+#ifndef F_CREATED_QUERY
+#define F_CREATED_QUERY (F_LINUX_SPECIFIC_BASE + 4)
+#endif
+
 /* splice, vmsplice, tee */
 
 #ifndef SPLICE_F_NONBLOCK
diff --git a/runtest/syscalls b/runtest/syscalls
index 5cd1ae656..5ba2315d1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -364,6 +364,8 @@ fcntl38 fcntl38
 fcntl38_64 fcntl38_64
 fcntl39 fcntl39
 fcntl39_64 fcntl39_64
+fcntl40 fcntl40
+fcntl40_64 fcntl40_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index e60176973..e3486ee45 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -72,3 +72,5 @@
 /fcntl38_64
 /fcntl39
 /fcntl39_64
+/fcntl40
+/fcntl40_64
diff --git a/testcases/kernel/syscalls/fcntl/fcntl40.c b/testcases/kernel/syscalls/fcntl/fcntl40.c
new file mode 100644
index 000000000..2e4bef3e2
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Basic test for fcntl using F_CREATED_QUERY.
+ * Verify if the fcntl() syscall is recognizing whether a file has been
+ * created or not via O_CREAT when O_CLOEXEC is also used.
+ *
+ * Test is based on a kernel selftests.
+ */
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+#define TEST_NAME "LTP_FCNTL_CREATED_QUERY_TEST"
+
+static void verify_fcntl(void)
+{
+	int fd;
+
+	fd = SAFE_OPEN("/dev/null", O_RDONLY | O_CLOEXEC);
+
+	/* We didn't create "/dev/null". */
+	SAFE_FCNTL(fd, F_CREATED_QUERY, 0);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(TEST_NAME, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
+
+	SAFE_FCNTL(fd, F_CREATED_QUERY, 0);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(TEST_NAME, O_RDONLY | O_CLOEXEC);
+
+	/* We're opening it again, so no positive creation check. */
+	SAFE_FCNTL(fd, F_CREATED_QUERY, 0);
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(TEST_NAME);
+
+	tst_res(TPASS, "fcntl F_CREATED_QUERY check pass");
+}
+
+static struct tst_test test = {
+	.test_all = verify_fcntl,
+	.needs_tmpdir = 1,
+	.min_kver = "6.12",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d0fe8920cbe4"},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
