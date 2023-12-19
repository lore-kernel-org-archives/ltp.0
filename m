Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8043AC41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 07:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 040B33CF2F2
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 08:43:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6748B3C88DB
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 08:43:03 +0100 (CET)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D6BD1A02385
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 08:43:01 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="131541093"
X-IronPort-AV: E=Sophos;i="6.04,287,1695654000"; d="scan'208";a="131541093"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2023 16:42:59 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8D99DC117A
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 16:42:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C5656D9489
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 16:42:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6729E200989EA
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 16:42:56 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 20FA91A006F;
 Tue, 19 Dec 2023 15:42:56 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 19 Dec 2023 00:48:03 -0500
Message-Id: <20231219054803.136732-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28066.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28066.005
X-TMASE-Result: 10--8.708500-10.000000
X-TMASE-MatchedRID: E6cLu42Bq/TLn7BI/CexuwPZZctd3P4BwTlc9CcHMZdgPgeggVwCFrKo
 UszL+Vmm4PKuGN+8yk31Z+4LIHcqPmx8N4YhLO2E30kDaWZBE1R9LQinZ4QefPcjNeVeWlqY+gt
 Hj7OwNO0UBC9BhrukgxdezuUHj3Ie8bHBbhOn9SSC2K6GWqRMsE7gv1c5vT70
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] gettimeofday01: test EFAULT error for single bad
 address tv/tz
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

man-pages said that one of TV or tz pointed outside the accessible address space.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../syscalls/gettimeofday/gettimeofday01.c    | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
index 3155beec9..adf4a7466 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
@@ -9,18 +9,37 @@
  *
  * Test for EFAULT error.
  *
- * - gettimeofday fail with EFAULT when one of tv or tz pointed outside the accessible
+ * - gettimeofday fail with EFAULT when tv pointed outside the accessible
+ *   address space
+ * - gettimeofday fail with EFAULT when tz pointed outside the accessible
+ *   address space
+ * - gettimeofday fail with EFAULT when both tv and tz pointed outside the accessible
  *   address space
  */
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-static void verify_gettimeofday(void)
+static struct timeval tv1;
+
+static struct tcase {
+	void *tv;
+	void *tz;
+} tcases[] = {
+	/* timezone structure is obsolete, tz should be treated as null */
+	{(void *)-1, NULL},
+	{&tv1, (void *)-1},
+	{(void *)-1, (void *)-1},
+};
+
+static void verify_gettimeofday(unsigned int n)
 {
-	TST_EXP_FAIL(tst_syscall(__NR_gettimeofday, (void *)-1, (void *)-1), EFAULT);
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(tst_syscall(__NR_gettimeofday, tc->tv, tc->tz), EFAULT);
 }
 
 static struct tst_test test = {
-	.test_all  = verify_gettimeofday,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_gettimeofday,
 };
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
