Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MRF07-0008OI-6B
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 00:39:07 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MRF00-0005eW-KV
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 00:39:07 +0000
Message-ID: <4A5E7649.9040705@cn.fujitsu.com>
Date: Thu, 16 Jul 2009 08:37:29 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix the system call number of exit_group01
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net

The system call number is depend on the system architecture, not
always 252. This patch fixed the problem.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

--- a/testcases/kernel/syscalls/exit_group/exit_group01.c	2009-05-22 02:14:40.000000000 +0800
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c	2009-07-15 09:26:23.000000000 +0800
@@ -136,7 +136,7 @@ int main(int ac, char **av) {
                      } else if (TEST_RETURN == 0){
 	                 	tst_resm(TINFO, "In the child process");
                            	sleep(5);
-				TEST(syscall(252,4));
+				TEST(syscall(__NR_exit_group,4));
                      }else {
 				tst_resm(TINFO,"in the parent process");
 				TEST(w = wait(&status));




------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
