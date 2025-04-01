Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82291C36018
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743494231; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IFlAXbn8jnlNvyyQWleo38+nALxBokVuEifgJkHHdlw=;
 b=fAjgqxfdV1Q33awzkd54qJGoTn4SUWJ/ZkFC+jPrzj1r7BLScBvrTsQlyD62K0hwX4iwN
 GLnusI8EtzwABbypAghe4izxa71THU5iOJY1xFLDVHN11/JtUe4oR4JvZuCW991Bu1TDr1g
 fcBBo954OhlKnELBjXK7ZgJDnggGbYU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E22343CAF92
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:57:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CCC33CAE86
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:56:50 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DEC51400512
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:56:49 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so27227685e9.1
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743494209; x=1744099009; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MfpCCOhEG8uM/4HHgQ68ZNYTEt9qvkyRdeLpWhPYP8=;
 b=fUMylFhkZkA0/2HxBTrAhW3D+Kkx9UnqnLTjSRH7Ik1JB8F9Dpyn+tTfzyW+d2ZQUR
 BqtmFKd1RFFcdafBeABAkb6eC5CEp9lPfLJKixOLE8IE+MahTRMVaZ0afGNRlpwWgPvp
 02xHBG5aYCXaqYwh8SlFfM2TcqptZq+jvunQCXYfTaTVV6wpjvlsDir/3Jwi90ED3G4I
 8ZZw/2nXn9uGmGklzM2+j1XRaoYBq4PHCrNn/oqqAe70psLT2ZhypnHvnJ5cM+bSyDIG
 9jNfbiIiylRTL5IV4la9qA39kXG7bAFRrFf49RiBvYhJfHZzs86xTW4d7Yk9K51Ox4KC
 K56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743494209; x=1744099009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MfpCCOhEG8uM/4HHgQ68ZNYTEt9qvkyRdeLpWhPYP8=;
 b=CQF9CZdmvnuM+izut1rATsJRXo+I+5z4mjSCzfjFj51Ugzsdw9E7AKdjF8yYURP9+e
 34+HRlxxunjnMK4xy4ZB39Plxe76pX/33hTfclis+3RPYIId4cbPGwpOvDZPzycc9JmU
 7YIXut0xEeZmRU+9OSTzQRyPdpYQrrYGnzpOW6paXLAPZhQpSi67ke++YX6rMHhWIonX
 GUuTbZBywdTeP5gydwVq3Ruml3VQQhpFxzx0Xu3eyFZG3uU0lVFVRU9z6ekZ493vZwZc
 3yWH0PDeoOJnUtNJKsxDM9AGO9aTkcI+dytDzvNOYR61UlcpCajO30zrCtL8YN/J1jcc
 32Gg==
X-Gm-Message-State: AOJu0YziTOa81qBKOsYX2tayHcXbLZcngRf2oKmhxQRFkwT/V1iDr5WI
 T3B4DvNjTykeLpb3Fe1axSJJCuIWMwKYzXi8nOFajv6VJX8Cq4YBeK5YefBI9BXmm7GTtGxuQ5u
 +hJrX
X-Gm-Gg: ASbGnct5oawNr0Bs5B1Rwlk/0TIbqA1lOaYZYqC/p3t+s2/jduk9iVYHlbA7zWNAHWK
 PlmwUiIB1dHk862tDn+5AeUmq921NhdabqSCBSacjS11C9UU7P99okGAqqwFtkWQJO+e2W5huF9
 HMQa8bx+iMFN0oufawC6CDtINoaY2v2v2X47GSIBN2KKf5ema57dT58h35H9vKdu4/KhebuzZzg
 mm8B3ME6WiG3aB87YvVZIkOcdE2vc9OG+U6MN6vkMyvpsw0+ytzGDM+BX4g6FiIOOa7mketszdo
 /nkgVUPFTYS60ybUBP8CtzCyyecrVMi5FA==
X-Google-Smtp-Source: AGHT+IHT/o3l0TQ+Tb1DN3LQLXVTVbyiflxnbzPvOQfSgdQrPGzH6VDOOPNbTCt+cc3lUeH9y/Zoxw==
X-Received: by 2002:a05:600c:1f8b:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43dbc6fb97fmr119116605e9.31.1743494208790; 
 Tue, 01 Apr 2025 00:56:48 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13823550f8f.54.2025.04.01.00.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:56:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  1 Apr 2025 03:56:42 -0400
Message-Id: <20250401075642.16656-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250301063134.14515-1-wegao@suse.com>
References: <20250301063134.14515-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] fcntl40.c: Test fcntl using F_CREATED_QUERY
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
index 000000000..882e0163f
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
+	TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(TEST_NAME, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
+
+	TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 1);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(TEST_NAME, O_RDONLY | O_CLOEXEC);
+
+	/* We're opening it again, so no positive creation check. */
+	TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(TEST_NAME);
+
+	/* tst_res(TPASS, "fcntl F_CREATED_QUERY check pass"); */
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
