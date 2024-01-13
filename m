Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F7CC4706C
	for <ltp@archiver.kernel.org>; Sat, 13 Jan 2024 14:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E2A43CE3C0
	for <ltp@archiver.kernel.org>; Sat, 13 Jan 2024 15:50:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E37853CA4A9
 for <ltp@lists.linux.it>; Sat, 13 Jan 2024 15:49:59 +0100 (CET)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 1BBA6201172
 for <ltp@lists.linux.it>; Sat, 13 Jan 2024 15:49:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UaiHy
 t1sSRJaSE+Vog/y39DUV2IeecXASyvR7MN+6sY=; b=bHXTWOvN6/zrCF+FS8trE
 apVKMh2HTPW6znk1PBJmbyhgSXQKIArcutC0P67Z7GEzJJziJiFVcngvvz3QKCHN
 QnOuewMKA6PwQll/N+2e46VVcKxOO7IrOfdqpxynlkibqSIbaOt6aSK3t7baDB8Z
 n6KtS45h0qjyOIEg9iByzs=
Received: from localhost.localdomain (unknown [183.210.226.120])
 by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3X1IFo6JlDGAUBA--.25846S3;
 Sat, 13 Jan 2024 22:49:44 +0800 (CST)
From: ice_yangxiao@163.com
To: ltp@lists.linux.it
Date: Sat, 13 Jan 2024 22:49:39 +0800
Message-Id: <20240113144940.133746-2-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240113144940.133746-1-ice_yangxiao@163.com>
References: <20240113144940.133746-1-ice_yangxiao@163.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3X1IFo6JlDGAUBA--.25846S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4rtr18ur4xtFW8tF1rtFb_yoW7AF4fp3
 y7K34qyws5ta1xWrnrXF48Aa4rZ3WfAry3u3W0yrs5Zr4Fqw15JF4aqFy5JFyUXry7KFW7
 tr4furW2y3WrZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQIDcUUUUU=
X-Originating-IP: [183.210.226.120]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqAJkXmVOBoai8gABsq
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/pwritev: Make make check happy
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Xiao Yang <yangx.jy@fujitsu.com>

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 testcases/kernel/syscalls/pwritev/pwritev.h   | 19 ++------
 testcases/kernel/syscalls/pwritev/pwritev01.c | 20 ++++----
 testcases/kernel/syscalls/pwritev/pwritev02.c | 46 +++++++++----------
 testcases/kernel/syscalls/pwritev/pwritev03.c |  2 +-
 4 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
index 833160ddb..6c12027b5 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -1,18 +1,7 @@
-/*
-* Copyright (c) 2015 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
-*/
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
 
 #ifndef PWRITEV_H
 #define PWRITEV_H
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 66358f7c4..4c2b84c5b 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -1,17 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2015 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
 
 /*
-* Test Name: pwritev01
-*
-* Test Description:
-* Testcase to check the basic functionality of the pwritev(2).
-* pwritev(2) should succeed to write the expected content of data
-* and after writing the file, the file offset is not changed.
-*/
+ * Test Name: pwritev01
+ *
+ * Test Description:
+ * Testcase to check the basic functionality of the pwritev(2).
+ * pwritev(2) should succeed to write the expected content of data
+ * and after writing the file, the file offset is not changed.
+ */
 
 #define _GNU_SOURCE
 #include <string.h>
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 0881b7566..de69d5add 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -1,30 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2015-2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
+ * Copyright (c) 2015-2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
 
 /*
-* Test Name: pwritev02
-*
-* Description:
-* 1) pwritev(2) fails if iov_len is invalid.
-* 2) pwritev(2) fails if the vector count iovcnt is less than zero.
-* 3) pwritev(2) fails if offset is negative.
-* 4) pwritev(2) fails when attempts to write from a invalid address
-* 5) pwritev(2) fails if file descriptor is invalid.
-* 6) pwritev(2) fails if file descriptor is not open for writing.
-* 7) pwritev(2) fails if fd is associated with a pipe.
-*
-* Expected Result:
-* 1) pwritev(2) should return -1 and set errno to EINVAL.
-* 2) pwritev(2) should return -1 and set errno to EINVAL.
-* 3) pwritev(2) should return -1 and set errno to EINVAL.
-* 4) pwritev(2) should return -1 and set errno to EFAULT.
-* 5) pwritev(2) should return -1 and set errno to EBADF.
-* 6) pwritev(2) should return -1 and set errno to EBADF.
-* 7) pwritev(2) should return -1 and set errno to ESPIPE.
-*/
+ * Test Name: pwritev02
+ *
+ * Description:
+ * 1) pwritev(2) fails if iov_len is invalid.
+ * 2) pwritev(2) fails if the vector count iovcnt is less than zero.
+ * 3) pwritev(2) fails if offset is negative.
+ * 4) pwritev(2) fails when attempts to write from a invalid address
+ * 5) pwritev(2) fails if file descriptor is invalid.
+ * 6) pwritev(2) fails if file descriptor is not open for writing.
+ * 7) pwritev(2) fails if fd is associated with a pipe.
+ *
+ * Expected Result:
+ * 1) pwritev(2) should return -1 and set errno to EINVAL.
+ * 2) pwritev(2) should return -1 and set errno to EINVAL.
+ * 3) pwritev(2) should return -1 and set errno to EINVAL.
+ * 4) pwritev(2) should return -1 and set errno to EFAULT.
+ * 5) pwritev(2) should return -1 and set errno to EBADF.
+ * 6) pwritev(2) should return -1 and set errno to EBADF.
+ * 7) pwritev(2) should return -1 and set errno to ESPIPE.
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 8b91de336..e60ef191e 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -90,7 +90,7 @@ static void verify_direct_pwritev(unsigned int n)
 static void setup(void)
 {
 	int dev_fd, ret;
-	
+
 	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
 	SAFE_IOCTL(dev_fd, BLKSSZGET, &ret);
 	SAFE_CLOSE(dev_fd);
-- 
2.26.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
