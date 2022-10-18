Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304BDC4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:09:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9EDD3CB073
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:09:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 220B43C4CCC
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 12:09:45 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 688821400C63
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 12:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1666087784; i=@fujitsu.com;
 bh=Iu6gA9vab9Ab5+a2VOfwMKowuMyqAQENZq0IsdjOEhI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=WOpCHxVvhoyxnHqAX2pDwlfMj87ui/phXZT+ADIFfMk8Y3Ug2DkAHPxpKO0jbBu/W
 SGkH9PdM/+YX28ggGGahCSvZ4dxMJZplOhP5lvTOpOk8qWHXUEm5QsM9nlVxlBJciv
 vcP8jrQ1jHtigqIrq4zbbJIRTgKqXfjBt6Z7IxPuB1FkbS3nctO2ZbW+xX6xUhp14g
 qdq9HpeDWSDfwnwsOvqlFj0e6CqS8oNml101zjW8YEVZaBPMR+xK8ffE8rxPQjCREY
 dVdv5mtZUWGBHS5ZjorTAjRzOJG+W8o1fQ+tOsf46SWvcAw8RBsXBEUVJ0o2dVtJUE
 zGOxGMGY0QBUQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8ORpJte7Zd
 scOGOmcWK7zsYHRg99v1exxrAGMWamZeUX5HAmrG45wR7wR2OiqevNjE3MO5g72Lk4hASOMUo
 seHlBUYIZy+TxPsfN1ghnD2MEtturmXqYuTkYBPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0C
 6xGWMBJ4sulM6wgNouAqsTWu+vBangFPCSa3r9gBLElBBQkpjx8zwwRF5Q4OfMJC8QcCYmDL1
 4wQ9QoSlzq+AZVXyExa1YbE4StJnH13CbmCYz8s5C0z0LSvoCRaRWjeXFqUVlqka6hsV5SUWZ
 6RkluYmaOXmKVbqJeaqluXn5RSYauoV5iebFeanGxXnFlbnJOil5easkmRmBAphSnSuxgbFj+
 R+8QoyQHk5Iob3WpX7IQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd79FUA5waLU9NSKtMwcYHTAp
 CU4eJREeFNBWnmLCxJzizPTIVKnGHU5ps7+t59ZiCUvPy9VSpyXtQqoSACkKKM0D24ELFIvMc
 pKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmnQwyhSczrwRu0yugI5iAjsjY7wVyREkiQkqqgam
 /unFpxts+9vitlsxB/sEqZxd4CPoY9gpOys6OCuD4dS9nz9ft9339rrXcY48qY66WXPF1WfD8
 Renn22UvMVse+xm4ca1H+qvUHywroq6ms2+7H8yZ4Lv0x6YnBRteuS6Sv/eVnXn5C0Ur64Uqt
 62/sFc9CmiOOVkYUrV4ltqqDENm9xnMKatvu+5LfRJS4e9zeta+MFNnvd/NHy3+frUR4W6/ve
 zIvyMrVzUWnt33egK7jd9NHTd3sR3tBo8m7ytp4Xsn+suroetPzLya6pTHi+uXhC5+Oe+08Gn
 +tX0p2p/OC9cme7jZ6908fmxuWmr6pG/3ph+d0pLsl3No8sI8rd+m709uObhLvsAjZqYSS3FG
 oqEWc1FxIgCtJYvWTwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-745.messagelabs.com!1666087783!15770!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12429 invoked from network); 18 Oct 2022 10:09:43 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-19.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2022 10:09:43 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 56FD61AF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 11:09:43 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 4C1FB1AB
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 11:09:43 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 18 Oct 2022 11:09:41 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 18 Oct 2022 19:10:13 +0800
Message-ID: <1666091413-7732-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
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
 testcases/kernel/syscalls/mount/mount03.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 7a6914fb1..e1dd8d170 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -24,6 +24,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/vfs.h>
 #include <pwd.h>
 #include "tst_test.h"
 #include "lapi/mount.h"
@@ -144,10 +145,10 @@ static void cleanup(void)
 		SAFE_UMOUNT(MNTPOINT);
 }
 
-
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
+	struct statfs stfs;
 
 	tst_res(TINFO, "Testing flag %s", tc->desc);
 
@@ -159,6 +160,11 @@ static void run(unsigned int n)
 	if (tc->test)
 		tc->test();
 
+	SAFE_STATFS(MNTPOINT, &stfs);
+	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
+		tst_res(TPASS, "statfs() gets the correct mount flag");
+	else
+		tst_res(TFAIL, "statfs() gets the incorrect mount flag");
 	cleanup();
 }
 
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
