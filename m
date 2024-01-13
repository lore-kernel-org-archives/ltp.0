Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06743C4707B
	for <ltp@archiver.kernel.org>; Sat, 13 Jan 2024 14:50:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 485833CE3BB
	for <ltp@archiver.kernel.org>; Sat, 13 Jan 2024 15:50:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 302423CA4A9
 for <ltp@lists.linux.it>; Sat, 13 Jan 2024 15:49:59 +0100 (CET)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id D5E6D1400C44
 for <ltp@lists.linux.it>; Sat, 13 Jan 2024 15:49:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=F7rDs
 22gRFQqKtAU0mQRHTOQu0UDtFEMsyFO6hdckf4=; b=fTQDxiOS4IZIQ6D1asnIv
 pemyjvu5c8sf3ttcBNlBCF809uT0T9eB8r2nDvt01d5HsQCMIn/ov9knXIFZXABX
 GYweswD1QFo2V1aG9l1T5/Ee/PYtWZTFiwSeC6rlh+SfaI1Eq6AQiUuq/4Ba0tni
 yDetiBE3+JHlQmjscFM77Q=
Received: from localhost.localdomain (unknown [183.210.226.120])
 by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3X1IFo6JlDGAUBA--.25846S2;
 Sat, 13 Jan 2024 22:49:43 +0800 (CST)
From: ice_yangxiao@163.com
To: ltp@lists.linux.it
Date: Sat, 13 Jan 2024 22:49:38 +0800
Message-Id: <20240113144940.133746-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CM-TRANSID: _____wD3X1IFo6JlDGAUBA--.25846S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw47CF15GryDKr18AF1UJrb_yoW7Cr43p3
 y7Ja4UKF4kJr1fu3Z7Zr40ka1rA3Z2yFyrKF4Ika15ZrsYvw45CFW2qFyrJFyUXr48Kayj
 yF4fXry2qw1kJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPkusUUUUU=
X-Originating-IP: [183.210.226.120]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBEhFkXmVOBo5MrwAAs5
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/preadv: Make make check happy
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
 testcases/kernel/syscalls/preadv/preadv.h   | 19 ++------
 testcases/kernel/syscalls/preadv/preadv01.c | 26 +++++------
 testcases/kernel/syscalls/preadv/preadv02.c | 50 ++++++++++-----------
 3 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
index 73466a9aa..c3e9e5f19 100644
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ b/testcases/kernel/syscalls/preadv/preadv.h
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
 
 #ifndef PREADV_H
 #define PREADV_H
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 62f9296f2..aba4748a5 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
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
-* Test Name: preadv01
-*
-* Test Description:
-* Testcase to check the basic functionality of the preadv(2).
-* Preadv(2) should succeed to read the expected content of data
-* and after reading the file, the file offset is not changed.
-*/
+ * Test Name: preadv01
+ *
+ * Test Description:
+ * Testcase to check the basic functionality of the preadv(2).
+ * Preadv(2) should succeed to read the expected content of data
+ * and after reading the file, the file offset is not changed.
+ */
 
 #define _GNU_SOURCE
 
@@ -38,7 +38,7 @@ static struct tcase {
 	{1, CHUNK*3/2, CHUNK/2, 'b'}
 };
 
-void verify_preadv(unsigned int n)
+static void verify_preadv(unsigned int n)
 {
 	int i;
 	char *vec;
@@ -81,7 +81,7 @@ void verify_preadv(unsigned int n)
 		 "with content '%c' expectedly", tc->size, tc->content);
 }
 
-void setup(void)
+static void setup(void)
 {
 	char buf[CHUNK];
 
@@ -94,7 +94,7 @@ void setup(void)
 	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (fd > 0)
 		SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 500059e42..65d4795d6 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -1,32 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2015-2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
+ * Copyright (c) 2015-2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
 
 /*
-* Test Name: preadv02
-*
-* Description:
-* 1) preadv(2) fails if iov_len is invalid.
-* 2) preadv(2) fails if the vector count iovcnt is less than zero.
-* 3) preadv(2) fails if offset is negative.
-* 4) preadv(2) fails when attempts to read into a invalid address.
-* 5) preadv(2) fails if file descriptor is invalid.
-* 6) preadv(2) fails if file descriptor is not open for reading.
-* 7) preadv(2) fails when fd refers to a directory.
-* 8) preadv(2) fails if fd is associated with a pipe.
-*
-* Expected Result:
-* 1) preadv(2) should return -1 and set errno to EINVAL.
-* 2) preadv(2) should return -1 and set errno to EINVAL.
-* 3) preadv(2) should return -1 and set errno to EINVAL.
-* 4) preadv(2) should return -1 and set errno to EFAULT.
-* 5) preadv(2) should return -1 and set errno to EBADF.
-* 6) preadv(2) should return -1 and set errno to EBADF.
-* 7) preadv(2) should return -1 and set errno to EISDIR.
-* 8) preadv(2) should return -1 and set errno to ESPIPE.
-*/
+ * Test Name: preadv02
+ *
+ * Description:
+ * 1) preadv(2) fails if iov_len is invalid.
+ * 2) preadv(2) fails if the vector count iovcnt is less than zero.
+ * 3) preadv(2) fails if offset is negative.
+ * 4) preadv(2) fails when attempts to read into a invalid address.
+ * 5) preadv(2) fails if file descriptor is invalid.
+ * 6) preadv(2) fails if file descriptor is not open for reading.
+ * 7) preadv(2) fails when fd refers to a directory.
+ * 8) preadv(2) fails if fd is associated with a pipe.
+ *
+ * Expected Result:
+ * 1) preadv(2) should return -1 and set errno to EINVAL.
+ * 2) preadv(2) should return -1 and set errno to EINVAL.
+ * 3) preadv(2) should return -1 and set errno to EINVAL.
+ * 4) preadv(2) should return -1 and set errno to EFAULT.
+ * 5) preadv(2) should return -1 and set errno to EBADF.
+ * 6) preadv(2) should return -1 and set errno to EBADF.
+ * 7) preadv(2) should return -1 and set errno to EISDIR.
+ * 8) preadv(2) should return -1 and set errno to ESPIPE.
+ */
 
 #define _GNU_SOURCE
 
-- 
2.26.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
