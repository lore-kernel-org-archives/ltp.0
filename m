Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XqBhe-00017a-Ni
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 02:06:06 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XqBhd-0003VG-8o
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 02:06:06 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAH25gq3017528
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 10:05:42 +0800
Message-ID: <1416189838.26092.1.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 17 Nov 2014 10:03:58 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] ltp_acpi_cpufreq.c: Fix compilation.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

Fix compilation on missing 'CLOCK_MONOTONIC_RAW'.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
index 5b9c2a9..423188e 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
@@ -33,6 +33,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "lapi/posix_clocks.h"
 #include "safe_macros.h"
 #include "safe_stdio.h"
 
-- 
1.9.3




------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
