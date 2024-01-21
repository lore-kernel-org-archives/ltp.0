Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21591C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 12:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39FA53CFA98
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 13:31:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BA613CC7EF
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:20 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=yangx.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 353AB600721
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:18 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="135153293"
X-IronPort-AV: E=Sophos;i="6.05,209,1701097200"; d="scan'208";a="135153293"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 21:30:15 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id AEE8AD64B8
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D8D59D9470
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 70511200A7872
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.214.93])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 100331A0160;
 Sun, 21 Jan 2024 20:30:12 +0800 (CST)
From: Xiao Yang <yangx.jy@fujitsu.com>
To: pvorel@suse.cz
Date: Sun, 21 Jan 2024 20:29:58 +0800
Message-Id: <20240121122959.1386-3-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240121122959.1386-1-yangx.jy@fujitsu.com>
References: <20240121122959.1386-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28132.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28132.007
X-TMASE-Result: 10--5.930100-10.000000
X-TMASE-MatchedRID: nRYjnRMpeiBa6JkWul/UfE7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOEWY
 FvwCgnnKu+jFdzsOreuEvOHjK+JtGip2scJP0Uwa5p1ddw6V4RsaJDwYgQY/f7IE/YCsDN7/zHA
 hKDI1N0jj2fPqln0vq0jXhM3XsvYuKJdDErrWm9CeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
 quNi0WJGNTctom35V6iP7eMmgisuOH24HUJngs3vE1Ic8A23DoftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] syscalls/pwritev: Fix docparse
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
 testcases/kernel/syscalls/pwritev/pwritev01.c | 16 +++++-----
 testcases/kernel/syscalls/pwritev/pwritev02.c | 32 +++++++------------
 testcases/kernel/syscalls/pwritev/pwritev03.c |  6 ++--
 3 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 66358f7c4..d0ec14a69 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -4,14 +4,14 @@
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 */
 
-/*
-* Test Name: pwritev01
-*
-* Test Description:
-* Testcase to check the basic functionality of the pwritev(2).
-* pwritev(2) should succeed to write the expected content of data
-* and after writing the file, the file offset is not changed.
-*/
+/*\
+ * [Description]
+ *
+ * Testcase to check the basic functionality of the pwritev(2).
+ *
+ * pwritev(2) should succeed to write the expected content of data
+ * and after writing the file, the file offset is not changed.
+ */
 
 #define _GNU_SOURCE
 #include <string.h>
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 0881b7566..f3a7cc003 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -4,27 +4,17 @@
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 */
 
-/*
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
+/*\
+ * [Description]
+ *
+ * - EINVAL when iov_len is invalid.
+ * - EINVAL when the vector count iovcnt is less than zero.
+ * - EINVAL when offset is negative.
+ * - EFAULT when attempts to write from a invalid address
+ * - EBADF when file descriptor is invalid.
+ * - EBADF when file descriptor is not open for writing.
+ * - ESPIPE when fd is associated with a pipe.
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 8b91de336..ea2892971 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -4,10 +4,12 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
+/*\
+ * [Description]
+ *
  * Check the basic functionality of the pwritev(2) for the file
  * opened with O_DIRECT in all filesystem.
+ *
  * pwritev(2) should succeed to write the expected content of data
  * and after writing the file, the file offset is not changed.
  */
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
