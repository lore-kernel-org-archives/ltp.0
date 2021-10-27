Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16CC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:26:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFC9610A0
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EFC9610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 586EC3C68C7
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 067073C67D8
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:33 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D2DD60239E
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337592; i=@fujitsu.com;
 bh=doO3sTDvEJTFSYMzgLN5YuTSObGOveutfq1Od4xmxWw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=E9Ixi0m6lgVQiQB8EQPQtdtTwFbXmHtly5E9kcLcDt5yVlnm/nrjPnilyML04/aRW
 EbaJgnePnbqn+H/83NcLUqLXQGlEDPEBd3KSC4KPXeckuoiatewX+RO/QwKGAYbQwx
 ct+fhvmgTIi+brIZ6IbdUInQrt0H6jHCT9w81lyhtbhkW8qC/XvihnEnNgF5sjzBby
 p36nmYAOa1tqB3Do5ZCwRfPF92SG08cJ+eDtaaLCMhpdcW9Pu+b9LX30xFnZveKxtE
 frMW8t1K3Zjy7szUK3Ghn3uUxzYYpj7FXGQnxAqY7ecWWHK6qHulIr89aiiEamW1X2
 C3isdbl3UpaoA==
Received: from [100.113.0.18] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.symcld.net id C7/91-32197-87549716;
 Wed, 27 Oct 2021 12:26:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8ORqFvuWpl
 o8POGpcWK7zsYHRg99v1exxrAGMWamZeUX5HAmrHr2CHWgpX2FZs3PmBsYPxh3MXIySEkcJZR
 4ujhsC5GLiB7J5PEw62bGCGcPYwSLb+b2EGq2AQ0JZ51LmAGsUUEJCQ6Gt6CxZkF1CWWT/rFB
 GILCzhLHDn0nRXEZhFQlZj1cCKYzSvgIbFk2wSwXgkBBYkpD9+D2ZwCnhKTdi1ihbjCQ2LC9W
 fMEPWCEidnPmGBmC8hcfDFC6heRYlLHd8YIewKiVmz2pggbDWJq+c2MU9gFJyFpH0WkvYFjEy
 rGC2TijLTM0pyEzNzdA0NDHQNDY11jXUNLU30Eqt0E/VSS3WTU/NKihKBsnqJ5cV6xZW5yTkp
 enmpJZsYgSGcUsh8aAfjk9cf9A4xSnIwKYnyBuhUJgrxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4
 D3jCJQTLEpNT61Iy8wBxhNMWoKDR0mE1xAkzVtckJhbnJkOkTrFqMtx+fq8RcxCLHn5ealS4r
 wcLkBFAiBFGaV5cCNgsX2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjCvvTPQFJ7MvBK4Ta+
 AjmACOoJZqQLkiJJEhJRUA5Or31T/5pdB37X/v/zQVuvHlvg7ZfdFsQfbzO8VH7yb1xS4ru+7
 /Af2OQzdfhnnmZ5cKfzlsdbo3yW91GfamuLqaypyrW68uuYX3d7+5qxJmPKp/3MvJHvJKb1fN
 fV2eNaEmM7XKx+/KGypV2FXfPDkhhLj530b1sy67zTzTtX2Cc0f4y5/eeawS+XtPa6Z2jIS7k
 /bL+w5l6vX03vxuOdEn/4yg8jJyQWFovWqP57dcxRXubv5z1T1ve63n19vTRP+vOu3hpVXhva
 qD5KTy0+FTl1yak3aVfmYz45LE1iMJu9T2bl75q1Axbt3Pu5iT9n93WRZqMn/pFzuNQvFHRJm
 L7y8eK9L8ZwJoub/g2f6KrEUZyQaajEXFScCAGK22BZoAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-232.messagelabs.com!1635337591!3305824!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22770 invoked from network); 27 Oct 2021 12:26:31 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-4.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:26:31 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 730E510024B
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 65F83100239
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:26:29 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:26:00 +0800
Message-ID: <1635337569-4634-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/13] syscalls/quotactl:Add docparse formatting
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
 .../kernel/syscalls/quotactl/quotactl05.c     | 32 +++++------
 .../kernel/syscalls/quotactl/quotactl07.c     |  9 ++--
 5 files changed, 49 insertions(+), 66 deletions(-)

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
