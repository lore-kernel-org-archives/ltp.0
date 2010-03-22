Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NtbIk-00015f-Tp
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 06:39:50 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NtbIj-0000HJ-Gi
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 06:39:50 +0000
Date: Mon, 22 Mar 2010 12:09:36 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100322063936.GA20606@linux.vnet.ibm.com>
References: <1268975755.12801.44.camel@lishuang-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1268975755.12801.44.camel@lishuang-desktop>
Subject: Re: [LTP] When I execute ppoll01 testcase in mips board,
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
To: Henry xu <feng.xu@windriver.com>
Cc: ltp-list <ltp-list@lists.sf.net>, takahiro.yasui.mp@hitachi.com, sa-fuji@sdl.hitachi.co.jp, yumiko.sugita.yf@hitachi.com

On Fri, Mar 19, 2010 at 01:15:55PM +0800, Henry xu wrote:
> Hi,all
> 
> summary:
> ===================================================================
> When I execute ppoll01 testcase in mips board,the testcase failed.

Again can you send us the strace of this ?

@All, Let us know if anyone also facing the same problem, i am not having any
mips box but may be someone can help here to Henry.

-Rishi
> 
> Environment
> ================================================================
> linux version:2.6.27.45
> hardware platform:mips
> 
> 
> 
> symptom Details
> =====================================================================
> root@localhost:/opt/mytest> ./ppoll01
> ppoll01     0  TINFO  :  (case00) START
> ppoll01     0  TINFO  :  EXPECT: revents=0x0005
> ppoll01     0  TINFO  :  RESULT: revents=0x0005
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       1 errno=0 (Success)
> ppoll01     0  TINFO  :  (case00) END => OK
> ppoll01     0  TINFO  :  (case01) START
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
> ppoll01     0  TINFO  :  (case01) END => NG
> ppoll01     0  TINFO  :  (case02) START
> ^CEXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
> ppoll01     0  TINFO  :  (case02) END => NG
> ppoll01     0  TINFO  :  (case03) START
> ppoll01     0  TINFO  :  EXPECT: revents=0x0020
> ppoll01     0  TINFO  :  RESULT: revents=0x0020
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       1 errno=0 (Success)
> ppoll01     0  TINFO  :  (case03) END => OK
> ppoll01     0  TINFO  :  (case04) START
> EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
> RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
> ppoll01     0  TINFO  :  (case04) END => OK
> ppoll01     0  TINFO  :  (case05) START
> EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
> RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
> ppoll01     0  TINFO  :  (case05) END => OK
> ppoll01     0  TINFO  :  (case06) START
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> ppoll01     0  TINFO  :  (case06) END => OK
> ppoll01     0  TINFO  :  (case07) START
> EXPECT: return value(ret)=-1 errno=14 (Bad address)
> RESULT: return value(ret)=-1 errno=14 (Bad address)
> ppoll01     0  TINFO  :  (case07) END => OK
> ppoll01     1  TFAIL  :  ppoll01 failed: TEST_ERRNO=EFAULT(14): Bad
> address
> NGppoll01     0  TWARN  :  tst_rmdir(): rmobj(/tmp/ppoKT1uvV) failed:
> unlink(/tmp/ppoKT1uvV/.nfs00000000005bcdac00000035) failed; errno=16:
> Device or resource busy
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

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
