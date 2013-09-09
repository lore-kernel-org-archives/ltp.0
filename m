Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VJ0VE-00084v-RE
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 12:23:36 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJ0VC-0000cA-Uw
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 12:23:36 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r89CNSI6003572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Sep 2013 12:23:29 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r89CNRSn018509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Sep 2013 12:23:28 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r89CNQLt007534
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Sep 2013 12:23:26 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon,  9 Sep 2013 16:23:01 +0400
Message-Id: <1378729381-32706-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers: rtc: minor updates
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Makefile updated.
Added .gitignore file.
Added root check and rtc device check.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/rtc/.gitignore |    1 +
 testcases/kernel/device-drivers/rtc/Makefile   |   39 +++++++++--------------
 testcases/kernel/device-drivers/rtc/rtc-test.c |   32 ++++++++++++++++---
 3 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/rtc/.gitignore

diff --git a/testcases/kernel/device-drivers/rtc/.gitignore b/testcases/kernel/device-drivers/rtc/.gitignore
new file mode 100644
index 0000000..727656a
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/.gitignore
@@ -0,0 +1 @@
+/rtc-test
diff --git a/testcases/kernel/device-drivers/rtc/Makefile b/testcases/kernel/device-drivers/rtc/Makefile
index 0eefcb0..effd5da 100644
--- a/testcases/kernel/device-drivers/rtc/Makefile
+++ b/testcases/kernel/device-drivers/rtc/Makefile
@@ -1,29 +1,20 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
 #
-#  Copyright (c) Larsen & Toubro Infotech Ltd., 2010
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
-#
-#
-
-CFLAGS = -O2 -Wall -I ../../../../include/
-LIBS = -L ../../../../lib/ -lltp
-SRC = rtc-test.c
-
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
-all: $(SRC)
-	$(CC) $(SRC) $(CFLAGS) $(LIBS) -o rtc-test
+top_srcdir		?= ../../../..
 
-clean:
-	rm -f rtc-test
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/rtc/rtc-test.c b/testcases/kernel/device-drivers/rtc/rtc-test.c
index 28c1113..aa931f5 100644
--- a/testcases/kernel/device-drivers/rtc/rtc-test.c
+++ b/testcases/kernel/device-drivers/rtc/rtc-test.c
@@ -3,6 +3,7 @@
  *   Tests for the Real Time Clock driver.
  *
  *   Copyright (c) Larsen & Toubro Infotech Ltd., 2010
+ *   Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
  *   Author : Silesh C V <Silesh.Vellattu@lntinfotech.com>
  *
@@ -21,7 +22,7 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-#include "test.h"
+
 #include <sys/ioctl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -31,10 +32,26 @@
 #include <errno.h>
 #include <time.h>
 
+#include "test.h"
+#include "usctest.h"
+
 int rtc_fd = -1;
 char *TCID = "rtc01";
 int TST_TOTAL = 3;
 
+static char *rtc_dev = "/dev/rtc";
+static int dflag;
+static const option_t options[] = {
+	{"d:", &dflag, &rtc_dev},
+	{NULL, NULL, NULL}
+};
+
+static void help(void)
+{
+	printf("  -d x    rtc device node, default is %s\n",
+		rtc_dev);
+}
+
 /* Read and Alarm Tests :  Read test reads the Date/time from RTC
  * while Alarm test, sets the alarm to 5 seconds in future and
  * waits for it to ring.The ioctls tested in these tests are
@@ -192,12 +209,17 @@ void update_interrupts_test(void)
 	tst_resm(TPASS, "RTC UPDATE INTERRUPTS TEST Passed");
 }
 
-int main(int argc, char **argv)
+int main(int argc, char *argv[])
 {
-	char *rtc_dev = "/dev/rtc";
+	char *msg;
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	tst_require_root(NULL);
 
-	if (argc == 2)
-		rtc_dev = argv[1];
+	if (access(rtc_dev, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "couldn't find rtc device '%s'", rtc_dev);
 
 	rtc_fd = open(rtc_dev, O_RDONLY);
 
-- 
1.7.1


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
