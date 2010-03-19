Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Xu@windriver.com>) id 1NsUUw-0000y1-Tu
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 05:11:50 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NsUUs-0006VQ-G4
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 05:11:50 +0000
From: Henry xu <feng.xu@windriver.com>
Date: Fri, 19 Mar 2010 13:15:55 +0800
Message-Id: <1268975755.12801.44.camel@lishuang-desktop>
Mime-Version: 1.0
Subject: [LTP] When I execute ppoll01 testcase in mips board,
	the testcase failed.
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
To: takahiro.yasui.mp@hitachi.com, yumiko.sugita.yf@hitachi.com, sa-fuji@sdl.hitachi.co.jp
Cc: ltp-list <ltp-list@lists.sf.net>

Hi,all

summary:
===================================================================
When I execute ppoll01 testcase in mips board,the testcase failed.

Environment
================================================================
linux version:2.6.27.45
hardware platform:mips



symptom Details
=====================================================================
root@localhost:/opt/mytest> ./ppoll01
ppoll01     0  TINFO  :  (case00) START
ppoll01     0  TINFO  :  EXPECT: revents=0x0005
ppoll01     0  TINFO  :  RESULT: revents=0x0005
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case00) END => OK
ppoll01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case01) END => NG
ppoll01     0  TINFO  :  (case02) START
^CEXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case02) END => NG
ppoll01     0  TINFO  :  (case03) START
ppoll01     0  TINFO  :  EXPECT: revents=0x0020
ppoll01     0  TINFO  :  RESULT: revents=0x0020
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case03) END => OK
ppoll01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case04) END => OK
ppoll01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case05) END => OK
ppoll01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
ppoll01     0  TINFO  :  (case06) END => OK
ppoll01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=14 (Bad address)
ppoll01     0  TINFO  :  (case07) END => OK
ppoll01     1  TFAIL  :  ppoll01 failed: TEST_ERRNO=EFAULT(14): Bad
address
NGppoll01     0  TWARN  :  tst_rmdir(): rmobj(/tmp/ppoKT1uvV) failed:
unlink(/tmp/ppoKT1uvV/.nfs00000000005bcdac00000035) failed; errno=16:
Device or resource busy

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
