Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PB0sg-0001Wp-NY
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 07:57:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB0sd-0002O3-Mb
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 07:57:10 +0000
Message-ID: <4CC7DAFD.3090005@cn.fujitsu.com>
Date: Wed, 27 Oct 2010 15:55:41 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX]aio_suspend-4: we just need care the selected request.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

At linux, the aio_suspend tests report following error:
  aio_suspend/4-1.c aio_suspend() should set errno to EAGAIN: 4 (Interrupted system call)

Man page said:
  The  aio_suspend()  function  suspends  the calling process until at least one of the asynchronous
  I/O requests in the list cblist of length n have completed, a signal is delivered, or timeout is
  not NULL and the time interval it indicates has passed.

When  a signal is delivered, whether should aio_suspend return immediately although 
we have set a SA_RESTART flag for this signal action?

Maybe the followed path is necessary.
------------------------------------------------------------------------------------------------------
We just care the selected IO request, and set a little timeout.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 conformance/interfaces/aio_suspend/4-1.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/conformance/interfaces/aio_suspend/4-1.c b/conformance/interfaces/aio_suspend/4-1.c
index 260c26a..dd8e5f0 100644
--- a/conformance/interfaces/aio_suspend/4-1.c
+++ b/conformance/interfaces/aio_suspend/4-1.c
@@ -47,8 +47,7 @@ int received_all	= 0;
 void
 sigrt1_handler(int signum, siginfo_t *info, void *context)
 {
-	if (info->si_value.sival_int == WAIT_FOR_AIOCB)
-		received_selected = 1;
+	received_selected = 1;
 }
 
 void
@@ -68,7 +67,7 @@ main ()
 	char *bufs;
 	struct sigaction action;
 	struct sigevent event;
-	struct timespec ts = {0, 10000000}; /* 10 ms */
+	struct timespec ts = {0, 1000}; /* 1 us */
 	int errors = 0;
 	int ret;
 	int err;
@@ -123,9 +122,11 @@ main ()
 		aiocbs[i]->aio_lio_opcode = LIO_READ;
 
 		/* Use SIRTMIN+1 for individual completions */
-		aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
-		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN+1;
-		aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
+		if (i == WAIT_FOR_AIOCB) {
+			aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
+			aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN+1;
+			aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
+		}
 	}
 
 	/* Use SIGRTMIN+2 for list completion */
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


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
