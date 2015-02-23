Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YPqIL-0002qM-0G
	for ltp-list@lists.sourceforge.net; Mon, 23 Feb 2015 10:31:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YPqIJ-0008R1-5a
	for ltp-list@lists.sourceforge.net; Mon, 23 Feb 2015 10:31:20 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1NAVC97003923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Feb 2015 05:31:12 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t1NAVBcX021218
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Feb 2015 05:31:11 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Feb 2015 11:31:05 +0100
Message-Id: <f0b16dcce340d36b9d60df2155371bfeb623982e.1424687402.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] difftime/1-1: avoid running on second boundary
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

Quoting https://lkml.org/lkml/2015/2/19/384
  "The idea that time() would be ok as being HZ granular, and its
  been this way since 2.6.23.  Thus you have a < HZ sized window
  where gettimeofday() will return the next second before time()
  gets updated by the tick."

Avoid running this test on second boundary as there is small
window, where this test can fail on Linux, reporting that 2
seconds has passed.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/difftime/1-1.c           | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
index 97bf443..2872e08 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
@@ -15,14 +15,31 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/time.h>
 #include "posixtest.h"
 
 int main(void)
 {
 	time_t time1, time0;
-
 	double time_diff;
-	time_diff = 0;
+	struct timeval t1;
+
+	/*
+	 * Quoting https://lkml.org/lkml/2015/2/19/384
+	 *  "The idea that time() would be ok as being HZ granular, and its
+	 *  been this way since 2.6.23.  Thus you have a < HZ sized window
+	 *  where gettimeofday() will return the next second before time()
+	 *  gets updated by the tick."
+	 *
+	 * Avoid running this test on second boundary as there is small
+	 * window, where this test can fail on Linux, reporting that 2
+	 * seconds has passed.
+	 */
+	do {
+		usleep(10000);
+		gettimeofday(&t1, NULL);
+	} while (t1.tv_usec > 700*1000 || t1.tv_usec < 300*1000);
+
 	time0 = time(NULL);
 	sleep(WAIT_DURATION);
 	time1 = time(NULL);
-- 
1.8.3.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
