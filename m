Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6D0C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 12:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B38123CE29A
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 13:31:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2433CC7F6
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=yangx.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2FD491A0117B
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:18 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="148427042"
X-IronPort-AV: E=Sophos;i="6.05,209,1701097200"; d="scan'208";a="148427042"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 21:30:15 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 65B88C1634
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:13 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 908D6D4F42
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C55322EAD8
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.214.93])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7143C1A0070;
 Sun, 21 Jan 2024 20:30:11 +0800 (CST)
From: Xiao Yang <yangx.jy@fujitsu.com>
To: pvorel@suse.cz
Date: Sun, 21 Jan 2024 20:29:56 +0800
Message-Id: <20240121122959.1386-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28132.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28132.007
X-TMASE-Result: 10--7.096100-10.000000
X-TMASE-MatchedRID: 4dQSGpW1RnZa6JkWul/UfE7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOEWY
 FvwCgnnKu+jFdzsOrevwpcCKD24C0z0zZJkr4Qiy5p1ddw6V4RvrLfunoI8iwMnJhTYnTng9CeW
 hs1FY/qWaodLlCZqD9UeSXLsBjkkFMkH7vrbBCJDrCzoWXDcUYn0tCKdnhB589yM15V5aWpj6C0
 ePs7A07fk39LXMSri6roh8AquVr3fo/K1YsqkFdGIAUB9PHXJ6HOMayw00/fI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] syscalls/preadv: Fix docparse
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 testcases/kernel/syscalls/preadv/preadv01.c | 16 +++++-----
 testcases/kernel/syscalls/preadv/preadv02.c | 35 +++++++--------------
 testcases/kernel/syscalls/preadv/preadv03.c |  6 ++--
 3 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 62f9296f2..10604200d 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -4,14 +4,14 @@
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 */
 
-/*
-* Test Name: preadv01
-*
-* Test Description:
-* Testcase to check the basic functionality of the preadv(2).
-* Preadv(2) should succeed to read the expected content of data
-* and after reading the file, the file offset is not changed.
-*/
+/*\
+ * [Description]
+ *
+ * Testcase to check the basic functionality of the preadv(2).
+ *
+ * Preadv(2) should succeed to read the expected content of data
+ * and after reading the file, the file offset is not changed.
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 500059e42..bfcf5052b 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -4,29 +4,18 @@
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 */
 
-/*
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
+/*\
+ * [Description]
+ *
+ * - EINVAL when iov_len is invalid.
+ * - EINVAL when the vector count iovcnt is less than zero.
+ * - EINVAL when offset is negative.
+ * - EFAULT when attempts to read into a invalid address.
+ * - EBADF when file descriptor is invalid.
+ * - EBADF when file descriptor is not open for reading.
+ * - EISDIR when fd refers to a directory.
+ * - ESPIPE when fd is associated with a pipe.
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index d4595dda6..5d2946bc3 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -4,10 +4,12 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
+/*\
+ * [Description]
+ *
  * Check the basic functionality of the preadv(2) for the file
  * opened with O_DIRECT in all filesystem.
+ *
  * preadv(2) should succeed to read the expected content of data
  * and after reading the file, the file offset is not changed.
  */
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
