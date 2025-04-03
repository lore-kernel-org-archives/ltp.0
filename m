Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD3CC3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743663530; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NAyGIkfNCZvHifT7xHqxvXEpIo+4/wov341AGNtpa6U=;
 b=osO4aa04VyAob+z9SsVVmpLrA7nMg43h6a8TFyvHjEXZw6VpfkjKFuhxCNJ92+rEaSYkC
 oEPogwpE5o1eZYmzza9lqlo7ojzI/+SPmLhgKp4y5kRghOarp/f+XyihruIf8t7pyC3Ofjk
 NYVUz55h0aTRjsPi6+ZPXRWIyY8eCUI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EA8B3CAF0D
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 08:58:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387443CAD5E
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 08:58:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D039E10005B4
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 08:58:26 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso3180825e9.2
 for <ltp@lists.linux.it>; Wed, 02 Apr 2025 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743663506; x=1744268306; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYs4vzFo1xT3BTOMfn/Fi788a7GJA+1T8pRhYRN++AU=;
 b=eiynBIAreigGhWhPniLfksjlKZJzY0uoFZI+m78h1ywVStiFDPg8JtNv+PDQzigkNg
 XVWGTwWsr91CaQFj3ZZ1arGlJRejsjzqxABNgoBlOERH/NG6MLllj8LHpv1Zb9HrZ8vD
 XvjkKy7LBCv1HkTc8IabVoqAmFSpLQ0xkwn0ThX6IzZJWAKySUwCzY3AHbrwNx8BMJxC
 Ni8vz6NmLMK1bsrMBm0iANwl90R7KQgFPymN1QP8SfD8nIhpCSzCUHrgChi2QQ+7PvQi
 BQ8dW/NYlLou5Iu4m0sJsno8DKuclleYGBvdmk+E8YkboG0AWM+5KJY+TMVTT0aG1aEj
 QxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743663506; x=1744268306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYs4vzFo1xT3BTOMfn/Fi788a7GJA+1T8pRhYRN++AU=;
 b=KtR4XQXG1QMJUS8vjIX4Dk3/QC1PkQGybdZocvN/taDXQp1y4FD4rUrvzDDS1dPdDU
 xLSRRnr9AuocpoqZQugXmgQe4zneTjyNm1KvAvOxzltpPU/a3r7RSW7a3wLLsyygZxPn
 3+O5bU+t1mBFkA4gb2lK8+rNa6Wbqr6Nc5Z4L7bfv9VMlgidy1ebADesOY+JvcmRuRk9
 rO+ei4EatHy3+flidp/nXymSkd7upl0iN96NJo7O8JTxTdovtd6MQ/mKFl5qo9c0O1ih
 tAEw6oSGWD0BPADVMpQSsXLf24CBduF1Hn+9fP08AG+KAULSAp18EOU2rmwA0sy3NHQE
 6cog==
X-Gm-Message-State: AOJu0YwfR+ugL1BpRZvEIOuZqv29xFvnKtc5thjWn7f40TlZ5SLfTMJt
 LOB/W0F0MHc6SJS79iOSdsShgagGD1nMlGd8hC67MiGzQgoJqhseBSQjoY0TPR9fuvojFHu0W/v
 /SxL/
X-Gm-Gg: ASbGncsOfzBgHd9NNQsmSbAm6woX+hr68SDKVv+SdTS4A4R/2oJFr/3/5KIXfg1ZaX4
 EnWdj7s8+CYn0Ofid0MZZOqA2AiglblZe2dFVo7T+XIsoGz4n7zRTfZbhurlpxU3O+H1zUe3ZUZ
 13L9QZeyEekkRKuGB2sWtPyq7xr+OAAI4neIEFq6s0TKYwjWeTkHP5a8tBs+a6tU78mDNouKHrV
 O7FWiko8gH88d2MXW/E56E7e0t8zh1wU+WhCnIvFMxZ6sgcj5oGr0o6YjxYW4tLovNubUTNimft
 YFZIe1R1lp/MQauD6yZB20QiHcNfSEwi/Q==
X-Google-Smtp-Source: AGHT+IFZpTzdbFHkdWy22M+uKG9U9Ep4cz2cdvFJGwGHKWAjz9MgcBxZ+WzimwzuysVDZ/wVQDiSPw==
X-Received: by 2002:a05:6000:2905:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-39c2f8f23e8mr1215835f8f.34.1743663506059; 
 Wed, 02 Apr 2025 23:58:26 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d98bsm915026f8f.76.2025.04.02.23.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 23:58:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Apr 2025 02:58:18 -0400
Message-Id: <20250403065818.21722-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250401075642.16656-1-wegao@suse.com>
References: <20250401075642.16656-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] fcntl40.c: Test fcntl using F_CREATED_QUERY
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
Based on a kernel selftest commit d0fe8920cbe4.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/fcntl.h                       |  8 ++++
 runtest/syscalls                           |  2 +
 testcases/kernel/syscalls/fcntl/.gitignore |  2 +
 testcases/kernel/syscalls/fcntl/fcntl40.c  | 46 ++++++++++++++++++++++
 4 files changed, 58 insertions(+)
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
index 000000000..e90525fef
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
@@ -0,0 +1,46 @@
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
+ * Test is based on a kernel selftests commit d0fe8920cbe4.
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
+}
+
+static struct tst_test test = {
+	.test_all = verify_fcntl,
+	.needs_tmpdir = 1,
+	.min_kver = "6.12",
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
