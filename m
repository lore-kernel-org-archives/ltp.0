Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1P8pog-0006tl-3P
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 07:44:02 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8poe-0000z1-V7
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 07:44:02 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9L7hsH4001257
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Oct 2010 03:43:55 -0400
Date: Thu, 21 Oct 2010 03:43:54 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <122866027.1125401287647034456.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <761398766.1125341287646854846.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix sched_getaffinity01 failure
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
To: LTP List <ltp-list@lists.sourceforge.net>

Hi all, when I'm using LTP, sometimes the
test syscalls/sched_getaffinity01 fails by
giving the following output:

sched_getaffinity01    0  TINFO  :  system has 4 processor(s).
sched_getaffinity01    0  TINFO  :  cpusetsize is 128
sched_getaffinity01    0  TINFO  :  mask.__bits[0] = 15 
sched_getaffinity01    1  TPASS  :  sched_getaffinity() succeed ,this process 29494 is running processor: 0
sched_getaffinity01    2  TPASS  :  sched_getaffinity() succeed ,this process 29494 is running processor: 1
sched_getaffinity01    3  TPASS  :  sched_getaffinity() succeed ,this process 29494 is running processor: 2
sched_getaffinity01    4  TPASS  :  sched_getaffinity() succeed ,this process 29494 is running processor: 3
sched_getaffinity01    5  TPASS  :  sched_getaffinity(0, len, (cpu_set_t *)-1): TEST_ERRNO=EFAULT(14): Bad address
sched_getaffinity01    6  TPASS  :  sched_getaffinity(0, 0, mask): TEST_ERRNO=EINVAL(22): Invalid argument
sched_getaffinity01    7  TFAIL  :  sched_getaffinity(getpid() + 1, len, mask): TEST_ERRNO=???(0): Success

Seems that using ``getpid() + 1'' is not
always correct, so I use another non-existed
pid to replace ``getpid() + ''. 

Signed-off-by: Caspar Zhang <czhang@redhat.com>

---
 .../sched_getaffinity/sched_getaffinity01.c        |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index 7dfb0ec..aaa646d 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -41,7 +41,7 @@
 #include<stdio.h>
 #include<sys/types.h>
 #include<unistd.h>
-#define _GNU_SOURCE 
+#define _GNU_SOURCE
 #define __USE_GNU
 #include<sched.h>
 #include<string.h>
@@ -201,11 +201,10 @@ realloc:
 #endif
                      QUICK_TEST(sched_getaffinity(0, len, (cpu_set_t *)-1));
                      QUICK_TEST(sched_getaffinity(0, 0, mask));
-                     QUICK_TEST(sched_getaffinity(getpid() + 1, len, mask));
+                     QUICK_TEST(sched_getaffinity(65535, len, mask));
 		     CPU_FREE(mask);
                 }
 	}
         cleanup();
 	tst_exit();
 }
-
-- 
1.7.3.1

-- 
Quality Assurance Associate (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch

TEL: +86-10-62608150
WEB: http://www.redhat.com/

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
