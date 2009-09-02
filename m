Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zhangxiliang@cn.fujitsu.com>) id 1MiiYU-0000cv-JV
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 05:38:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MiiYN-0004Lp-U6
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 05:38:50 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id C9A6D170091
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Sep 2009 13:38:31 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n825cTB9000600
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Sep 2009 13:38:29 +0800
Received: from [127.0.0.1] (unknown [10.167.141.212])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id D19CED416D
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Sep 2009 13:38:11 +0800 (CST)
Message-ID: <4A9E0612.2030003@cn.fujitsu.com>
Date: Wed, 02 Sep 2009 13:43:46 +0800
From: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/3] mbind01: Fix the bug of result output
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

I tested ltp mbind case and found the result is error as follows:

mbind01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
mbind01     0  TINFO  :  (case00) END => OK
mbind01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
mbind01     0  TINFO  :  (case01) END => NG
mbind01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
mbind01     0  TINFO  :  (case02) END => NG
mbind01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
mbind01     0  TINFO  :  (case03) END => OK
mbind01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
mbind01     0  TINFO  :  (case04) END => NG
mbind01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
mbind01     0  TINFO  :  (case05) END => OK
mbind01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=0 errno=0 (Success), r/w check=OK
RESULT: return value(ret)=0 errno=0 (Success), r/w check=NG
mbind01     0  TINFO  :  (case06) END => OK
mbind01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
mbind01     0  TINFO  :  (case07) END => OK
mbind01     0  TINFO  :  (case08) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
mbind01     0  TINFO  :  (case08) END => NG
mbind01     0  TINFO  :  (case09) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
mbind01     0  TINFO  :  (case09) END => NG
mbind01     0  TINFO  :  (case10) START
mbind01     1  TFAIL  :  get_mempolicy failed - errno = 14 : Bad address
 
In case01,case02,case04,case08,case09, the expect is same with the result.
So these cases should be OK instead of NG.

In sourse code, TEST_RETURN should get value by "ret".
By the way, the "switch/case RESULT_OK" missed "break".

Signed-off-by: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mbind/mbind01.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 2b861ac..94c2dd0 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -389,6 +389,7 @@ int main(int ac, char **av) {
         		        int ret;
 	        	        tst_resm(TINFO,"(case%02d) START", i);
         	        	ret = do_test(&tcase[i]);
+				TEST_RETURN = ret;
 	        	        tst_resm(TINFO,"(case%02d) END => %s", i, ( TEST_RETURN== 0) ? "OK" : "NG");
 	                	result |= ret;
         		}
@@ -399,6 +400,7 @@ int main(int ac, char **av) {
 		        switch(result) {
         		case RESULT_OK:
 					tst_resm(TPASS, "mbind call succeeded --OK-- ");
+					break;
 
 		        default:
                 		tst_resm(TFAIL, "%s failed - errno = %d : %s --NG--", TCID, TEST_ERRNO, strerror(TEST_ERRNO));



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
