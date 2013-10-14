Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <voipio@kos.to>) id 1VVd73-0000Ue-Nl
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 08:02:49 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VVd72-0007cj-8I
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 08:02:49 +0000
Received: from kos.to (91-157-208-114.elisa-laajakaista.fi [91.157.208.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by afflict.kos.to (Postfix) with ESMTPSA id 4D72026553
	for <ltp-list@lists.sourceforge.net>;
	Mon, 14 Oct 2013 10:02:41 +0200 (CEST)
From: Riku Voipio <riku.voipio@linaro.org>
Date: Mon, 14 Oct 2013 11:02:38 +0300
Message-Id: <1381737758-10516-1-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH] power_management: add TCID
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

get_sched_values.c uses interfaces provided by -lltp which need
TCID defined. Not sure how this built successfully before.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 testcases/kernel/power_management/get_sched_values.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/power_management/get_sched_values.c b/testcases/kernel/power_management/get_sched_values.c
index 08260d5..b9d0156 100644
--- a/testcases/kernel/power_management/get_sched_values.c
+++ b/testcases/kernel/power_management/get_sched_values.c
@@ -17,6 +17,8 @@
 #include <stdio.h>
 #include "test.h"
 
+const char *TCID = "Power_Management";
+
 int get_supp_sched_mc(void)
 {
 	if (tst_kvercmp(2, 6, 29) < 0)
-- 
1.8.1.2


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
