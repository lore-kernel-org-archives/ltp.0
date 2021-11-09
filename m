Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F4C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1832061178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1832061178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF5423C088E
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:53:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02C113C0918
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:53:02 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D83CD1001583
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455181; i=@fujitsu.com;
 bh=4Csno799F725ITPeNEyfdNtAiUMSI7QO/RizCcLxohI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=blif8XCsKEL2teGPx4igE7huqNZU0MjAES+Io2k6ysBgsgzDM9PuaJBtxs5gcNXm0
 cFx7jEabqnwuJ0FngLqjTxWfHH2IcCeZ/FHTRWkquf6LHeM1U/HPPalm76oW7S/szL
 m8q2KwIwiRH7EsiXQdXfgnV7PNi5YYK2VOS7pMqWiWLh5hAF+7eLEUs7kH3dsFsKI0
 8rXp/YORZxzvSOzLDu+929yrjR2a6/Zc5QoUeoIl3S/n14qnucAXlOh4bgqHCwxuBr
 PtKhtKLYj2A7ztgZQ3Bl4xjcClFqfSmLiBMxHE07Vj645Xr3QMt48tRHUj+4E2O0GU
 PpvpfpKysd+1w==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-central-1.aws.symcld.net id DD/BB-30139-D035A816;
 Tue, 09 Nov 2021 10:53:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8ORqMsT3JV
 ocGe6tsWK7zsYHRg99v1exxrAGMWamZeUX5HAmtH2YCJbwZ2gis3r7jM1ME506WLk4hASOMso
 sfvNbWYIZyeTxLqvm1khnN2MEpd757J1MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6x
 QRiCws4S8w61AoWZxFQkbhxeBdYL6+Ah8TszafBaiQEFCSmPHwPNIeDg1PAU+LvR1eQsBBQyY
 7nnxkhygUlTs58wgIxXkLi4IsXzBCtihKXOr4xQtgVErNmtUGNVJO4em4T8wRGwVlI2mchaV/
 AyLSK0TKpKDM9oyQ3MTNH19DAQNfQ0FjXVNfIxFAvsUo3SS+1VDc5Na+kKBEoq5dYXqxXXJmb
 nJOil5dasokRGMIphawfdzAeev1B7xCjJAeTkijvZbGuRCG+pPyUyozE4oz4otKc1OJDjDIcH
 EoSvAn+QDnBotT01Iq0zBxgPMGkJTh4lER49XyA0rzFBYm5xZnpEKlTjLocl6/PW8QsxJKXn5
 cqJc7bGAhUJABSlFGaBzcCFtuXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzVoJM4cnMK4H
 b9AroCCagIw5+aQc5oiQRISXVwBQ1u7Tw+c+lQZZMQcEaPm0JHvv+/nMo7D/4YMFfSxd+kSPt
 Cn3mZzdNqC2oFHtx0dab947yv01ttY3Mh5UmPT21+tyD0CMGKtEdTq83KVx7tkDaTjZV5ohwc
 tqzgu/lZlvlS3dJ1Z1XzGUs7mObZ3totr1ZvL7SKcNDYfskO51iZf4c3lhQOHnJ9Gft6rd0/c
 xdZS/O2lh0MO3PK5tF5e9rfzknt171uBmwgmeydli64zOBxEMaEbd/Hq20Z7RTCdidWHM4cFf
 3pZA+00Mbp89QrcqxPZXCljj71Z6PU2yKjmyckGy4wdPS/7OxQ7bdjg8s9w6klGanxQQ8aQ36
 scSn3HRTScUm210dIjtElFiKMxINtZiLihMBr9KzVmgDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-245.messagelabs.com!1636455180!378562!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7717 invoked from network); 9 Nov 2021 10:53:00 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-6.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:53:00 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3145A100242
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:53:00 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 241A9100234
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:53:00 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:52:45 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:52:39 +0800
Message-ID: <1636455161-8278-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 04/12] syscalls/quotactl:Add docparse formatting
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

Also remove useless header files and add linux git in test structure.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl02.c     | 54 ++++++-------------
 .../kernel/syscalls/quotactl/quotactl02.h     |  3 +-
 .../kernel/syscalls/quotactl/quotactl03.c     | 17 +++---
 .../kernel/syscalls/quotactl/quotactl04.c     | 39 ++++++--------
 .../kernel/syscalls/quotactl/quotactl05.c     | 32 +++++------
 .../kernel/syscalls/quotactl/quotactl07.c     |  9 ++--
 6 files changed, 65 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index ad81ee7e5..55a6a8906 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -1,50 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2013-2019 FUJITSU LIMITED. All rights reserved
+ * Copyright (c) 2013-2021 FUJITSU LIMITED. All rights reserved
  * Author: DAN LI <li.dan@cn.fujitsu.com>
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
  */
 
 /*\
  * [Description]
  *
- * This testcase checks basic flags of quotactl(2) for an XFS file system:
+ * This testcases checks that quotactl(2) on xfs filesystem succeeds to:
  *
- * 1. quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
- *    for user.
- *
- * 2. quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
- *    for user.
- *
- * 3. quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
- *    limits for user.
- *
- * 4. quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
- *    quota limits greater than or equal to ID for user.
- *
- * 5. quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
- *    for user.
- *
- * 6. quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
- *    for user.
- *
- * 7. quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
- *    for group.
- *
- * 8. quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
- *    for group.
- *
- * 9. quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
- *    limits for group.
- *
- * 10. quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
- *     quota limits for group.
- *
- * 11. quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
- *     for group.
- *
- * 12. quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
- *     for group.
+ * - turn off xfs quota and get xfs quota off status for user
+ * - turn on xfs quota and get xfs quota on status for user
+ * - set and use Q_XGETQUOTA to get xfs disk quota limits for user
+ * - set and use Q_XGETNEXTQUOTA to get xfs disk quota limits greater than or
+ *   equal to ID for user
+ * - turn off xfs quota and get xfs quota off statv for user
+ * - turn on xfs quota and get xfs quota on statv for user
+ * - turn off xfs quota and get xfs quota off status for group
+ * - turn on xfs quota and get xfs quota on status for group
+ * - set and use Q_XGETQUOTA to get xfs disk quota limits for group
+ * - set and use Q_XGETNEXTQUOTA to get xfs disk quota limits for group
+ * - turn off xfs quota and get xfs quota off statv for group
+ * - turn on xfs quota and get xfs quota on statv for gorup
  */
 
 #include "quotactl02.h"
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
index 37f3d7eb7..3351fb578 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -1,14 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
  */
 
 #ifndef QUOTACTL02_H
 #define QUOTACTL02_H
 
 #define _GNU_SOURCE
-#include "config.h"
 #include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 3ec931727..e0e4bf5b2 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -4,10 +4,9 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Test Name: quotactl03
+/*\
+ * [Description]
  *
- * Description:
  * quotactl(2) with XGETNEXTQUOTA looks for the next active quota for an user
  * equal or higher to a given ID, in this test the ID is specified to a value
  * close to UINT_MAX(max value of unsigned int). When reaching the upper limit
@@ -16,11 +15,11 @@
  *
  * This kernel bug of xfs has been fixed in:
  *
- * commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
- * Author: Eric Sandeen <sandeen@redhat.com>
- * Date:   Tue Jan 17 11:43:38 2017 -0800
+ *  commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
+ *  Author: Eric Sandeen <sandeen@redhat.com>
+ *  Date:   Tue Jan 17 11:43:38 2017 -0800
  *
- *     xfs: don't wrap ID in xfs_dq_get_next_id
+ *  xfs: don't wrap ID in xfs_dq_get_next_id
  */
 
 #define _GNU_SOURCE
@@ -75,6 +74,10 @@ static struct tst_test test = {
 	.dev_fs_type = "xfs",
 	.mntpoint = mntpoint,
 	.mnt_data = "usrquota",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "657bdfb7f5e6"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index f3e2cf3a5..dab61cf4d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -1,24 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * This testcase checks the basic flag of quotactl(2) for project quota on
- * non-XFS filesystems.
+ * This testcase checks that quotactl(2) on ext4 filesystem succeeds to:
  *
- * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
- * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
- *    for project.
- * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
- *    for project.
- * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
- *    flag for project.
- * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
- *    flag for project.
- * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
- * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
- *    ID with Q_GETNEXTQUOTA flag for project.
- * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
+ * - turn on quota with Q_QUOTAON flag for project
+ * - set disk quota limits with Q_SETQUOTA flag for project
+ * - get disk quota limits with Q_GETQUOTA flag for project
+ * - set information about quotafile with Q_SETINFO flag for project
+ * - get information about quotafile with Q_GETINFO flag for project
+ * - get quota format with Q_GETFMT flag for project
+ * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for project
+ * - turn off quota with Q_QUOTAOFF flag for project
  *
  * Minimum e2fsprogs version required is 1.43.
  */
@@ -29,14 +27,9 @@
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
-#include "config.h"
-#include "lapi/quotactl.h"
 #include "tst_safe_stdio.h"
 #include "tst_test.h"
-
-#ifndef QFMT_VFS_V1
-# define QFMT_VFS_V1 4
-#endif
+#include "lapi/quotactl.h"
 
 #define FMTID QFMT_VFS_V1
 #define MNTPOINT	"mntpoint"
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index e811e47a4..15a6c1e67 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -1,23 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@.fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * This testcase checks basic flags of quotactl(2) for project on an XFS file
- * system:
- * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
- *    for project.
- * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
- *    for project.
- * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
- *    limits for project.
- * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
- *    quota limits Cgreater than or equal to ID for project.
- * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
- *    for project.
- * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
- *    for project.
+ * This testcases checks that quotactl(2) on xfs filesystem succeeds to:
+ *
+ * - turn off xfs quota and get xfs quota off status for project
+ * - turn on xfs quota and get xfs quota on status for project
+ * - set and use Q_XGETQUOTA to get xfs disk quota limits for project
+ * - set and use Q_XGETNEXTQUOTA to get xfs disk quota limits greater than or
+ *   equal to ID for project
+ * - turn off xfs quota and get xfs quota off statv for project
+ * - turn on xfs quota and get xfs quota on statvfor project
  */
+
 #include "quotactl02.h"
 #if defined(HAVE_XFS_XQM_H)
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index db477589b..2992a6112 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -1,19 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
  * This is a regresstion test for kernel commit 3dd4d40b4208
  * ("xfs: Sanity check flags of Q_XQUOTARM call").
  */
 
-#include "config.h"
 #include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/quota.h>
-#include "lapi/quotactl.h"
 #include "tst_test.h"
+#include "lapi/quotactl.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
