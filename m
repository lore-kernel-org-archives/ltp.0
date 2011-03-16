Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PzmCY-0005b7-Ne
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 08:35:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PzmCW-0000dK-QU
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 08:35:30 +0000
Message-ID: <4D80769F.70202@cn.fujitsu.com>
Date: Wed, 16 Mar 2011 16:36:47 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH] sem_wait: Setting a range for time checking.
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

Hi,

According to POSIX, many historical implementations (including Version 7 
and System V) allow an alarm to occur up to a second early. Other 
implementations allow alarms up to half a second or one clock tick early 
or do not allow them to occur early at all. That means, the SIGALRM sent 
by alarm() could arrive a little earlier. So, even if sem_wait() is 
blocked, test could still fail.
Setting a range for time checking would be better. When sem_wait() is 
block and then be interrupted by SIGALRM, if the time is in this range, 
test is passed.

Signed-off-by: tangchen <tangchen@cn.fujitsu.com>
---
  .../conformance/interfaces/sem_wait/13-1.c         |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

diff --git 
a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c 
b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c
index 7bf547c..f30bba5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c
@@ -83,6 +83,8 @@
  /******************************************************************************/
  /***************************    Test case   
***********************************/
  /******************************************************************************/
+#define RANGE 1000000    /* 1000000 nsec */
+
  sem_t sem;

  void handler(int sig)
@@ -163,7 +165,7 @@ int main(int argc, char * argv[])
      }

      if (((ts_fin.tv_sec - ts_ref.tv_sec) * 1000000000) +
-        (ts_fin.tv_nsec - ts_ref.tv_nsec) < 1000000000)
+        (ts_fin.tv_nsec - ts_ref.tv_nsec) < (1000000000 - RANGE))
      {
          output("Ts: %d.%9.9d  ->  %d.%9.9d\n", ts_ref.tv_sec, 
ts_ref.tv_nsec, ts_fin.tv_sec, ts_fin.tv_nsec);
          FAILED("The sem_wait call did not block");
@@ -185,4 +187,4 @@ int main(int argc, char * argv[])
  #endif

      PASSED;
-}
\ No newline at end of file
+}
-- 
1.7.1

-- 
Best Regards,
Tang chen
--------------------------------------------------



------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
