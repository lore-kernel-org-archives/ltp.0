Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NxEwv-0003zv-7s
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 07:36:21 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxEws-0006jQ-Ug
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 07:36:21 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o317BMOO010726
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 03:11:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o317N88f1777804
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 03:23:08 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o317N7Pp032162
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 04:23:07 -0300
Date: Thu, 1 Apr 2010 12:53:05 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100401072305.GC13796@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [risrajak@linux.vnet.ibm.com: [Ltp-commits] [Git] ltp
	updated.]
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
Cc: sachinp@linux.vnet.ibm.com, iranna.ankad@in.ibm.com, svishuku@in.ibm.com

Hi All,

For those who does not subscribed to ltp-commits list.

This is the new file which will be updated every month by maintainer. While
testing during the month if anyone get a chance to test on h/w or distro which i
could not cover due to time availability please send me a patch will include as
hotfixes and that can be helpful for each one us during whole month to refer.

-Rishi

----- Forwarded message from Rishi kesh K Rajak <risrajak@linux.vnet.ibm.com> -----

Date: Thu,  1 Apr 2010 07:14:26 +0000
From: Rishi kesh K Rajak <risrajak@linux.vnet.ibm.com>
To: ltp-commits@lists.sourceforge.net
Subject: [Ltp-commits] [Git] ltp updated.

The branch, next, has been updated
       via  aabf191024aacc91784593b0d3f8d5fa37434b25 (commit)
      from  f50539e0bcb0f9bab88101ce40a8e09a1d76d4a9 (commit)


- Log -----------------------------------------------------------------
commit aabf191024aacc91784593b0d3f8d5fa37434b25
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Thu Apr 1 12:43:27 2010 +0530

    Added a new file called result where maintainer need to provide the result on which he has run before releasing the tar ball for month end release.
    
    Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

-----------------------------------------------------------------------

Summary of changes:
 result |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 result

diff --git a/result b/result
new file mode 100644
index 0000000..78db428
--- /dev/null
+++ b/result
@@ -0,0 +1,96 @@
+This file contains for corresponding monthly release results. it will alwats help to refer this file and come to know about known failures.
+
+
+ltp-full-20100331 Result pon various Arch:
+
+On x86_64 machine with RHEL5.4(2.6.18-164.el5):
+*****************************************************
+
+Result Log file:
+===============
+eventfd01                      FAIL       4    
+syslog07                       FAIL       1    
+syslog08                       FAIL       1    
+mtest06                        FAIL       255  
+su01                           FAIL       1    
+hugemmap04                     FAIL       2    
+hugeshmat01                    FAIL       6    
+hugeshmat02                    FAIL       6    
+hugeshmat03                    FAIL       2    
+hugeshmctl01                   FAIL       6    
+hugeshmctl02                   FAIL       6    
+hugeshmctl03                   FAIL       2    
+hugeshmdt01                    FAIL       6    
+hugeshmget01                   FAIL       2    
+hugeshmget02                   FAIL       6    
+hugeshmget03                   FAIL       6    
+hugeshmget05                   FAIL       2    
+mail                           FAIL       2    
+
+
+Result Output file:
+==================
+syslog07    1  TFAIL  :  Higher level messages are not logged.
+check_netns_enabled    1  TFAIL  :  unshare syscall smoke test failed: errno=EINVAL(22): Invalid argument
+mail_tests::mail02    2  TFAIL  :  Test #2: Mailer-Deamon failed to report delivery failure. Reason:
+mail_tests::mail05    5  TFAIL  :  Test #5: mail failed to carbon copy user mail_test. Reason:
+
+
+On ppc64 machine with RHEL5.4(2.6.18-164.el5):
+*****************************************************
+
+Result Log file:
+===============
+cct01                         FAIL       1    
+eventfd01                      FAIL       4    
+fdatasync02                    FAIL       1    
+syslog07                       FAIL       1    
+syslog08                       FAIL       1    
+mtest06                        FAIL       255  
+mmapstress03                   FAIL       1    
+su01                           FAIL       1    
+cron_deny01                    FAIL       1    
+
+
+Result Output file:
+==================
+acct01      1  TFAIL  :  attempting to assign acct file to device: expected failure but got okay return
+fdatasync02    2  TFAIL  :  Unexpected results for file descriptor to a special file ; returned 0 (expected -1), errno 0 (expected 22)
+syslog07    1  TFAIL  :  Higher level messages are not logged.
+mmapstress03    1  TFAIL  :  Test failed
+check_netns_enabled    1  TFAIL  :  unshare syscall smoke test failed: errno=EINVAL(22): Invalid argument
+
+
+
+On s390x machine with RHEL5.4(2.6.18-164.el5):
+*****************************************************
+
+Result Log file:
+===============
+eventfd01                      FAIL       4    
+keyctl01                       FAIL       1    
+rt_sigsuspend01                FAIL       11   
+timer_getoverrun01             FAIL       1    
+timer_gettime01                FAIL       1    
+su01                           FAIL       1    
+cron_allow01                   FAIL       1    
+
+
+
+Result Output file:
+==================
+keyctl01    2  TFAIL  :  KEYCTL_REVOKE got unexpected errno: errno=EINVAL(22): Invalid argument
+timer_getoverrun01    1  TFAIL  :  Block 1: test 0 FAILED... errno = 22 : Invalid argument
+timer_gettime01    1  TFAIL  :  Block 1: test 0 FAILED... errno = 22 : Invalid argument
+check_netns_enabled    1  TFAIL  :  unshare syscall smoke test failed: errno=EINVAL(22): Invalid argument
+
+
+
+On x86_64 machine with SLES11GA(2.6.27.19-5-default):
+*****************************************************
+
+Result Log file:
+===============
+eventfd2_03                    FAIL       1    
+utimensat01                    FAIL       1    
+ftest04                        FAIL       1    


hooks/post-receive
-- 
ltp

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-commits mailing list
Ltp-commits@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-commits

----- End forwarded message -----

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
