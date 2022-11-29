Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF528C43217
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 01:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BE833CC664
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 02:28:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BD6A3C01D2
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 02:28:05 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 579D810005FA
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 02:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1669685283; i=@fujitsu.com;
 bh=jKry2qw6IMOn7aMHD+eHECLtDxy/AVfTlgYNPQMACoc=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=oVmVI8g/nPJym5fAYdj5QxZvVVUdH6nlMdyURC/JVo0lHq9wID/diyVS9n25gp7f0
 kGntmzaG2l7CiIhHy2YcHCtYD5k10tpe4V1Aygi59o8sjJ2X5kRG6L+VUfZpx/Gc+Q
 A+yF/6L7NkxH8CyOUIV1jxIJ+Mov3qwQpjctuaASBvBg6e0dNkHoFct1M43OHccUB5
 lHG4NcVqKuqKXMa1k6Ahboii4FfyQalc3Io5YJYMcxHXes3TTK4PdMSc8p3GtmjYO/
 /dV+kiLhTvQs7kRV88gEE03zCfCjxRgpFNAX+CwUKyaLPN9OPnHAPrJVnVgu7E0WG9
 ADlsi3jolwn4g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRWlGSWpSXmKPExsViZ8OxWVcxoTX
 ZYMVZM4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPtw8ksBW+4Kjb0qDYwXuPsYuTiEBI4ySjR
 O+MmI4Szl0mi/0MjK4Szh1Hi79+5QA4nB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX0wgt
 rCAg8SDk01gNouAqsS9IzeA6jk4eAU8JC5e9AIJSwgoSEx5+B5sDK+AoMTJmU9YIMZISBx88Y
 IZokZR4lLHN0YIu0Ji1qw2JghbTeLquU3MExj5ZyFpn4WkfQEj0ypGs+LUorLUIl0TvaSizPS
 MktzEzBy9xCrdRL3UUt28/KKSDF1DvcTyYr3U4mK94src5JwUvbzUkk2MwFBMKU6y2cH4d+kf
 vUOMkhxMSqK88k9bkoX4kvJTKjMSizPii0pzUosPMcpwcChJ8PrHtSYLCRalpqdWpGXmAOMCJ
 i3BwaMkwmsOkuYtLkjMLc5Mh0idYtTl2LSv6wCzEEtefl6qlDjvepAiAZCijNI8uBGwGL3EKC
 slzMvIwMAgxFOQWpSbWYIq/4pRnINRSZi3CmQKT2ZeCdymV0BHMAEdsUmxCeSIkkSElFQD0xq
 tqSJO+dJ5PEn/dpgvvbHVySbjvI7V8aTgG9susLgb59kKXFzteThr5inu87tzfIAR+/fV0jQX
 2f3nfntJ/OZ45jTl97S5TnOXlgT8jZiqrGAdo2LhsDVpU9vHJRw6pn/P/azenbVQujFe6mFb9
 xojzc2rm1INHC43bji3N2r2JOZ7K5Z++3Fv0o5ww6uvo47lJ/Hn3lD6vXrKxaMvjooYsP61ND
 MKm/WL/WA6k4fo1fMNzB33S4x/fpm6viM3mTPswc0N7BWmMevqa0WyAz8ZOi195nO74bmDSO0
 c6V6pcH2B+1+//Pjz9pazql2Nz1WvJ2rn069FvFC197bXO5ATP3fOifveu2btkNRhUGIpzkg0
 1GIuKk4EAHUA19VMAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-732.messagelabs.com!1669685281!214082!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27610 invoked from network); 29 Nov 2022 01:28:01 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-14.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 29 Nov 2022 01:28:01 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 5C51773
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 01:28:01 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 4F9F2153
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 01:28:01 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 29 Nov 2022 01:27:59 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 29 Nov 2022 10:28:37 +0800
Message-ID: <1669688917-1997-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/namespace_constants.h: Add CLONE_NEWCGROUP
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

This fix undefined CLONE_NEWCGROUP problem on centos7.

Fixes: 5f2a365da ("cgroup_core02: copy from kernel selftest test_cgcore_lesser_ns_open")
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
I have verified it on my ltp fork[1]
[1]https://github.com/xuyang0410/ltp/actions/runs/3570059301/jobs/6000664209
 include/lapi/namespaces_constants.h                 | 3 +++
 testcases/kernel/controllers/cgroup/cgroup_core02.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_constants.h
index 447f16c5b..e34b0d6a8 100644
--- a/include/lapi/namespaces_constants.h
+++ b/include/lapi/namespaces_constants.h
@@ -21,6 +21,9 @@
 #ifndef CLONE_NEWUSER
 #  define CLONE_NEWUSER	0x10000000
 #endif
+#ifndef CLONE_NEWCGROUP
+#  define CLONE_NEWCGROUP 0x02000000
+#endif
 #ifndef CLONE_NEWUTS
 #  define CLONE_NEWUTS	0x04000000
 #endif
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index 0dff71eea..e6d599b36 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -31,6 +31,7 @@
 #include <pwd.h>
 #include "tst_test.h"
 #include "tst_safe_file_at.h"
+#include "lapi/namespaces_constants.h"
 
 static struct tst_cg_group *cg_child_a, *cg_child_b;
 static uid_t nobody_uid;
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
