Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88932E77188
	for <ltp@archiver.kernel.org>; Sat, 28 Dec 2024 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735392767; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=lG5ATCk8eYVJigB3ssqp1X6iwDOsO4tWame8GPRTxRI=;
 b=KCoWJrse9xOiCnh+6l6IJ56eokVvYsmmysPu+oG2eFO7wDDxBmJYZSGw877hj2MQq+/W6
 Y4CVNSJYoa8tcmDoW2yMIFrZCgIJ3jaO6/XavGDWKriGxsHHLVJ0GyoGv0SULc/b/XE0QUs
 gU4zPoqtSYMJjz7fj8m82POEJhckLPY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B41053E576A
	for <ltp@archiver.kernel.org>; Sat, 28 Dec 2024 14:32:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B4393E11CC
 for <ltp@lists.linux.it>; Sat, 28 Dec 2024 14:32:25 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AE5AD625B72
 for <ltp@lists.linux.it>; Sat, 28 Dec 2024 14:32:24 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1102275366b.1
 for <ltp@lists.linux.it>; Sat, 28 Dec 2024 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735392743; x=1735997543; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0fqGXbuVw/1qan5dm8yor8PhLe/zYJR0LGoP0lPv0v8=;
 b=QzjKlx6vlDmyeMeTyDzMUTcAytQFHxuF8fG20vMoZoHO3ICL++hconWTq5aE/f/eZw
 FfagmIRhxnnlCHtBT/OpmM17ZUdws9gLCANzlUmR6Zu+VUx4WN09RVuYtV+2vv0Tpr/r
 L0lAMTpw9h1it1vNuAXgUXV0N87zjN1lWdIh9RwAv7arSviK1rVbTKd5nz5PR1dTfd3t
 my0ida8SbUU2/0276mXA0A7UteqDw5mbYaSt2o9JAQph5iNZSy60KGa01FiNYZ7+vAha
 RmR6CBKVAUzncYQQhhiafcCY1bezmf4SArBEahND8Sd6iJrC06IwkIIiqqVlPtyeoFdr
 Q+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735392743; x=1735997543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fqGXbuVw/1qan5dm8yor8PhLe/zYJR0LGoP0lPv0v8=;
 b=Vq+7xxxn5BQpGk/b6vjcw2svpQtP67oWNUHpsRvgA0vmSvTdXXs3fpD3eO4+ESYCZ4
 lPhMSpDiXGYELV0HRssoEWted5Lo6L9hyPZeeLB5XQNqhPize4K/+mSVJmGGGEs5nukW
 uRu0jSotDkAdZQbrMhiLoaIYduQb+xjUMb7VmCGsf6LuHBfc/juDTnAbFkM1aLT4kU7l
 2+StHAwIdtyzP13gVSkBssbPN77tpldBwTEp+Bwd/OPzlG5RgRqGKM26jms3lQkH2cUL
 shpjK8M7NA8Jfwfg86sswwGy2c39RXWxqrwJKz8yP661PLxqNqt0YK+TtT1LHDDlNMrd
 G8ig==
X-Gm-Message-State: AOJu0Yztotl/O8okZHtXWz3njTtuxR0nKmhg7gcL5dGmQBTLCezqobo3
 yP3wjHJWbl+YBtgYReKOqUL9S+lCJSpVl34Kf8Pb73vbyQYQ7AtywRgTAT82zCJbodYim7XlqQM
 =
X-Gm-Gg: ASbGncsS66eDzqKa7yPZfsR9o7A3FPQ2Ssc7cBdZt4IUI/8AhtoIspIQ8mX7g8QxQr3
 y6bX+yUbyPyV6MbAA0DHtA49k8Le+otdF7JpWDB+0fVYEPvAQuxLA3TfK0LgcKHaDZVacOCVxht
 ymfTSWO7KkPC4HVMX85/98CKLAtOSfo+m3gXm7GYp8ObCVUt6t6S1HIHHmgZSaBZh3cQbmZHR8T
 wJPefbkPr/A1ZLvN+fSHq6Pv4gjJ5Cw46Qo4i7dUkIlCg==
X-Google-Smtp-Source: AGHT+IHMC4LAby+e5kmsAZYsNDH7mOvKKpNJ0U43GKdSEfjGx80+vgfDBmaUGdR2slj+3Ns8HWoCMw==
X-Received: by 2002:a17:906:9c8f:b0:aae:d199:6eae with SMTP id
 a640c23a62f3a-aaed1998ef7mr1769099266b.14.1735392743405; 
 Sat, 28 Dec 2024 05:32:23 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f014538sm1258403066b.146.2024.12.28.05.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 05:32:23 -0800 (PST)
To: ltp@lists.linux.it
Date: Sat, 28 Dec 2024 08:32:17 -0500
Message-Id: <20241228133217.28945-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mmap21.c: Test for new MAP_DROPPABLE flag for mmap
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
 include/lapi/mmap.h                       |  4 ++
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/mmap/.gitignore |  1 +
 testcases/kernel/syscalls/mmap/mmap21.c   | 73 +++++++++++++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap21.c

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index ea9730586..248b64564 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -87,6 +87,10 @@
 # define MADV_PAGEOUT	21
 #endif
 
+#ifndef MAP_DROPPABLE
+# define MAP_DROPPABLE 0x08
+#endif
+
 #ifndef MAP_FIXED_NOREPLACE
 
 #ifdef __alpha__
diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..7166e39a4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -840,6 +840,7 @@ mmap17 mmap17
 mmap18 mmap18
 mmap19 mmap19
 mmap20 mmap20
+mmap21 mmap21
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index 4591fdbb9..87b23aaee 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -18,3 +18,4 @@
 /mmap18
 /mmap19
 /mmap20
+/mmap21
diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
new file mode 100644
index 000000000..e2b8c4551
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap21.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test mmap(2) with MAP_DROPPABLE flag.
+ *
+ * Test base on kernel selftests/mm/droppable.c
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+static void test_mmap(void)
+{
+	size_t alloc_size = 134217728;
+	size_t page_size = getpagesize();
+	void *alloc;
+	pid_t child;
+
+	alloc = SAFE_MMAP(0, alloc_size, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
+
+	memset(alloc, 'A', alloc_size);
+	for (size_t i = 0; i < alloc_size; i += page_size) {
+		if (*(char *)(alloc + i) != 'A')
+			tst_res(TFAIL, "memset failed");
+	}
+
+	int *shared_var = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	*shared_var = 0;
+
+	child = SAFE_FORK();
+	if (!child) {
+		for (;;) {
+			*(char *)malloc(page_size) = 'B';
+			if ((*shared_var) == 1)
+				exit(0);
+		}
+	}
+
+	for (; !(*shared_var);) {
+		for (size_t i = 0; i < alloc_size; i += page_size) {
+			if (!*(uint8_t *)(alloc + i)) {
+				*shared_var = 1;
+				break;
+			}
+		}
+	}
+
+	TST_EXP_EQ_LI((*shared_var), 1);
+
+	SAFE_WAITPID(child, NULL, 0);
+
+	SAFE_MUNMAP(alloc, alloc_size);
+	SAFE_MUNMAP(shared_var, sizeof(int));
+}
+
+static struct tst_test test = {
+	.min_kver = "6.11",
+	.test_all = test_mmap,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.max_runtime = 180,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
