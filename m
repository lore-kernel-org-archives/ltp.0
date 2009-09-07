Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mkcb3-0003Xr-0i
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:41:21 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mkcay-0006al-CG
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:41:20 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87BeFws000917
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:40:15 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87BfATf214518
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:41:10 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87BfA5s002833
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 05:41:10 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A9E0612.2030003@cn.fujitsu.com>
References: <4A9E0612.2030003@cn.fujitsu.com>
Date: Mon, 07 Sep 2009 17:10:43 +0530
Message-Id: <1252323649.4922.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] mbind01: Fix the bug of result output
Reply-To: subrata@linux.vnet.ibm.com
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
To: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-09-02 at 13:43 +0800, Zhang Xiliang wrote: 
> I tested ltp mbind case and found the result is error as follows:
> 
> mbind01     0  TINFO  :  (case00) START
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=0 errno=0 (Success)
> mbind01     0  TINFO  :  (case00) END => OK
> mbind01     0  TINFO  :  (case01) START
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> mbind01     0  TINFO  :  (case01) END => NG
> mbind01     0  TINFO  :  (case02) START
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> mbind01     0  TINFO  :  (case02) END => NG
> mbind01     0  TINFO  :  (case03) START
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=0 errno=0 (Success)
> mbind01     0  TINFO  :  (case03) END => OK
> mbind01     0  TINFO  :  (case04) START
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> mbind01     0  TINFO  :  (case04) END => NG
> mbind01     0  TINFO  :  (case05) START
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=0 errno=0 (Success)
> mbind01     0  TINFO  :  (case05) END => OK
> mbind01     0  TINFO  :  (case06) START
> EXPECT: return value(ret)=0 errno=0 (Success), r/w check=OK
> RESULT: return value(ret)=0 errno=0 (Success), r/w check=NG
> mbind01     0  TINFO  :  (case06) END => OK
> mbind01     0  TINFO  :  (case07) START
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=0 errno=0 (Success)
> mbind01     0  TINFO  :  (case07) END => OK
> mbind01     0  TINFO  :  (case08) START
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> mbind01     0  TINFO  :  (case08) END => NG
> mbind01     0  TINFO  :  (case09) START
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> mbind01     0  TINFO  :  (case09) END => NG
> mbind01     0  TINFO  :  (case10) START
> mbind01     1  TFAIL  :  get_mempolicy failed - errno = 14 : Bad address
> 
> In case01,case02,case04,case08,case09, the expect is same with the result.
> So these cases should be OK instead of NG.
> 
> In sourse code, TEST_RETURN should get value by "ret".
> By the way, the "switch/case RESULT_OK" missed "break".
> 
> Signed-off-by: Zhang Xiliang <zhangxiliang@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/mbind/mbind01.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
> index 2b861ac..94c2dd0 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -389,6 +389,7 @@ int main(int ac, char **av) {
>          		        int ret;
>  	        	        tst_resm(TINFO,"(case%02d) START", i);
>          	        	ret = do_test(&tcase[i]);
> +				TEST_RETURN = ret;
>  	        	        tst_resm(TINFO,"(case%02d) END => %s", i, ( TEST_RETURN== 0) ? "OK" : "NG");
>  	                	result |= ret;
>          		}
> @@ -399,6 +400,7 @@ int main(int ac, char **av) {
>  		        switch(result) {
>          		case RESULT_OK:
>  					tst_resm(TPASS, "mbind call succeeded --OK-- ");
> +					break;
> 
>  		        default:
>                  		tst_resm(TFAIL, "%s failed - errno = %d : %s --NG--", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> 
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
