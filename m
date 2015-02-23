Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YPuOY-0005R1-EE
	for ltp-list@lists.sourceforge.net; Mon, 23 Feb 2015 14:54:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YPuOT-0000fp-SV
	for ltp-list@lists.sourceforge.net; Mon, 23 Feb 2015 14:54:02 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1NErpmA018375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Feb 2015 09:53:51 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t1NEro7e009900
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Feb 2015 09:53:50 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Feb 2015 15:53:47 +0100
Message-Id: <b59b91bc1b79d666e65e03beb7bbdf6b9fb96be0.1424703130.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] difftime/1-1: eliminate sleep
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

No need to sleep for 1 sec, we can compute second time
immediately and pass it to difftime.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../open_posix_testsuite/conformance/interfaces/difftime/1-1.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
index 97bf443..1d2e19f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
@@ -15,18 +15,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/time.h>
 #include "posixtest.h"
 
 int main(void)
 {
-	time_t time1, time0;
-
+	time_t time0;
 	double time_diff;
-	time_diff = 0;
+
 	time0 = time(NULL);
-	sleep(WAIT_DURATION);
-	time1 = time(NULL);
-	time_diff = difftime(time1, time0);
+	time_diff = difftime(time0 + 1, time0);
 
 	if (time_diff != WAIT_DURATION) {
 		perror
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
