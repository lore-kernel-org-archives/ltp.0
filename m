Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Rsyq2-0005y0-GK
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 15:44:42 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rsypw-0004ED-WC
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 15:44:42 +0000
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 2 Feb 2012 15:44:13 +0000
Message-ID: <1328197453-21108-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mtest07/shm_test: Use unique key when allocating new
	shared memory region
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

We use a unique key for every allocation instead of a static one which may have
already been used by another process. In the case where a key has been assigned to a
memory region with a different size compared to the one we currently
want to allocate, shmget() will fail with -EINVAL error code.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/mem/mtest07/shm_test.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/mtest07/shm_test.c b/testcases/kernel/mem/mtest07/shm_test.c
index 29c626a..4e88ebc 100644
--- a/testcases/kernel/mem/mtest07/shm_test.c
+++ b/testcases/kernel/mem/mtest07/shm_test.c
@@ -290,7 +290,6 @@ main(int	argc,		/* number of input parameters		      */
     int		thrd_ndx;	/* index into the array of thread ids         */
     int		th_status;	/* exit status of LWP's	                      */
     int		map_size;	/* size of the file mapped.                   */
-    int		shmkey   = 1969;/* key used to generate shmid by shmget()     */
     pthread_t	thrdid[30];	/* maxinum of 30 threads allowed              */
     long	chld_args[4];   /* arguments to the thread function           */
     char        *map_address=NULL;
@@ -339,7 +338,7 @@ main(int	argc,		/* number of input parameters		      */
         srand(time(NULL)%100);
         map_size = (1 + (int)(1000.0*rand()/(RAND_MAX+1.0))) * 4096;

-        chld_args[1] = shmkey++;
+        chld_args[1] = IPC_PRIVATE;
         chld_args[2] = map_size;

 	dprt("main(): thrd_ndx = %d map_address = %#x map_size = %d\n",
@@ -384,4 +383,4 @@ main(int	argc,		/* number of input parameters		      */
         }
     }
     exit(0);
-}
\ No newline at end of file
+}
--
1.7.1



------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
