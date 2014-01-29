Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1W8dqo-0006pW-W0
	for ltp-list@lists.sourceforge.net; Wed, 29 Jan 2014 22:43:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W8dqn-0002i7-Pd
	for ltp-list@lists.sourceforge.net; Wed, 29 Jan 2014 22:43:18 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0TMh98a021469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 29 Jan 2014 17:43:11 -0500
Received: from tarantula.localdomain (ovpn-113-197.phx2.redhat.com
	[10.3.113.197])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s0TMh8jr020433
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 29 Jan 2014 17:43:09 -0500
Date: Wed, 29 Jan 2014 16:43:07 -0600
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20140129224307.GL30688@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] fix glb_run type for disktest
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
To: ltp-list@lists.sourceforge.net

disktest/main.c and disktest/timer.c fail to compile on certain
platforms due to mismatch in types -- short vs long -- with a
gcc error "relocation truncated to fit"

Thanks to Kyle McMartin for the hint on how to fix the error!
---
 testcases/kernel/io/disktest/main.c  | 2 +-
 testcases/kernel/io/disktest/timer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/disktest/main.c b/testcases/kernel/io/disktest/main.c
index 5e5b91a37a12..9484ec103601 100644
--- a/testcases/kernel/io/disktest/main.c
+++ b/testcases/kernel/io/disktest/main.c
@@ -290,7 +290,7 @@ void *threadedMain(void *vtest)
 	int i;
 	unsigned char *sharedMem;
 
-	extern unsigned long glb_run;
+	extern unsigned short glb_run;
 	extern int signal_action;
 
 	test->args->pid = GETPID();
diff --git a/testcases/kernel/io/disktest/timer.c b/testcases/kernel/io/disktest/timer.c
index 45ae09f17b38..f47fa7dde496 100644
--- a/testcases/kernel/io/disktest/timer.c
+++ b/testcases/kernel/io/disktest/timer.c
@@ -86,7 +86,7 @@ void *ChildTimer(void *vtest)
 	test_env_t *env = test->env;
 
 	extern int signal_action;
-	extern unsigned long glb_run;
+	extern unsigned short glb_run;
 
 #ifdef _DEBUG
 	PDBG3(DBUG, args, "In timer %lu, %d\n", time(NULL), env->bContinue);
-- 
1.8.3.1


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
