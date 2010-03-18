Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NsFlJ-00075r-An
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 13:27:45 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NsFlH-0005k8-4R
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 13:27:45 +0000
Date: Thu, 18 Mar 2010 18:57:32 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100318132732.GA27760@linux.vnet.ibm.com>
References: <1268903717.12801.30.camel@lishuang-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1268903717.12801.30.camel@lishuang-desktop>
Subject: Re: [LTP] LTP clock_nanosleep01 testcase fail
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, Mar 18, 2010 at 05:15:17PM +0800, Henry xu wrote:
> Hi,all
> 
> summary:
> ===================================================================
> When I execute nanosleep01 testcase in mips board,the case01 is fail.


Hi Henry,

Can you please send me the strace of execution of this testcase ?

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
> clock_nanosleep01    0  TINFO  :  (case00) START
> clock_nanosleep01    0  TINFO  :  check sleep time: (min:480) < 500 <
> (max:520) (msec)
> clock_nanosleep01    0  TINFO  :  remain time: 0 1
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=0 errno=0 (Success)
> clock_nanosleep01    0  TINFO  :  (case00) END => OK
> clock_nanosleep01    0  TINFO  :  (case01) START
> clock_nanosleep01    0  TINFO  :  remain time: 0 1
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=122 errno=0 (Success)
> clock_nanosleep01    0  TINFO  :  (case01) END => NG
> clock_nanosleep01    0  TINFO  :  (case02) START
> clock_nanosleep01    0  TINFO  :  remain time: 0 1
> EXPECT: return value(ret)=22 errno=0 (Success)
> RESULT: return value(ret)=22 errno=0 (Success)
> clock_nanosleep01    0  TINFO  :  (case02) END => OK
> clock_nanosleep01    0  TINFO  :  (case03) START
> clock_nanosleep01    0  TINFO  :  remain time: 0 1
> EXPECT: return value(ret)=22 errno=0 (Success)
> RESULT: return value(ret)=22 errno=0 (Success)
> clock_nanosleep01    0  TINFO  :  (case03) END => OK
> clock_nanosleep01    0  TINFO  :  (case04) START
> clock_nanosleep01    0  TINFO  :  remain time: 0 1
> EXPECT: return value(ret)=22 errno=0 (Success)
> RESULT: return value(ret)=22 errno=0 (Success)
> clock_nanosleep01    0  TINFO  :  (case04) END => OK
> clock_nanosleep01    0  TINFO  :  (case05) START
> clock_nanosleep01    0  TINFO  :  remain time: 9 499708701
> EXPECT: return value(ret)=4 errno=0 (Success)
> RESULT: return value(ret)=4 errno=0 (Success)
> clock_nanosleep01    0  TINFO  :  (case05) END => OK
> clock_nanosleep01    1  TFAIL  :  clock_nanosleep failed
> clock_nanosleep01    0  TINFO  :  NG
> 
> 
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
