Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WkZzV-0001OS-DS
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 14:17:05 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WkZzU-0003Mh-Mh
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 14:17:05 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4EEGw88025499
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 May 2014 14:16:59 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4EEGvNW011545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 May 2014 14:16:58 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4EEGuQK019684
	for <ltp-list@lists.sourceforge.net>; Wed, 14 May 2014 14:16:57 GMT
From: shuang.qiu@oracle.com
Date: Wed, 14 May 2014 22:16:49 +0800
Message-Id: <1400077009-6831-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] kernel/mem/mtest06/mmap1.c: Update the
	synchronization logic
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

From: Shuang Qiu <shuang.qiu@oracle.com>

Currently in mmap1.c,the reader and writer cannot synchronize with each other.
Added one more lock and update the logic a little to make it work.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/mem/mtest06/mmap1.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index cd1127f..6bdbf75 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -65,6 +65,7 @@ static int verbose_print = 0;
 static char *volatile map_address;
 static jmp_buf jmpbuf;
 static volatile char read_lock = 0;
+static volatile char write_lock = 0;
 
 char *TCID = "mmap1";
 int TST_TOTAL = 1;
@@ -157,6 +158,7 @@ void *map_write_unmap(void *ptr)
 
 		while (read_lock)
 			sched_yield();
+		read_lock = 1;
 
 		sigfillset(&sa.sa_mask);
 		sigdelset(&sa.sa_mask, SIGSEGV);
@@ -197,6 +199,7 @@ void *map_write_unmap(void *ptr)
 			perror("map_write_unmap(): mmap()");
 			pthread_exit((void *)1);
 		}
+		write_lock = 0;
 	}
 
 	pthread_exit((void *)0);
@@ -218,6 +221,9 @@ void *read_mem(void *ptr)
 
 	for (i = 0; i < args[2]; i++) {
 
+		while (write_lock)
+			sched_yield();
+		write_lock = 1;
 		if (verbose_print)
 			tst_resm(TINFO, "read_mem() in while loop %ld times "
 				 "to go %ld times", i, args[2]);
@@ -229,20 +235,17 @@ void *read_mem(void *ptr)
 					 "a read after an unmap");
 		} else {
 			if (verbose_print) {
-				read_lock = 1;
 				tst_resm(TINFO,
 					 "read_mem(): content of memory: %s",
 					 (char *)map_address);
-				read_lock = 0;
 			}
 			for (j = 0; j < args[1]; j++) {
-				read_lock = 1;
 				if (map_address[j] != 'a')
 					pthread_exit((void *)-1);
-				read_lock = 0;
 				if (random() % 2)
 					sched_yield();
 			}
+			read_lock = 0;
 		}
 	}
 
-- 
1.7.9.5


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
