Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1W035e-0001pF-FT
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 05:51:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W035c-0006ZZ-Vm
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 05:51:06 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s065outm016271
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jan 2014 13:50:56 +0800
Message-ID: <1388987451.1648.16.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Mon, 06 Jan 2014 13:50:51 +0800
In-Reply-To: <1386844070.1603.18.camel@G08JYZSD130126>
References: <1386844070.1603.18.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] getrlimit/getrlimit01.c: add some new test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Could anyone help to review this?

Thanks,
Zeng

On Thu, 2013-12-12 at 18:27 +0800, zenglg.jy wrote:
> add new test for getrlimit(2):
> RLIMIT_MSGQUEUE
> RLIMIT_NICE
> RLIMIT_RTPRIO
> RLIMIT_RTTIME
> RLIMIT_SIGPENDING
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/getrlimit/getrlimit01.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> index f397a19..369ee05 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> @@ -47,6 +47,13 @@ static struct test_t {
>  	{RLIMIT_MEMLOCK, "RLIMIT_MEMLOCK"},
>  	{RLIMIT_AS, "RLIMIT_AS"},
>  	{RLIMIT_LOCKS, "RLIMIT_LOCKS"},
> +	{RLIMIT_MSGQUEUE, "RLIMIT_MSGQUEUE"},
> +	{RLIMIT_NICE, "RLIMIT_NICE"},
> +	{RLIMIT_RTPRIO, "RLIMIT_RTPRIO"},
> +	{RLIMIT_SIGPENDING, "RLIMIT_SIGPENDING"},
> +#ifdef RLIMIT_RTTIME
> +	{RLIMIT_RTTIME, "RLIMIT_RTTIME"},
> +#endif
>  };
>  
>  char *TCID = "getrlimit01";



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
