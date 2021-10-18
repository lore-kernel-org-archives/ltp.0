Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE315C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F0C6103C
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 13:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75F0C6103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDFC13C2F45
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:15:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FFC83C2F77
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:18 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7F42600D70
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634562911; i=@fujitsu.com;
 bh=nm2LRgMdVS09kq1iW3PqU/SW5omEU5Gr8nEdlecEe4I=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=EOWUVlympYUWOZM34SRUBHXM+SPqGnOKhlJZs0JXpGW1BuL0wTXvSx7Vx53VQ5hpp
 cpvsGKRm9NDe1cHiseCmGKH11W7tCA65zOrOalcKNzVgLgP+SgxFRcIdK/EOHeGZYW
 y19PmiKRxMsBiTC+6PQMo1mpfDT8xbG2dQMm6oItPM6FZulFbVl3RROjk8NQq96HbX
 ZSQ9OUwbTPyuRE+dy6iEPGfCSjouPOtQzmRnVfm84W4EV5n96VBPyw0W77FgHUOgfl
 oMWWOwdioE+p8dm8Fkd/9kR/roIn2NScq9bZsCkPRvUhOLDNmhyexwQMpvt2x/srGq
 8N8X3VhRrSFJg==
Received: from [100.113.3.109] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-a.eu-central-1.aws.symcld.net id 29/17-11692-E537D616;
 Mon, 18 Oct 2021 13:15:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRWlGSWpSXmKPExsViZ8MxSdevODf
 RYOdDJYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePArOeMBXfFK5bePc/WwLhbpIuRi0NI4Cyj
 xINvi1ghnJ1MEov3v2KGcPYwSuzuPwTkcHKwCWhKPOtcAGaLCEhIdDS8ZQexmQXUJZZP+sUEY
 gsLuEvc7Z8MFmcRUJU4uP0BYxcjBwevgIfEp9NRIGEJAQWJKQ/fg43hFRCUODnzCQvEGAmJgy
 9eMEPUKEpc6vjGCGFXSMya1cYEYatJXD23iXkCI/8sJO2zkLQvYGRaxWiZVJSZnlGSm5iZo2t
 oYKBraGisa6hrZGSml1ilm6iXWqqbnJpXUpQIlNVLLC/WK67MTc5J0ctLLdnECAzJlELGRzsY
 T7/+oHeIUZKDSUmUt18pN1GILyk/pTIjsTgjvqg0J7X4EKMMB4eSBO/pfKCcYFFqempFWmYOM
 D5g0hIcPEoivFWFQGne4oLE3OLMdIjUKUZdjsvX5y1iFmLJy89LlRLnZS0AKhIAKcoozYMbAY
 vVS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeaNBVvFk5pXAbXoFdAQT0BFXnXNAjihJREh
 JNTC13Jy8PGiaANvJBUGpNUZHFb+L6juFG0XbNSm9y3KfM3meT1q02Yw7bBE/F4icz0m8dSL/
 74J/bVKMKr9Kd5SvZtsR5bakqH7VTDkzzRdTJp9KUFKYzviAdd+FxaUKd5RLOv8u8HpcZvHym
 GN63Z+gH6JTpkv/e/5lzgWTP50dtyxKeu6Eqgd5XXG34r1p5Da/9oX+vPmdry8GJRT8yii63p
 v4oVRT+H1mlqvEfO+tx09McM/fU2RpXJkyKVls9qUZCgrv+3fKfymZN2fPAVOehbMbrN5qGXx
 bpLX51K/V73r+XY0xClPo4P21zPA6q+jn/VtOBPBO03gnO8GT1Sf90aQntaVyxub8E3bfdjZU
 YinOSDTUYi4qTgQAEkmHl1ADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-228.messagelabs.com!1634562894!273862!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23778 invoked from network); 18 Oct 2021 13:14:54 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-5.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2021 13:14:54 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 0DA89100463
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:14:54 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 0176C100458
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 14:14:54 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Oct 2021 14:14:45 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 18 Oct 2021 21:14:43 +0800
Message-ID: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 06/11] lapi/quotactl.h: Add fallback for quotactl_fd
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                    |  1 +
 include/lapi/quotactl.h                         | 16 +++++++++++++++-
 testcases/kernel/syscalls/quotactl/quotactl01.c |  2 +-
 testcases/kernel/syscalls/quotactl/quotactl04.c |  2 +-
 testcases/kernel/syscalls/quotactl/quotactl07.c |  2 +-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5bf3c52ec..859aa9857 100644
--- a/configure.ac
+++ b/configure.ac
@@ -122,6 +122,7 @@ AC_CHECK_FUNCS_ONCE([ \
     profil \
     pwritev \
     pwritev2 \
+    quotactl_fd \
     rand_r \
     readlinkat \
     recvmmsg \
diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index 348b70b58..e265a6708 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2017-2019 Fujitsu Ltd.
+ * Copyright (c) 2017-2021 FUJITSU LIMITED. All rights reserved
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
  */
@@ -9,6 +9,20 @@
 #define LAPI_QUOTACTL_H__
 
 #include <sys/quota.h>
+#include "lapi/syscalls.h"
+
+static inline void quotactl_fd_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_quotactl_fd);
+}
+
+#ifndef HAVE_QUOTACTL_FD
+static inline int quotactl_fd(int fd, int cmd, int id, caddr_t addr)
+{
+	return tst_syscall(__NR_quotactl_fd, fd, cmd, id, addr);
+}
+#endif
 
 #ifdef HAVE_STRUCT_IF_NEXTDQBLK
 # include <linux/quota.h>
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 4b791a03a..469c47437 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -63,8 +63,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "lapi/quotactl.h"
 #include "tst_test.h"
+#include "lapi/quotactl.h"
 
 #define USRPATH MNTPOINT "/aquota.user"
 #define GRPPATH MNTPOINT "/aquota.group"
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index ca6a94263..e01657de5 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -41,9 +41,9 @@
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include "config.h"
+#include "tst_test.h"
 #include "lapi/quotactl.h"
 #include "tst_safe_stdio.h"
-#include "tst_test.h"
 
 #define FMTID QFMT_VFS_V1
 #define MNTPOINT	"mntpoint"
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index a55416f0e..f745e9b1c 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -16,8 +16,8 @@
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
