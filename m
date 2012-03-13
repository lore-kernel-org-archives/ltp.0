Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1S7P1w-0005oG-TO
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 10:32:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7P1r-0000j2-De
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 10:32:36 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2DAWPeC007034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Mar 2012 06:32:25 -0400
Message-ID: <4F5F2238.9010402@redhat.com>
Date: Tue, 13 Mar 2012 11:32:24 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050105080600050103080300"
Subject: [LTP] [PATCH] mmstress: make shared global variables volatile
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------050105080600050103080300
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Synchronization of threads depends on shared global variable.
With gcc version 4.6.2 this test spins forever on:
     while (wait_thread)
         sched_yield();

Make global shared variables volatile, so each thread
sees current value.

See also:
Bug 36081 - gcc optimizations and threads (pthread)
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=36081

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/mem/mtest05/mmstress.c |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)



--------------050105080600050103080300
Content-Type: text/x-patch;
	name="0001-mmstress-make-shared-global-variables-volatile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-mmstress-make-shared-global-variables-volatile.patch"

diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index 8a0c6f6..a8d4e7d 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -140,8 +140,8 @@ typedef struct {      /* structure returned by map_and_thread()               */
     caddr_t mapaddr;  /* address at which the file is mapped                  */
 } RETINFO_t;
 
-static   int  wait_thread = 0;       /* used to wake up sleeping threads      */
-static   int  thread_begin = 0;      /* used to coordinate threads            */
+static volatile int  wait_thread = 0;  /* used to wake up sleeping threads    */
+static volatile int  thread_begin = 0; /* used to coordinate threads          */
 static   int  verbose_print = FALSE; /* print more test information           */
 
 static   int    pages_num = NUMPAGES; /* number of pages to use for tests     */
@@ -989,4 +989,4 @@ main(int   argc,     /* number of command line parameters                     */
         tst_resm(TPASS, "Test Passed");
     }
     exit(global_rc);
-}
\ No newline at end of file
+}


--------------050105080600050103080300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------050105080600050103080300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050105080600050103080300--

